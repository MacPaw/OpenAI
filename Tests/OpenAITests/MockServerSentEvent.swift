//
//  MockServerSentEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.04.2025.
//

import Foundation

struct MockServerSentEvent {
    // Chunk with 3 objects. I captured it from a real response. It's a very short response that contains just "Hi"
    static func chatCompletionChunk() -> Data {
        "data: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":\"sysfig\",\"choices\":[{\"index\":0,\"delta\":{\"role\":\"assistant\",\"content\":\"\",\"refusal\":null},\"logprobs\":null,\"finish_reason\":null}]}\n\ndata: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":\"sysfig\",\"choices\":[{\"index\":0,\"delta\":{\"content\":\"Hi\"},\"logprobs\":null,\"finish_reason\":null}]}\n\ndata: {\"id\":\"chatcmpl-AwnboO5ZnaUyii9xxC5ZVmM5vGark\",\"object\":\"chat.completion.chunk\",\"created\":1738577084,\"model\":\"gpt-4-0613\",\"service_tier\":\"default\",\"system_fingerprint\":\"sysfig\",\"choices\":[{\"index\":0,\"delta\":{},\"logprobs\":null,\"finish_reason\":\"stop\"}]}\n\n".data(using: .utf8)!
    }
    
    static func chatCompletionChunkTermination() -> Data {
        "data: [DONE]\n\n".data(using: .utf8)!
    }
    
    static func chatCompletionError() -> Data {
        "{\n    \"error\": {\n        \"message\": \"The model `o3-mini` does not exist or you do not have access to it.\",\n        \"type\": \"invalid_request_error\",\n        \"param\": null,\n        \"code\": \"model_not_found\"\n    }\n}\n".data(using: .utf8)!
    }
}
