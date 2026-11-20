//
//  APIErrorDecodingTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

final class APIErrorDecodingTests: XCTestCase {
    func testDecodeStringCode() throws {
        let error = try decode(#"{"message": "Incorrect API key provided", "type": "invalid_request_error", "param": null, "code": "invalid_api_key"}"#)
        XCTAssertEqual(error.code, "invalid_api_key")
    }

    /// llama.cpp server sends the HTTP status as a number.
    func testDecodeNumericCode() throws {
        let error = try decode(#"{"message": "the request exceeds the available context size", "type": "exceed_context_size_error", "code": 400}"#)
        XCTAssertEqual(error.code, "400")
    }

    func testDecodeNullCode() throws {
        let error = try decode(#"{"message": "Server error", "type": "server_error", "code": null}"#)
        XCTAssertNil(error.code)
    }

    func testDecodeMissingCode() throws {
        let error = try decode(#"{"message": "Server error", "type": "server_error"}"#)
        XCTAssertNil(error.code)
    }

    func testDecodeFailsForCodeOfAnotherType() {
        XCTAssertThrowsError(try decode(#"{"message": "Server error", "type": "server_error", "code": true}"#)) { error in
            XCTAssertTrue(error is DecodingError, "Expected a DecodingError, got \(error)")
        }
    }

    private func decode(_ json: String) throws -> APIError {
        try JSONDecoder().decode(APIError.self, from: Data(json.utf8))
    }
}
