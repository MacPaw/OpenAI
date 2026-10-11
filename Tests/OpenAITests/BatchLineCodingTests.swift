//
//  BatchLineCodingTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

class BatchLineCodingTests: XCTestCase {

    func testBatchResponseLineDecoding() throws {
        let jsonString = """
        {
            "id": "response_abc123",
            "custom_id": "request-1",
            "response": {
                "status_code": 200,
                "request_id": "req_abc123",
                "body": {
                    "id": "chatcmpl-abc123",
                    "object": "chat.completion",
                    "created": 1711471533,
                    "model": "gpt-4o-mini",
                    "choices": [
                        {
                            "index": 0,
                            "message": {
                                "role": "assistant",
                                "content": "Hello! How can I help you?"
                            },
                            "finish_reason": "stop"
                        }
                    ],
                    "usage": {
                        "prompt_tokens": 10,
                        "completion_tokens": 8,
                        "total_tokens": 18
                    }
                }
            },
            "error": null
        }
        """

        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)!
        let responseLine = try decoder.decode(BatchResponseLine.self, from: data)

        XCTAssertEqual(responseLine.id, "response_abc123")
        XCTAssertEqual(responseLine.customId, "request-1")
        XCTAssertNotNil(responseLine.response)
        XCTAssertEqual(responseLine.response?.statusCode, 200)
        XCTAssertEqual(responseLine.response?.requestId, "req_abc123")
        XCTAssertNil(responseLine.error)
    }

    func testBatchResponseLineWithError() throws {
        let jsonString = """
        {
            "id": "response_def456",
            "custom_id": "request-2",
            "response": null,
            "error": {
                "code": "rate_limit_exceeded",
                "message": "Rate limit exceeded"
            }
        }
        """

        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)!
        let responseLine = try decoder.decode(BatchResponseLine.self, from: data)

        XCTAssertEqual(responseLine.id, "response_def456")
        XCTAssertEqual(responseLine.customId, "request-2")
        XCTAssertNil(responseLine.response)
        XCTAssertNotNil(responseLine.error)
        XCTAssertEqual(responseLine.error?.code, "rate_limit_exceeded")
        XCTAssertEqual(responseLine.error?.message, "Rate limit exceeded")
    }
}
