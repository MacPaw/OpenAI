//
//  ServerSentEventsStreamDecoder.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

/// https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation
/// 9.2.6 Interpreting an event stream
final class ServerSentEventsStreamDecoder <ResultType: Codable & Sendable>: @unchecked Sendable, StreamInterpreter {
    private let streamingCompletionMarker = "[DONE]"
    private var previousChunkBuffer = ""
    
    private var onEventDispatched: ((ResultType) -> Void)?
    private var onError: ((Error) -> Void)?
    private let executionSerializer: ExecutionSerializer
    
    init(executionSerializer: ExecutionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated)) {
        self.executionSerializer = executionSerializer
    }
    
    /// Sets closures an instance of type in a thread safe manner
    ///
    /// - Parameters:
    ///     - onEventDispatched: Can be called multiple times per `processData`
    ///     - onError: Will only be called once per `processData`
    func setCallbackClosures(onEventDispatched: @escaping @Sendable (ResultType) -> Void, onError: @escaping @Sendable (Error) -> Void) {
        executionSerializer.dispatch {
            self.onEventDispatched = onEventDispatched
            self.onError = onError
        }
    }
    
    func processData(_ data: Data) {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(APIErrorResponse.self, from: data) {
            onError?(decoded)
            return
        }
        
        guard let stringContent = String(data: data, encoding: .utf8) else {
            onError?(StreamingError.unknownContent)
            return
        }
        
        executionSerializer.dispatch {
            self.processJSON(from: stringContent)
        }
    }
    
    private func processJSON(from stringContent: String) {
        if stringContent.isEmpty {
            return
        }

        let fullChunk = "\(previousChunkBuffer)\(stringContent)"
        let chunkLines = fullChunk
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { $0.isEmpty == false }

        var jsonObjects: [String] = []
        for line in chunkLines {

            // Skip comments
            if line.starts(with: ":") { continue }

            // Get JSON object
            let jsonData = line
                .components(separatedBy: "data:")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                .filter { $0.isEmpty == false }
            jsonObjects.append(contentsOf: jsonData)
        }

        previousChunkBuffer = ""
        
        guard jsonObjects.isEmpty == false, jsonObjects.first != streamingCompletionMarker else {
            return
        }
        
        jsonObjects.enumerated().forEach { (index, jsonContent)  in
            guard jsonContent != streamingCompletionMarker && !jsonContent.isEmpty else {
                return
            }
            guard let jsonData = jsonContent.data(using: .utf8) else {
                onError?(StreamingError.unknownContent)
                return
            }
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(ResultType.self, from: jsonData)
                onEventDispatched?(object)
            } catch {
                if let decoded = try? decoder.decode(APIErrorResponse.self, from: jsonData) {
                    onError?(decoded)
                    return
                } else if index == jsonObjects.count - 1 {
                    previousChunkBuffer = "data: \(jsonContent)" // Chunk ends in a partial JSON
                } else {
                    onError?(error)
                }
            }
        }
    }
}
