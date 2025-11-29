//
//  AudioChatResultTests.swift
//  OpenAI
//
//  Created by OpenAI SDK Contributors.
//

import XCTest
@testable import OpenAI

final class AudioChatResultTests: XCTestCase {
    private let decoder = JSONDecoder()

    func testDecodeBasicAudioChatResult() throws {
        let jsonString = """
            {
                "id": "chatcmpl-123",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "message": {
                            "role": "assistant",
                            "content": "Hello! How can I help you?",
                            "audio": {
                                "id": "audio-123",
                                "data": "base64encodedaudiodata",
                                "transcript": "Hello! How can I help you?",
                                "expires_at": 1234567890
                            }
                        },
                        "finish_reason": "stop"
                    }
                ],
                "usage": {
                    "prompt_tokens": 10,
                    "completion_tokens": 20,
                    "total_tokens": 30
                }
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.id, "chatcmpl-123")
        XCTAssertEqual(result.model, "gpt-4o-audio-preview")
        XCTAssertEqual(result.choices.count, 1)

        let choice = result.choices[0]
        XCTAssertEqual(choice.index, 0)
        XCTAssertEqual(choice.message.role, "assistant")
        XCTAssertEqual(choice.message.content, "Hello! How can I help you?")
        XCTAssertEqual(choice.finishReason, "stop")

        let audio = try XCTUnwrap(choice.message.audio)
        XCTAssertEqual(audio.id, "audio-123")
        XCTAssertEqual(audio.data, "base64encodedaudiodata")
        XCTAssertEqual(audio.transcript, "Hello! How can I help you?")
        XCTAssertEqual(audio.expiresAt, 1234567890)
    }

    func testDecodeWithoutAudio() throws {
        let jsonString = """
            {
                "id": "chatcmpl-456",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "message": {
                            "role": "assistant",
                            "content": "Text-only response"
                        },
                        "finish_reason": "stop"
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.id, "chatcmpl-456")
        XCTAssertEqual(result.choices[0].message.content, "Text-only response")
        XCTAssertNil(result.choices[0].message.audio)
    }

    func testDecodeMultipleChoices() throws {
        let jsonString = """
            {
                "id": "chatcmpl-789",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "message": {
                            "role": "assistant",
                            "content": "First response",
                            "audio": {
                                "id": "audio-1",
                                "data": "data1",
                                "transcript": "First response",
                                "expires_at": 1234567890
                            }
                        },
                        "finish_reason": "stop"
                    },
                    {
                        "index": 1,
                        "message": {
                            "role": "assistant",
                            "content": "Second response",
                            "audio": {
                                "id": "audio-2",
                                "data": "data2",
                                "transcript": "Second response",
                                "expires_at": 1234567891
                            }
                        },
                        "finish_reason": "stop"
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.choices.count, 2)
        XCTAssertEqual(result.choices[0].message.audio?.id, "audio-1")
        XCTAssertEqual(result.choices[1].message.audio?.id, "audio-2")
    }

    func testDecodeWithUsage() throws {
        let jsonString = """
            {
                "id": "chatcmpl-usage",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "message": {
                            "role": "assistant",
                            "content": "Response"
                        },
                        "finish_reason": "stop"
                    }
                ],
                "usage": {
                    "prompt_tokens": 100,
                    "completion_tokens": 50,
                    "total_tokens": 150
                }
            }
            """

        let result = try decode(jsonString)
        let usage = try XCTUnwrap(result.usage)
        XCTAssertEqual(usage.promptTokens, 100)
        XCTAssertEqual(usage.completionTokens, 50)
        XCTAssertEqual(usage.totalTokens, 150)
    }

    func testDecodeFailsForMissingId() {
        let jsonString = """
            {
                "object": "chat.completion",
                "model": "gpt-4o-audio-preview"
            }
            """

        do {
            _ = try decode(jsonString)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key as! AudioChatResult.CodingKeys, AudioChatResult.CodingKeys.id)
            default:
                XCTFail("Unexpected error")
            }
        } catch {
            XCTFail("Unexpected error")
        }
    }

    func testDecodeMissingIdSucceedsWithRelaxedOptions() throws {
        let jsonString = """
            {
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": []
            }
            """

        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let result = try decode(jsonString)
        XCTAssertEqual(result.id, "")
    }

    func testDecodeEmptyUsage() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [],
                "usage": {}
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.model, "gpt-4o-audio-preview")
        XCTAssertNil(result.usage)
    }

    func testDecodeSystemFingerprint() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [],
                "system_fingerprint": "fp_abc123"
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.systemFingerprint, "fp_abc123")
    }

    func testDecodeNullSystemFingerprint() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [],
                "system_fingerprint": null
            }
            """

        let result = try decode(jsonString)
        XCTAssertNil(result.systemFingerprint)
    }

    private func decode(_ jsonString: String) throws -> AudioChatResult {
        let jsonData = jsonString.data(using: .utf8)!
        return try decoder.decode(AudioChatResult.self, from: jsonData)
    }
}
