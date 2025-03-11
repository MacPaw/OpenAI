//
//  URLSessionDelegateProtocol.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

protocol URLSessionDelegateProtocol {
    func urlSession(_ session: URLSessionProtocol, task: URLSessionTaskProtocol, didCompleteWithError error: Error?)
}

protocol URLSessionDataDelegateProtocol: URLSessionDelegateProtocol {
    func urlSession(_ session: URLSessionProtocol, dataTask: URLSessionDataTaskProtocol, didReceive data: Data)
}
