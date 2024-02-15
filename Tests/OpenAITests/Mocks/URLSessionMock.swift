//
//  URLSessionMock.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

class URLSessionMock: URLSessionProtocol {
    
    var dataTask: DataTaskMock!
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask.completion = completionHandler
        return dataTask
    }
    
    public func dataTask(with request: URLRequest) -> URLSessionDataTaskProtocol {
        dataTask
    }
}
