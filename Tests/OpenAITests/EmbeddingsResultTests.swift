//
//  EmbeddingsResultTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

final class EmbeddingsResultTests: XCTestCase {
    private let decoder = JSONDecoder()

    /// An embeddings response from an OpenAI-compatible provider that sends neither `usage` nor `object`.
    private let jsonWithoutUsage = """
        {
            "data": [
                { "object": "embedding", "embedding": [0.1, 0.2], "index": 0 }
            ],
            "model": "text-embedding-004"
        }
        """

    func testDecodeFailsForMissingUsage() {
        // no relaxing options
        do {
            _ = try decode(jsonWithoutUsage)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key.stringValue, "usage")
            default:
                XCTFail("Unexpected error")
            }
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testDecodeMissingUsageSucceedsWithRelaxedOptions() throws {
        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let result = try decode(jsonWithoutUsage)
        XCTAssertEqual(result.data, [.init(object: "embedding", embedding: [0.1, 0.2], index: 0)])
        XCTAssertEqual(result.model, "text-embedding-004")
        XCTAssertEqual(result.usage, .init(promptTokens: 0, totalTokens: 0))
        XCTAssertEqual(result.object, "list")
    }

    func testDecodeNullUsageSucceedsWithFillValueOption() throws {
        let jsonString = """
            {
                "object": "list",
                "data": [],
                "model": "text-embedding-004",
                "usage": null
            }
            """

        decoder.userInfo = [.parsingOptions: ParsingOptions.fillRequiredFieldIfValueNotFound]
        let result = try decode(jsonString)
        XCTAssertEqual(result.usage, .init(promptTokens: 0, totalTokens: 0))
    }

    func testDecodePartialUsageSucceedsWithRelaxedOptions() throws {
        let jsonString = """
            {
                "object": "list",
                "data": [],
                "model": "text-embedding-004",
                "usage": { "prompt_tokens": 5 }
            }
            """

        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let result = try decode(jsonString)
        XCTAssertEqual(result.usage, .init(promptTokens: 5, totalTokens: 0))
    }

    func testThrowsErrorIfOptionsNotSufficient() {
        decoder.userInfo = [.parsingOptions: ParsingOptions.fillRequiredFieldIfValueNotFound]
        XCTAssertThrowsError(try decode(jsonWithoutUsage))
    }

    func testDecodeCompleteResponseIsUnchanged() throws {
        let jsonString = """
            {
                "object": "list",
                "data": [
                    { "object": "embedding", "embedding": [0.1, 0.2], "index": 0 }
                ],
                "model": "text-embedding-3-small",
                "usage": { "prompt_tokens": 8, "total_tokens": 8 }
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.usage, .init(promptTokens: 8, totalTokens: 8))
        XCTAssertEqual(result.object, "list")
        XCTAssertEqual(result.model, "text-embedding-3-small")
    }

    private func decode(_ jsonString: String) throws -> EmbeddingsResult {
        let jsonData = jsonString.data(using: .utf8)!
        return try decoder.decode(EmbeddingsResult.self, from: jsonData)
    }
}
