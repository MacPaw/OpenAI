//
//  CombineClient.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import Foundation

#if canImport(Combine)
import Combine
#endif

final class CombineClient: Sendable {
    private let configuration: OpenAI.Configuration
    private let session: URLSessionProtocol
    private let middlewares: [OpenAIMiddleware]
    private let responseHandler: URLResponseHandler
    
    init(configuration: OpenAI.Configuration, session: URLSessionProtocol, middlewares: [OpenAIMiddleware], responseHandler: URLResponseHandler) {
        self.configuration = configuration
        self.session = session
        self.middlewares = middlewares
        self.responseHandler = responseHandler
    }
    
#if canImport(Combine)
    func performRequest<ResultType: Codable>(request: any URLRequestBuildable) -> AnyPublisher<ResultType, Error> {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }
            
            return session
                .dataTaskPublisher(for: interceptedRequest)
                .tryMap { (data, response) in
                    try self.responseHandler.interceptAndDecode(response: response, urlRequest: urlRequest, responseData: data)
                }.eraseToAnyPublisher()
        } catch {
            return Fail(outputType: ResultType.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
    
    func performSpeechRequest(request: any URLRequestBuildable) -> AnyPublisher<AudioSpeechResult, Error> {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }
            return session
                .dataTaskPublisher(for: interceptedRequest)
                .tryMap { (data, response) in
                    let finalData: Data = try self.responseHandler.interceptAndDecodeRaw(response: response, urlRequest: urlRequest, responseData: data)
                    return .init(audio: finalData)
                }.eraseToAnyPublisher()
        } catch {
            return Fail(outputType: AudioSpeechResult.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
#endif
}
