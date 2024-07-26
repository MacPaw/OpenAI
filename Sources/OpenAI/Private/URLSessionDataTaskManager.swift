//
//  URLSessionDataTaskManager.swift
//  
//
//  Created by Benjamin Truitt on 7/29/23.
//

import Foundation

public class URLSessionDataTaskManager {
    
    private var session: URLSessionProtocol

    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func performDataTask<ResultType: Codable>(with request: URLRequest, completion: @escaping (Result<ResultType, Error>) -> Void) {
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(.success(decoded))
                } catch {
                    do {
                        let decoded = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                        completion(.failure(decoded))
                    } catch let decodingError {
                        completion(.failure(decodingError))
                    }
                }
            } else {
                completion(.failure(OpenAIError.emptyData))
            }
        }
        task.resume()
    }
}
