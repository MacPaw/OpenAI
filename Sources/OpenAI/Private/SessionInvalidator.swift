//
//  SessionInvalidator.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

final class SessionInvalidator: CancellableRequest {
    var session: InvalidatableSession?
    
    func cancelRequest() {
        session?.invalidateAndCancel()
    }
}
