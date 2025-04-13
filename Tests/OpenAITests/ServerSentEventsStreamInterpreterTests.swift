//
//  StreamInterpreterTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 03.02.2025.
//

import Testing
import Foundation
@testable import OpenAI

@MainActor
struct ServerSentEventsStreamInterpreterTests {
    private let interpreter = ServerSentEventsStreamInterpreter<ChatStreamResult>(
        parsingOptions: []
    )
    
    @Test func parseShortMessageResponseStream() async throws {
        var chatStreamResults: [ChatStreamResult] = []
        
        try await withCheckedThrowingContinuation { continuation in
            interpreter.setCallbackClosures { result in
                Task {
                    await MainActor.run {
                        chatStreamResults.append(result)
                        if chatStreamResults.count == 3 {
                            continuation.resume()
                        } else if chatStreamResults.count > 3 {
                            assert(false)
                        }
                    }
                }
            } onError: { error in
                continuation.resume(throwing: error)
            }
            
            interpreter.processData(chatCompletionChunk())
            interpreter.processData(chatCompletionChunkTermination())
        }
        
        #expect(chatStreamResults.count == 3)
    }
    
    // https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation
    // If the line starts with a U+003A COLON character (:)
    // - Ignore the line.
    @Test func ignoresLinesStartingWithColon() async throws {
        var chatStreamResults: [ChatStreamResult] = []
        try await withCheckedThrowingContinuation { continuation in
            interpreter.setCallbackClosures { result in
                Task {
                    await MainActor.run {
                        chatStreamResults.append(result)
                        continuation.resume()
                    }
                }
            } onError: { error in
                continuation.resume(throwing: error)
            }
            
            interpreter.processData(chatCompletionChunkWithComment())
        }
        
        #expect(chatStreamResults.count == 1)
    }
    
    @Test func parseApiError() async throws {
        var error: Error!
        
        await withCheckedContinuation { continuation in
            interpreter.setCallbackClosures { result in
            } onError: { apiError in
                Task {
                    await MainActor.run {
                        error = apiError
                        continuation.resume()
                    }
                }
            }
            
            interpreter.processData(chatCompletionError())
        }
        
        #expect(error is APIErrorResponse)
    }
    
    private func chatCompletionChunk() -> Data {
        MockServerSentEvent.chatCompletionChunk()
    }
    
    private func chatCompletionChunkWithComment() -> Data {
        ": OPENROUTER PROCESSING\n\ndata: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":\"sysfig\",\"choices\":[{\"index\":0,\"delta\":{\"role\":\"assistant\",\"content\":\"\",\"refusal\":null},\"logprobs\":null,\"finish_reason\":null}]}\n\n".data(using: .utf8)!
    }
    
    private func chatCompletionChunkTermination() -> Data {
        MockServerSentEvent.chatCompletionChunkTermination()
    }
    
    // Copied from an actual reponse that was an input to inreptreter
    private func chatCompletionError() -> Data {
        MockServerSentEvent.chatCompletionError()
    }
}

private actor ChatStreamResultsActor {
    var chatStreamResults: [ChatStreamResult] = []
}
