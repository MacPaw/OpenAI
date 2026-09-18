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

    static func responseStreamEvent(
        itemId: String = "msg_1",
        payloadType: String,
        outputIndex: Int = 0,
        contentIndex: Int = 0,
        delta: String = "",
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": payloadType,
            "output_index": outputIndex,
            "item_id": itemId,
            "content_index": contentIndex,
            "delta": delta,
            "sequence_number": sequenceNumber,
            "logprobs": [Any]()
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func reasoningTextDoneEvent(
        itemId: String = "item_1",
        outputIndex: Int = 0,
        contentIndex: Int = 0,
        text: String = "Because the sky is blue.",
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": "response.reasoning_text.done",
            "item_id": itemId,
            "output_index": outputIndex,
            "content_index": contentIndex,
            "text": text,
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func customToolCallInputDoneEvent(
        itemId: String = "item_1",
        outputIndex: Int = 0,
        input: String = "{}",
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": "response.custom_tool_call_input.done",
            "item_id": itemId,
            "output_index": outputIndex,
            "input": input,
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func shellCallCommandAddedEvent(
        outputIndex: Int = 0,
        commandIndex: Int = 0,
        command: String = "ls -la",
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": "response.shell_call_command.added",
            "output_index": outputIndex,
            "command_index": commandIndex,
            "command": command,
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func shellCallCommandDeltaEvent(
        outputIndex: Int = 0,
        commandIndex: Int = 0,
        delta: String = " -la",
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": "response.shell_call_command.delta",
            "output_index": outputIndex,
            "command_index": commandIndex,
            "delta": delta,
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func shellCallCommandDoneEvent(
        outputIndex: Int = 0,
        commandIndex: Int = 0,
        command: String = "ls -la",
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": "response.shell_call_command.done",
            "output_index": outputIndex,
            "command_index": commandIndex,
            "command": command,
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func shellCallOutputContentDeltaEvent(
        itemId: String = "item_1",
        outputIndex: Int = 0,
        commandIndex: Int = 0,
        stdout: String? = "hello",
        stderr: String? = nil,
        sequenceNumber: Int = 1
    ) -> Data {
        var delta: [String: Any] = [:]
        if let stdout { delta["stdout"] = stdout }
        if let stderr { delta["stderr"] = stderr }
        let payload: [String: Any] = [
            "type": "response.shell_call_output_content.delta",
            "item_id": itemId,
            "output_index": outputIndex,
            "command_index": commandIndex,
            "delta": delta,
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func shellCallOutputContentDoneEvent(
        itemId: String = "item_1",
        outputIndex: Int = 0,
        commandIndex: Int = 0,
        stdout: String = "hello\n",
        stderr: String = "",
        exitCode: Int = 0,
        sequenceNumber: Int = 1
    ) -> Data {
        let payload: [String: Any] = [
            "type": "response.shell_call_output_content.done",
            "item_id": itemId,
            "output_index": outputIndex,
            "command_index": commandIndex,
            "output": [
                [
                    "stdout": stdout,
                    "stderr": stderr,
                    "outcome": [
                        "type": "exit",
                        "exit_code": exitCode
                    ]
                ]
            ],
            "sequence_number": sequenceNumber
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: payload)
        return "data: \(String(data: jsonData, encoding: .utf8)!)\n\n".data(using: .utf8)!
    }

    static func annotationAddedEvent(withExplicitEventField: Bool) -> Data {
        let json = #"{"type":"response.output_text.annotation.added","item_id":"item_1","output_index":0,"content_index":0,"annotation_index":2,"sequence_number":5,"annotation":{"type":"url_citation","url":"https://example.com","start_index":0,"end_index":1,"title":"Example"}}"#
        if withExplicitEventField {
            return "event: response.output_text.annotation.added\ndata: \(json)\n\n".data(using: .utf8)!
        } else {
            return "data: \(json)\n\n".data(using: .utf8)!
        }
    }
}
