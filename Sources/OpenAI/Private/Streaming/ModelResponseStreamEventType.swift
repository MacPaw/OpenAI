//
//  ModelResponseStreamEventType.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 17.04.2025.
//

import Foundation

enum ModelResponseStreamEventType: String {
    case responseCreated = "response.created"
    case responseInProgress = "response.in_progress"
    case responseCompleted = "response.completed"
    case responseFailed = "response.failed"
    case responseIncomplete = "response.incomplete"
    case responseQueued = "response.queued"
    
    case responseOutputItemAdded = "response.output_item.added"
    case responseOutputItemDone = "response.output_item.done"
    
    case responseContentPartAdded = "response.content_part.added"
    case responseContentPartDone = "response.content_part.done"
    
    case responseOutputTextDelta = "response.output_text.delta"
    case responseOutputTextDone = "response.output_text.done"
    
    case responseRefusalDelta = "response.refusal.delta"
    case responseRefusalDone = "response.refusal.done"
    
    case responseFunctionCallArgumentsDelta = "response.function_call_arguments.delta"
    case responseFunctionCallArgumentsDone = "response.function_call_arguments.done"
    
    case responseFileSearchCallInProgress = "response.file_search_call.in_progress"
    case responseFileSearchCallSearching = "response.file_search_call.searching"
    case responseFileSearchCallCompleted = "response.file_search_call.completed"
    
    case responseWebSearchCallInProgress = "response.web_search_call.in_progress"
    case responseWebSearchCallSearching = "response.web_search_call.searching"
    case responseWebSearchCallCompleted = "response.web_search_call.completed"
    
    case responseReasoningSummaryPartAdded = "response.reasoning_summary_part.added"
    case responseReasoningSummaryPartDone = "response.reasoning_summary_part.done"
    
    case responseReasoningSummaryTextDelta = "response.reasoning_summary_text.delta"
    case responseReasoningSummaryTextDone = "response.reasoning_summary_text.done"
    
    case responseImageGenerationCallCompleted = "response.image_generation_call.completed"
    case responseImageGenerationCallGenerating = "response.image_generation_call.generating"
    case responseImageGenerationCallInProgress = "response.image_generation_call.in_progress"
    case responseImageGenerationCallPartialImage = "response.image_generation_call.partial_image"
    
    // 😌(🤬) Once OpenAI fixed the issue, please rename this back to
    // response.mcp_call.arguments.delta
    // response.mcp_call.arguments.done
    case responseMcpCallArgumentsDelta = "response.mcp_call_arguments.delta"
    case responseMcpCallArgumentsDone = "response.mcp_call_arguments.done"
    
    case responseMcpCallCompleted = "response.mcp_call.completed"
    case responseMcpCallFailed = "response.mcp_call.failed"
    case responseMcpCallInProgress = "response.mcp_call.in_progress"
    
    case responseMcpListToolsCompleted = "response.mcp_list_tools.completed"
    case responseMcpListToolsFailed = "response.mcp_list_tools.failed"
    case responseMcpListToolsInProgress = "response.mcp_list_tools.in_progress"
    
    case responseOutputTextAnnotationAdded = "response.output_text_annotation.added"
    
    case responseReasoningDelta = "response.reasoning.delta"
    case responseReasoningDone = "response.reasoning.done"
    
    case responseReasoningSummaryDelta = "response.reasoning_summary.delta"
    case responseReasoningSummaryDone = "response.reasoning_summary.done"
    
    case error = "error"
    
    // The following events are not present in the API Reference at the moment, but they are in generated code, so we also include them just in case
    case responseAudioDelta = "response.audio.delta"
    case responseAudioDone = "response.audio.done"
    case responseAudioTranscriptDelta = "response.audio_transcript.delta"
    case responseAudioTranscriptDone = "response.audio_transcript.done"
    case responseCodeInterpreterCallCodeDelta = "response.code_interpreter_call.code.delta"
    case responseCodeInterpreterCallCodeDone = "response.code_interpreter_call.code.done"
    case responseCodeInterpreterCallInProgress = "response.code_interpreter_call.in_progress"
    case responseCodeInterpreterCallInterpreting = "response.code_interpreter_call.interpreting"
    case responseCodeInterpreterCallCompleted = "response.code_interpreter_call.completed"
}
