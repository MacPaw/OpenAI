//
//  ResponseObjectCodingTests.swift
//  OpenAI
//

// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
import Testing
@testable import OpenAI
import Foundation

struct ResponseObjectCodingTests {
    private let minimalJSON = """
    {
        "id": "resp-abc123",
        "object": "response",
        "model": "gpt-4o",
        "created_at": 1717459200,
        "output": [],
        "tools": [],
        "metadata": {},
        "parallel_tool_calls": false
    }
    """

    @Test func decodeMinimalResponse() throws {
        let response = try decode(minimalJSON)
        #expect(response.id == "resp-abc123")
        #expect(response.object == "response")
        #expect(response.model == "gpt-4o")
        #expect(response.output.isEmpty)
        #expect(response.tools.isEmpty)
    }

    @Test func decodeCreatedAtAsDouble() throws {
        let response = try decode(minimalJSON)
        #expect(response.createdAt == 1717459200.0)
    }

    @Test func decodeIncompleteDetailsAbsent() throws {
        let response = try decode(minimalJSON)
        #expect(response.incompleteDetails == nil)
    }

    @Test func decodeIncompleteDetailsNull() throws {
        let json = """
        {
            "id": "resp-abc123",
            "object": "response",
            "model": "gpt-4o",
            "created_at": 1717459200,
            "output": [],
            "tools": [],
            "metadata": {},
            "parallel_tool_calls": false,
            "incomplete_details": null
        }
        """
        let response = try decode(json)
        #expect(response.incompleteDetails == nil)
    }

    @Test func decodeIncompleteDetailsPresent() throws {
        let json = """
        {
            "id": "resp-abc123",
            "object": "response",
            "model": "gpt-4o",
            "created_at": 1717459200,
            "output": [],
            "tools": [],
            "metadata": {},
            "parallel_tool_calls": false,
            "incomplete_details": { "reason": "max_output_tokens" }
        }
        """
        let response = try decode(json)
        #expect(response.incompleteDetails != nil)
    }

    // Servers attach their own codes to failed responses (OpenAI adds codes
    // without a spec bump; OpenAI-compatible servers use codes such as
    // `upstream_error`). A failed response must decode whatever the code is,
    // so callers see the human-readable message instead of a decoding error.
    @Test(arguments: ["server_error", "rate_limit_exceeded", "upstream_error", "server_is_overloaded", "model_unavailable"])
    func decodeFailedResponseWithAnyErrorCode(code: String) throws {
        let json = """
        {
            "id": "resp-abc123",
            "object": "response",
            "model": "gpt-4o",
            "created_at": 1717459200,
            "status": "failed",
            "output": [],
            "tools": [],
            "metadata": {},
            "parallel_tool_calls": false,
            "error": { "code": "\(code)", "message": "The server had an error while processing your request." }
        }
        """
        let response = try decode(json)
        #expect(response.error?.code == code)
        #expect(response.error?.message == "The server had an error while processing your request.")
    }

    @Test func decodeFailedResponseEventWithUnknownErrorCode() throws {
        let json = """
        {
            "type": "response.failed",
            "sequence_number": 7,
            "response": {
                "id": "resp-abc123",
                "object": "response",
                "model": "gpt-4o",
                "created_at": 1717459200,
                "status": "failed",
                "output": [],
                "tools": [],
                "metadata": {},
                "parallel_tool_calls": false,
                "error": { "code": "upstream_error", "message": "boom" }
            }
        }
        """
        let event = try JSONDecoder().decode(Components.Schemas.ResponseFailedEvent.self, from: Data(json.utf8))
        #expect(event.response.value3.error?.code == "upstream_error")
    }

    private func decode(_ json: String) throws -> ResponseObject {
        try JSONDecoder().decode(ResponseObject.self, from: Data(json.utf8))
    }
}
#endif
