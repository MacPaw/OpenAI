//
//  StreamingSessionIntegrationTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.03.2025.
//

import XCTest
@testable import OpenAI

@MainActor
final class StreamingSessionIntegrationTests: XCTestCase {
    private enum Call {
        case content
        case complete
    }
    
    private let urlSessionFactory = MockURLSessionFactory()
    private let streamInterpreter = ServerSentEventsStreamInterpreter<ChatStreamResult>(parsingOptions: [])
    private var calls: [Call] = []
    private lazy var expectation: XCTestExpectation = {
        let expectation = self.expectation(description: "3 content and 1 finish happened")
        expectation.expectedFulfillmentCount = 4
        return expectation
    }()
    
    private var executionSerializer: ExecutionSerializer = NoDispatchExecutionSerializer()
    
    private lazy var streamingSession = StreamingSession(
        urlSessionFactory: urlSessionFactory,
        urlRequest: .init(url: .init(string: "/")!),
        interpreter: streamInterpreter,
        sslDelegate: nil,
        middlewares: [],
        executionSerializer: executionSerializer,
        onReceiveContent: { _, _ in
            Task {
                await MainActor.run {
                    self.calls.append(.content)
                    self.expectation.fulfill()
                }
            }
        },
        onProcessingError: { _, _ in },
        onComplete: { _,_ in
            Task {
                await MainActor.run {
                    self.calls.append(.complete)
                    self.expectation.fulfill()
                }
            }
        }
    )

    @MainActor
    func testCompleteCalledAfterAllEventsWithMockSerializer() {
        XCTAssertTrue(executionSerializer is NoDispatchExecutionSerializer)
        let asserted = testCompleteCalledAfterAllEvents()
        XCTAssertTrue(asserted)
    }
    
    @MainActor
    func testCompleteCalledAfterAllEventsWithRealSerializer() {
        executionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated)
        let asserted = testCompleteCalledAfterAllEvents()
        XCTAssertTrue(asserted)
    }
    
    @MainActor
    private func testCompleteCalledAfterAllEvents() -> Bool {
        _ = streamingSession
        let cancellable = streamingSession.makeSession()
        
        let dataEvent = ServerSentEventsStreamInterpreterTests.chatCompletionChunk()
        streamInterpreter.processData(dataEvent)
        
        let doneEvent = ServerSentEventsStreamInterpreterTests.chatCompletionChunkTermination()
        streamInterpreter.processData(doneEvent)
        
        let urlSession = urlSessionFactory.urlSession
        urlSession.delegate!.urlSession(urlSession, task: DataTaskMock(), didCompleteWithError: nil)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(calls[0], .content)
        XCTAssertEqual(calls[1], .content)
        XCTAssertEqual(calls[2], .content)
        XCTAssertEqual(calls[3], .complete)
        cancellable.invalidateAndCancel() // just to hold a reference
        return true
    }
}
