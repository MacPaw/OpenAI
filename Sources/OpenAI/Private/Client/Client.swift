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

            let task = dataTaskFactory.makeRawResponseDataTask(forRequest: interceptedRequest) { result in
                switch result {
                case .success(let success):
                    completion(.success(.init(audio: success)))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
            task.resume()
            return cancellablesFactory.makeTaskCanceller(task: task)
        } catch {
            completion(.failure(error))
            return NoOpCancellableRequest()
        }
    }
}
