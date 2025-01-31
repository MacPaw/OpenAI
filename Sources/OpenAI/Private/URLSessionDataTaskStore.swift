//
//  URLSessionDataTaskStore.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
actor URLSessionDataTaskStore {
    private var dataTask: URLSessionDataTaskProtocol?
    
    func setDataTask(_ dataTask: URLSessionDataTaskProtocol) {
        self.dataTask = dataTask
    }
    
    func getDataTask() -> URLSessionDataTaskProtocol? {
        dataTask
    }
}
