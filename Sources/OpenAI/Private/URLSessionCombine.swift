//
//  URLSessionCombine.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

#if canImport(Combine)
import Combine
import Foundation

protocol URLSessionCombine {
    @available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionCombine {
    @available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
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
