//
//  File.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol URLSessionProtocol {

    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
    func dataTask(with request: URLRequest) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {

    func dataTask(with request: URLRequest) -> URLSessionDataTaskProtocol {
        dataTask(with: request) as URLSessionDataTask
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
