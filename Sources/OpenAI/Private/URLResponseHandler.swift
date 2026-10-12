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
        let finalData = interceptedData ?? data
        try throwIfErrorStatus(response: response, data: finalData)
        return finalData
    }
    
    func interceptAndDecodeRaw(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> Data {
        let interceptedData = intercept(response: response, data: data, request: urlRequest)
        if let error {
            throw error
        }
        try throwIfErrorStatus(response: response, data: interceptedData ?? data)
        return try unwrap(error: nil, originalData: data, interceptedData: interceptedData)
    }
    
    private func decodeJson<ResultType: Codable>(data: Data) throws -> ResultType {
        let jsonDecoder = JSONResponseDecoder(parsingOptions: configuration.parsingOptions)
        return try jsonDecoder.decodeResponseData(data)
    }
    
    /// Raw responses aren't decoded as JSON, so unlike JSON requests they can't fall back to decoding an API error
    /// when the expected type fails to decode; check the status code instead, as `StreamingSession` does.
    private func throwIfErrorStatus(response: URLResponse?, data: Data?) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 else {
            return
        }
        
        if let data, let decodedError = JSONResponseErrorDecoder(decoder: JSONDecoder()).decodeErrorResponse(data: data) {
            throw decodedError
        }
        throw OpenAIError.statusError(response: httpResponse, statusCode: httpResponse.statusCode)
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
