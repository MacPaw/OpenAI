//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

#if canImport(Combine)

import Combine
import Foundation

protocol URLSessionDataTaskPublisherProtocol: Publisher, Sendable where Output == (data: Data, response: URLResponse), Failure == URLError {
}

extension URLSession.DataTaskPublisher: URLSessionDataTaskPublisherProtocol {}

#endif
