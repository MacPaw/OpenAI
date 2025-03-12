//
//  URLSessionTaskCanceller.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

protocol URLSessionTaskCancelling: CancellableRequest {
    var task: URLSessionTaskProtocol? { get set }
    
    func cancelRequest()
}

final class URLSessionTaskCanceller: URLSessionTaskCancelling {
    var task: URLSessionTaskProtocol?
    
    func cancelRequest() {
        task?.cancel()
    }
}
