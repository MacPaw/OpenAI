//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 08.02.2025.
//

import Foundation

protocol CancellablesFactory {
    func makeTaskCanceller() -> URLSessionTaskCancelling
    func makeSessionCanceller() -> SessionInvalidating
}

struct DefaultCancellablesFactory: CancellablesFactory {
    func makeTaskCanceller() -> URLSessionTaskCancelling {
        URLSessionTaskCanceller()
    }
    
    func makeSessionCanceller() -> SessionInvalidating {
        SessionInvalidator()
    }
}
