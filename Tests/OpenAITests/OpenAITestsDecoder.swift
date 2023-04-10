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
    
    private let decoder = JSONDecoder()
    
    override func setUp() {
        super.setUp()
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
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(CompletionsResult.self, from: data)
        let mock = CompletionsResult(id: "foo", object: "text_completion", created: 1589478378, model: .textDavinci_003, choices: [
            .init(text: "Hello, world!", index: 0)
        ], usage: .init(promptTokens: 5, completionTokens: 7, totalTokens: 12))
        XCTAssertEqual(decoded, mock)
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
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(ImagesResult.self, from: data)
        let mock = ImagesResult(created: 1589478378, data: [
            .init(url: "https://foo.bar"),
            .init(url: "https://bar.foo")
        ])
        XCTAssertEqual(decoded, mock)
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
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(ChatResult.self, from: data)
        let mock = ChatResult(id: "chatcmpl-123", object: "chat.completion", created: 1677652288, model: .gpt4, choices: [
            .init(index: 0, message: Chat(role: "assistant", content: "Hello, world!"), finishReason: "stop")
        ], usage: .init(promptTokens: 9, completionTokens: 12, totalTokens: 21))
        XCTAssertEqual(decoded, mock)
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
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(EmbeddingsResult.self, from: data)
        let mock = EmbeddingsResult(data: [
            .init(object: "embedding", embedding: [0.0023064255, -0.009327292, -0.0028842222], index: 0)
        ], usage: .init(promptTokens: 8, totalTokens: 8))
        XCTAssertEqual(decoded, mock)
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
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(ModelsResult.self, from: data)
        let mock = ModelsResult(data: [
            .init(id: .gpt3_5Turbo, object: "model", ownedBy: "organization-owner"),
            .init(id: .gpt4, object: "model", ownedBy: "organization-owner"),
            .init(id: .textDavinci_001, object: "model", ownedBy: "openai")
        ], object: "list")
        XCTAssertEqual(decoded, mock)
    }
    
    func testModelType() async throws {
        let data = """
        {
          "id": "text-davinci-003",
          "object": "model",
          "owned_by": "openai"
        }
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(ModelResult.self, from: data)
        let mock = ModelResult(id: .textDavinci_003, object: "model", ownedBy: "openai")
        XCTAssertEqual(decoded, mock)
    }
    
    func testAudioTranscriptions() async throws {
        let data = """
        {
          "text": "Hello, world!"
        }
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(AudioTranscriptionResult.self, from: data)
        let mock = AudioTranscriptionResult(text: "Hello, world!")
        XCTAssertEqual(decoded, mock)
    }
    
    func testAudioTranslations() async throws {
        let data = """
        {
          "text": "Hello, world!"
        }
        """.data(using: .utf8)!
        
        let decoded = try decoder.decode(AudioTranslationResult.self, from: data)
        let mock = AudioTranslationResult(text: "Hello, world!")
        XCTAssertEqual(decoded, mock)
    }
}
