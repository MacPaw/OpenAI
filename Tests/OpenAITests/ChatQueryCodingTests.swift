//
//  ChatQueryCodingTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 20.05.2025.
//

// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
import Testing
@testable import OpenAI
import Foundation

struct ChatQueryCodingTests {
    @Test func encodeUserMessageWithImageContentParts() async throws {
        let query = ChatQuery(
            messages: [
                .user(.init(
                    content: .contentParts([
                        .text(.init(text: "What is in this image?")),
                        .image(.init(
                            imageUrl: .init(
                                url: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg",
                                detail: nil
                            )
                        )),
                    ])
                ))
            ],
            model: .gpt4_1
        )
        
        let expected = """
        {
            "model": "gpt-4.1",
            "messages": [
              {
                "role": "user",
                "content": [
                  {
                    "type": "text",
                    "text": "What is in this image?"
                  },
                  {
                    "type": "image_url",
                    "image_url": {
                      "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
                    }
                  }
                ]
              }
            ],
            "stream": false
        }
        """
        
        let encodedQuery = try encodedAndComparable(query)
        let decodedExpectation = try decodedAndComparable(expected)
        #expect(encodedQuery == decodedExpectation)
    }
    
    @Test func encodePredictionWithTextContent() async throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            prediction: .staticContent(.init(content: .textContent("text_content")))
        )
        
        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "prediction": {
                "type": "content",
                "content": "text_content"
            },
            "stream": false
        }
        """
        
        #expect(try equal(query, expected))
    }
    
    @Test func encodeServiceTier() throws {
        let query = ChatQuery(messages: [], model: .gpt4_o, serviceTier: .flexTier)
        
        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "service_tier": "flex",
            "stream": false
        }
        """
        
        #expect(try equal(query, expected))
    }
    
    @Test func encodeReasoningContent() throws {
        let query = ChatQuery(
            messages: [
                .assistant(.init(content: .textContent("Content"), reasoningContent: "Reasoning"))
            ],
            model: .gpt4_o
        )
        
        let expected = """
        {
            "model": "gpt-4o",
            "messages": [
              {
                "role": "assistant",
                "content": "Content",
                "reasoning_content": "Reasoning"
              }
            ],
            "stream": false
        }
        """
        
        #expect(try equal(query, expected))
    }
    
    @Test func encodeWebSearchOptions() throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            webSearchOptions: .init(
                userLocation: .init(
                    approximate: .init(
                        country: "Ukraine",
                        region: "Oblast",
                        city: "Kyiv",
                        timezone: "EET"
                    )
                ),
                searchContextSize: .medium
            )
        )
        
        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "web_search_options": {
                "user_location": {
                  "type": "approximate",
                  "approximate": {
                    "country": "Ukraine",
                    "region": "Oblast",
                    "city": "Kyiv",
                    "timezone": "EET"
                  }
                },
                "search_context_size": "medium"
              },
            "stream": false
        }
        """
        
        #expect(try equal(query, expected))
    }
    
    @Test func encodeUserMessageWithInputAudioContentPart() throws {
        let query = ChatQuery(
            messages: [
                .user(.init(
                    content: .contentParts([
                        .text(.init(text: "What is this recording about?")),
                        .audio(.init(inputAudio: .init(data: Data("fake-audio-bytes".utf8), format: .wav)))
                    ])
                ))
            ],
            model: .gpt_audio_1_5,
            modalities: [.text, .audio],
            audioOptions: .init(format: .pcm16, voice: .alloy)
        )
        
        let expected = """
        {
            "model": "gpt-audio-1.5",
            "messages": [
              {
                "role": "user",
                "content": [
                  {
                    "type": "text",
                    "text": "What is this recording about?"
                  },
                  {
                    "type": "input_audio",
                    "input_audio": {
                      "data": "ZmFrZS1hdWRpby1ieXRlcw==",
                      "format": "wav"
                    }
                  }
                ]
              }
            ],
            "modalities": ["text", "audio"],
            "audio": {
                "format": "pcm16",
                "voice": "alloy"
            },
            "stream": false
        }
        """
        
        #expect(try equal(query, expected))
    }
    
    @Test func encodeAssistantMessageReferencingPreviousAudio() throws {
        let query = ChatQuery(
            messages: [
                .assistant(.init(audio: .init(id: "audio_abc123")))
            ],
            model: .gpt_audio_1_5
        )
        
        let expected = """
        {
            "model": "gpt-audio-1.5",
            "messages": [
              {
                "role": "assistant",
                "audio": {
                  "id": "audio_abc123"
                }
              }
            ],
            "stream": false
        }
        """
        
        #expect(try equal(query, expected))
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
#endif
