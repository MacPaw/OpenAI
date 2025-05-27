//
//  ChatResultTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import XCTest
@testable import OpenAI

final class ChatResultTests: XCTestCase {
    private let decoder = JSONDecoder()
    
    func testDecodeFailsForMissingId() {
        let jsonString = """
            {
                "object": "chat.completion",
                "model": "gpt-4"
            }
            """
        
        // no relaxing options
        do {
            _ = try decode(jsonString)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key as! ChatResult.CodingKeys, ChatResult.CodingKeys.id)
            default:
                XCTFail("Unexpected error")
            }
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testDecodeMissingIdSucceedsWithRelaxedOptions() throws {
        // mock json with missing id
        let jsonString = """
            {
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "system_fingerprint": null
            }
            """
        
        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let chatResult = try decode(jsonString)
        XCTAssertEqual(chatResult.id, "")
    }
    
    func testThrowsErrorIfOptionsNotSufficient() throws {
        let jsonString = """
            {
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": []
            }
            """
        
        decoder.userInfo = [.parsingOptions: ParsingOptions.fillRequiredFieldIfValueNotFound]
        do {
            _ = try decode(jsonString)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key as! ChatResult.CodingKeys, ChatResult.CodingKeys.id)
            default:
                XCTFail("Unexpected error")
            }
        } catch {
            XCTFail("Unexpected error")
        }
    }
    
    func testParseNullSystemFingerprintWithDefaultParsingOptions() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "system_fingerprint": null
            }
            """
        
        let jsonDict = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!) as! [String: Any]
        
        XCTAssertEqual(jsonDict["model"] as! String, "gpt-4", "Invalid json mock")
        XCTAssertTrue(jsonDict["system_fingerprint"] is NSNull, "The field is expected to be missing or null")
        let chatResult = try decode(jsonString)
        XCTAssertEqual(chatResult.model, "gpt-4")
        XCTAssertEqual(chatResult.systemFingerprint, nil)
    }
    
    /// [Issue 338](https://github.com/MacPaw/OpenAI/issues/338)
    func testParseEmptyUsage() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "usage": {}
            }
            """
        
        let jsonData = jsonString.data(using: .utf8)!
        let chatResult = try JSONDecoder().decode(ChatResult.self, from: jsonData)
        XCTAssertEqual(chatResult.model, "gpt-4")
        XCTAssertEqual(chatResult.usage, nil)
    }
    
    /// [Issue 338](https://github.com/MacPaw/OpenAI/issues/338)
    func testParseEmptyUsageStream() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "usage": {}
            }
            """
        
        let jsonData = jsonString.data(using: .utf8)!
        let chatStreamResult = try JSONDecoder().decode(ChatStreamResult.self, from: jsonData)
        XCTAssertEqual(chatStreamResult.model, "gpt-4")
        XCTAssertEqual(chatStreamResult.usage, nil)
    }
    
    func testDecodeServiceTier() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4",
                "choices": [],
                "service_tier": "flex"
            }
            """
        
        let result = try decode(jsonString)
        XCTAssertEqual(result.serviceTier, .flexTier)
    }
    
    private func decode(_ jsonString: String) throws -> ChatResult {
        let jsonData = jsonString.data(using: .utf8)!
        return try decoder.decode(ChatResult.self, from: jsonData)
    }
}
