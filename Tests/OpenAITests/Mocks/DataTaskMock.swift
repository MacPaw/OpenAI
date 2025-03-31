//
//  DataTaskMock.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

class DataTaskMock: URLSessionDataTaskProtocol, @unchecked Sendable {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    var urlError: URLError? // Needed for mocking combine dataTaskPublisher
    var originalRequest: URLRequest?

    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    func resume() {
        completion?(data, response, error)
    }
    
    var cancelCallCount = 0
    func cancel() {
        cancelCallCount += 1
    }
}

extension DataTaskMock {
    
    static func successful(with data: Data) -> DataTaskMock {
        let task = DataTaskMock()
        task.data = data
        task.response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 200, httpVersion: nil, headerFields: nil)
        return task
    }
    
    static func failed(with error: Error) -> DataTaskMock {
        let task = DataTaskMock()
        task.error = error
        task.response = HTTPURLResponse(url: URL(fileURLWithPath: ""), statusCode: 503, httpVersion: nil, headerFields: nil)
        return task
    }
}
