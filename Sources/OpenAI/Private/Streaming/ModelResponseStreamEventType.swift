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
    
    case responseOutputItemAdded = "response.output_item.added"
    case responseOutputItemDone = "response.output_item.done"
    
    case responseContentPartAdded = "response.content_part.added"
    case responseContentPartDone = "response.content_part.done"
    
    case responseOutputTextDelta = "response.output_text.delta"
    case responseOutputTextAnnotationAdded = "response.output_text.annotation.added"
    case responseOutputTextDone = "response.output_text.done"
    
    case responseRefusalDelta = "response.refusal.delta"
    case responseRefusalDone = "response.refusal.done"
    
    case responseFunctionCallArgumentsDelta = "response.function_call.arguments.delta"
    case responseFunctionCallArgumentsDone = "response.function_call.arguments.done"
    
    case responseFileSearchCallInProgress = "response.file_search_call.in_progress"
    case responseFileSearchCallSearching = "response.file_search_call.searching"
    case responseFileSearchCallCompleted = "response.file_search_call.completed"
    
    case responseWebSearchCallInProgress = "response.web_search_call.in_progress"
    case responseWebSearchCallSearching = "response.web_search_call.searching"
    case responseWebSearchCallCompleted = "response.web_search_call.completed"
    
    case responseAudioDelta = "response.audio.delta"
    case responseAudioDone = "response.audio.done"
    
    case responseAudioTranscriptDelta = "response.audio_transcript.delta"
    case responseAudioTranscriptDone = "response.audio_transcript.done"
    
    case responseCodeInterpreterCallCodeDelta = "response.code_interpreter_call.code.delta"
    case responseCodeInterpreterCallCodeDone = "response.code_interpreter_call.code.done"
    case responseCodeInterpreterCallInProgress = "response.code_interpreter_call.in_progress"
    case responseCodeInterpreterCallInterpreting = "response.code_interpreter_call.interpreting"
    case responseCodeInterpreterCallCompleted = "response.code_interpreter_call.completed"
    
    case error = "error"
}
