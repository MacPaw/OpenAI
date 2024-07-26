//
//  BaseRequest.swift
//  
//
//  Created by Benjamin Truitt on 7/28/23.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol RequestBuildable {
    var url: URL { get }
    var headers: [String: String] { get }
    var method: String { get }
    var timeoutInterval: TimeInterval { get }
    
    func getBody() throws -> Data?    
}

protocol BaseRequest: RequestBuildable {
    func build() throws -> URLRequest
}

extension BaseRequest {
    func build() throws -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        
        request.httpMethod = method
        request.httpBody = try getBody()
        request.allHTTPHeaderFields = headers
                
        return request
    }
}
