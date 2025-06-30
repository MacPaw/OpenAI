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

class URLSessionMock: URLSessionProtocol, @unchecked Sendable {
    struct DataTaskCallParams {
        let request: URLRequest
    }
    
    struct DataTaskWithCompletionCallParams {
        let request: URLRequest
        let completionHandler: @Sendable (Data?, URLResponse?, Error?) -> Void
    }
    
    struct DataAsyncCallParams {
        let request: URLRequest
        let delegate: (any URLSessionTaskDelegate)?
    }
    
    var dataTask: DataTaskMock!
    var dataTaskIsCancelled = false
    
    var delegate: URLSessionDataDelegateProtocol?
    
    var dataTaskCalls: [DataTaskCallParams] = []
    var dataTaskWithCompletionCalls: [DataTaskWithCompletionCallParams] = []
    var dataAsyncCalls: [DataAsyncCallParams] = []
    var dataTaskPublisherCalls: [DataTaskCallParams] = []
    
    var invalidateAndCancelCallCount = 0
    var finishTasksAndInvalidateCallCount = 0
    
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        dataTask.completion = completionHandler
        dataTaskWithCompletionCalls.append(.init(request: request, completionHandler: completionHandler))
        return dataTask
    }
    
    func dataTask(with request: URLRequest) -> URLSessionDataTaskProtocol {
        dataTaskCalls.append(.init(request: request))
        return dataTask
    }
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        dataAsyncCalls.append(.init(request: request, delegate: delegate))
        
        let result = try await withCheckedThrowingContinuation { continuation in
            if let data = dataTask.data {
                continuation.resume(returning: (data, dataTask.response!))
            } else {
                continuation.resume(throwing: dataTask.error!)
            }
        }
        self.dataTaskIsCancelled = Task.isCancelled
        return result
    }
    
    func invalidateAndCancel() {
        invalidateAndCancelCallCount += 1
    }
    
    func finishTasksAndInvalidate() {
        finishTasksAndInvalidateCallCount += 1
    }
    
#if canImport(Combine)
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        dataTaskPublisherCalls.append(.init(request: request))
        
        if let data = dataTask.data {
            return Just((data, dataTask.response!))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(outputType: (data: Data, response: URLResponse).self, failure: dataTask.urlError!)
                .eraseToAnyPublisher()
        }
    }
#endif
}

#if canImport(Combine)
import Combine

class URLSessionMockCombine: URLSessionMock, @unchecked Sendable {
    var dataTaskPublisher: AnyPublisher<(data: Data, response: URLResponse), URLError>?
    
    override func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let dataTaskPublisher {
            return dataTaskPublisher
        } else {
            return super.dataTaskPublisher(for: request)
        }
    }
}
#endif
