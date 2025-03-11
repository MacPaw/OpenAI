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
    
    func makeTaskCanceller(task: any URLSessionTaskProtocol) -> any CancellableRequest {
        taskCanceller
    }
    
    var sessionCanceller = MockSessionCanceller()
    
    func makeSessionCanceller(session: any InvalidatableSession) -> any CancellableRequest {
        sessionCanceller
    }
}

class MockTaskCanceller: CancellableRequest, @unchecked Sendable {
    func cancelRequest() {
    }
}

class MockSessionCanceller: CancellableRequest, @unchecked Sendable {
    var cancelCallCount = 0
    func cancelRequest() {
        cancelCallCount += 1
    }
}
