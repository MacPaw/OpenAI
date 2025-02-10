//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 08.02.2025.
//

import Foundation
@testable import OpenAI

class MockCancellablesFactory: CancellablesFactory {
    var taskCanceller: MockTaskCanceller!
    func makeTaskCanceller() -> any URLSessionTaskCancelling {
        taskCanceller
    }
    
    var sessionCanceller: MockSessionCanceller!
    func makeSessionCanceller() -> any SessionInvalidating {
        sessionCanceller
    }
}

class MockTaskCanceller: URLSessionTaskCancelling {
    var task: (any URLSessionTaskProtocol)?
    
    func cancelRequest() {
    }
}

class MockSessionCanceller: SessionInvalidating {
    var session: (any InvalidatableSession)?
    
    var cancelCallCount = 0
    func cancelRequest() {
        cancelCallCount += 1
    }
}
