//
//  APIErrorDecodingTests.swift
//  OpenAI
//

// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
import Testing
@testable import OpenAI
import Foundation

struct APIErrorDecodingTests {
    @Test func decodeStringCode() throws {
        let error = try decode(#"{"message": "Incorrect API key provided", "type": "invalid_request_error", "param": null, "code": "invalid_api_key"}"#)
        #expect(error.code == "invalid_api_key")
    }

    /// llama.cpp server sends the HTTP status as a number.
    @Test func decodeNumericCode() throws {
        let error = try decode(#"{"message": "the request exceeds the available context size", "type": "exceed_context_size_error", "code": 400}"#)
        #expect(error.code == "400")
    }

    @Test func decodeNullCode() throws {
        let error = try decode(#"{"message": "Server error", "type": "server_error", "code": null}"#)
        #expect(error.code == nil)
    }

    @Test func decodeMissingCode() throws {
        let error = try decode(#"{"message": "Server error", "type": "server_error"}"#)
        #expect(error.code == nil)
    }

    @Test func decodeFailsForCodeOfAnotherType() {
        #expect(throws: DecodingError.self) {
            try decode(#"{"message": "Server error", "type": "server_error", "code": true}"#)
        }
    }

    private func decode(_ json: String) throws -> APIError {
        try JSONDecoder().decode(APIError.self, from: Data(json.utf8))
    }
}
#endif
