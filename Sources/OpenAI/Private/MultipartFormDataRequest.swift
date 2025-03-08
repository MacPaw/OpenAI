//
//  MultipartFormDataRequest.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class MultipartFormDataRequest<ResultType> {
    
    let body: MultipartFormDataBodyEncodable
    let url: URL
    let method: String
        
    init(body: MultipartFormDataBodyEncodable, url: URL, method: String = "POST") {
        self.body = body
        self.url = url
        self.method = method
    }
}

extension MultipartFormDataRequest: URLRequestBuildable {
    
    func build(token: String?, organizationIdentifier: String?, timeoutInterval: TimeInterval, customHeaders: [String: String]) throws -> URLRequest {
        var request = URLRequest(url: url)
        let boundary: String = UUID().uuidString
        request.timeoutInterval = timeoutInterval
        request.httpMethod = method
        
        if let token {        
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        if let organizationIdentifier {
            request.setValue(organizationIdentifier, forHTTPHeaderField: "OpenAI-Organization")
        }
        
        for (headerField, value) in customHeaders {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        
        request.httpBody = body.encode(boundary: boundary)
        return request
    }
}
