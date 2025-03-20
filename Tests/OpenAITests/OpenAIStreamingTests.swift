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
