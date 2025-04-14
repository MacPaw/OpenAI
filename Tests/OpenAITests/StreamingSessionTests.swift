//
//  StreamingSessionTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import XCTest
@testable import OpenAI

final class StreamingSessionTests: XCTestCase {
    private let streamInterpreter = MockDataStreamInterpreter()
    
    private var onReceivedContentCallCount = 0
    
    private lazy var streamingSession = StreamingSession(
        urlSessionFactory: MockURLSessionFactory(),
        urlRequest: .init(url: .init(string: "/")!),
        interpreter: streamInterpreter,
        sslDelegate: nil,
        middlewares: [],
        executionSerializer: NoDispatchExecutionSerializer(),
        onReceiveContent: { _, _ in
            self.onReceivedContentCallCount += 1
        },
        onProcessingError: { _, _ in },
        onComplete: { _,_ in }
    )

    @MainActor
    func testDataProcessedCallback() async throws {
        _ = streamingSession
        streamInterpreter.processData(.init())
        XCTAssertEqual(onReceivedContentCallCount, 1)
    }
}

class MockDataStreamInterpreter: StreamInterpreter, @unchecked Sendable {
    typealias ResultType = Data
    
    private var onEventDispatched: ((Data) -> Void)?
    private var onError: ((any Error) -> Void)?
    
    func setCallbackClosures(onEventDispatched: @escaping (Data) -> Void, onError: @escaping (any Error) -> Void) {
        self.onEventDispatched = onEventDispatched
        self.onError = onError
    }
    
    func processData(_ data: Data) {
        onEventDispatched?(data)
    }
}
