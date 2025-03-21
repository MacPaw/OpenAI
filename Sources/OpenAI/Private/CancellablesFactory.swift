//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 08.02.2025.
//

import Foundation

protocol CancellablesFactory {
    func makeTaskCanceller(task: URLSessionTaskProtocol) -> any CancellableRequest    
    func makeSessionCanceller(session: InvalidatableSession) -> any CancellableRequest
}

struct DefaultCancellablesFactory: CancellablesFactory {
    func makeTaskCanceller(task: any URLSessionTaskProtocol) -> any CancellableRequest {
        URLSessionTaskCanceller(task: task)
    }
    
    func makeSessionCanceller(session: any InvalidatableSession) -> any CancellableRequest {
        SessionInvalidator(session: session)
    }
}

struct NoOpCancellableRequest: CancellableRequest {
    func cancelRequest() {
    }
}
