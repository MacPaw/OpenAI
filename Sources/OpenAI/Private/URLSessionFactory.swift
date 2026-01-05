//
//  URLSessionFactory.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.03.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Factory protocol for creating URLSession instances.
/// Implement this protocol to provide custom session creation for streaming requests.
public protocol URLSessionFactory: Sendable {
    /// Creates a URLSession for streaming requests.
    /// - Parameter delegate: The delegate to receive streaming data callbacks
    /// - Returns: A URLSession protocol implementation
    func makeUrlSession(delegate: URLSessionDataDelegateProtocol) -> URLSessionProtocol
}

/// Default factory that creates standard Foundation URLSession instances.
public struct FoundationURLSessionFactory: URLSessionFactory {
    public init() {}

    public func makeUrlSession(delegate: URLSessionDataDelegateProtocol) -> any URLSessionProtocol {
        let forwarder = URLSessionDataDelegateForwarder(target: delegate)
        return URLSession(configuration: .default, delegate: forwarder, delegateQueue: nil)
    }
}
