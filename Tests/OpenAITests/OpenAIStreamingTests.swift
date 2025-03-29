//
//  OpenAIStreamingTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.03.2025.
//

import Foundation

import XCTest
@testable import OpenAI

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
class OpenAIStreamingTests: XCTestCase {
    private var configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
    private let streamingSessionFactory = MockStreamingSessionFactory()
    private let cancellablesFactory = MockCancellablesFactory()
    
    private var urlSession: URLSessionMock {
        streamingSessionFactory.urlSessionFactory.urlSession
    }
    
    private lazy var openAI = OpenAI(
        configuration: configuration,
        session: URLSessionMock(),
        streamingSessionFactory: streamingSessionFactory,
        cancellablesFactory: cancellablesFactory,
        executionSerializer: NoDispatchExecutionSerializer()
    )
    
    func testCancelStreamingRequest() async throws {
        try stub(result: makeChatResult())
        
        let task = Task {
            let stream: AsyncThrowingStream<ChatStreamResult, Error> = openAI.chatsStream(query: makeChatQuery())
            for try await _ in stream {
            }
        }
        
        task.cancel()
        _ = try await task.value
        XCTAssertEqual(cancellablesFactory.sessionCanceller.cancelCallCount, 1)
    }
    
    func testImplicitlyCreatedUrlSessionIsInvalidatedToBreakRetainCycle() throws {
        try stub(result: makeChatResult())
        
        var assertedInAnotherFunction = false
        performStreamAndAssertInvalidation { completion in
            _ = openAI.chatsStream(query: makeChatQuery()) { result in
            } completion: { error in
                completion(error)
            }
            assertedInAnotherFunction = true
        }
        XCTAssertTrue(assertedInAnotherFunction)
    }
    
    
    func testGeminiStyleChunkDecoding() throws {
        let json = """
        [
          {
            "object": "chat.completion.chunk",
            "created": 1743249736,
            "model": "gemini-2.0-flash",
            "choices": [
              {
                "delta": {
                  "content": "Hey",
                  "role": "assistant"
                },
                "index": 0
              }
            ]
          }
        ]
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let result = try decoder.decode([ChatStreamResult].self, from: json)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].model, "gemini-2.0-flash")
        XCTAssertEqual(result[0].choices.first?.delta.content, "Hey")
        XCTAssertEqual(result[0].choices.first?.delta.role, .assistant)
    }
    
    func testChatResultWithToolCallDecoding() throws {
        let json = """
        {
          "choices": [
            {
              "finish_reason": "tool_calls",
              "index": 0,
              "message": {
                "role": "assistant",
                "tool_calls": [
                  {
                    "function": {
                      "arguments": "{\\"query\\":\\"Lakers score\\"}",
                      "name": "search_web"
                    },
                    "id": "",
                    "type": "function"
                  }
                ]
              }
            }
          ],
          "created": 1743275155,
          "model": "gemini-2.0-flash",
          "object": "chat.completion",
          "usage": {
            "completion_tokens": 7,
            "prompt_tokens": 266,
            "total_tokens": 273
          }
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let result = try decoder.decode(ChatResult.self, from: json)

        XCTAssertEqual(result.model, "gemini-2.0-flash")
        XCTAssertEqual(result.choices.count, 1)

        let choice = result.choices[0]
        XCTAssertEqual(choice.finishReason, "tool_calls")
        XCTAssertEqual(choice.index, 0)
        XCTAssertEqual(choice.message.toolCalls?.count, 1)

        let toolCall = choice.message.toolCalls?.first
        XCTAssertEqual(toolCall?.function.name, "search_web")
        XCTAssertEqual(toolCall?.function.arguments, "{\"query\":\"Lakers score\"}")
    }
    
    func testAudioSpeechSessionInvalidated() throws {
        try stub(result: Data())
        
        var asserted = false
        performStreamAndAssertInvalidation { completion in
            _ = openAI.audioCreateSpeechStream(query: .mock) { result in
            } completion: { error in
                completion(error)
            }
            asserted = true
        }
        XCTAssertTrue(asserted)
    }
    
    private func performStreamAndAssertInvalidation(performStream: (_ completion: @escaping (Error?) -> Void) -> Void) {
        urlSession.dataTask.completion = { data, _, error in
            let dataDelegate = self.urlSession.delegate
            dataDelegate?.urlSession(self.urlSession, task: self.urlSession.dataTask, didCompleteWithError: error)
        }
        
        var completionCallCount = 0
        let completionCalledClosure = UncheckedSendableClosure {
            dispatchPrecondition(condition: .onQueue(.main))
            completionCallCount += 1
        }
        
        performStream { error in
            dispatchPrecondition(condition: .onQueue(.main))
            completionCalledClosure.closure()
        }
        
        XCTAssertEqual(completionCallCount, 1)
        
        let finished = urlSession.finishTasksAndInvalidateCallCount == 1 && urlSession.invalidateAndCancelCallCount == 0
        let canceled = urlSession.finishTasksAndInvalidateCallCount == 0 && urlSession.invalidateAndCancelCallCount == 1
        XCTAssertTrue(finished || canceled)
    }
    
    private func makeChatQuery() -> ChatQuery {
        .init(messages: [
            .system(.init(content: "You are Librarian-GPT. You know everything about the books.")),
            .user(.init(content: .string("Who wrote Harry Potter?")))
        ], model: .gpt3_5Turbo)
    }
    
    private func makeChatResult() -> ChatResult {
        .mock
    }
    
    private func stub(result: Codable) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(result)
        let task = DataTaskMock.successful(with: data)
        urlSession.dataTask = task
    }
}

struct UncheckedSendableClosure: @unchecked Sendable {
    typealias Closure = () -> Void

    let closure: Closure

    init(_ closure: @escaping Closure) {
        self.closure = {
            closure()
        }
    }
}
