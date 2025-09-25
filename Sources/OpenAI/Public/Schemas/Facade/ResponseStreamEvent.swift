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
        /// Emitted when there is a delta (partial update) to the reasoning content.
        case delta(Schemas.ResponseReasoningDeltaEvent)
        /// Emitted when the reasoning content is finalized for an item.
        case done(Schemas.ResponseReasoningDoneEvent)
    }
    
    public enum ReasoningSummaryEvent: Codable, Equatable, Sendable {
        /// Emitted when there is a delta (partial update) to the reasoning summary content.
        case delta(Schemas.ResponseReasoningSummaryDeltaEvent)
        /// Emitted when the reasoning summary content is finalized for an item.
        case done(Schemas.ResponseReasoningSummaryDoneEvent)
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
    case reasoningSummary(ReasoningSummaryEvent)
    
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
            case .responseQueued:
                self = .queued(responseEvent)
            default:
                throw ResponseStreamEventDecodingError.unknownEventType(responseEvent.type)
            }
            return
        } catch {
            // Do nothing, will try other coding types
        }
        
        do {
            // Decoding Output Item events
            let outputItemAddedEvent = try ResponseOutputItemAddedEvent(from: decoder)
            self = .outputItem(.added(outputItemAddedEvent))
            return
        } catch {
            // Do nothing, will try other coding types
        }
        
        do {
            // Decoding Output Item events
            let outputItemDoneEvent = try ResponseOutputItemDoneEvent(from: decoder)
            self = .outputItem(.done(outputItemDoneEvent))
            return
        } catch {
            // Do nothing, will try other coding types
        }
        
        // Decoding MCPCallArgumentsEvent
        // Once OPENAI fix the response issue, can put back below code to rawEvent
        //        else if let value = rawEvent.value40 {
        //            self = .mcpCallArguments(.delta(value))
        //        } else if let value = rawEvent.value41 {
        //            self = .mcpCallArguments(.done(value))
        //        }
        do {
            let mcpCallArgumentsEvent = try MCPCallArgumentsEvent(from: decoder)
            switch mcpCallArgumentsEvent {
            case .delta(let deltaEvent):
                self = .mcpCallArguments(.delta(deltaEvent))
            case .done(let doneEvent):
                self = .mcpCallArguments(.done(doneEvent))
            }
            return
        } catch {
            //
        }
        
        let rawEvent = try Components.Schemas.ResponseStreamEvent(from: decoder)
        if rawEvent.value10 != nil || rawEvent.value13 != nil || rawEvent.value20 != nil || rawEvent.value21 != nil, rawEvent.value22 != nil, rawEvent.value40 != nil, rawEvent.value41 != nil, rawEvent.value49 != nil {
            // The following events are handled elsewhere by non-generated types
            // (search "Decoding Response Event")
            //
            // `response.completed`
            // `response.created`
            // `response.inProgress`
            // `response.failed`
            // `response.incomplete`
            // `response.queued`
            // `response.response.mcp_call_arguments.delta`
            // `response.mcp_call_arguments.done`
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
            self = .reasoningSummaryPart(.added(value))
        } else if let value = rawEvent.value26 {
            self = .reasoningSummaryPart(.done(value))
        } else if let value = rawEvent.value27 {
            self = .reasoningSummaryText(.delta(value))
        } else if let value = rawEvent.value28 {
            self = .reasoningSummaryText(.done(value))
        } else if let value = rawEvent.value29 {
            self = .refusal(.delta(value))
        } else if let value = rawEvent.value30 {
            self = .refusal(.done(value))
        } else if let value = rawEvent.value31 {
            self = .outputText(.delta(value))
        } else if let value = rawEvent.value32 {
            self = .outputText(.done(value))
        } else if let value = rawEvent.value33 {
            self = .webSearchCall(.completed(value))
        } else if let value = rawEvent.value34 {
            self = .webSearchCall(.inProgress(value))
        } else if let value = rawEvent.value35 {
            self = .webSearchCall(.searching(value))
        } else if let value = rawEvent.value36 {
            self = .imageGenerationCall(.completed(value))
        } else if let value = rawEvent.value37 {
            self = .imageGenerationCall(.generating(value))
        } else if let value = rawEvent.value38 {
            self = .imageGenerationCall(.inProgress(value))
        } else if let value = rawEvent.value39 {
            self = .imageGenerationCall(.partialImage(value))
        } else if let value = rawEvent.value42 {
            self = .mcpCall(.completed(value))
        } else if let value = rawEvent.value43 {
            self = .mcpCall(.failed(value))
        } else if let value = rawEvent.value44 {
            self = .mcpCall(.inProgress(value))
        } else if let value = rawEvent.value45 {
            self = .mcpListTools(.completed(value))
        } else if let value = rawEvent.value46 {
            self = .mcpListTools(.failed(value))
        } else if let value = rawEvent.value47 {
            self = .mcpListTools(.inProgress(value))
        } else if let value = rawEvent.value48 {
            self = .outputTextAnnotation(.added(value))
        } else if let value = rawEvent.value50 {
            self = .reasoning(.delta(value))
        } else if let value = rawEvent.value51 {
            self = .reasoning(.done(value))
        } else if let value = rawEvent.value52 {
            self = .reasoningSummary(.delta(value))
        } else if let value = rawEvent.value53 {
            self = .reasoningSummary(.done(value))
        } else {
            throw ResponseStreamEventDecodingError.unknownEvent(rawEvent)
        }
    }
}
