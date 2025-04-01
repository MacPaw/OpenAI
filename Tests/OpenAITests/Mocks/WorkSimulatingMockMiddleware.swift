//
//  WorkSimulatingMockMiddleware.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.03.2025.
//

import XCTest
@testable import OpenAI

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct WorkSimulatingMockMiddleware: OpenAIMiddleware {
    func intercept(request: URLRequest) -> URLRequest {
        simulateBusyThread(duration: 0.1)
        return request
    }
    
    func interceptStreamingData(request: URLRequest?, _ data: Data) -> Data {
        simulateBusyThread(duration: 0.1)
        return data
    }
    
    func intercept(response: URLResponse?, request: URLRequest, data: Data?) -> (response: URLResponse?, data: Data?) {
        simulateBusyThread(duration: 0.1)
        return (response, data)
    }
    
    private func simulateBusyThread(duration: TimeInterval) {
        let end = Date().addingTimeInterval(duration)
        while Date() < end {
            _ = UUID().uuidString.hashValue  // Some pointless work
        }
    }
}
