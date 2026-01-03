//
//  URLSessionDataTaskProtocol.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol URLSessionTaskProtocol: Sendable {
    var originalRequest: URLRequest? { get }
    func cancel()
}

extension URLSessionTask: URLSessionTaskProtocol {}

public protocol URLSessionDataTaskProtocol: URLSessionTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
