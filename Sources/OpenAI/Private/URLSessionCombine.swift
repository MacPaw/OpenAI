//
//  URLSessionCombine.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

#if canImport(Combine)
import Combine

public protocol URLSessionCombine {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionCombine {
    public func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let typedPublisher: URLSession.DataTaskPublisher = dataTaskPublisher(for: request)
        return typedPublisher.eraseToAnyPublisher()
    }
}

#else
public protocol URLSessionCombine {
}

extension URLSession: URLSessionCombine {}
#endif
