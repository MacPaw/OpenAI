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
    private let session: URLSessionProtocol
    private let responseHandler: URLResponseHandler
    
    init(session: URLSessionProtocol, responseHandler: URLResponseHandler) {
        self.session = session
        self.responseHandler = responseHandler
    }
    
    func makeDataTask<ResultType: Codable>(forRequest request: URLRequest, completion: @escaping @Sendable (Result<ResultType, Error>) -> Void) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, response, error in
            do {
                let decoded: ResultType = try self.responseHandler.interceptAndDecode(
                    response: response,
                    urlRequest: request,
                    error: error,
                    responseData: data
                )
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func makeRawResponseDataTask(forRequest request: URLRequest, completion: @escaping @Sendable (Result<Data, Error>) -> Void) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, response, error in
            do {
                let decoded: Data = try self.responseHandler.interceptAndDecodeRaw(
                    response: response,
                    urlRequest: request,
                    error: error,
                    responseData: data
                )
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
