//
//  DataTaskPerformingURLSession.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class DataTaskPerformingURLSession: Sendable, PerformableSession, InvalidatableSession {
    private let urlRequest: URLRequest
    private let urlSession: URLSessionProtocol
    
    init(urlRequest: URLRequest, urlSession: URLSessionProtocol) {
        self.urlRequest = urlRequest
        self.urlSession = urlSession
    }
    
    func performSession() {
        urlSession.dataTask(with: urlRequest).resume()
    }
    
    func invalidateAndCancel() {
        urlSession.invalidateAndCancel()
    }
    
    func finishTasksAndInvalidate() {
        urlSession.finishTasksAndInvalidate()
    }
}
