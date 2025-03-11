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

protocol URLSessionFactory: Sendable {
    func makeUrlSession(delegate: URLSessionDataDelegateProtocol) -> URLSessionProtocol
}

struct FoundationURLSessionFactory: URLSessionFactory {
    func makeUrlSession(delegate: URLSessionDataDelegateProtocol) -> any URLSessionProtocol {
        let forwarder = URLSessionDataDelegateForwarder(target: delegate)
        return URLSession(configuration: .default, delegate: forwarder, delegateQueue: nil)
    }
}
