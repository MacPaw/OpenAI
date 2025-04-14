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
    ///     - onError: Will only be called once per `processData`
    func setCallbackClosures(onEventDispatched: @escaping @Sendable (ResultType) -> Void, onError: @escaping @Sendable (Error) -> Void) {
        self.onEventDispatched = onEventDispatched
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
            let decoder = JSONDecoder()
            decoder.userInfo[.parsingOptions] = parsingOptions
            do {
                let object = try decoder.decode(ResultType.self, from: jsonData)
                onEventDispatched?(object)
            } catch {
                if let decoded = JSONResponseErrorDecoder(decoder: decoder).decodeErrorResponse(data: jsonData) {
                    onError?(decoded)
                    return
                } else {
                    onError?(error)
                }
            }
        default:
            onError?(InterpeterError.unhandledStreamEventType(event.eventType))
        }
    }
}
