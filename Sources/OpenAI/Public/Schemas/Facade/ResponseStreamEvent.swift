//
//  ResponseStreamEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import Foundation

/// Improved interface to use instead of generated `Components.Schemas.ResponseStreamEvent`
public enum ResponseStreamEvent: Codable, Equatable, Sendable {
    public typealias Schemas = Components.Schemas
    public typealias OutputItem = Components.Schemas.OutputItem
    public typealias OutputContent = Components.Schemas.OutputContent
    public typealias OutputText = Components.Schemas.OutputText
    public typealias Annotation = Components.Schemas.Annotation
    
    public enum OutputItemEvent: Codable, Equatable, Sendable {
        /// Emitted when a new output item is added.
        case added(ResponseOutputItemAddedEvent)
        /// Emitted when an output item is marked done.
        case done(ResponseOutputItemDoneEvent)
    }
    
    public enum ContentPartEvent: Codable, Equatable, Sendable {
        /// Emitted when a new content part is added.
        case added(Schemas.ResponseContentPartAddedEvent)
        /// Emitted when a content part is done.
        case done(Schemas.ResponseContentPartDoneEvent)
    }
    
    public enum OutputTextEvent: Codable, Equatable, Sendable, CustomStringConvertible {
        /// Emitted when there is an additional text delta.
        case delta(Schemas.ResponseTextDeltaEvent)
        /// Emitted when a text annotation is added.
        case annotationAdded(Schemas.ResponseTextAnnotationDeltaEvent)
        /// Emitted when text content is finalized.
        case done(Schemas.ResponseTextDoneEvent)
        
        public var description: String {
            switch self {
            case .delta(let event):
                return "OutputTextEvent.delta(delta: \(event))"
            case .annotationAdded(let event):
                return "OutputTextEvent.annotationAdded(annotation: \(event))"
            case .done(let event):
                return "OutputTextEvent.done(done: \(event))"
            }
        }
    }
    
    public enum RefusalEvent: Codable, Equatable, Sendable {
        /// Emitted when there is a partial refusal text.
        case delta(Schemas.ResponseRefusalDeltaEvent)
        /// Emitted when refusal text is finalized.
        case done(Schemas.ResponseRefusalDoneEvent)
    }
    
    public enum FunctionCallArgumentsEvent: Codable, Equatable, Sendable {
        /// Emitted when there is a partial function-call arguments delta.
        case delta(Schemas.ResponseFunctionCallArgumentsDeltaEvent)
        /// Emitted when function-call arguments are finalized.
        case done(Schemas.ResponseFunctionCallArgumentsDoneEvent)
    }
    
    public enum FileSearchCallEvent: Codable, Equatable, Sendable {
        /// Emitted when a file search call is initiated.
        case inProgress(Schemas.ResponseFileSearchCallInProgressEvent)
        /// Emitted when a file search is currently searching.
        case searching(Schemas.ResponseFileSearchCallSearchingEvent)
        /// Emitted when a file search call is completed (results found).
        case completed(Schemas.ResponseFileSearchCallCompletedEvent)
    }
    
    public enum WebSearchCallEvent: Codable, Equatable, Sendable {
        /// Emitted when a web search call is initiated.
        case inProgress(Schemas.ResponseWebSearchCallInProgressEvent)
        /// Emitted when a web search call is executing.
        case searching(Schemas.ResponseWebSearchCallSearchingEvent)
        /// Emitted when a web search call is completed.
        case completed(Schemas.ResponseWebSearchCallCompletedEvent)
    }
    
    public enum AudioEvent: Codable, Equatable, Sendable {
        case delta(Schemas.ResponseAudioDeltaEvent)
        case done(Schemas.ResponseAudioDoneEvent)
    }
    
    public enum AudioTranscriptEvent: Codable, Equatable, Sendable {
        case delta(Schemas.ResponseAudioTranscriptDeltaEvent)
        case done(Schemas.ResponseAudioTranscriptDoneEvent)
    }
    
    public enum CodeInterpreterCallEvent: Codable, Equatable, Sendable {
        public enum CodeEvent: Codable, Equatable, Sendable {
            case delta(Schemas.ResponseCodeInterpreterCallCodeDeltaEvent)
            case done(Schemas.ResponseCodeInterpreterCallCodeDoneEvent)
        }
        
        case code(CodeEvent)
        case completed(Schemas.ResponseCodeInterpreterCallCompletedEvent)
        case inProgress(Schemas.ResponseCodeInterpreterCallInProgressEvent)
        case interpreting(Schemas.ResponseCodeInterpreterCallInterpretingEvent)
    }
    
    /// An event that is emitted when a response is created.
    case created(ResponseEvent)
    /// Emitted when the response is in progress.
    case inProgress(ResponseEvent)
    /// Emitted when the model response is complete.
    case completed(ResponseEvent)
    /// An event that is emitted when a response fails.
    case failed(ResponseEvent)
    /// An event that is emitted when a response finishes as incomplete.
    case incomplete(ResponseEvent)
    
    case outputItem(OutputItemEvent)
    case contentPart(ContentPartEvent)
    case outputText(OutputTextEvent)
    case audio(AudioEvent)
    case audioTranscript(AudioTranscriptEvent)
    case codeInterpreterCall(CodeInterpreterCallEvent)
    case error(Schemas.ResponseErrorEvent)
    case fileSearchCall(FileSearchCallEvent)
    case functionCallArguments(FunctionCallArgumentsEvent)
    case refusal(RefusalEvent)
    case webSearchCall(WebSearchCallEvent)
    
    enum ResponseStreamEventDecodingError: Error {
        case unknownEventType(String)
        case unknownEvent(Components.Schemas.ResponseStreamEvent)
        case unexpectedParsingCase
    }
    
    public init(from decoder: any Decoder) throws {
        do {
            // Decoding Response Event
            let responseEvent = try ResponseEvent(from: decoder)
            guard let responseEventType = ModelResponseStreamEventType(rawValue: responseEvent.type) else {
                throw ResponseStreamEventDecodingError.unknownEventType(responseEvent.type)
            }
            
            switch responseEventType {
            case .responseCreated:
                self = .created(responseEvent)
            case .responseInProgress:
                self = .inProgress(responseEvent)
            case .responseCompleted:
                self = .completed(responseEvent)
            case .responseFailed:
                self = .failed(responseEvent)
            case .responseIncomplete:
                self = .incomplete(responseEvent)
            default:
                throw ResponseStreamEventDecodingError.unknownEventType(responseEvent.type)
            }
        } catch {
            // Do nothing, will try other coding types
        }
        
        do {
            // Decoding Output Item events
            let outputItemAddedEvent = try ResponseOutputItemAddedEvent(from: decoder)
            self = .outputItem(.added(outputItemAddedEvent))
        } catch {
            // Do nothing, will try other coding types
        }
        
        do {
            // Decoding Output Item events
            let outputItemDoneEvent = try ResponseOutputItemDoneEvent(from: decoder)
            self = .outputItem(.done(outputItemDoneEvent))
        } catch {
            // Do nothing, will try other coding types
        }
        
        let rawEvent = try Components.Schemas.ResponseStreamEvent(from: decoder)
        if rawEvent.value10 != nil || rawEvent.value13 != nil || rawEvent.value20 != nil || rawEvent.value21 != nil, rawEvent.value22 != nil {
            // The following events are handled elsewhere by non-generated types
            // (search "Decoding Response Event")
            //
            // `response.completed`
            // `response.created`
            // `response.inProgress`
            // `response.failed`
            // `response.incomplete`
            throw ResponseStreamEventDecodingError.unexpectedParsingCase
        } else if rawEvent.value23 != nil || rawEvent.value24 != nil {
            // The following events are handled elsewhere by non-generated types
            // (search "Decoding Output Item events")
            //
            // `response.output_item.added`
            // `response.output_item.done`
            throw ResponseStreamEventDecodingError.unexpectedParsingCase
        } else if let audioDelta = rawEvent.value1 {
            self = .audio(.delta(audioDelta))
        } else if let value = rawEvent.value2 {
            self = .audio(.done(value))
        } else if let value = rawEvent.value3 {
            self = .audioTranscript(.delta(value))
        } else if let value = rawEvent.value4 {
            self = .audioTranscript(.done(value))
        } else if let value = rawEvent.value5 {
            self = .codeInterpreterCall(.code(.delta(value)))
        } else if let value = rawEvent.value6 {
            self = .codeInterpreterCall(.code(.done(value)))
        } else if let value = rawEvent.value7 {
            self = .codeInterpreterCall(.completed(value))
        } else if let value = rawEvent.value8 {
            self = .codeInterpreterCall(.inProgress(value))
        } else if let value = rawEvent.value9 {
            self = .codeInterpreterCall(.interpreting(value))
        } else if let value = rawEvent.value11 {
            self = .contentPart(.added(value))
        } else if let value = rawEvent.value12 {
            self = .contentPart(.done(value))
        } else if let value = rawEvent.value14 {
            self = .error(value)
        } else if let value = rawEvent.value15 {
            self = .fileSearchCall(.completed(value))
        } else if let value = rawEvent.value16 {
            self = .fileSearchCall(.inProgress(value))
        } else if let value = rawEvent.value17 {
            self = .fileSearchCall(.searching(value))
        } else if let value = rawEvent.value18 {
            self = .functionCallArguments(.delta(value))
        } else if let value = rawEvent.value19 {
            self = .functionCallArguments(.done(value))
        } else if let value = rawEvent.value25 {
            self = .refusal(.delta(value))
        } else if let value = rawEvent.value26 {
            self = .refusal(.done(value))
        } else if let value = rawEvent.value27 {
            self = .outputText(.annotationAdded(value))
        } else if let value = rawEvent.value28 {
            self = .outputText(.delta(value))
        } else if let value = rawEvent.value29 {
            self = .outputText(.done(value))
        } else if let value = rawEvent.value30 {
            self = .webSearchCall(.completed(value))
        } else if let value = rawEvent.value31 {
            self = .webSearchCall(.inProgress(value))
        } else if let value = rawEvent.value32 {
            self = .webSearchCall(.searching(value))
        } else {
            throw ResponseStreamEventDecodingError.unknownEvent(rawEvent)
        }
    }
}
