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

protocol URLSessionCombine {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionCombine {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        let typedPublisher: URLSession.DataTaskPublisher = dataTaskPublisher(for: request)
        return typedPublisher.eraseToAnyPublisher()
    }
}

#else
protocol URLSessionCombine {
}

extension URLSession: URLSessionCombine {}
#endif
