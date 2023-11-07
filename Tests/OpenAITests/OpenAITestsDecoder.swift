//
//  OpenAITestsDecoder.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import XCTest
@testable import OpenAI

@available(iOS 13.0, *)
@available(watchOS 6.0, *)
@available(tvOS 13.0, *)
class OpenAITestsDecoder: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    private func decode<T: Decodable & Equatable>(_ jsonString: String, _ expectedValue: T) throws {
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(T.self, from: data)
        XCTAssertEqual(decoded, expectedValue)
    }
    
    func jsonDataAsNSDictionary(_ data: Data) throws -> NSDictionary {
        return NSDictionary(dictionary: try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any])
    }
    
    func testCompletions() async throws {
        let data = """
        {
          "id": "foo",
          "object": "text_completion",
          "created": 1589478378,
          "model": "text-davinci-003",
          "choices": [
            {
              "text": "Hello, world!",
              "index": 0,
              "logprobs": null,
              "finish_reason": "length"
            }
          ],
          "usage": {
            "prompt_tokens": 5,
            "completion_tokens": 7,
            "total_tokens": 12
          }
        }
        """
        
        let expectedValue = CompletionsResult(id: "foo", object: "text_completion", created: 1589478378, model: .textDavinci_003, choices: [
            .init(text: "Hello, world!", index: 0, finishReason: "length")
        ], usage: .init(promptTokens: 5, completionTokens: 7, totalTokens: 12))
        try decode(data, expectedValue)
    }
    
    func testImages() async throws {
        let data = """
        {
          "created": 1589478378,
          "data": [
            {
              "url": "https://foo.bar"
            },
            {
              "url": "https://bar.foo"
            }
          ]
        }
        """
        
        let expectedValue = ImagesResult(created: 1589478378, data: [
            .init(url: "https://foo.bar"),
            .init(url: "https://bar.foo")
        ])
        try decode(data, expectedValue)
    }
    
    func testChatCompletion() async throws {
        let data = """
        {
          "id": "chatcmpl-123",
          "object": "chat.completion",
          "created": 1677652288,
          "model": "gpt-4",
          "choices": [{
            "index": 0,
            "message": {
              "role": "assistant",
              "content": "Hello, world!",
            },
            "finish_reason": "stop"
          }],
          "usage": {
            "prompt_tokens": 9,
            "completion_tokens": 12,
            "total_tokens": 21
          }
        }
        """
        
        let expectedValue = ChatResult(id: "chatcmpl-123", object: "chat.completion", created: 1677652288, model: .gpt4, choices: [
            .init(index: 0, message: Chat(role: .assistant, content: "Hello, world!"), finishReason: "stop")
        ], usage: .init(promptTokens: 9, completionTokens: 12, totalTokens: 21))
        try decode(data, expectedValue)
    }
  
    func testChatQueryWithFunctionCall() async throws {
        let chatQuery = ChatQuery(
            model: .gpt3_5Turbo,
            messages: [
                Chat(role: .user, content: "What's the weather like in Boston?")
            ],
            responseFormat: .init(type: .jsonObject),
            functions: [
                ChatFunctionDeclaration(
                    name: "get_current_weather",
                    description: "Get the current weather in a given location",
                    parameters:
                      JSONSchema(
                        type: .object,
                        properties: [
                          "location": .init(type: .string, description: "The city and state, e.g. San Francisco, CA"),
                          "unit": .init(type: .string, enumValues: ["celsius", "fahrenheit"])
                        ],
                        required: ["location"]
                      )
                )
            ]
        )
        let expectedValue = """
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            { "role": "user", "content": "What's the weather like in Boston?" }
          ],
          "response_format": {
            "type": "json_object"
           },
          "functions": [
            {
              "name": "get_current_weather",
              "description": "Get the current weather in a given location",
              "parameters": {
                "type": "object",
                "properties": {
                  "location": {
                    "type": "string",
                    "description": "The city and state, e.g. San Francisco, CA"
                  },
                  "unit": { "type": "string", "enum": ["celsius", "fahrenheit"] }
                },
                "required": ["location"]
              }
            }
          ],
          "stream": false
        }
        """
        
        // To compare serialized JSONs we first convert them both into NSDictionary which are comparable (unline native swift dictionaries)
        let chatQueryAsDict = try jsonDataAsNSDictionary(JSONEncoder().encode(chatQuery))
        let expectedValueAsDict = try jsonDataAsNSDictionary(expectedValue.data(using: .utf8)!)
        
        XCTAssertEqual(chatQueryAsDict, expectedValueAsDict)
    }

    func testChatCompletionWithFunctionCall() async throws {
        let data = """
        {
          "id": "chatcmpl-1234",
          "object": "chat.completion",
          "created": 1677652288,
          "model": "gpt-3.5-turbo",
          "choices": [
            {
              "index": 0,
              "message": {
                "role": "assistant",
                "content": null,
                "function_call": {
                  "name": "get_current_weather"
                }
              },
              "finish_reason": "function_call"
            }
          ],
          "usage": {
            "prompt_tokens": 82,
            "completion_tokens": 18,
            "total_tokens": 100
          }
        }
        """
        
        let expectedValue = ChatResult(
            id: "chatcmpl-1234",
            object: "chat.completion",
            created: 1677652288,
            model: .gpt3_5Turbo,
            choices: [
                .init(index: 0, message:
                        Chat(role: .assistant,
                             functionCall: ChatFunctionCall(name: "get_current_weather", arguments: nil)),
                      finishReason: "function_call")
            ],
            usage: .init(promptTokens: 82, completionTokens: 18, totalTokens: 100))
        try decode(data, expectedValue)
    }

    func testEdits() async throws {
        let data = """
        {
          "object": "edit",
          "created": 1589478378,
          "choices": [
            {
              "text": "What day of the week is it?",
              "index": 0,
            }
          ],
          "usage": {
            "prompt_tokens": 25,
            "completion_tokens": 32,
            "total_tokens": 57
          }
        }
        """
        
        let expectedValue = EditsResult(object: "edit", created: 1589478378, choices: [
            .init(text: "What day of the week is it?", index: 0)
        ], usage: .init(promptTokens: 25, completionTokens: 32, totalTokens: 57))
        try decode(data, expectedValue)
    }
    
    func testEmbeddings() async throws {
        let data = """
        {
          "object": "list",
          "data": [
            {
              "object": "embedding",
              "embedding": [
                0.0023064255,
                -0.009327292,
                -0.0028842222,
              ],
              "index": 0
            }
          ],
          "model": "text-embedding-ada-002",
          "usage": {
            "prompt_tokens": 8,
            "total_tokens": 8
          }
        }
        """
        
        let expectedValue = EmbeddingsResult(data: [
            .init(object: "embedding", embedding: [0.0023064255, -0.009327292, -0.0028842222], index: 0)
        ], model: .textEmbeddingAda, usage: .init(promptTokens: 8, totalTokens: 8))
        try decode(data, expectedValue)
    }
    
    func testModels() async throws {
        let data = """
        {
          "data": [
            {
              "id": "gpt-3.5-turbo",
              "object": "model",
              "owned_by": "organization-owner"
            },
            {
              "id": "gpt-4",
              "object": "model",
              "owned_by": "organization-owner"
            },
            {
              "id": "text-davinci-001",
              "object": "model",
              "owned_by": "openai"
            }
          ],
          "object": "list"
        }
        """
        
        let expectedValue = ModelsResult(data: [
            .init(id: .gpt3_5Turbo, object: "model", ownedBy: "organization-owner"),
            .init(id: .gpt4, object: "model", ownedBy: "organization-owner"),
            .init(id: .textDavinci_001, object: "model", ownedBy: "openai")
        ], object: "list")
        try decode(data, expectedValue)
    }
    
    func testModelType() async throws {
        let data = """
        {
          "id": "text-davinci-003",
          "object": "model",
          "owned_by": "openai"
        }
        """
        
        let expectedValue = ModelResult(id: .textDavinci_003, object: "model", ownedBy: "openai")
        try decode(data, expectedValue)
    }
    
    func testModerations() async throws {
        let data = """
        {
          "id": "modr-5MWoLO",
          "model": "text-moderation-001",
          "results": [
            {
              "categories": {
                "hate": false,
                "hate/threatening": true,
                "self-harm": false,
                "sexual": false,
                "sexual/minors": false,
                "violence": true,
                "violence/graphic": false
              },
              "category_scores": {
                "hate": 0.22714105248451233,
                "hate/threatening": 0.4132447838783264,
                "self-harm": 0.00523239187896251,
                "sexual": 0.01407341007143259,
                "sexual/minors": 0.0038522258400917053,
                "violence": 0.9223177433013916,
                "violence/graphic": 0.036865197122097015
              },
              "flagged": true
            }
          ]
        }
        """
        
        let expectedValue = ModerationsResult(id: "modr-5MWoLO", model: .moderation, results: [
            .init(categories: .init(hate: false, hateThreatening: true, selfHarm: false, sexual: false, sexualMinors: false, violence: true, violenceGraphic: false),
                  categoryScores: .init(hate: 0.22714105248451233, hateThreatening: 0.4132447838783264, selfHarm: 0.00523239187896251, sexual: 0.01407341007143259, sexualMinors: 0.0038522258400917053, violence: 0.9223177433013916, violenceGraphic: 0.036865197122097015),
                  flagged: true)
        ])
        try decode(data, expectedValue)
    }
    
    func testAudioTranscriptions() async throws {
        let data = """
        {
          "text": "Hello, world!"
        }
        """
        
        let expectedValue = AudioTranscriptionResult(text: "Hello, world!")
        try decode(data, expectedValue)
    }
    
    func testAudioTranslations() async throws {
        let data = """
        {
          "text": "Hello, world!"
        }
        """
        
        let expectedValue = AudioTranslationResult(text: "Hello, world!")
        try decode(data, expectedValue)
    }
}
