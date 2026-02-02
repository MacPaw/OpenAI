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

    @Test func parseWebSearchEvent() async throws {
        var webSearchEvents: [WebSearchEvent] = []

        await withCheckedContinuation { continuation in
            interpreter.setCallbackClosures { _ in
            } onWebSearchEvent: { event in
                Task {
                    await MainActor.run {
                        webSearchEvents.append(event)
                        continuation.resume()
                    }
                }
            } onError: { _ in
            }

            interpreter.processData(webSearchEventData())
        }

        #expect(webSearchEvents.count == 1)
        #expect(webSearchEvents.first?.type == "web_search_call")
        #expect(webSearchEvents.first?.status == .inProgress)
        #expect(webSearchEvents.first?.action?.query == "latest news")
    }

    @Test func parseWebSearchEventCompleted() async throws {
        var webSearchEvents: [WebSearchEvent] = []

        await withCheckedContinuation { continuation in
            interpreter.setCallbackClosures { _ in
            } onWebSearchEvent: { event in
                Task {
                    await MainActor.run {
                        webSearchEvents.append(event)
                        continuation.resume()
                    }
                }
            } onError: { _ in
            }

            interpreter.processData(webSearchEventCompletedData())
        }

        #expect(webSearchEvents.count == 1)
        #expect(webSearchEvents.first?.status == .completed)
    }

    @Test func webSearchEventDoesNotTriggerOnResult() async throws {
        var chatStreamResults: [ChatStreamResult] = []
        var webSearchEvents: [WebSearchEvent] = []

        await withCheckedContinuation { continuation in
            interpreter.setCallbackClosures { result in
                Task {
                    await MainActor.run {
                        chatStreamResults.append(result)
                    }
                }
            } onWebSearchEvent: { event in
                Task {
                    await MainActor.run {
                        webSearchEvents.append(event)
                        continuation.resume()
                    }
                }
            } onError: { _ in
            }

            interpreter.processData(webSearchEventData())
        }

        #expect(chatStreamResults.isEmpty)
        #expect(webSearchEvents.count == 1)
    }

    @Test func invalidWebSearchEventReportsError() async throws {
        var receivedError: Error?

        await withCheckedContinuation { continuation in
            interpreter.setCallbackClosures { _ in
            } onWebSearchEvent: { _ in
            } onError: { error in
                Task {
                    await MainActor.run {
                        receivedError = error
                        continuation.resume()
                    }
                }
            }

            interpreter.processData(invalidWebSearchEventData())
        }

        #expect(receivedError != nil)
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

    private func webSearchEventData() -> Data {
        "data: {\"type\":\"web_search_call\",\"item_id\":\"ws_123\",\"output_index\":0,\"status\":\"in_progress\",\"action\":{\"type\":\"search\",\"query\":\"latest news\"}}\n\n".data(using: .utf8)!
    }

    private func webSearchEventCompletedData() -> Data {
        "data: {\"type\":\"web_search_call\",\"item_id\":\"ws_123\",\"output_index\":0,\"status\":\"completed\"}\n\n".data(using: .utf8)!
    }

    private func invalidWebSearchEventData() -> Data {
        "data: {\"type\":\"web_search_call\",\"status\":\"unknown_status\"}\n\n".data(using: .utf8)!
    }
}

private actor ChatStreamResultsActor {
    var chatStreamResults: [ChatStreamResult] = []
}
