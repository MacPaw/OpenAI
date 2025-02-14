//
//  SessionInvalidator.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

protocol SessionInvalidating: CancellableRequest {
    var session: InvalidatableSession? { get set }
    
    func cancelRequest()
}

final class SessionInvalidator: SessionInvalidating {
    var session: InvalidatableSession?
    
    func cancelRequest() {
        session?.invalidateAndCancel()
    }
}
