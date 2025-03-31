//
//  AsyncClient.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.03.2025.
//

import Foundation

actor AsyncClient {
    private let configuration: OpenAI.Configuration
    private let middlewares: [OpenAIMiddleware]
    private let session: URLSessionProtocol
    
    init(configuration: OpenAI.Configuration, middlewares: [OpenAIMiddleware], session: URLSessionProtocol) {
        self.configuration = configuration
        self.middlewares = middlewares
        self.session = session
    }
    
    func performRequest<ResultType: Codable & Sendable>(request: any URLRequestBuildable) async throws -> ResultType {
        let urlRequest = try request.build(configuration: configuration)
        let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
            middleware.intercept(request: current)
        }

        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            let (data, response) = try await session.data(for: interceptedRequest, delegate: nil)
            let (_, interceptedData) = self.middlewares.reduce((response, data)) { current, middleware in
                middleware.intercept(response: current.response, request: urlRequest, data: current.data)
            }
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(ResultType.self, from: interceptedData ?? data)
            } catch {
                throw (try? decoder.decode(APIErrorResponse.self, from: interceptedData ?? data)) ?? error
            }
        } else {
            let dataTaskStore = URLSessionDataTaskStore()
            return try await withTaskCancellationHandler {
                return try await withCheckedThrowingContinuation { continuation in
                    let dataTask = self.makeDataTask(forRequest: interceptedRequest) { (result: Result<ResultType, Error>) in
                        continuation.resume(with: result)
                    }
                    
                    dataTask.resume()
                    
                    Task {
                        await dataTaskStore.setDataTask(dataTask)
                    }
                }
            } onCancel: {
                Task {
                    await dataTaskStore.getDataTask()?.cancel()
                }
            }
        }
    }
    
    private func makeDataTask<ResultType: Codable>(
        forRequest request: URLRequest,
        completion: @escaping @Sendable (Result<ResultType, Error>) -> Void
    ) -> URLSessionDataTaskProtocol {
        session.makeDataTask(forRequest: request, middlewares: middlewares, completion: completion)
    }
}
