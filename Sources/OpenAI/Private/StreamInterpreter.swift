//
//  StreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 03.02.2025.
//

import Foundation

/// https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation
/// 9.2.6 Interpreting an event stream
class StreamInterpreter<ResultType: Codable> {
    private let streamingCompletionMarker = "[DONE]"
    private var previousChunkBuffer = ""
    
    var onEventDispatched: ((ResultType) -> Void)?
    
    func processData(_ data: Data) throws {
        guard let stringContent = String(data: data, encoding: .utf8) else {
            throw StreamingError.unknownContent
        }
        try processJSON(from: stringContent)
    }
    
    private func processJSON(from stringContent: String) throws {
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
        
        try jsonObjects.enumerated().forEach { (index, jsonContent)  in
            guard jsonContent != streamingCompletionMarker && !jsonContent.isEmpty else {
                return
            }
            guard let jsonData = jsonContent.data(using: .utf8) else {
                throw StreamingError.unknownContent
            }
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(ResultType.self, from: jsonData)
                onEventDispatched?(object)
            } catch {
                if let decoded = try? decoder.decode(APIErrorResponse.self, from: jsonData) {
                    throw decoded
                } else if index == jsonObjects.count - 1 {
                    previousChunkBuffer = "data: \(jsonContent)" // Chunk ends in a partial JSON
                } else {
                    throw error
                }
            }
        }
    }
}
