//
//  ChatStreamResultTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 23.05.2025.
//

import XCTest
@testable import OpenAI

final class ChatStreamResultTests: XCTestCase {
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
                XCTAssertEqual(key as! ChatStreamResult.CodingKeys, ChatStreamResult.CodingKeys.id)
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
        let result = try decode(jsonString)
        XCTAssertEqual(result.id, "")
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
                XCTAssertEqual(key as! ChatStreamResult.CodingKeys, ChatStreamResult.CodingKeys.id)
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
        let result = try decode(jsonString)
        XCTAssertEqual(result.model, "gpt-4")
        XCTAssertEqual(result.systemFingerprint, nil)
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
    
    func testDecodeDeltaAudio() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-audio-1.5",
                "choices": [
                    {
                        "index": 0,
                        "delta": {
                            "role": "assistant",
                            "audio": {
                                "id": "audio_abc123",
                                "transcript": "Hello",
                                "expires_at": 1677655888,
                                "data": "ZmFrZS1hdWRpby1ieXRlcw=="
                            }
                        }
                    }
                ]
            }
            """
        
        let audio = try XCTUnwrap(decode(jsonString).choices.first?.delta.audio)
        XCTAssertEqual(audio.id, "audio_abc123")
        XCTAssertEqual(audio.transcript, "Hello")
        XCTAssertEqual(audio.expiresAt, 1677655888)
        XCTAssertEqual(audio.data, "ZmFrZS1hdWRpby1ieXRlcw==")
    }
    
    /// Audio chunks in a stream usually carry a single field, so every field of the delta audio must be optional.
    func testDecodeDeltaAudioWithDataOnly() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-audio-1.5",
                "choices": [
                    {
                        "index": 0,
                        "delta": {
                            "audio": {
                                "data": "ZmFrZS1hdWRpby1ieXRlcw=="
                            }
                        }
                    }
                ]
            }
            """
        
        let audio = try XCTUnwrap(decode(jsonString).choices.first?.delta.audio)
        XCTAssertEqual(audio.data, "ZmFrZS1hdWRpby1ieXRlcw==")
        XCTAssertNil(audio.id)
        XCTAssertNil(audio.transcript)
        XCTAssertNil(audio.expiresAt)
    }
    
    private func decode(_ jsonString: String) throws -> ChatStreamResult {
        let jsonData = jsonString.data(using: .utf8)!
        return try decoder.decode(ChatStreamResult.self, from: jsonData)
    }
}
