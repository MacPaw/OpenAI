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
    var interceptedResponses: [(response: URLResponse?, request: URLRequest, data: Data?)] = []
    var interceptStreamingDataCallCount = 0
    
    func intercept(request: URLRequest) -> URLRequest {
        interceptRequestReturnValue ?? request
    }
    
    func interceptStreamingData(request: URLRequest?, _ data: Data) -> Data {
        interceptStreamingDataCallCount += 1
        return interceptStreamingDataReturnValue ?? data
    }
    
    func intercept(response: URLResponse?, request: URLRequest, data: Data?) -> (response: URLResponse?, data: Data?) {
        interceptedResponses.append((response, request, data))
        return interceptResponseReturnValue ?? (response, data)
    }
}
