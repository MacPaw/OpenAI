//
//  StreamInterpreterTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 03.02.2025.
//

import Testing
import Foundation
@testable import OpenAI

struct StreamInterpreterTests {
    let interpreter = StreamInterpreter<ChatStreamResult>()
    
    @Test func testParseShortMessageResponseStream() throws {
        var chatStreamResults: [ChatStreamResult] = []
        interpreter.onEventDispatched = { chatStreamResults.append($0) }
        
        try interpreter.processData(chatCompletionChunk())
        try interpreter.processData(chatCompletionChunkTermination())
        #expect(chatStreamResults.count == 3)
    }
    
    // https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation
    // If the line starts with a U+003A COLON character (:)
    // - Ignore the line.
    @Test func testIgnoresLinesStartingWithColon() throws {
        var chatStreamResults: [ChatStreamResult] = []
        interpreter.onEventDispatched = { chatStreamResults.append($0) }
        
        try interpreter.processData(chatCompletionChunkWithComment())
        #expect(chatStreamResults.count == 1)
    }
    
    @Test func parseApiError() throws {
        do {
            try interpreter.processData(chatCompletionError())
        } catch {
            #expect(error is APIErrorResponse)
        }
    }
    
    // Chunk with 3 objects. I captured it from a real response. It's a very short response that contains just "Hi"
    private func chatCompletionChunk() -> Data {
        "data: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":null,\"choices\":[{\"index\":0,\"delta\":{\"role\":\"assistant\",\"content\":\"\",\"refusal\":null},\"logprobs\":null,\"finish_reason\":null}]}\n\ndata: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":null,\"choices\":[{\"index\":0,\"delta\":{\"content\":\"Hi\"},\"logprobs\":null,\"finish_reason\":null}]}\n\ndata: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":null,\"choices\":[{\"index\":0,\"delta\":{},\"logprobs\":null,\"finish_reason\":\"stop\"}]}\n\n".data(using: .utf8)!
    }
    
    private func chatCompletionChunkWithComment() -> Data {
        ": OPENROUTER PROCESSING\n\ndata: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":null,\"choices\":[{\"index\":0,\"delta\":{\"role\":\"assistant\",\"content\":\"\",\"refusal\":null},\"logprobs\":null,\"finish_reason\":null}]}\n\n".data(using: .utf8)!
    }
    
    private func chatCompletionChunkTermination() -> Data {
        "data: [DONE]\n\n".data(using: .utf8)!
    }
    
    // Copied from an actual reponse that was an input to inreptreter
    private func chatCompletionError() -> Data {
        "{\n    \"error\": {\n        \"message\": \"The model `o3-mini` does not exist or you do not have access to it.\",\n        \"type\": \"invalid_request_error\",\n        \"param\": null,\n        \"code\": \"model_not_found\"\n    }\n}\n".data(using: .utf8)!
    }
}
