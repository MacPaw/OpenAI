//
//  CombineClient.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//
#if canImport(Combine)
import Foundation
import Combine

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
final class CombineClient: Sendable {
    private let configuration: OpenAI.Configuration
    private let session: URLSessionProtocol
    private let middlewares: [OpenAIMiddleware]
    
    init(configuration: OpenAI.Configuration, session: URLSessionProtocol, middlewares: [OpenAIMiddleware]) {
        self.configuration = configuration
        self.session = session
        self.middlewares = middlewares
    }
    
    func performRequestCombine<ResultType: Codable>(request: any URLRequestBuildable) -> AnyPublisher<ResultType, Error> {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }

            let parsingOptions = configuration.parsingOptions
            return session
                .dataTaskPublisher(for: interceptedRequest)
                .tryMap { (data, response) in
                    let decoder = JSONDecoder()
                    decoder.userInfo[.parsingOptions] = parsingOptions
                    let (_, interceptedData) = self.middlewares.reduce((response, data)) { current, middleware in
                        middleware.intercept(response: current.response, request: urlRequest, data: current.data)
                    }
                    do {
                        return try decoder.decode(ResultType.self, from: interceptedData ?? data)
                    } catch {
                        throw (try? decoder.decode(APIErrorResponse.self, from: interceptedData ?? data)) ?? error
                    }
                }.eraseToAnyPublisher()
        } catch {
            return Fail(outputType: ResultType.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
    
    func performSpeechRequestCombine(request: any URLRequestBuildable) -> AnyPublisher<AudioSpeechResult, Error> {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }
            return session
                .dataTaskPublisher(for: interceptedRequest)
                .tryMap { (data, response) in
                    let (_, interceptedData) = self.middlewares.reduce((response, data)) { current, middleware in
                        middleware.intercept(response: current.response, request: urlRequest, data: current.data)
                    }
                    return .init(audio: interceptedData ?? data)
                }.eraseToAnyPublisher()
        } catch {
            return Fail(outputType: AudioSpeechResult.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
#endif
