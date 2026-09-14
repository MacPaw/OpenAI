//
//  AudioChatQueryCodingTests.swift
//  OpenAI
//
//  Created by OpenAI SDK Contributors.
//

import Testing
@testable import OpenAI
import Foundation

struct AudioChatQueryCodingTests {
    @Test func encodeBasicTextMessage() async throws {
        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: [
                .init(role: .system, content: .text("You are a helpful assistant")),
                .init(role: .user, content: .text("Hello"))
            ],
            modalities: [.text, .audio],
            audio: .init(voice: .alloy, format: .pcm16)
        )

        let expected = """
        {
            "model": "gpt-4o-audio-preview",
            "messages": [
                {
                    "role": "system",
                    "content": "You are a helpful assistant"
                },
                {
                    "role": "user",
                    "content": "Hello"
                }
            ],
            "modalities": ["text", "audio"],
            "audio": {
                "voice": "alloy",
                "format": "pcm16"
            },
            "stream": false
        }
        """

        let encodedQuery = try encodedAndComparable(query)
        let decodedExpectation = try decodedAndComparable(expected)
        #expect(encodedQuery == decodedExpectation)
    }

    @Test func encodeAudioInputMessage() async throws {
        let audioData = "base64encodedaudiodata"
        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: [
                .init(role: .user, content: .parts([
                    .init(inputAudio: .init(data: audioData, format: .wav))
                ]))
            ],
            modalities: [.text, .audio],
            audio: .init(voice: .onyx, format: .pcm16)
        )

        let expected = """
        {
            "model": "gpt-4o-audio-preview",
            "messages": [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "input_audio",
                            "input_audio": {
                                "data": "base64encodedaudiodata",
                                "format": "wav"
                            }
                        }
                    ]
                }
            ],
            "modalities": ["text", "audio"],
            "audio": {
                "voice": "onyx",
                "format": "pcm16"
            },
            "stream": false
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func encodeMixedContentParts() async throws {
        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: [
                .init(role: .user, content: .parts([
                    .init(text: "Please analyze this audio:"),
                    .init(inputAudio: .init(data: "audiodata", format: .mp3))
                ]))
            ],
            audio: .init(voice: .shimmer, format: .opus)
        )

        let expected = """
        {
            "model": "gpt-4o-audio-preview",
            "messages": [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": "Please analyze this audio:"
                        },
                        {
                            "type": "input_audio",
                            "input_audio": {
                                "data": "audiodata",
                                "format": "mp3"
                            }
                        }
                    ]
                }
            ],
            "modalities": ["text", "audio"],
            "audio": {
                "voice": "shimmer",
                "format": "opus"
            },
            "stream": false
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func encodeWithAllVoices() async throws {
        let voices: [AudioChatQuery.AudioConfig.Voice] = [.alloy, .echo, .fable, .onyx, .nova, .shimmer]

        for voice in voices {
            let query = AudioChatQuery(
                model: .gpt_4o_audio_preview,
                messages: [.init(role: .user, content: .text("Test"))],
                audio: .init(voice: voice, format: .pcm16)
            )

            let encoded = try JSONEncoder().encode(query)
            let decoded = try JSONDecoder().decode(AudioChatQuery.self, from: encoded)

            #expect(decoded.audio?.voice == voice)
        }
    }

    @Test func encodeWithAllFormats() async throws {
        let formats: [AudioFormat] = [.wav, .mp3, .flac, .opus, .pcm16]

        for format in formats {
            let query = AudioChatQuery(
                model: .gpt_4o_audio_preview,
                messages: [.init(role: .user, content: .text("Test"))],
                audio: .init(voice: .alloy, format: format)
            )

            let encoded = try JSONEncoder().encode(query)
            let decoded = try JSONDecoder().decode(AudioChatQuery.self, from: encoded)

            #expect(decoded.audio?.format == format)
        }
    }

    @Test func encodeStreamingQuery() async throws {
        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: [.init(role: .user, content: .text("Hello"))],
            audio: .init(voice: .alloy, format: .pcm16),
            stream: true
        )

        let expected = """
        {
            "model": "gpt-4o-audio-preview",
            "messages": [
                {
                    "role": "user",
                    "content": "Hello"
                }
            ],
            "modalities": ["text", "audio"],
            "audio": {
                "voice": "alloy",
                "format": "pcm16"
            },
            "stream": true
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func encodeWithOptionalParameters() async throws {
        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: [.init(role: .user, content: .text("Test"))],
            audio: .init(voice: .alloy, format: .pcm16),
            temperature: 0.7,
            maxTokens: 100,
            frequencyPenalty: 0.5,
            presencePenalty: 0.3,
            stop: ["STOP"],
            seed: 42
        )

        let expected = """
        {
            "model": "gpt-4o-audio-preview",
            "messages": [
                {
                    "role": "user",
                    "content": "Test"
                }
            ],
            "modalities": ["text", "audio"],
            "audio": {
                "voice": "alloy",
                "format": "pcm16"
            },
            "temperature": 0.7,
            "max_tokens": 100,
            "frequency_penalty": 0.5,
            "presence_penalty": 0.3,
            "stop": ["STOP"],
            "seed": 42,
            "stream": false
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func testStreamableProtocolConformance() async throws {
        let query = AudioChatQuery(
            model: .gpt_4o_audio_preview,
            messages: [.init(role: .user, content: .text("Test"))],
            audio: .init(voice: .alloy, format: .pcm16),
            stream: false
        )

        // Test makeStreamable
        let streamable = query.makeStreamable()
        #expect(streamable.stream == true)

        // Test makeNonStreamable
        let nonStreamable = streamable.makeNonStreamable()
        #expect(nonStreamable.stream == false)
    }

    private func equal(_ query: Codable, _ expected: String) throws -> Bool {
        let encodedQuery = try encodedAndComparable(query)
        let decodedExpectation = try decodedAndComparable(expected)
        return encodedQuery == decodedExpectation
    }

    private func encodedAndComparable(_ candidate: Codable) throws -> NSDictionary {
        try jsonDataAsNSDictionary(try JSONEncoder().encode(candidate))
    }

    private func decodedAndComparable(_ candidate: String) throws -> NSDictionary {
        try jsonDataAsNSDictionary(candidate.data(using: .utf8)!)
    }

    private func jsonDataAsNSDictionary(_ data: Data) throws -> NSDictionary {
        NSDictionary(dictionary: try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any])
    }
}
