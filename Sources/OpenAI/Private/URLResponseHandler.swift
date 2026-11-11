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
        try decodeJson(data: interceptAndValidate(response: response, urlRequest: urlRequest, error: nil, responseData: data))
    }
    
    func interceptAndDecode<ResultType: Codable>(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> ResultType {
        try decodeJson(data: interceptAndValidate(response: response, urlRequest: urlRequest, error: error, responseData: data))
    }
    
    func interceptAndDecodeRaw(response: URLResponse, urlRequest: URLRequest, responseData data: Data) throws -> Data {
        try interceptAndValidate(response: response, urlRequest: urlRequest, error: nil, responseData: data)
    }
    
    func interceptAndDecodeRaw(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> Data {
        try interceptAndValidate(response: response, urlRequest: urlRequest, error: error, responseData: data)
    }
    
    private func decodeJson<ResultType: Codable>(data: Data) throws -> ResultType {
        let jsonDecoder = JSONResponseDecoder(parsingOptions: configuration.parsingOptions)
        return try jsonDecoder.decodeResponseData(data)
    }
    
    /// Response middleware runs first, then cancellation is thrown unchanged. The status check reads the response
    /// the middleware returns. An HTTP status of 400 or above is an `HTTPResponseError` for every JSON and raw
    /// response, carrying the original body, the API or Gemini error decoded from the body the middleware returns,
    /// and any transport error. Otherwise a transport error is thrown unchanged. The body is returned only after
    /// that check, or `OpenAIError.emptyData` when there is none. JSON callers decode that body next, so a 2xx that
    /// isn't the result type still falls back to an API or Gemini error.
    private func interceptAndValidate(response: URLResponse?, urlRequest: URLRequest, error: Error?, responseData data: Data?) throws -> Data {
        let intercepted = intercept(response: response, data: data, request: urlRequest)
        if let error, (error as? URLError)?.code == .cancelled || error is CancellationError {
            throw error
        }
        
        try throwIfErrorStatus(response: intercepted.response ?? response, body: data, decodingBody: intercepted.data, error: error)
        if let error {
            throw error
        }
        
        guard let body = intercepted.data ?? data else {
            throw OpenAIError.emptyData
        }
        
        return body
    }
    
    /// Status >= 400, matching `StreamingSession`. Statuses below 400 are not an error here.
    private func throwIfErrorStatus(response: URLResponse?, body: Data?, decodingBody: Data?, error: Error?) throws {
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 else {
            return
        }
        
        throw HTTPResponseError(
            response: httpResponse,
            body: body ?? Data(),
            isBodyTruncated: false,
            underlyingError: error,
            decodingBody: decodingBody
        )
    }
    
    private func intercept(response: URLResponse?, data: Data?, request: URLRequest) -> (response: URLResponse?, data: Data?) {
        self.middlewares.reduce((response, data)) { current, middleware in
            middleware.intercept(response: current.response, request: request, data: current.data)
        }
    }
}
