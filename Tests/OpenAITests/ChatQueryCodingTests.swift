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
    
    @Test func encodeExtraBodyMergesTopLevelFields() throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            stream: false,
            extraBody: [
                "chat_template_kwargs": .object([
                    "thinking": .bool(true),
                    "reasoning_effort": .string("high"),
                ]),
            ]
        )

        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": false,
            "chat_template_kwargs": {
                "thinking": true,
                "reasoning_effort": "high"
            }
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func encodeExtraBodyIgnoresReservedKeys() throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            stream: false,
            extraBody: [
                "model": .string("should-be-ignored"),
                "reasoning_effort": .string("low"),
                "temperature": .double(0.99),
                "x_custom": .string("kept"),
            ]
        )

        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": false,
            "x_custom": "kept"
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func encodeFunctionDefinitionExtraMergesSiblingFields() throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            tools: [
                .init(function: .init(
                    name: "vendor_tool",
                    description: "A tool with vendor metadata.",
                    parameters: nil,
                    strict: nil,
                    extra: [
                        "x_vendor_flag": .bool(true),
                    ]
                )),
            ],
            stream: false
        )

        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": false,
            "tools": [
                {
                    "type": "function",
                    "function": {
                        "name": "vendor_tool",
                        "description": "A tool with vendor metadata.",
                        "x_vendor_flag": true
                    }
                }
            ]
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func encodeFunctionDefinitionExtraIgnoresReservedKeys() throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            tools: [
                .init(function: .init(
                    name: "tool_with_collisions",
                    description: "Reserved keys must not shadow typed fields.",
                    parameters: nil,
                    strict: nil,
                    extra: [
                        "name": .string("should-be-ignored"),
                        "description": .string("also-ignored"),
                        "strict": .bool(true),
                        "x_custom": .string("kept"),
                    ]
                )),
            ],
            stream: false
        )

        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": false,
            "tools": [
                {
                    "type": "function",
                    "function": {
                        "name": "tool_with_collisions",
                        "description": "Reserved keys must not shadow typed fields.",
                        "x_custom": "kept"
                    }
                }
            ]
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func decodeFunctionDefinitionExtraCollectsUnknownSiblings() throws {
        let json = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": false,
            "tools": [
                {
                    "type": "function",
                    "function": {
                        "name": "vendor_tool",
                        "x_vendor_flag": true,
                        "vendor_priority": 7
                    }
                }
            ]
        }
        """

        let decoded = try JSONDecoder().decode(ChatQuery.self, from: json.data(using: .utf8)!)
        let fn = try #require(decoded.tools?.first?.function)

        #expect(fn.name == "vendor_tool")
        #expect(fn.extra?["x_vendor_flag"] == .bool(true))
        #expect(fn.extra?["vendor_priority"] == .int(7))
    }

    @Test func functionDefinitionWithoutExtraEncodesUnchanged() throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            tools: [
                .init(function: .init(name: "plain_tool")),
            ],
            stream: false
        )

        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": false,
            "tools": [
                {
                    "type": "function",
                    "function": {
                        "name": "plain_tool"
                    }
                }
            ]
        }
        """

        #expect(try equal(query, expected))
    }

    @Test func decodeExtraBodyCollectsUnknownKeys() throws {
        let json = """
        {
            "model": "gpt-4o",
            "messages": [],
            "stream": true,
            "chat_template_kwargs": { "enable_thinking": false },
            "vendor_x": 42
        }
        """

        let decoded = try JSONDecoder().decode(ChatQuery.self, from: json.data(using: .utf8)!)

        #expect(decoded.extraBody?["chat_template_kwargs"] == .object(["enable_thinking": .bool(false)]))
        #expect(decoded.extraBody?["vendor_x"] == .int(42))
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
