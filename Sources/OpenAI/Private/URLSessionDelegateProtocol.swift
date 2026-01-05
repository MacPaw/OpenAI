//
//  URLSessionDelegateProtocol.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Protocol for handling URLSession delegate callbacks.
/// Sendable to match URLSessionDelegate behavior.
/// AnyObject constraint allows weak references to delegate implementations.
public protocol URLSessionDelegateProtocol: AnyObject, Sendable {
    func urlSession(_ session: URLSessionProtocol, task: URLSessionTaskProtocol, didCompleteWithError error: Error?)

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping @Sendable (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    )
}

/// Protocol for handling URLSession data delegate callbacks.
/// Used for streaming data reception.
public protocol URLSessionDataDelegateProtocol: URLSessionDelegateProtocol {
    func urlSession(_ session: URLSessionProtocol, dataTask: URLSessionDataTaskProtocol, didReceive data: Data)

    func urlSession(
        _ session: URLSessionProtocol,
        dataTask: URLSessionDataTaskProtocol,
        didReceive response: URLResponse,
        completionHandler: @escaping @Sendable (URLSession.ResponseDisposition) -> Void
    )
}
