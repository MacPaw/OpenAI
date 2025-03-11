//
//  URLSessionTaskCanceller.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

final class URLSessionTaskCanceller: CancellableRequest {
    private let task: URLSessionTaskProtocol
    
    init(task: URLSessionTaskProtocol) {
        self.task = task
    }
    
    func cancelRequest() {
        task.cancel()
    }
}
