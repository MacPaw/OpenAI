//
//  AssistantsRequest.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.01.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AssistantsRequest<ResultType>: URLRequestBuildable {
    private enum Body {
        case json(Codable?)
        case multipartFormData(MultipartFormDataBodyEncodable)
    }
    
    private let urlBuilder: URLBuilder
    private let body: Body
    private let method: String
    
    static func jsonRequest(urlBuilder: URLBuilder, body: Codable?, method: String = "POST") -> AssistantsRequest<ResultType> {
        return .init(urlBuilder: urlBuilder, body: .json(body), method: method)
    }
    
    static func multipartFormDataRequest(urlBuilder: URLBuilder, body: MultipartFormDataBodyEncodable, method: String = "POST") -> AssistantsRequest<ResultType> {
        return .init(urlBuilder: urlBuilder, body: .multipartFormData(body), method: method)
    }
    
    private init(urlBuilder: URLBuilder, body: Body, method: String = "POST") {
        self.urlBuilder = urlBuilder
        self.body = body
        self.method = method
    }
    
    func build(token: String, organizationIdentifier: String?, timeoutInterval: TimeInterval) throws -> URLRequest {
        let customHeaders = ["OpenAI-Beta": "assistants=v2"]
        
        switch body {
        case .json(let codable):
            let jsonRequest = JSONRequest<ResultType>(
                body: codable,
                url: urlBuilder.buildURL(),
                method: method,
                customHeaders: customHeaders
            )
            
            return try jsonRequest.build(
                token: token,
                organizationIdentifier: organizationIdentifier,
                timeoutInterval: timeoutInterval
            )
        case .multipartFormData(let encodable):
            let request = MultipartFormDataRequest<ResultType>(
                body: encodable,
                url: urlBuilder.buildURL(),
                customHeaders: customHeaders
            )
            return try request.build(
                token: token,
                organizationIdentifier: organizationIdentifier,
                timeoutInterval: timeoutInterval
            )
        }
    }
}
