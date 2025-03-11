//
//  NeverURLSessionMock.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.03.2025.
//

import Foundation
@testable import OpenAI

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct NeverURLSessionMock: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> any URLSessionDataTaskProtocol {
        fatalError()
    }
    
    func dataTask(with request: URLRequest) -> any URLSessionDataTaskProtocol {
        fatalError()
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        fatalError()
    }
    
    func invalidateAndCancel() {
        fatalError()
    }
    
    func finishTasksAndInvalidate() {
        fatalError()
    }
}

#if canImport(Combine)
import Combine
    
extension NeverURLSessionMock {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        fatalError()
    }
}
#endif
