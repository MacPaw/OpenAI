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
        
        /**
         * When the server returns an error, it will return a JSON string like this:
         *   {
         *      "error":    {
         *          "message": "The model `o3-mini` does not exist or you do not have access to it.",
         *          "type": "invalid_request_error",
         *          "param": null,
         *          "code": "model_not_found"
         *       }
         *   }
         * The error json will cause the following jsonObject fail and a new parsing error will be thrown to caller, which replaces the real error.
         * So the error should be checked here and throw to the caller.
        */
        let fullContent = chunkLines.joined(separator: "\n")
        if fullContent.contains("error") {
            guard let data = fullContent.data(using: .utf8) else {
                throw APIError(message: "Invalid JSON string", type: "parsing_error", param: nil, code: nil)
            }
            let apiErrorResponse = try JSONDecoder().decode([String: APIError].self, from: data)
            if let apiError = apiErrorResponse["error"] {
                throw apiError
            } else {
                throw APIError(message: fullContent, type: "api_error", param: nil, code: nil)
            }
        }

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
