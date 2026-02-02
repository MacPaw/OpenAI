//
//  ServerSentEventsStreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

/// https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation
/// 9.2.6 Interpreting an event stream
///
/// - Note: This class is NOT thread safe. It is a caller's responsibility to call all the methods in a thread-safe manner.
final class ServerSentEventsStreamInterpreter <ResultType: Codable & Sendable>: @unchecked Sendable, StreamInterpreter {
    private let parser = ServerSentEventsStreamParser()
    private let streamingCompletionMarker = "[DONE]"
    private var previousChunkBuffer = ""
    
    private var onEventDispatched: ((ResultType) -> Void)?
    private var onWebSearchEvent: ((WebSearchEvent) -> Void)?
    private var onError: ((Error) -> Void)?
    private let parsingOptions: ParsingOptions
    
    enum InterpeterError: Error {
        case unhandledStreamEventType(String)
    }
    
    init(parsingOptions: ParsingOptions) {
        self.parsingOptions = parsingOptions
        
        parser.setCallbackClosures { [weak self] event in
            self?.processEvent(event)
        } onError: { [weak self] error in
            self?.onError?(error)
        }
    }
    
    /// Sets closures an instance of type. Not thread safe.
    ///
    /// - Parameters:
    ///     - onEventDispatched: Can be called multiple times per `processData`
    ///     - onWebSearchEvent: Called when a web search event is received (optional)
    ///     - onError: Will only be called once per `processData`
    func setCallbackClosures(
        onEventDispatched: @escaping @Sendable (ResultType) -> Void,
        onWebSearchEvent: (@Sendable (WebSearchEvent) -> Void)? = nil,
        onError: @escaping @Sendable (Error) -> Void
    ) {
        self.onEventDispatched = onEventDispatched
        self.onWebSearchEvent = onWebSearchEvent
        self.onError = onError
    }
    
    /// Not thread safe
    func processData(_ data: Data) {
        let decoder = JSONDecoder()
        if let decoded = JSONResponseErrorDecoder(decoder: decoder).decodeErrorResponse(data: data) {
            onError?(decoded)
            return
        }
        
        parser.processData(data: data)
    }
    
    private func processEvent(_ event: ServerSentEventsStreamParser.Event) {
        switch event.eventType {
        case "message":
            let jsonContent = event.decodedData
            guard jsonContent != streamingCompletionMarker && !jsonContent.isEmpty else {
                return
            }
            guard let jsonData = jsonContent.data(using: .utf8) else {
                onError?(StreamingError.unknownContent)
                return
            }

            // Handle web search events (they have "type" field instead of "object")
            if let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any],
               json["type"] as? String == "web_search_call" {
                if let event = try? JSONDecoder().decode(WebSearchEvent.self, from: jsonData) {
                    onWebSearchEvent?(event)
                }
                return
            }

            let decoder = JSONResponseDecoder(parsingOptions: parsingOptions)
            do {
                let object: ResultType = try decoder.decodeResponseData(jsonData)
                onEventDispatched?(object)
            } catch {
                onError?(error)
            }
        default:
            onError?(InterpeterError.unhandledStreamEventType(event.eventType))
        }
    }
}
