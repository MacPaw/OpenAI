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
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask.completion = completionHandler
        return dataTask
    }
    
    func dataTask(with request: URLRequest) -> URLSessionDataTaskProtocol {
        dataTask
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        if let data = dataTask.data {
            return (data, dataTask.response!)
        } else {
            throw dataTask.error!
        }
    }
    
    func invalidateAndCancel() {
    }
    
    func finishTasksAndInvalidate() {
    }
}

#if canImport(Combine)
import Combine

extension URLSessionMock {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let data = dataTask.data {
            return Just((data, dataTask.response!))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(outputType: (data: Data, response: URLResponse).self, failure: dataTask.urlError!)
                .eraseToAnyPublisher()
        }
    }
}
#else
#endif
