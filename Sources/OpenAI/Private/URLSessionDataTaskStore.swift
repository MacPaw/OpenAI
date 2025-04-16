//
//  URLSessionDataTaskStore.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

actor URLSessionDataTaskStore {
    private var dataTask: URLSessionDataTaskProtocol?
    
    func setDataTask(_ dataTask: URLSessionDataTaskProtocol) {
        self.dataTask = dataTask
    }
    
    func getDataTask() -> URLSessionDataTaskProtocol? {
        dataTask
    }
}
