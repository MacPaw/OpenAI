//
//  MultipartFormDataRequest.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

struct MultipartFormDataRequest<BodyType: MultipartFormDataBodyEncodable, ResultType>: BaseRequest, URLRequestBuildable {
    var body: MultipartFormDataBodyEncodable?
    var url: URL
    var headers: [String: String]
    var method: String = "POST"
    var timeoutInterval: TimeInterval
    var boundary: String = UUID().uuidString
    
    init(body: BodyType?, url: URL, method: String = "POST", headers: [String: String]?, timeoutInterval: TimeInterval) {
        self.body = body
        self.url = url
        self.method = method
        self.headers = headers ?? [:]
        self.headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
        self.timeoutInterval = timeoutInterval
    }
    
    func getBody() throws -> Data? {
        return body?.encode(boundary: boundary)
    }
}


