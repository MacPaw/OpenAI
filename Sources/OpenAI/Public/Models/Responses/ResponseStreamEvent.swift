//
//  ResponseStreamEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import Foundation

public enum ResponseStreamEvent: Codable, Equatable, Sendable {
    public typealias Schemas = Components.Schemas
    
    public enum OutputItemEvent: Codable, Equatable, Sendable {
        /// Emitted when a new output item is added.
        case added(Schemas.ResponseOutputItemAddedEvent)
        /// Emitted when an output item is marked done.
        case done(Schemas.ResponseOutputItemDoneEvent)
    }
    
    public enum ContentPartEvent: Codable, Equatable, Sendable {
        /// Emitted when a new content part is added.
        case added(Schemas.ResponseContentPartAddedEvent)
        /// Emitted when a content part is done.
        case done(Schemas.ResponseContentPartDoneEvent)
    }
    
    public enum OutputTextEvent: Codable, Equatable, Sendable {
        /// Emitted when there is an additional text delta.
        case delta(Schemas.ResponseTextDeltaEvent)
        /// Emitted when a text annotation is added.
        case annotationAdded(Schemas.ResponseTextAnnotationDeltaEvent)
        /// Emitted when text content is finalized.
        case done(Schemas.ResponseTextDoneEvent)
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
    case created(Schemas.ResponseCreatedEvent)
    /// Emitted when the response is in progress.
    case inProgress(Schemas.ResponseInProgressEvent)
    /// Emitted when the model response is complete.
    case completed(Schemas.ResponseCompletedEvent)
    /// An event that is emitted when a response fails.
    case failed(Schemas.ResponseFailedEvent)
    /// An event that is emitted when a response finishes as incomplete.
    case incomplete(Schemas.ResponseIncompleteEvent)
    
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
        case unknownEvent(Components.Schemas.ResponseStreamEvent)
    }
    
    public init(from decoder: any Decoder) throws {
        let rawEvent = try Components.Schemas.ResponseStreamEvent(from: decoder)
        if let audioDelta = rawEvent.value1 {
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
        } else if let value = rawEvent.value10 {
            self = .completed(value)
        } else if let value = rawEvent.value11 {
            self = .contentPart(.added(value))
        } else if let value = rawEvent.value12 {
            self = .contentPart(.done(value))
        } else if let value = rawEvent.value13 {
            self = .created(value)
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
        } else if let value = rawEvent.value20 {
            self = .inProgress(value)
        } else if let value = rawEvent.value21 {
            self = .failed(value)
        } else if let value = rawEvent.value22 {
            self = .incomplete(value)
        } else if let value = rawEvent.value23 {
            self = .outputItem(.added(value))
        } else if let value = rawEvent.value24 {
            self = .outputItem(.done(value))
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
