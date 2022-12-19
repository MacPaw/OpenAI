//
//  OpenAI.swift
//  Oasis
//
//  Created by Sergii Kryvoblotskyi on 9/18/22.
//

import Foundation

final public class OpenAI {

    public enum OpenAIError: Error {
        case invalidURL
        case emptyData
    }

    private let apiToken: String
    private let session = URLSession.shared

    public init(apiToken: String) {
        self.apiToken = apiToken
    }
}

///MARK: - Completions
public extension OpenAI {
    
    struct CompletionsQuery: Codable {
        let model: Model
        let prompt: String
        let temperature: Int
        let max_tokens: Int
        let top_p: Int
        let frequency_penalty: Int
        let presence_penalty: Int
        let stop: [String]
    }
    
    struct CompletionsResult: Codable {
        struct Choice: Codable {
            let text: String
            let index: Int
        }

        let id: String
        let object: String
        let created: TimeInterval
        let model: Model
        let choices: [Choice]
    }

    func completions(query: CompletionsQuery, completion: @escaping (Result<CompletionsResult, Error>) -> Void) {
        performRequest(request: Request<CompletionsResult>(body: query, url: .completions), completion: completion)
    }
}

///MARK: - Images
public extension OpenAI {
    
    struct ImagesQuery: Codable {
        /// A text description of the desired image(s). The maximum length is 1000 characters.
        let prompt: String
        /// The number of images to generate. Must be between 1 and 10.
        let n: Int?
        /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
        let size: String?
    }
    
    struct ImagesResult: Codable {
        struct URLResult: Codable {
            let url: String
        }
        let created: TimeInterval
        let data: [URLResult]
    }
    
    func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: Request<ImagesResult>(body: query, url: .images), completion: completion)
    }
}

///MARK: - Embeddings
public extension OpenAI {
    
    struct EmbeddingsQuery: Codable {
        /// ID of the model to use.
        let model: Model
        /// Input text to get embeddings for
        let input: String
    }
    
    struct EmbeddingsResult: Codable {
        
        struct Embedding: Codable {
            
            let object: String
            let embedding: [Double]
            let index: Int
        }
        let data: [Embedding]
    }
    
    func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
        performRequest(request: Request<EmbeddingsResult>(body: query, url: .embeddings), completion: completion)
    }
}

private extension OpenAI {

    func makeRequest(query: Codable, url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(query)
        return request
    }
}

private extension OpenAI {
    
    func performRequest<ResultType: Codable>(request: Request<ResultType>, completion: @escaping (Result<ResultType, Error>) -> Void) {
        do {
            let request = try makeRequest(query: request.body, url: request.url)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(OpenAIError.emptyData))
                    return
                }
                do {
                    let decoded = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
            return
        }
    }
}

private extension URL {
    
    static let completions = URL(string: "https://api.openai.com/v1/completions")!
    static let images = URL(string: "https://api.openai.com/v1/images/generations")!
    static let embeddings = URL(string: "https://api.openai.com/v1/embeddings")!
}
