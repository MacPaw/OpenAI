//
//  JSONRequest.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//


import Foundation

struct JSONRequest<BodyType: Encodable, ResultType>: BaseRequest, URLRequestBuildable {
    var body: BodyType?
    var url: URL
    var method: String = "POST"
    var headers: [String: String]
    var timeoutInterval: TimeInterval
        
    init(body: BodyType? = nil, url: URL, method: String = "POST", headers: [String: String]?, timeoutInterval: TimeInterval) {
        self.body = body
        self.url = url
        self.method = method
        self.headers = headers ?? [:]
        self.headers["Content-Type"] = "application/json"
        self.timeoutInterval = timeoutInterval
    }
    
    func getBody() throws -> Data? {
        return try body.map { try JSONEncoder().encode($0) }
    }
}
