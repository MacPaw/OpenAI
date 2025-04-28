//
//  OpenAITestsDecoder.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import XCTest
@testable import OpenAI

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
class OpenAITestsDecoder: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    private func decode<T: Decodable & Equatable>(_ jsonString: String, _ expectedValue: T, file: StaticString = #filePath, line: UInt = #line) throws {
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(T.self, from: data)
        XCTAssertEqual(decoded, expectedValue, file: file, line: line)
    }

    private func encode<T: Encodable & Equatable>(_ expectedValue: T, _ jsonString: String, file: StaticString = #filePath, line: UInt = #line) throws {
        // To compare serialized JSONs we first convert them both into NSDictionary which are comparable (unlike native swift dictionaries)
        let expectedValueAsDict = try jsonDataAsNSDictionary(JSONEncoder().encode(expectedValue))
        let jsonStringAsDict = try jsonDataAsNSDictionary(jsonString.data(using: .utf8)!)
        XCTAssertEqual(jsonStringAsDict, expectedValueAsDict, file: file, line: line)
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
            .init(b64Json: nil, revisedPrompt: nil, url: "https://foo.bar"),
            .init(b64Json: nil, revisedPrompt: nil, url: "https://bar.foo"),
            .init(b64Json: "test", revisedPrompt: nil, url: nil)
        ])
        try decode(data, expectedValue)
    }
    
    func testChatCompletion() async throws {
        let data = ChatResult.mockJsonString
        
        let expectedValue = ChatResult(
            id: "chatcmpl-123", created: 1677652288, model: .gpt4, object: "chat.completion", serviceTier: nil, systemFingerprint: "fp_fc9f1d7035",
            choices: [
                .init(
                    index: 0,
                    logprobs: nil,
                    message: .init(content: "Hello, world!", refusal: nil, role: "assistant", annotations: [], audio: nil, toolCalls: [], _reasoning: nil, _reasoningContent: nil),
                    finishReason: "stop"
                )
            ],
            usage: .init(completionTokens: 12, promptTokens: 9, totalTokens: 21),
            citations: nil
        )
        try decode(data, expectedValue)
    }
    
    func testImageQuery() async throws {
        let imageQuery = ImagesQuery(
            prompt: "test",
            model: .dall_e_2,
            n: 1,
            responseFormat: .b64_json,
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
        
        try encode(imageQuery, expectedValue)
    }

    func testChatQueryWithVision() async throws {
        let chatQuery = ChatQuery(messages: [
//            .init(role: .user, content: [
//                .chatCompletionContentPartTextParam(.init(text: "What's in this image?")),
//                .chatCompletionContentPartImageParam(.init(imageUrl: .init(url: "https://some.url/image.jpeg", detail: .auto)))
//            ])!
            .user(.init(content: .vision([
                .chatCompletionContentPartTextParam(.init(text: "What's in this image?")),
                .chatCompletionContentPartImageParam(.init(imageUrl: .init(url: "https://some.url/image.jpeg", detail: .auto)))
            ])))
        ], model: Model.gpt4_vision_preview, maxTokens: 300)
        let expectedValue = """
        {
            "model": "gpt-4-vision-preview",
            "messages": [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "text",
                            "text": "What's in this image?"
                        },
                        {
                            "type": "image_url",
                            "image_url": {
                                "url": "https://some.url/image.jpeg",
                                "detail": "auto"
                            }
                        }
                    ]
                }
            ],
            "max_tokens": 300,
            "stream": false
        }
        """

        // To compare serialized JSONs we first convert them both into NSDictionary which are comparable (unline native swift dictionaries)
        let chatQueryAsDict = try jsonDataAsNSDictionary(JSONEncoder().encode(chatQuery))
        let expectedValueAsDict = try jsonDataAsNSDictionary(expectedValue.data(using: .utf8)!)

        XCTAssertEqual(chatQueryAsDict, expectedValueAsDict)
    }
    
    func testChatQueryWithStreamOptions() async throws {
        let chatQuery = ChatQuery(messages: [
            .init(role: .user, content: "Who are you?")!
        ], model: .gpt4, stream: true, streamOptions: .init(includeUsage: true))
        let expectedValue = """
        {
            "model": "gpt-4",
            "messages": [
                {
                    "role": "user",
                    "content": "Who are you?"
                }
            ],
            "stream": true,
            "stream_options": {
                "include_usage" : true
            }
        }
        """
        
        let chatQueryAsDict = try jsonDataAsNSDictionary(JSONEncoder().encode(chatQuery))
        let expectedValueAsDict = try jsonDataAsNSDictionary(expectedValue.data(using: .utf8)!)

        XCTAssertEqual(chatQueryAsDict, expectedValueAsDict)
    }
    
    func testChatQueryWithoutStreamOptions() async throws {
        let chatQuery = ChatQuery(messages: [
            .init(role: .user, content: "Who are you?")!
        ], model: .gpt4, stream: true)
        let expectedValue = """
        {
            "model": "gpt-4",
            "messages": [
                {
                    "role": "user",
                    "content": "Who are you?"
                }
            ],
            "stream": true
        }
        """
        
        let chatQueryAsDict = try jsonDataAsNSDictionary(JSONEncoder().encode(chatQuery))
        let expectedValueAsDict = try jsonDataAsNSDictionary(expectedValue.data(using: .utf8)!)

        XCTAssertEqual(chatQueryAsDict, expectedValueAsDict)
    }
    
    func testChatQueryWithFunctionCall() async throws {
        let chatQuery = ChatQuery(
            messages: [
                .user(.init(content: .string("What's the weather like in Boston?")))
            ],
            model: .gpt3_5Turbo,
            responseFormat: ChatQuery.ResponseFormat.jsonObject,
            toolChoice: .function("get_current_weather"),
            tools: [
                .makeWeatherMock()
            ]
        )
        let expectedValue = """
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": "What's the weather like in Boston?"
            }
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
          "tool_choice": {
            "type": "function",
            "function": {
              "name": "get_current_weather"
            }
          },
          "stream": false
        }
        """
        
        try encode(chatQuery, expectedValue)
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
                "annotations": [],
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
          },
          "system_fingerprint": "fp_fc9f1d7035"
        }
        """
        
        let expectedValue = ChatResult(
            id: "chatcmpl-1234",
            created: 1677652288,
            model: .gpt3_5Turbo,
            object: "chat.completion",
            serviceTier: nil,
            systemFingerprint: "fp_fc9f1d7035",
            choices: [
                .init(
                    index: 0,
                    logprobs: nil,
                    message: .init(
                        content: nil,
                        refusal: nil,
                        role: "assistant",
                        annotations: [],
                        audio: nil,
                        toolCalls: [.init(id: "chatcmpl-1234", function: .init(arguments: "", name: "get_current_weather"))],
                        _reasoning: nil,
                        _reasoningContent: nil
                    ),
                    finishReason: "tool_calls"
                )
            ],
            usage: .init(completionTokens: 18, promptTokens: 82, totalTokens: 100),
            citations: nil
        )
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
        ], model: .textEmbeddingAda, usage: .init(promptTokens: 8, totalTokens: 8), object: "list")
        try decode(data, expectedValue)
    }
    
    func testModels() async throws {
        let data = """
        {
          "data": [
            {
              "id": "gpt-3.5-turbo",
              "created": 222,
              "object": "model",
              "owned_by": "organization-owner"
            },
            {
              "id": "dall-e-2",
              "created": 111,
              "object": "model",
              "owned_by": "organization-owner"
            },
            {
              "id": "whisper-1",
              "created": 333,
              "object": "model",
              "owned_by": "openai"
            }
          ],
          "object": "list"
        }
        """
        
        let expectedValue = ModelsResult(data: [
            .init(id: .gpt3_5Turbo, created: 222, object: "model", ownedBy: "organization-owner"),
            .init(id: .dall_e_2, created: 111, object: "model", ownedBy: "organization-owner"),
            .init(id: .whisper_1, created: 333, object: "model", ownedBy: "openai")
        ], object: "list")
        try decode(data, expectedValue)
    }
    
    func testModelType() async throws {
        let data = """
        {
          "id": "whisper-1",
          "created": 555,
          "object": "model",
          "owned_by": "openai"
        }
        """
        
        let expectedValue = ModelResult(id: .whisper_1, created: 555, object: "model", ownedBy: "openai")
        try decode(data, expectedValue)
    }
    
    func testModerations() async throws {
        let data = """
        {
          "id": "modr-5MWoLO",
          "model": "text-moderation-007",
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
        
        let expectedValue = ModerationsResult(id: "modr-5MWoLO", model: .moderation, results: [
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
    
    func testAudioAudioTranslationResults() async throws {
        let data = """
        {
          "text": "Hello, world!"
        }
        """
        
        let expectedValue = AudioTranslationResult(text: "Hello, world!")
        try decode(data, expectedValue)
    }
    
    func testAssistantResult() async throws {
        let data = """
        {
          "id": "asst_abc123",
          "object": "assistant",
          "created_at": 1698984975,
          "name": "Math Tutor",
          "description": null,
          "model": "gpt-4",
          "instructions": "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "file_ids": [],
          "metadata": {}
        }
        """
        
        let expectedValue = AssistantResult(id: "asst_abc123", name: "Math Tutor", description: nil, instructions: "You are a personal math tutor. When asked a question, write and run Python code to answer the question.", tools: [.codeInterpreter], toolResources: nil)
        try decode(data, expectedValue)
    }
    
    func testAssistantsQuery() async throws {
        let assistantsQuery = AssistantsQuery(
            model: .gpt4,
            name: "Math Tutor",
            description: nil,
            instructions: "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
            tools: [.codeInterpreter],
            toolResources: nil
        )
        
        let expectedValue = """
        {
            "instructions": "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
            "name": "Math Tutor",
            "tools": [
                {"type": "code_interpreter"}
            ],
            "model": "gpt-4"
        }
        """
        
        try encode(assistantsQuery, expectedValue)
    }
    
    func testAssistantsResult() async throws {
        let data = """
        {
          "object": "list",
          "data": [
            {
              "id": "asst_abc123",
              "object": "assistant",
              "created_at": 1698982736,
              "name": "Coding Tutor",
              "description": null,
              "model": "gpt-4",
              "instructions": "You are a helpful assistant designed to make me better at coding!",
              "tools": [],
              "file_ids": [],
              "metadata": {}
            },
            {
              "id": "asst_abc456",
              "object": "assistant",
              "created_at": 1698982718,
              "name": "My Assistant",
              "description": null,
              "model": "gpt-4",
              "instructions": "You are a helpful assistant designed to teach me about AI!",
              "tools": [],
              "file_ids": [],
              "metadata": {}
            }
          ],
          "first_id": "asst_abc123",
          "last_id": "asst_abc789",
          "has_more": false
        }
        """
        
        let expectedValue = AssistantsResult(
            data: [
                .init(id: "asst_abc123", name: "Coding Tutor", description: nil, instructions: "You are a helpful assistant designed to make me better at coding!", tools: [], toolResources: nil),
                .init(id: "asst_abc456", name: "My Assistant", description: nil, instructions: "You are a helpful assistant designed to teach me about AI!", tools: [], toolResources: nil),
            ],
            firstId: "asst_abc123", 
            lastId: "asst_abc789",
            hasMore: false
        )
        
        try decode(data, expectedValue)
    }
    
    func testMessageQuery() async throws {
        let messageQuery = MessageQuery(
            role: .user,
            content: "How does AI work? Explain it in simple terms.",
            fileIds: ["file_abc123"]
        )
        
        let expectedValue = """
        {
            "role": "user",
            "content": "How does AI work? Explain it in simple terms.",
            "file_ids": ["file_abc123"]
        }
        """

        try encode(messageQuery, expectedValue)
    }
    
    func testRunResult() async throws {
        let data = """
        {
            "id": "run_1a",
            "thread_id": "thread_2b",
            "status": "requires_action",
            "required_action": {
                "type": "submit_tool_outputs",
                "submit_tool_outputs": {
                    "tool_calls": [
                        {
                            "id": "tool_abc890",
                            "type": "function",
                            "function": {
                                "name": "print",
                                "arguments": "{\\"text\\": \\"hello\\"}"
                            }
                        }
                    ]
                }
            }
        }
        """
        
        let expectedValue = RunResult(
            id: "run_1a",
            threadId: "thread_2b",
            status: .requiresAction,
            requiredAction: .init(
                submitToolOutputs: .init(toolCalls: [.init(id: "tool_abc890", type: "function", function: .init(name: "print", arguments: "{\"text\": \"hello\"}"))])
            )
        )
        
        try decode(data, expectedValue)
    }
    
    func testRunToolOutputsQuery() async throws {
        let runToolOutputsQuery = RunToolOutputsQuery(
            toolOutputs: [
                .init(toolCallId: "call_abc0", output: "success")
            ]
        )
        
        let expectedValue = """
        {
            "tool_outputs": [
                {
                    "tool_call_id": "call_abc0",
                    "output": "success"
                }
            ]
        }
        """
        
        try encode(runToolOutputsQuery, expectedValue)
    }
    
    func testThreadRunQuery() async throws {
        let threadRunQuery = ThreadRunQuery(
            assistantId: "asst_abc123",
            thread: .init(
                messages: [.init(role: .user, content: "Explain deep learning to a 5 year old.")!]
            )
        )
        
        let expectedValue = """
        {
            "assistant_id": "asst_abc123",
            "thread": {
                "messages": [
                    {"role": "user", "content": "Explain deep learning to a 5 year old."}
                ]
            }
        }
        """
        
        try encode(threadRunQuery, expectedValue)
    }
    
    func testChatQueryWithStructuredOutputDerivedSchema() throws {        
        let query = ChatQuery(
            messages: [.system(.init(content: "Return a structured response."))],
            model: .gpt4_o,
            responseFormat: .derivedJsonSchema(name: "movie-info", type: MovieInfo.self)
        )
        
        let data = try JSONEncoder().encode(query)
        let dict = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        XCTAssertEqual(dict["model"] as! String, "gpt-4o")
        XCTAssertEqual(dict["stream"] as! Bool, false)
        
        let responseFormat = dict["response_format"] as! [String: Any]
        XCTAssertEqual(responseFormat["type"] as! String, "json_schema")
        
        let configOptions = responseFormat["json_schema"] as! [String: Any]
        XCTAssertEqual(configOptions["name"] as! String, "movie-info")
        XCTAssertEqual(configOptions.keys.contains(where: { $0 == "description" }), false)
        XCTAssertEqual(configOptions["strict"] as! Bool, true)
        
        let jsonSchema = configOptions["schema"] as! [String: Any]
        XCTAssertEqual(jsonSchema["type"] as! String, "object")
        let properties = jsonSchema["properties"] as! [String: [String: Any]]
        let titleSchema = properties["title"]!
        XCTAssertEqual(titleSchema.count, 1)
        XCTAssertEqual(titleSchema["type"] as! String, "string")
    }
    
    func testChatQueryWithStructuredOutputJsonSchema() throws {
        let query = ChatQuery(
            messages: [.system(.init(content: "Return a structured response."))],
            model: .gpt4_o,
            responseFormat: .jsonSchema(
                .init(
                    name: "movie-info",
                    description: "dezg",
                    schema: .init(fields: [
                        .type(.object),
                        .properties([
                            "title": .init(fields: [
                                .type(.string)
                            ])
                        ])
                    ]),
                    strict: false
                )
            )
        )
        
        let data = try JSONEncoder().encode(query)
        let dict = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        XCTAssertEqual(dict["model"] as! String, "gpt-4o")
        XCTAssertEqual(dict["stream"] as! Bool, false)
        
        let responseFormat = dict["response_format"] as! [String: Any]
        XCTAssertEqual(responseFormat["type"] as! String, "json_schema")
        
        let configOptions = try XCTUnwrap(responseFormat["json_schema"] as? [String: Any])
        XCTAssertEqual(try XCTUnwrap(configOptions["name"] as? String), "movie-info")
        XCTAssertEqual(try XCTUnwrap(configOptions["description"] as? String), "dezg")
        XCTAssertEqual(try XCTUnwrap(configOptions["strict"] as? Bool), false)
        
        let jsonSchema = configOptions["schema"] as! [String: Any]
        XCTAssertEqual(try XCTUnwrap(jsonSchema["type"] as? String), "object")
        let properties = try XCTUnwrap(jsonSchema["properties"] as? [String: [String: Any]])
        let titleSchema = try XCTUnwrap(properties["title"])
        XCTAssertEqual(titleSchema.count, 1)
        XCTAssertEqual(try XCTUnwrap(titleSchema["type"] as? String), "string")
    }
}
