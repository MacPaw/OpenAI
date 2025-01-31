//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

#if canImport(Combine)

import Combine
import Foundation

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
protocol URLSessionDataTaskPublisherProtocol: Publisher, Sendable where Output == (data: Data, response: URLResponse), Failure == URLError {
}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
extension URLSession.DataTaskPublisher: URLSessionDataTaskPublisherProtocol {}

#endif
