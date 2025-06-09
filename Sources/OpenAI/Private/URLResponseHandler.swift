//
//  URLResponseHandler.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 09.06.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct URLResponseHandler {
    let middlewares: [OpenAIMiddleware]
    let configuration: OpenAI.Configuration
    
    init(middlewares: [OpenAIMiddleware], configuration: OpenAI.Configuration) {
        self.middlewares = middlewares
        self.configuration = configuration
    }
    
    func interceptAndDecode<ResultType: Codable>(response: URLResponse, urlRequest: URLRequest, responseData data: Data) throws -> ResultType {
        let interceptedData = intercept(response: response, data: data, request: urlRequest)
        return try decodeJson(data: interceptedData ?? data)
    }
    
    func interceptAndDecode<ResultType: Codable>(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> ResultType {
        let interceptedData = intercept(response: response, data: data, request: urlRequest)
        let unwrappedData = try self.unwrap(error: error, originalData: data, interceptedData: interceptedData)
        return try decodeJson(data: unwrappedData)
    }
    
    func interceptAndDecodeRaw(response: URLResponse, urlRequest: URLRequest, responseData data: Data) throws -> Data {
        let interceptedData = intercept(response: response, data: data, request: urlRequest)
        return interceptedData ?? data
    }
    
    func interceptAndDecodeRaw(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> Data {
        let interceptedData = intercept(response: response, data: data, request: urlRequest)
        return try unwrap(error: error, originalData: data, interceptedData: interceptedData)
    }
    
    private func decodeJson<ResultType: Codable>(data: Data) throws -> ResultType {
        let jsonDecoder = JSONResponseDecoder(parsingOptions: configuration.parsingOptions)
        return try jsonDecoder.decodeResponseData(data)
    }
    
    private func intercept(response: URLResponse?, data: Data?, request: URLRequest) -> Data? {
        let (_, interceptedData) = self.middlewares.reduce((response, data)) { current, middleware in
            middleware.intercept(response: current.response, request: request, data: current.data)
        }
        
        return interceptedData
    }
    
    private func unwrap(error: Error?, originalData: Data?, interceptedData: Data?) throws -> Data {
        if let error {
            throw error
        }
        
        let finalData = interceptedData ?? originalData
        guard let finalData else {
            throw OpenAIError.emptyData
        }
        
        return finalData
    }
}
