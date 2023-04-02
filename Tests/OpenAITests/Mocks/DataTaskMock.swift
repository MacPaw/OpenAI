//
//  DataTaskMock.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
@testable import OpenAI

class DataTaskMock: URLSessionDataTaskProtocol {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    var completion: ((Data?, URLResponse?, Error?) -> Void)?
    
    func resume() {
        completion?(data, response, error)
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
