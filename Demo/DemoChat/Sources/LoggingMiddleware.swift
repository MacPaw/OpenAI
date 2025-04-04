//
//  LoggingMiddleware.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import Foundation
import OpenAI

public final class LoggingMiddleware: OpenAIMiddleware {
    public init() {}
    
    public func intercept(request: URLRequest) -> URLRequest {
        return request
    }
    
    public func interceptStreamingData(request: URLRequest?, _ data: Data) -> Data {
        return data
    }
    
    public func intercept(response: URLResponse?, request: URLRequest, data: Data?) -> (response: URLResponse?, data: Data?) {
        return (response, data)
    }
}
