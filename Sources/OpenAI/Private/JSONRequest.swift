//
//  JSONRequest.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class JSONRequest<ResultType>: URLRequestBuildable {
    
    let body: Codable
    let url: URL
    let timeoutInterval: TimeInterval
    let method: String
    
    init(body: Codable, url: URL, method: String = "POST", timeoutInterval: TimeInterval) {
        self.body = body
        self.url = url
        self.method = method
        self.timeoutInterval = timeoutInterval
    }
    
    func build(token: String) throws -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = method
        request.httpBody = try JSONEncoder().encode(body)
        return request
    }
}

