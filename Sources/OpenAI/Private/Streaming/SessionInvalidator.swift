//
//  SessionInvalidator.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

final class SessionInvalidator: CancellableRequest {
    private let session: InvalidatableSession
    
    init(session: InvalidatableSession) {
        self.session = session
    }
    
    func cancelRequest() {
        session.invalidateAndCancel()
    }
}
