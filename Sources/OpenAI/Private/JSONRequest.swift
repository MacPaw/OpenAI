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
    
    let body: (Codable & Sendable)?
    let url: URL
    let method: String
    /// Per-request headers applied after the configuration's headers, so a
    /// caller can add or override a header for a single call.
    let customHeaders: [String: String]
    
    init(body: (Codable & Sendable)? = nil, url: URL, method: String = "POST", customHeaders: [String: String] = [:]) {
        self.body = body
        self.url = url
        self.method = method
        self.customHeaders = customHeaders
    }
}

extension JSONRequest: URLRequestBuildable {
    func build(
        token: String?,
        organizationIdentifier: String?,
        timeoutInterval: TimeInterval,
        customHeaders: [String: String]
    ) throws -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token {        
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let organizationIdentifier {
            request.setValue(organizationIdentifier, forHTTPHeaderField: "OpenAI-Organization")
        }
        
        for (headerField, value) in customHeaders {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        for (headerField, value) in self.customHeaders {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        
        request.httpMethod = method
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        return request
    }
}
