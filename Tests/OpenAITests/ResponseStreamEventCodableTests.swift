//
//  ResponseStreamEventCodableTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

final class ResponseStreamEventCodableTests: XCTestCase {
    private func assertRoundTrips(_ json: String, file: StaticString = #filePath, line: UInt = #line) throws {
        let data = json.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(ResponseStreamEvent.self, from: data)
        let encoded = try JSONEncoder().encode(decoded)
        let redecoded = try JSONDecoder().decode(ResponseStreamEvent.self, from: encoded)
        XCTAssertEqual(decoded, redecoded, file: file, line: line)

        let originalObject = try XCTUnwrap(
            JSONSerialization.jsonObject(with: data) as? [String: Any],
            file: file,
            line: line
        )
        let encodedObject = try XCTUnwrap(
            JSONSerialization.jsonObject(with: encoded) as? [String: Any],
            file: file,
            line: line
        )
        XCTAssertEqual(
            NSDictionary(dictionary: originalObject),
            NSDictionary(dictionary: encodedObject),
            file: file,
            line: line
        )
    }

    func testResponseCreatedRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.created",
          "sequence_number": 0,
          "response": {
            "id": "resp_123",
            "object": "response",
            "created_at": 0,
            "status": "in_progress",
            "model": "gpt-4o",
            "output": [],
            "parallel_tool_calls": true,
            "tool_choice": "auto",
            "tools": []
          }
        }
        """)
    }

    func testOutputItemAddedRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.output_item.added",
          "output_index": 0,
          "item": {
            "id": "msg_123",
            "type": "message",
            "role": "assistant",
            "status": "in_progress",
            "content": []
          }
        }
        """)
    }

    func testOutputItemDoneWithFunctionToolCallRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.output_item.done",
          "output_index": 1,
          "item": {
            "id": "fc_123",
            "type": "function_call",
            "call_id": "call_123",
            "name": "get_weather",
            "arguments": "{\\"city\\":\\"Seoul\\"}",
            "status": "completed"
          }
        }
        """)
    }

    func testContentPartAddedRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.content_part.added",
          "item_id": "msg_123",
          "output_index": 0,
          "content_index": 0,
          "sequence_number": 5,
          "part": {
            "type": "output_text",
            "text": "hello",
            "annotations": [],
            "logprobs": []
          }
        }
        """)
    }

    func testCodeInterpreterCallCompletedRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.code_interpreter_call.completed",
          "item_id": "ci_123",
          "output_index": 0,
          "sequence_number": 3
        }
        """)
    }

    func testShellCallCommandAddedRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.shell_call_command.added",
          "output_index": 0,
          "command_index": 0,
          "command": "ls",
          "sequence_number": 4
        }
        """)
    }

    func testMcpCallArgumentsDeltaRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.mcp_call_arguments.delta",
          "output_index": 0,
          "item_id": "mcp_123",
          "delta": "{\\"a\\":1}",
          "sequence_number": 2
        }
        """)
    }

    func testFunctionCallArgumentsDoneRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "response.function_call_arguments.done",
          "item_id": "item-abc",
          "name": "get_weather",
          "output_index": 1,
          "arguments": "{}",
          "sequence_number": 7
        }
        """)
    }

    func testErrorEventRoundTrips() throws {
        try assertRoundTrips("""
        {
          "type": "error",
          "message": "boom",
          "sequence_number": 1
        }
        """)
    }
}
