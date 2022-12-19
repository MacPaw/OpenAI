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
        /// ID of the model to use.
        let model: Model
        /// The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.
        let prompt: String
        /// What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.
        let temperature: Int
        /// The maximum number of tokens to generate in the completion.
        let max_tokens: Int
        /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
        let top_p: Int
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
        let frequency_penalty: Int
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
        let presence_penalty: Int
        /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
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
