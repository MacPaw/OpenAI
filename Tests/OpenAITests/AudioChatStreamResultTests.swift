//
//  AudioChatStreamResultTests.swift
//  OpenAI
//
//  Created by OpenAI SDK Contributors.
//

import XCTest
@testable import OpenAI

final class AudioChatStreamResultTests: XCTestCase {
    private let decoder = JSONDecoder()

    func testDecodeBasicStreamChunk() throws {
        let jsonString = """
            {
                "id": "chatcmpl-123",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "delta": {
                            "role": "assistant",
                            "content": "Hello"
                        },
                        "finish_reason": null
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.id, "chatcmpl-123")
        XCTAssertEqual(result.model, "gpt-4o-audio-preview")
        XCTAssertEqual(result.choices.count, 1)

        let choice = result.choices[0]
        XCTAssertEqual(choice.index, 0)
        XCTAssertEqual(choice.delta.role, "assistant")
        XCTAssertEqual(choice.delta.content, "Hello")
        XCTAssertNil(choice.finishReason)
    }

    func testDecodeAudioDelta() throws {
        let jsonString = """
            {
                "id": "chatcmpl-456",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "delta": {
                            "audio": {
                                "id": "audio-123",
                                "data": "base64chunk",
                                "transcript": "partial transcript"
                            }
                        },
                        "finish_reason": null
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        let audio = try XCTUnwrap(result.choices[0].delta.audio)
        XCTAssertEqual(audio.id, "audio-123")
        XCTAssertEqual(audio.data, "base64chunk")
        XCTAssertEqual(audio.transcript, "partial transcript")
    }

    func testDecodeAudioDeltaWithOnlyData() throws {
        let jsonString = """
            {
                "id": "chatcmpl-789",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "delta": {
                            "audio": {
                                "data": "audiochunk123"
                            }
                        },
                        "finish_reason": null
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        let audio = try XCTUnwrap(result.choices[0].delta.audio)
        XCTAssertEqual(audio.data, "audiochunk123")
        XCTAssertNil(audio.id)
        XCTAssertNil(audio.transcript)
    }

    func testDecodeWithFinishReason() throws {
        let jsonString = """
            {
                "id": "chatcmpl-final",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "delta": {},
                        "finish_reason": "stop"
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.choices[0].finishReason, "stop")
    }

    func testDecodeMultipleChoices() throws {
        let jsonString = """
            {
                "id": "chatcmpl-multi",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "delta": {
                            "content": "First"
                        },
                        "finish_reason": null
                    },
                    {
                        "index": 1,
                        "delta": {
                            "content": "Second"
                        },
                        "finish_reason": null
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.choices.count, 2)
        XCTAssertEqual(result.choices[0].delta.content, "First")
        XCTAssertEqual(result.choices[1].delta.content, "Second")
    }

    func testDecodeEmptyDelta() throws {
        let jsonString = """
            {
                "id": "chatcmpl-empty",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [
                    {
                        "index": 0,
                        "delta": {},
                        "finish_reason": null
                    }
                ]
            }
            """

        let result = try decode(jsonString)
        XCTAssertNil(result.choices[0].delta.role)
        XCTAssertNil(result.choices[0].delta.content)
        XCTAssertNil(result.choices[0].delta.audio)
    }

    // Note: AudioChatStreamResult does not include usage field unlike ChatStreamResult

    func testDecodeFailsForMissingId() {
        let jsonString = """
            {
                "object": "chat.completion.chunk",
                "model": "gpt-4o-audio-preview"
            }
            """

        do {
            _ = try decode(jsonString)
            XCTFail("Should throw error")
        } catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key as! AudioChatStreamResult.CodingKeys, AudioChatStreamResult.CodingKeys.id)
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
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": []
            }
            """

        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let result = try decode(jsonString)
        XCTAssertEqual(result.id, "")
    }


    func testDecodeSystemFingerprint() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [],
                "system_fingerprint": "fp_xyz789"
            }
            """

        let result = try decode(jsonString)
        XCTAssertEqual(result.systemFingerprint, "fp_xyz789")
    }

    func testDecodeNullSystemFingerprint() throws {
        let jsonString = """
            {
                "id": "some_id",
                "object": "chat.completion.chunk",
                "created": 1677652288,
                "model": "gpt-4o-audio-preview",
                "choices": [],
                "system_fingerprint": null
            }
            """

        let result = try decode(jsonString)
        XCTAssertNil(result.systemFingerprint)
    }

    private func decode(_ jsonString: String) throws -> AudioChatStreamResult {
        let jsonData = jsonString.data(using: .utf8)!
        return try decoder.decode(AudioChatStreamResult.self, from: jsonData)
    }
}
