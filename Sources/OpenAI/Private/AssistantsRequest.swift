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
    
    func build(token: String?, organizationIdentifier: String?, timeoutInterval: TimeInterval, customHeaders: [String: String]) throws -> URLRequest {
        let customHeaders = customHeaders
            .merging(["OpenAI-Beta": "assistants=v2"], uniquingKeysWith: { first, _ in first })
        
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
                timeoutInterval: timeoutInterval,
                customHeaders: customHeaders
            )
        case .multipartFormData(let encodable):
            let request = MultipartFormDataRequest<ResultType>(
                body: encodable,
                url: urlBuilder.buildURL()
            )
            return try request.build(
                token: token,
                organizationIdentifier: organizationIdentifier,
                timeoutInterval: timeoutInterval,
                customHeaders: customHeaders
            )
        }
    }
}
