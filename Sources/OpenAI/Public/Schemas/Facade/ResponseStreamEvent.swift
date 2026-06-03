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
    public typealias OutputContent = Components.Schemas.OutputContent
    public typealias OutputText = Components.Schemas.OutputTextContent
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
        /// Emitted when text content is finalized.
        case done(Schemas.ResponseTextDoneEvent)
        
        public var description: String {
            switch self {
            case .delta(let event):
                return "OutputTextEvent.delta(delta: \(event))"
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
        case done(ResponseFunctionCallArgumentsDoneEvent)
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
    
    public enum ReasoningSummaryPartEvent: Codable, Equatable, Sendable {
        /// Emitted when a new reasoning summary part is added.
        case added(Schemas.ResponseReasoningSummaryPartAddedEvent)
        /// Emitted when a reasoning summary part is completed.
        case done(Schemas.ResponseReasoningSummaryPartDoneEvent)
    }
    
    public enum ReasoningSummaryTextEvent: Codable, Equatable, Sendable {
        /// Emitted when a delta is added to a reasoning summary text.
        case delta(Schemas.ResponseReasoningSummaryTextDeltaEvent)
        /// Emitted when a reasoning summary text is completed.
        case done(Schemas.ResponseReasoningSummaryTextDoneEvent)
    }
    
    public enum ImageGenerationCallEvent: Codable, Equatable, Sendable {
        /// Emitted when an image generation tool call has completed and the final image is available.
        case completed(Schemas.ResponseImageGenCallCompletedEvent)
        /// Emitted when an image generation tool call is actively generating an image (intermediate state).
        case generating(Schemas.ResponseImageGenCallGeneratingEvent)
        /// Emitted when an image generation tool call is in progress.
        case inProgress(Schemas.ResponseImageGenCallInProgressEvent)
        /// Emitted when a partial image is available during image generation streaming.
        case partialImage(Schemas.ResponseImageGenCallPartialImageEvent)
    }
    
    public enum MCPCallArgumentsEvent: Codable, Equatable, Sendable {
        /// Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        case delta(ResponseMCPCallArgumentsDeltaEvent)
        /// Emitted when the arguments for an MCP tool call are finalized.
        case done(ResponseMCPCallArgumentsDoneEvent)
    }
    
    public enum MCPCallEvent: Codable, Equatable, Sendable {
        /// Emitted when an MCP tool call has completed successfully.
        case completed(Schemas.ResponseMCPCallCompletedEvent)
        /// Emitted when an MCP tool call has failed.
        case failed(Schemas.ResponseMCPCallFailedEvent)
        /// Emitted when an MCP tool call is in progress.
        case inProgress(Schemas.ResponseMCPCallInProgressEvent)
    }
    
    public enum MCPListToolsEvent: Codable, Equatable, Sendable {
        /// Emitted when the list of available MCP tools has been successfully retrieved.
        case completed(Schemas.ResponseMCPListToolsCompletedEvent)
        /// Emitted when the attempt to list available MCP tools has failed.
        case failed(Schemas.ResponseMCPListToolsFailedEvent)
        /// Emitted when the system is in the process of retrieving the list of available MCP tools.
        case inProgress(Schemas.ResponseMCPListToolsInProgressEvent)
    }
    
    public enum OutputTextAnnotationEvent: Codable, Equatable, Sendable {
        /// Emitted when an annotation is added to output text content.
        case added(Schemas.ResponseOutputTextAnnotationAddedEvent)
    }
    
    public enum ReasoningEvent: Codable, Equatable, Sendable {
        /// Emitted when a delta is added to a reasoning text.
        case delta(Schemas.ResponseReasoningTextDeltaEvent)
        /// Emitted when a reasoning text is completed.
        case done(Schemas.ResponseReasoningTextDoneEvent)
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
    /// Emitted when a response is queued and waiting to be processed.
    case queued(ResponseEvent)
    
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
    case reasoningSummaryPart(ReasoningSummaryPartEvent)
    case reasoningSummaryText(ReasoningSummaryTextEvent)
    case imageGenerationCall(ImageGenerationCallEvent)
    case mcpCall(MCPCallEvent)
    case mcpCallArguments(MCPCallArgumentsEvent)
    case mcpListTools(MCPListToolsEvent)
    case outputTextAnnotation(OutputTextAnnotationEvent)
    case reasoning(ReasoningEvent)
    
    enum ResponseStreamEventDecodingError: Error {
        case unknownEventType(String)
    }

    public init(from decoder: any Decoder) throws {
        struct TypeProbe: Decodable { let type: String }

        let eventTypeString = try TypeProbe(from: decoder).type
        guard let eventType = ModelResponseStreamEventType(rawValue: eventTypeString) else {
            throw ResponseStreamEventDecodingError.unknownEventType(eventTypeString)
        }

        switch eventType {
        case .responseCreated:
            self = .created(try ResponseEvent(from: decoder))
        case .responseInProgress:
            self = .inProgress(try ResponseEvent(from: decoder))
        case .responseCompleted:
            self = .completed(try ResponseEvent(from: decoder))
        case .responseFailed:
            self = .failed(try ResponseEvent(from: decoder))
        case .responseIncomplete:
            self = .incomplete(try ResponseEvent(from: decoder))
        case .responseQueued:
            self = .queued(try ResponseEvent(from: decoder))
        case .responseOutputItemAdded:
            self = .outputItem(.added(try ResponseOutputItemAddedEvent(from: decoder)))
        case .responseOutputItemDone:
            self = .outputItem(.done(try ResponseOutputItemDoneEvent(from: decoder)))
        case .responseContentPartAdded:
            self = .contentPart(.added(try Schemas.ResponseContentPartAddedEvent(from: decoder)))
        case .responseContentPartDone:
            self = .contentPart(.done(try Schemas.ResponseContentPartDoneEvent(from: decoder)))
        case .responseOutputTextDelta:
            self = .outputText(.delta(try Schemas.ResponseTextDeltaEvent(from: decoder)))
        case .responseOutputTextDone:
            self = .outputText(.done(try Schemas.ResponseTextDoneEvent(from: decoder)))
        case .responseRefusalDelta:
            self = .refusal(.delta(try Schemas.ResponseRefusalDeltaEvent(from: decoder)))
        case .responseRefusalDone:
            self = .refusal(.done(try Schemas.ResponseRefusalDoneEvent(from: decoder)))
        case .responseFunctionCallArgumentsDelta:
            self = .functionCallArguments(.delta(try Schemas.ResponseFunctionCallArgumentsDeltaEvent(from: decoder)))
        case .responseFunctionCallArgumentsDone:
            // Uses the locally extracted type to preserve `name` (missing from the generated schema).
            self = .functionCallArguments(.done(try ResponseFunctionCallArgumentsDoneEvent(from: decoder)))
        case .responseFileSearchCallInProgress:
            self = .fileSearchCall(.inProgress(try Schemas.ResponseFileSearchCallInProgressEvent(from: decoder)))
        case .responseFileSearchCallSearching:
            self = .fileSearchCall(.searching(try Schemas.ResponseFileSearchCallSearchingEvent(from: decoder)))
        case .responseFileSearchCallCompleted:
            self = .fileSearchCall(.completed(try Schemas.ResponseFileSearchCallCompletedEvent(from: decoder)))
        case .responseWebSearchCallInProgress:
            self = .webSearchCall(.inProgress(try Schemas.ResponseWebSearchCallInProgressEvent(from: decoder)))
        case .responseWebSearchCallSearching:
            self = .webSearchCall(.searching(try Schemas.ResponseWebSearchCallSearchingEvent(from: decoder)))
        case .responseWebSearchCallCompleted:
            self = .webSearchCall(.completed(try Schemas.ResponseWebSearchCallCompletedEvent(from: decoder)))
        case .responseReasoningSummaryPartAdded:
            self = .reasoningSummaryPart(.added(try Schemas.ResponseReasoningSummaryPartAddedEvent(from: decoder)))
        case .responseReasoningSummaryPartDone:
            self = .reasoningSummaryPart(.done(try Schemas.ResponseReasoningSummaryPartDoneEvent(from: decoder)))
        case .responseReasoningSummaryTextDelta:
            self = .reasoningSummaryText(.delta(try Schemas.ResponseReasoningSummaryTextDeltaEvent(from: decoder)))
        case .responseReasoningSummaryTextDone:
            self = .reasoningSummaryText(.done(try Schemas.ResponseReasoningSummaryTextDoneEvent(from: decoder)))
        case .responseImageGenerationCallCompleted:
            self = .imageGenerationCall(.completed(try Schemas.ResponseImageGenCallCompletedEvent(from: decoder)))
        case .responseImageGenerationCallGenerating:
            self = .imageGenerationCall(.generating(try Schemas.ResponseImageGenCallGeneratingEvent(from: decoder)))
        case .responseImageGenerationCallInProgress:
            self = .imageGenerationCall(.inProgress(try Schemas.ResponseImageGenCallInProgressEvent(from: decoder)))
        case .responseImageGenerationCallPartialImage:
            self = .imageGenerationCall(.partialImage(try Schemas.ResponseImageGenCallPartialImageEvent(from: decoder)))
        case .responseMcpCallArgumentsDelta:
            // 😌(🤬) See ModelResponseStreamEventType.responseMcpCallArgumentsDelta for context.
            self = .mcpCallArguments(.delta(try ResponseMCPCallArgumentsDeltaEvent(from: decoder)))
        case .responseMcpCallArgumentsDone:
            self = .mcpCallArguments(.done(try ResponseMCPCallArgumentsDoneEvent(from: decoder)))
        case .responseMcpCallCompleted:
            self = .mcpCall(.completed(try Schemas.ResponseMCPCallCompletedEvent(from: decoder)))
        case .responseMcpCallFailed:
            self = .mcpCall(.failed(try Schemas.ResponseMCPCallFailedEvent(from: decoder)))
        case .responseMcpCallInProgress:
            self = .mcpCall(.inProgress(try Schemas.ResponseMCPCallInProgressEvent(from: decoder)))
        case .responseMcpListToolsCompleted:
            self = .mcpListTools(.completed(try Schemas.ResponseMCPListToolsCompletedEvent(from: decoder)))
        case .responseMcpListToolsFailed:
            self = .mcpListTools(.failed(try Schemas.ResponseMCPListToolsFailedEvent(from: decoder)))
        case .responseMcpListToolsInProgress:
            self = .mcpListTools(.inProgress(try Schemas.ResponseMCPListToolsInProgressEvent(from: decoder)))
        case .responseOutputTextAnnotationAdded:
            self = .outputTextAnnotation(.added(try Schemas.ResponseOutputTextAnnotationAddedEvent(from: decoder)))
        case .responseReasoningDelta:
            self = .reasoning(.delta(try Schemas.ResponseReasoningTextDeltaEvent(from: decoder)))
        case .responseReasoningDone:
            self = .reasoning(.done(try Schemas.ResponseReasoningTextDoneEvent(from: decoder)))
        case .error:
            self = .error(try Schemas.ResponseErrorEvent(from: decoder))
        case .responseAudioDelta:
            self = .audio(.delta(try Schemas.ResponseAudioDeltaEvent(from: decoder)))
        case .responseAudioDone:
            self = .audio(.done(try Schemas.ResponseAudioDoneEvent(from: decoder)))
        case .responseAudioTranscriptDelta:
            self = .audioTranscript(.delta(try Schemas.ResponseAudioTranscriptDeltaEvent(from: decoder)))
        case .responseAudioTranscriptDone:
            self = .audioTranscript(.done(try Schemas.ResponseAudioTranscriptDoneEvent(from: decoder)))
        case .responseCodeInterpreterCallCodeDelta:
            self = .codeInterpreterCall(.code(.delta(try Schemas.ResponseCodeInterpreterCallCodeDeltaEvent(from: decoder))))
        case .responseCodeInterpreterCallCodeDone:
            self = .codeInterpreterCall(.code(.done(try Schemas.ResponseCodeInterpreterCallCodeDoneEvent(from: decoder))))
        case .responseCodeInterpreterCallInProgress:
            self = .codeInterpreterCall(.inProgress(try Schemas.ResponseCodeInterpreterCallInProgressEvent(from: decoder)))
        case .responseCodeInterpreterCallInterpreting:
            self = .codeInterpreterCall(.interpreting(try Schemas.ResponseCodeInterpreterCallInterpretingEvent(from: decoder)))
        case .responseCodeInterpreterCallCompleted:
            self = .codeInterpreterCall(.completed(try Schemas.ResponseCodeInterpreterCallCompletedEvent(from: decoder)))
        }
    }
}
