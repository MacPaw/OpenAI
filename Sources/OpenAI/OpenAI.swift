//
//  OpenAI.swift
//  Oasis
//
//  Created by Sergii Kryvoblotskyi on 9/18/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

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
        public let model: Model
        /// The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.
        public let prompt: String
        /// What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.
        public let temperature: Double?
        /// The maximum number of tokens to generate in the completion.
        public let max_tokens: Int?
        /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
        public let top_p: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
        public let frequency_penalty: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
        public let presence_penalty: Double?
        /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
        public let stop: [String]?
        /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
        public let user: String?
        
        public init(model: Model, prompt: String, temperature: Double? = nil, max_tokens: Int? = nil, top_p: Double? = nil, frequency_penalty: Double? = nil, presence_penalty: Double? = nil, stop: [String]? = nil, user: String? = nil) {
            self.model = model
            self.prompt = prompt
            self.temperature = temperature
            self.max_tokens = max_tokens
            self.top_p = top_p
            self.frequency_penalty = frequency_penalty
            self.presence_penalty = presence_penalty
            self.stop = stop
            self.user = user
        }
    }

    struct CompletionsResult: Codable {
        public struct Choice: Codable {
            public let text: String
            public let index: Int
        }

        public let id: String
        public let object: String
        public let created: TimeInterval
        public let model: Model
        public let choices: [Choice]
    }

    func completions(query: CompletionsQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<CompletionsResult, Error>) -> Void) {
        performRequest(request: Request<CompletionsResult>(body: query, url: .completions, timeoutInterval: timeoutInterval), completion: completion)
    }
}

///MARK: - Images
public extension OpenAI {

    struct ImagesQuery: Codable {
        /// A text description of the desired image(s). The maximum length is 1000 characters.
        public let prompt: String
        /// The number of images to generate. Must be between 1 and 10.
        public let n: Int?
        /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
        public let size: String?

        public init(prompt: String, n: Int?, size: String?) {
            self.prompt = prompt
            self.n = n
            self.size = size
        }
    }

    struct ImagesResult: Codable {
        public struct URLResult: Codable {
            public let url: String
        }
        public let created: TimeInterval
        public let data: [URLResult]
    }

    func images(query: ImagesQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: Request<ImagesResult>(body: query, url: .images, timeoutInterval: timeoutInterval), completion: completion)
    }
}

///MARK: - Embeddings
public extension OpenAI {

    struct EmbeddingsQuery: Codable {
        /// ID of the model to use.
        public let model: Model
        /// Input text to get embeddings for
        public let input: String

        public init(model: Model, input: String) {
            self.model = model
            self.input = input
        }
    }

    struct EmbeddingsResult: Codable {

        public struct Embedding: Codable {
            public let object: String
            public let embedding: [Double]
            public let index: Int
        }
        public let data: [Embedding]
    }

    func embeddings(query: EmbeddingsQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
        performRequest(request: Request<EmbeddingsResult>(body: query, url: .embeddings, timeoutInterval: timeoutInterval), completion: completion)
    }
}

internal extension OpenAI {

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
}
