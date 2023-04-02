//
//  OpenAI.swift
//
//
//  Created by Sergii Kryvoblotskyi on 9/18/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final public class OpenAI: OpenAIProtocol {

    private let apiToken: String
    private let session: URLSessionProtocol

    public init(apiToken: String) {
        self.apiToken = apiToken
        self.session = URLSession.shared
    }
    
    init(apiToken: String, session: URLSessionProtocol = URLSession.shared) {
        self.apiToken = apiToken
        self.session = session
    }
    
    public func completions(query: CompletionsQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<CompletionsResult, Error>) -> Void) {
        performRequest(request: Request<CompletionsResult>(body: query, url: .completions, timeoutInterval: timeoutInterval), completion: completion)
    }
    
    public func images(query: ImagesQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: Request<ImagesResult>(body: query, url: .images, timeoutInterval: timeoutInterval), completion: completion)
    }
    
    public func embeddings(query: EmbeddingsQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
        performRequest(request: Request<EmbeddingsResult>(body: query, url: .embeddings, timeoutInterval: timeoutInterval), completion: completion)
    }
    
    public func chats(query: ChatQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<ChatResult, Error>) -> Void) {
        performRequest(request: Request<ChatResult>(body: query, url: .chats, timeoutInterval: timeoutInterval), completion: completion)
    }
}

extension OpenAI {

    func performRequest<ResultType: Codable>(request: Request<ResultType>, completion: @escaping (Result<ResultType, Error>) -> Void) {
        do {
            let request = try makeRequest(query: request.body, url: request.url, timeoutInterval: request.timeoutInterval)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(OpenAIError.emptyData))
                    return
                }

                var apiError: Error? = nil
                do {
                    let decoded = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(.success(decoded))
                } catch {
                    apiError = error
                }
                
                if let apiError = apiError {
                    do {
                        let decoded = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                        completion(.failure(decoded))
                    } catch {
                        completion(.failure(apiError))
                    }
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
            return
        }
    }

    func makeRequest(query: Codable, url: URL, timeoutInterval: TimeInterval) throws -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(query)
        return request
    }
}

internal extension URL {

    static let completions = URL(string: "https://api.openai.com/v1/completions")!
    static let images = URL(string: "https://api.openai.com/v1/images/generations")!
    static let embeddings = URL(string: "https://api.openai.com/v1/embeddings")!
    static let chats = URL(string: "https://api.openai.com/v1/chat/completions")!
}
