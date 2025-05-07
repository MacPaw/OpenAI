//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import Foundation

final class Client: Sendable {
    private let configuration: OpenAI.Configuration
    private let session: URLSessionProtocol
    private let middlewares: [OpenAIMiddleware]
    private let dataTaskFactory: DataTaskFactory
    private let cancellablesFactory: CancellablesFactory
    
    init(
        configuration: OpenAI.Configuration,
        session: URLSessionProtocol,
        middlewares: [OpenAIMiddleware],
        dataTaskFactory: DataTaskFactory,
        cancellablesFactory: CancellablesFactory
    ) {
        self.configuration = configuration
        self.session = session
        self.middlewares = middlewares
        self.dataTaskFactory = dataTaskFactory
        self.cancellablesFactory = cancellablesFactory
    }
    
    func performRequest<ResultType: Codable>(request: any URLRequestBuildable, completion: @escaping @Sendable (Result<ResultType, Error>) -> Void) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }
            let task = dataTaskFactory.makeDataTask(forRequest: interceptedRequest, completion: completion)
            task.resume()
            return cancellablesFactory.makeTaskCanceller(task: task)
        } catch {
            completion(.failure(error))
            return NoOpCancellableRequest()
        }
    }
    
    func performSpeechRequest(request: any URLRequestBuildable, completion: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }

            let task = session.dataTask(with: interceptedRequest) { data, response, error in
                if let error {
                    return completion(.failure(error))
                }
                let (_, data) = self.middlewares.reduce((response, data)) { current, middleware in
                    middleware.intercept(response: current.response, request: urlRequest, data: current.data)
                }
                guard let data else {
                    return completion(.failure(OpenAIError.emptyData))
                }
                
                completion(.success(AudioSpeechResult(audio: data)))
            }
            task.resume()
            return cancellablesFactory.makeTaskCanceller(task: task)
        } catch {
            completion(.failure(error))
            return NoOpCancellableRequest()
        }
    }
}
