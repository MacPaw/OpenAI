//
//  ModelResponseEventsStreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 04.04.2025.
//

import Foundation



/// This class is NOT thread safe. It's a callers responsibility to make all the calls in serialized manner.
final class ModelResponseEventsStreamInterpreter: @unchecked Sendable, StreamInterpreter {
    private let parser = ServerSentEventsStreamParser()
    private var onEventDispatched: ((ResponseStreamEvent) -> Void)?
    private var onError: ((Error) -> Void)?
    private let decoder = JSONDecoder()
    
    enum InterpreterError: Error {
        case unknownEventType(String)
    }
    
    init () {
        parser.setCallbackClosures { [weak self] event in
            guard let self else {
                return
            }
            
            do {
                try self.processEvent(event)
            } catch {
                self.processError(error)
            }
        } onError: { [weak self] error in
            self?.processError(error)
        }
    }
    
    /// Sets closures an instance of type. Not thread safe.
    ///
    /// - Parameters:
    ///     - onEventDispatched: Can be called multiple times per `processData`
    ///     - onError: Will only be called once per `processData`
    func setCallbackClosures(onEventDispatched: @escaping @Sendable (ResponseStreamEvent) -> Void, onError: @escaping @Sendable (Error) -> Void) {
        self.onEventDispatched = onEventDispatched
        self.onError = onError
    }
    
    func processData(_ data: Data) {
        let decoder = JSONDecoder()
        if let decoded = JSONResponseErrorDecoder(decoder: decoder).decodeErrorResponse(data: data) {
            onError?(decoded)
            return
        }
        
        parser.processData(data: data)
    }
    
    private func processEvent(_ event: ServerSentEventsStreamParser.Event) throws {
        guard let modelResponseEventType = ModelResponseStreamEventType(rawValue: event.eventType) else {
            throw InterpreterError.unknownEventType(event.eventType)
        }
        
        let responseStreamEvent = try responseStreamEvent(modelResponseEventType: modelResponseEventType, data: event.data)
        onEventDispatched?(responseStreamEvent)
    }
    
    private func processError(_ error: Error) {
        onError?(error)
    }
    
    private typealias Schemas = Components.Schemas
    
    private func responseStreamEvent(
        modelResponseEventType: ModelResponseStreamEventType,
        data: Data
    ) throws -> ResponseStreamEvent {
        switch modelResponseEventType {
        case .responseCreated:
                .created(try decoder.decode(ResponseEvent.self, from: data))
        case .responseInProgress:
                .inProgress(try decoder.decode(ResponseEvent.self, from: data))
        case .responseCompleted:
                .completed(try decoder.decode(ResponseEvent.self, from: data))
        case .responseFailed:
                .failed(try decoder.decode(ResponseEvent.self, from: data))
        case .responseIncomplete:
                .incomplete(try decoder.decode(ResponseEvent.self, from: data))
        case .responseOutputItemAdded:
                .outputItem(.added(try decoder.decode(ResponseOutputItemAddedEvent.self, from: data)))
        case .responseOutputItemDone:
                .outputItem(.done(try decoder.decode(ResponseOutputItemDoneEvent.self, from: data)))
        case .responseContentPartAdded:
                .contentPart(.added(try decoder.decode(Schemas.ResponseContentPartAddedEvent.self, from: data)))
        case .responseContentPartDone:
                .contentPart(.done(try decoder.decode(Schemas.ResponseContentPartDoneEvent.self, from: data)))
        case .responseOutputTextDelta:
                .outputText(.delta(try decoder.decode(Schemas.ResponseTextDeltaEvent.self, from: data)))
        case .responseOutputTextAnnotationAdded:
                .outputText(.annotationAdded(try decoder.decode(Schemas.ResponseTextAnnotationDeltaEvent.self, from: data)))
        case .responseOutputTextDone:
                .outputText(.done(try decoder.decode(Schemas.ResponseTextDoneEvent.self, from: data)))
        case .responseRefusalDelta:
                .refusal(.delta(try decoder.decode(Schemas.ResponseRefusalDeltaEvent.self, from: data)))
        case .responseRefusalDone:
                .refusal(.done(try decoder.decode(Schemas.ResponseRefusalDoneEvent.self, from: data)))
        case .responseFunctionCallArgumentsDelta:
                .functionCallArguments(.delta(try decoder.decode(Schemas.ResponseFunctionCallArgumentsDeltaEvent.self, from: data)))
        case .responseFunctionCallArgumentsDone:
                .functionCallArguments(.done(try decoder.decode(Schemas.ResponseFunctionCallArgumentsDoneEvent.self, from: data)))
        case .responseFileSearchCallInProgress:
                .fileSearchCall(.inProgress(try decode(data: data)))
        case .responseFileSearchCallSearching:
                .fileSearchCall(.searching(try decode(data: data)))
        case .responseFileSearchCallCompleted:
                .fileSearchCall(.completed(try decode(data: data)))
        case .responseWebSearchCallInProgress:
                .webSearchCall(.inProgress(try decode(data: data)))
        case .responseWebSearchCallSearching:
                .webSearchCall(.searching(try decode(data: data)))
        case .responseWebSearchCallCompleted:
                .webSearchCall(.completed(try decode(data: data)))
        case .responseAudioDelta:
                .audio(.delta(try decode(data: data)))
        case .responseAudioDone:
                .audio(.done(try decode(data: data)))
        case .responseAudioTranscriptDelta:
                .audioTranscript(.delta(try decode(data: data)))
        case .responseAudioTranscriptDone:
                .audioTranscript(.done(try decode(data: data)))
        case .responseCodeInterpreterCallCodeDelta:
                .codeInterpreterCall(
                    .code(
                        .delta(
                            try decode(data: data)
                        )
                    )
                )
        case .responseCodeInterpreterCallCodeDone:
                .codeInterpreterCall(
                    .code(
                        .done(try decode(data: data))
                    )
                )
        case .responseCodeInterpreterCallInProgress:
                .codeInterpreterCall(.inProgress(try decode(data: data)))
        case .responseCodeInterpreterCallInterpreting:
                .codeInterpreterCall(.interpreting(try decode(data: data)))
        case .responseCodeInterpreterCallCompleted:
                .codeInterpreterCall(.completed(try decode(data: data)))
        case .error:
                .error(try decode(data: data))
        }
    }
    
    private func decode<T: Codable>(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
