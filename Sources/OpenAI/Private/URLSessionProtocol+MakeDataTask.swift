//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.03.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSessionProtocol {
    func makeDataTask<ResultType: Codable>(
        forRequest request: URLRequest,
        middlewares: [OpenAIMiddleware],
        completion: @escaping @Sendable (Result<ResultType, Error>) -> Void
    ) -> URLSessionDataTaskProtocol {
        dataTask(with: request) { data, response, error in
            if let error {
                return completion(.failure(error))
            }
            let (_, data) = middlewares.reduce((response, data)) { current, middleware in
                middleware.intercept(response: current.response, request: request, data: current.data)
            }
            guard let data else {
                return completion(.failure(OpenAIError.emptyData))
            }
            let decoder = JSONDecoder()
            do {
                completion(.success(try decoder.decode(ResultType.self, from: data)))
            } catch {
                completion(.failure((try? decoder.decode(APIErrorResponse.self, from: data)) ?? error))
            }
        }
    }
}
