//
//  StreamingSessionIntegrationTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.03.2025.
//

import XCTest
@testable import OpenAI

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
    private var middlewares: [OpenAIMiddleware] = []
    
    private lazy var streamingSession = StreamingSession(
        urlSessionFactory: urlSessionFactory,
        urlRequest: .init(url: .init(string: "/")!),
        interpreter: streamInterpreter,
        sslDelegate: nil,
        middlewares: middlewares,
        executionSerializer: executionSerializer,
        onReceiveContent: { _, _ in
            self.calls.append(.content)
            self.expectation.fulfill()
        },
        onProcessingError: { _, _ in },
        onComplete: { _,_ in
            self.calls.append(.complete)
            self.expectation.fulfill()
        }
    )

    func testCallOrderMockSerializerNoMiddleware() {
        let asserted = testCompleteCalledAfterAllEvents()
        XCTAssertTrue(asserted)
    }
    
    func testCallOrderMockSerializerWithHeavyMiddleware() {
        middlewares = [WorkSimulatingMockMiddleware()]
        let asserted = testCompleteCalledAfterAllEvents()
        XCTAssertTrue(asserted)
    }
    
    func testCallOrderWithRealSerializerNoMiddleware() {
        executionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated)
        let asserted = testCompleteCalledAfterAllEvents()
        XCTAssertTrue(asserted)
    }
    
    func testCallOrderWithRealSerializerHeavyMiddleware() {
        executionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated)
        middlewares = [WorkSimulatingMockMiddleware()]
        let asserted = testCompleteCalledAfterAllEvents()
        XCTAssertTrue(asserted)
    }
    
    private func testCompleteCalledAfterAllEvents() -> Bool {
        _ = streamingSession
        let cancellable = streamingSession.makeSession()
        
        let urlSession = urlSessionFactory.urlSession
        let urlSessionDelegate = urlSession.delegate!
        let dataTask = DataTaskMock()
        
        DispatchQueue.global().async {
            // urlSession delegate methods are usually called on arbitrary queue
            // it actually make each call to didReceive and didComplete on different queue than the previous call
            let dataEvent = MockServerSentEvent.chatCompletionChunk()
            urlSessionDelegate.urlSession(urlSession, dataTask: dataTask, didReceive: dataEvent)
            
            DispatchQueue.global().async {
                let doneEvent = MockServerSentEvent.chatCompletionChunkTermination()
                urlSessionDelegate.urlSession(urlSession, dataTask: dataTask, didReceive: doneEvent)
                
                DispatchQueue.global().async {
                    urlSession.delegate!.urlSession(urlSession, task: DataTaskMock(), didCompleteWithError: nil)
                }
            }
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(calls[0], .content)
        XCTAssertEqual(calls[1], .content)
        XCTAssertEqual(calls[2], .content)
        XCTAssertEqual(calls[3], .complete)
        cancellable.invalidateAndCancel() // just to hold a reference
        return true
    }
}


