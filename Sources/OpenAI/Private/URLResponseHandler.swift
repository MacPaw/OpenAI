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
        try decodeJson(data: try interceptedData(response: response, urlRequest: urlRequest, error: nil, responseData: data))
    }
    
    func interceptAndDecode<ResultType: Codable>(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> ResultType {
        try decodeJson(data: try interceptedData(response: response, urlRequest: urlRequest, error: error, responseData: data))
    }
    
    func interceptAndDecodeRaw(response: URLResponse, urlRequest: URLRequest, responseData data: Data) throws -> Data {
        try interceptedData(response: response, urlRequest: urlRequest, error: nil, responseData: data)
    }
    
    func interceptAndDecodeRaw(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> Data {
        try interceptedData(response: response, urlRequest: urlRequest, error: error, responseData: data)
    }
    
    private func decodeJson<ResultType: Codable>(data: Data) throws -> ResultType {
        let jsonDecoder = JSONResponseDecoder(parsingOptions: configuration.parsingOptions)
        return try jsonDecoder.decodeResponseData(data)
    }
    
    /// Response middleware runs first, then a transport error is thrown unchanged. An HTTP status of 400 or above
    /// is an error for every JSON and raw response: the decoded API or Gemini error, or `OpenAIError.statusError`.
    /// The body is returned only after that check, or `OpenAIError.emptyData` when there is none. JSON callers
    /// decode that body next, so a 2xx that isn't the result type still falls back to an API or Gemini error.
    private func interceptedData(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> Data {
        let middlewareData = intercept(response: response, data: data, request: urlRequest)
        if let error {
            throw error
        }
        
        let body = middlewareData ?? data
        try throwIfErrorStatus(response: response, data: body)
        guard let body else {
            throw OpenAIError.emptyData
        }
        
        return body
    }
    
    /// Status >= 400, matching `StreamingSession`: throw a decoded API or Gemini error when the body has one,
    /// otherwise `OpenAIError.statusError`. Statuses below 400 are not an error here.
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
}
