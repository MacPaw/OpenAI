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
            },
            {
                "b64_json": "test"
            }
          ]
        }
        """
        
        let expectedValue = ImagesResult(created: 1589478378, data: [
            .init(url: "https://foo.bar", b64_json: nil),
            .init(url: "https://bar.foo", b64_json: nil),
            .init(url: nil, b64_json: "test")
        ])
        try decode(data, expectedValue)
    }
    
    func testChatCompletion() async throws {
        let data = """
        {
          "id": "chatcmpl-123",
          "object": "chat.completion",
          "created": 1677652288,
          "model": "\(ChatModel.gpt_3_5_turbo_1106.rawValue)",
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
        
        let expectedValue = ChatResult(id: "chatcmpl-123", object: "chat.completion", created: 1677652288, model: ChatModel.gpt_3_5_turbo_1106.rawValue, choices: [
            .init(index: 0, message: Chat(role: .assistant, content: "Hello, world!"), finishReason: "stop")
        ], usage: .init(promptTokens: 9, completionTokens: 12, totalTokens: 21))
        try decode(data, expectedValue)
    }
    
    func testImageQuery() async throws {
        let imageQuery = ImagesQuery(
            prompt: "test",
            model: .dall_e_2,
            responseFormat: .b64_json,
            n: 1,
            size: ._256,
            style: "vivid",
            user: "user"
        )
        
        let expectedValue = """
        {
            "model": "dall-e-2",
            "prompt": "test",
            "n": 1,
            "size": "256x256",
            "style": "vivid",
            "user": "user",
            "response_format": "b64_json"
        }
        """
        
        // To compare serialized JSONs we first convert them both into NSDictionary which are comparable (unline native swift dictionaries)
        let imageQueryAsDict = try jsonDataAsNSDictionary(JSONEncoder().encode(imageQuery))
        let expectedValueAsDict = try jsonDataAsNSDictionary(expectedValue.data(using: .utf8)!)
        
        XCTAssertEqual(imageQueryAsDict, expectedValueAsDict)
    }
  
    func testChatQueryWithFunctionCall() async throws {
        let chatQuery = ChatQuery(
            model: .gpt_3_5_turbo_1106,
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
          "model": "\(ChatModel.gpt_3_5_turbo_1106.rawValue)",
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
            model: ChatModel.gpt_3_5_turbo.rawValue,
            choices: [
                .init(index: 0, message:
                        Chat(role: .assistant,
                             functionCall: ChatFunctionCall(name: "get_current_weather", arguments: nil)),
                      finishReason: "function_call")
            ],
            usage: .init(promptTokens: 82, completionTokens: 18, totalTokens: 100))
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
        
        let expectedValue = EmbeddingsResult(object: "list", data: [
            .init(object: "embedding", embedding: [0.0023064255, -0.009327292, -0.0028842222], index: 0)
        ], model: EmbeddingsModel.text_embedding_ada_002.rawValue, usage: .init(promptTokens: 8, totalTokens: 8))
        try decode(data, expectedValue)
    }
    
    func testModels() async throws {
        let data = """
        {
          "data": [
            {
              "created": 1000000000,
              "id": "\(ChatModel.gpt_3_5_turbo.rawValue)",
              "object": "model",
              "owned_by": "openai"
            },
            {
              "created": 1000000000,
              "id": "\(ImageModel.dall_e_2.rawValue)",
              "object": "model",
              "owned_by": "system"
            },
            {
              "created": 1000000000,
              "id": "\(AudioTranscriptionModel.whisper_1.rawValue)",
              "object": "model",
              "owned_by": "openai-internal"
            }
          ],
          "object": "list"
        }
        """
        
        let expectedValue = ModelsResult(data: [
            .init(created: TimeInterval(1_000_000_000), id: ChatModel.gpt_3_5_turbo.rawValue, object: "model", ownedBy: "openai"),
            .init(created: TimeInterval(1_000_000_000), id: ImageModel.dall_e_2.rawValue, object: "model", ownedBy: "system"),
            .init(created: TimeInterval(1_000_000_000), id: AudioTranscriptionModel.whisper_1.rawValue, object: "model", ownedBy: "openai-internal")
        ], object: "list")
        try decode(data, expectedValue)
    }
    
    func testModelType() async throws {
        let data = """
        {
          "created": 1000000000,
          "id": "\(AudioSpeechModel.tts_1.rawValue)",
          "object": "model",
          "owned_by": "openai-internal"
        }
        """
        
        let expectedValue = ModelResult(created: TimeInterval(1_000_000_000), id: AudioSpeechModel.tts_1.rawValue, object: "model", ownedBy: "openai-internal")
        try decode(data, expectedValue)
    }
    
    func testModerations() async throws {
        let data = """
        {
          "id": "modr-5MWoLO",
          "model": "\(ModerationsModel.textModerationLatest.rawValue)",
          "results": [
            {
              "categories": {
                "harassment": false,
                "harassment/threatening": false,
                "hate": false,
                "hate/threatening": true,
                "self-harm": false,
                "self-harm/intent": false,
                "self-harm/instructions": false,
                "sexual": false,
                "sexual/minors": false,
                "violence": true,
                "violence/graphic": false
              },
              "category_scores": {
                "harassment": 0.0431830403405153,
                "harassment/threatening": 0.1229622494034651,
                "hate": 0.22714105248451233,
                "hate/threatening": 0.4132447838783264,
                "self-harm": 0.00523239187896251,
                "self-harm/intent": 0.307237106114835,
                "self-harm/instructions": 0.42189350703096,
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
        
        let expectedValue = ModerationsResult(id: "modr-5MWoLO", model: ModerationsModel.textModerationLatest.rawValue, results: [
            .init(categories: .init(harassment: false, harassmentThreatening: false, hate: false, hateThreatening: true, selfHarm: false, selfHarmIntent: false, selfHarmInstructions: false, sexual: false, sexualMinors: false, violence: true, violenceGraphic: false),
                  categoryScores: .init(harassment: 0.0431830403405153, harassmentThreatening: 0.1229622494034651, hate: 0.22714105248451233, hateThreatening: 0.4132447838783264, selfHarm: 0.00523239187896251, selfHarmIntent: 0.307237106114835, selfHarmInstructions: 0.42189350703096, sexual: 0.01407341007143259, sexualMinors: 0.0038522258400917053, violence: 0.9223177433013916, violenceGraphic: 0.036865197122097015),
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
