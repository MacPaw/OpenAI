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

    private func decode<T: Decodable & Hashable>(_ jsonString: String, _ expectedValue: T) throws {
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

        let expectedValue = ImagesResponse(created: 1589478378, data: [
            .init(b64_json: nil, revised_prompt: nil, url: "https://foo.bar"),
            .init(b64_json: nil, revised_prompt: nil, url: "https://bar.foo"),
            .init(b64_json: "test", revised_prompt: nil, url: nil)
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

        let expectedValue = ChatCompletion(id: "chatcmpl-123", choices: [
            .init(finish_reason: "stop", index: 0, logprobs: nil, message: .assistant(.init(content: "Hello, world!")))
        ], created: 1677652288, model: ChatModel.gpt_3_5_turbo_1106.rawValue, object: "chat.completion", system_fingerprint: nil, usage: .init(completion_tokens: 12, prompt_tokens: 9, total_tokens: 21))
        try decode(data, expectedValue)
    }

    func testImageQuery() async throws {
        let imageQuery = ImageGenerateParams(
            prompt: "test",
            model: .dall_e_2,
            n: 1,
            response_format: .b64_json,
            size: ._512,
            style: .vivid,
            user: "user"
        )

        let expectedValue = """
        {
            "model": "dall-e-2",
            "prompt": "test",
            "n": 1,
            "size": "512x512",
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
        let chatQuery = ChatCompletionCreateParams(
            messages: [
                .user(.init(content: .string("What's the weather like in Boston?")))
            ],
            model: .gpt_3_5_turbo,
            response_format: ChatCompletionCreateParams.ResponseFormat.json_object,
            tools: [
                .init(function: .init(
                    name: "get_current_weather",
                    description: "Get the current weather in a given location",
                    parameters: .init(
                        type: .object,
                        properties: [
                          "location": .init(type: .string, description: "The city and state, e.g. San Francisco, CA"),
                          "unit": .init(type: .string, enum: ["celsius", "fahrenheit"])
                        ],
                        required: ["location"]
                      )
                ))
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
          "tools": [
            {
              "function": {
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
              },
              "type": "function"
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
          "model": "\(ChatModel.gpt_3_5_turbo.rawValue)",
          "choices": [
            {
              "index": 0,
              "message": {
                "role": "assistant",
                "tool_calls": [
                  {
                    "type": "function",
                    "id": "chatcmpl-1234",
                    "function": {
                      "name": "get_current_weather",
                      "arguments": ""
                    }
                  }
                ]
              },
              "finish_reason": "tool_calls",
              "logprobs": null
            }
          ],
          "usage": {
            "prompt_tokens": 82,
            "completion_tokens": 18,
            "total_tokens": 100
          }
        }
        """

        let expectedValue = ChatCompletion(
            id: "chatcmpl-1234",
            choices: [
                .init(finish_reason: "tool_calls", index: 0,
                      logprobs: nil, message:
                        .assistant(.init(tool_calls: [.init(id: "chatcmpl-1234", function: .init(arguments: "", name: "get_current_weather"))])))
            ],
            created: 1677652288,
            model: ChatModel.gpt_3_5_turbo.rawValue,
            object: "chat.completion",
            system_fingerprint: nil,
            usage: .init(completion_tokens: 18, prompt_tokens: 82, total_tokens: 100))
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

        let expectedValue = EmbeddingResponse(data: [
            .init(embedding: [0.0023064255, -0.009327292, -0.0028842222], index: 0, object: "embedding")
        ], model: EmbeddingsModel.text_embedding_ada_002.rawValue, object: "list", usage: .init(prompt_tokens: 8, total_tokens: 8))
        try decode(data, expectedValue)
    }

    func testModels() async throws {
        let data = """
        {
          "data": [
            {
              "id": "\(ChatModel.gpt_3_5_turbo.rawValue)",
              "created": 222,
              "object": "model",
              "owned_by": "organization-owner"
            },
            {
              "id": "\(ImageModel.dall_e_2.rawValue)",
              "created": 111,
              "object": "model",
              "owned_by": "organization-owner"
            },
            {
              "id": "\(AudioTranscriptionModel.whisper_1.rawValue)",
              "created": 333,
              "object": "model",
              "owned_by": "openai"
            }
          ],
          "object": "list"
        }
        """

        let expectedValue = ModelsResponse(data: [
            .init(id: ChatModel.gpt_3_5_turbo.rawValue, created: 222, object: "model", owned_by: "organization-owner"),
            .init(id: ImageModel.dall_e_2.rawValue, created: 111, object: "model", owned_by: "organization-owner"),
            .init(id: AudioTranscriptionModel.whisper_1.rawValue, created: 333, object: "model", owned_by: "openai")
        ], object: "list")
        try decode(data, expectedValue)
    }

    func testModelType() async throws {
        let data = """
        {
          "id": "\(AudioTranscriptionModel.whisper_1.rawValue)",
          "created": 555,
          "object": "model",
          "owned_by": "openai"
        }
        """

        let expectedValue = Model(id: AudioTranscriptionModel.whisper_1.rawValue, created: 555, object: "model", owned_by: "openai")
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

        let expectedValue = ModerationCreateResponse(id: "modr-5MWoLO", model: ModerationsModel.textModerationLatest.rawValue, results: [
            .init(categories: .init(harassment: false, harassment_threatening: false, hate: false, hate_threatening: true, self_harm: false, self_harm_intent: false, self_harm_instructions: false, sexual: false, sexual_minors: false, violence: true, violence_graphic: false),
                  category_scores: .init(harassment: 0.0431830403405153, harassment_threatening: 0.1229622494034651, hate: 0.22714105248451233, hate_threatening: 0.4132447838783264, self_harm: 0.00523239187896251, self_harm_intent: 0.307237106114835, self_harm_instructions: 0.42189350703096, sexual: 0.01407341007143259, sexual_minors: 0.0038522258400917053, violence: 0.9223177433013916, violence_graphic: 0.036865197122097015),
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

        let expectedValue = Transcription(text: "Hello, world!")
        try decode(data, expectedValue)
    }

    func testAudioTranslations() async throws {
        let data = """
        {
          "text": "Hello, world!"
        }
        """

        let expectedValue = Translation(text: "Hello, world!")
        try decode(data, expectedValue)
    }
}
