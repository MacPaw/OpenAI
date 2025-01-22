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

final class JSONRequest<ResultType> {
    
    let body: Codable?
    let url: URL
    let method: String
    let customHeaders: [String: String]
    
    init(body: Codable? = nil, url: URL, method: String = "POST", customHeaders: [String: String] = [:]) {
        self.body = body
        self.url = url
        self.method = method
        self.customHeaders = customHeaders
    }
}

extension JSONRequest: URLRequestBuildable {
    
    func build(
        token: String,
        organizationIdentifier: String?,
        timeoutInterval: TimeInterval
    ) throws -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        for (headerField, value) in customHeaders {
            request.setValue(value, forHTTPHeaderField: headerField)
        }

        if let organizationIdentifier {
            request.setValue(organizationIdentifier, forHTTPHeaderField: "OpenAI-Organization")
        }
        request.httpMethod = method
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        return request
    }
}


