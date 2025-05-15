//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class DataTaskFactory: Sendable {
    private let configuration: OpenAI.Configuration
    private let session: URLSessionProtocol
    private let middlewares: [OpenAIMiddleware]
    
    init(configuration: OpenAI.Configuration, session: URLSessionProtocol, middlewares: [OpenAIMiddleware]) {
        self.configuration = configuration
        self.session = session
        self.middlewares = middlewares
    }
    
    func makeDataTask<ResultType: Codable>(forRequest request: URLRequest, completion: @escaping @Sendable (Result<ResultType, Error>) -> Void) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, response, error in
            if let error {
                return completion(.failure(error))
            }
            let (_, data) = self.middlewares.reduce((response, data)) { current, middleware in
                middleware.intercept(response: current.response, request: request, data: current.data)
            }
            guard let data else {
                return completion(.failure(OpenAIError.emptyData))
            }
            let decoder = JSONDecoder()
            decoder.userInfo[.parsingOptions] = self.configuration.parsingOptions
            do {
                completion(.success(try decoder.decode(ResultType.self, from: data)))
            } catch {
                if let decoded = JSONResponseErrorDecoder(decoder: decoder).decodeErrorResponse(data: data) {
                    completion(.failure(decoded))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func makeRawResponseDataTask(forRequest request: URLRequest, completion: @escaping @Sendable (Result<Data, Error>) -> Void) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, response, error in
            if let error {
                return completion(.failure(error))
            }
            let (_, data) = self.middlewares.reduce((response, data)) { current, middleware in
                middleware.intercept(response: current.response, request: request, data: current.data)
            }
            guard let data else {
                return completion(.failure(OpenAIError.emptyData))
            }
            
            completion(.success(data))
        }
    }
}
