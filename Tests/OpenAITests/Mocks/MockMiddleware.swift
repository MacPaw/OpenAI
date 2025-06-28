//
//  MockMiddleware.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.06.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import OpenAI

final class MockMiddleware: OpenAIMiddleware, @unchecked Sendable {
    var interceptRequestReturnValue: URLRequest?
    var interceptStreamingDataReturnValue: Data?
    var interceptResponseReturnValue: (response: URLResponse?, data: Data?)?
    
    func intercept(request: URLRequest) -> URLRequest {
        interceptRequestReturnValue ?? request
    }
    
    func interceptStreamingData(request: URLRequest?, _ data: Data) -> Data {
        interceptStreamingDataReturnValue ?? data
    }
    
    func intercept(response: URLResponse?, request: URLRequest, data: Data?) -> (response: URLResponse?, data: Data?) {
        interceptResponseReturnValue ?? (response, data)
    }
}
