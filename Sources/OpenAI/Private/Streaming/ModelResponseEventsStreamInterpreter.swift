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
    
    enum InterpreterError: DescribedError {
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
                .created(try decode(data: data))
        case .responseInProgress:
                .inProgress(try decode(data: data))
        case .responseCompleted:
                .completed(try decode(data: data))
        case .responseFailed:
                .failed(try decode(data: data))
        case .responseIncomplete:
                .incomplete(try decode(data: data))
        case .responseOutputItemAdded:
                .outputItem(.added(try decode(data: data)))
        case .responseOutputItemDone:
                .outputItem(.done(try decode(data: data)))
        case .responseContentPartAdded:
                .contentPart(.added(try decode(data: data)))
        case .responseContentPartDone:
                .contentPart(.done(try decode(data: data)))
        case .responseOutputTextDelta:
                .outputText(.delta(try decode(data: data)))
        case .responseOutputTextDone:
                .outputText(.done(try decode(data: data)))
        case .responseRefusalDelta:
                .refusal(.delta(try decode(data: data)))
        case .responseRefusalDone:
                .refusal(.done(try decode(data: data)))
        case .responseFunctionCallArgumentsDelta:
                .functionCallArguments(.delta(try decode(data: data)))
        case .responseFunctionCallArgumentsDone:
                .functionCallArguments(.done(try decode(data: data)))
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
        case .responseReasoningSummaryPartAdded:
                .reasoningSummaryPart(.added(try decode(data: data)))
        case .responseReasoningSummaryPartDone:
                .reasoningSummaryPart(.done(try decode(data: data)))
        case .responseReasoningSummaryTextDelta:
                .reasoningSummaryText(.delta(try decode(data: data)))
        case .responseReasoningSummaryTextDone:
                .reasoningSummaryText(.done(try decode(data: data)))
        case .responseImageGenerationCallCompleted:
                .imageGenerationCall(.completed(try decode(data: data)))
        case .responseImageGenerationCallGenerating:
                .imageGenerationCall(.generating(try decode(data: data)))
        case .responseImageGenerationCallInProgress:
                .imageGenerationCall(.inProgress(try decode(data: data)))
        case .responseImageGenerationCallPartialImage:
                .imageGenerationCall(.partialImage(try decode(data: data)))
        case .responseMcpCallArgumentsDelta:
                .mcpCall(.arguments(.delta(try decode(data: data))))
        case .responseMcpCallArgumentsDone:
                .mcpCall(.arguments(.done(try decode(data: data))))
        case .responseMcpCallCompleted:
                .mcpCall(.completed(try decode(data: data)))
        case .responseMcpCallFailed:
                .mcpCall(.failed(try decode(data: data)))
        case .responseMcpCallInProgress:
                .mcpCall(.inProgress(try decode(data: data)))
        case .responseMcpListToolsCompleted:
                .mcpListTools(.completed(try decode(data: data)))
        case .responseMcpListToolsFailed:
                .mcpListTools(.failed(try decode(data: data)))
        case .responseMcpListToolsInProgress:
                .mcpListTools(.inProgress(try decode(data: data)))
        case .responseQueued:
                .queued(try decode(data: data))
        case .responseReasoningDelta:
                .reasoning(.delta(try decode(data: data)))
        case .responseReasoningDone:
                .reasoning(.done(try decode(data: data)))
        case .responseReasoningSummaryDelta:
                .reasoningSummary(.delta(try decode(data: data)))
        case .responseReasoningSummaryDone:
                .reasoningSummary(.done(try decode(data: data)))
        case .responseOutputTextAnnotationAdded:
                .outputTextAnnotation(.added(try decode(data: data)))
        case .responseAudioDelta:
            // Audio, AudioTranscript and CodeInterpreter events are not part of API Reference at the moment
            // But they are present in code generated from OpenAPI spec, so we also include it
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
