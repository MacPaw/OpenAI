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

final class MultipartFormDataRequest<ResultType>: URLRequestBuildable {
    
    let body: MultipartFormDataBodyEncodable
    let url: URL
    let timeoutInterval: TimeInterval
        
    init(body: MultipartFormDataBodyEncodable, url: URL, timeoutInterval: TimeInterval) {
        self.body = body
        self.url = url
        self.timeoutInterval = timeoutInterval
    }
    
    func build(token: String) throws -> URLRequest {
        var request = URLRequest(url: url)
        let boundary: String = UUID().uuidString
        request.timeoutInterval = timeoutInterval
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.encode(boundary: boundary)
        return request
    }
}
