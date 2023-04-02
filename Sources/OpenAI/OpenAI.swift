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

final public class OpenAI {

    public enum OpenAIError: Error {
        case invalidURL
        case emptyData
    }
    
    public struct APIError: Error, Decodable {
        public let message: String
        public let type: String
        public let param: String?
        public let code: String?
    }

    public struct APIErrorResponse: Error, Decodable {
        public let error: APIError
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
        public let maxTokens: Int?
        /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
        public let topP: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
        public let frequencyPenalty: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
        public let presencePenalty: Double?
        /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
        public let stop: [String]?
        /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
        public let user: String?
        
        enum CodingKeys: String, CodingKey {
            case model
            case prompt
            case temperature
            case maxTokens = "max_tokens"
            case topP = "top_p"
            case frequencyPenalty = "frequency_penalty"
            case presencePenalty = "presence_penalty"
            case stop
            case user
        }
        
        public init(model: Model, prompt: String, temperature: Double? = nil, maxTokens: Int? = nil, topP: Double? = nil, frequencyPenalty: Double? = nil, presencePenalty: Double? = nil, stop: [String]? = nil, user: String? = nil) {
            self.model = model
            self.prompt = prompt
            self.temperature = temperature
            self.maxTokens = maxTokens
            self.topP = topP
            self.frequencyPenalty = frequencyPenalty
            self.presencePenalty = presencePenalty
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

///MARK: - Chat
public extension OpenAI {
    
    struct Chat: Codable {
        public let role: String
        public let content: String
        
        public enum Role: String {
            case system
            case assistant
            case user
        }
        
        public init(role: String, content: String) {
            self.role = role
            self.content = content
        }
        
        public init(role: Role, content: String) {
            self.init(role: role.rawValue, content: content)
        }
    }
    
    struct ChatQuery: Codable {
        /// ID of the model to use. Currently, only gpt-3.5-turbo and gpt-3.5-turbo-0301 are supported.
        public let model: Model
        /// The messages to generate chat completions for
        public let messages: [Chat]
        /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and  We generally recommend altering this or top_p but not both.
        public let temperature: Double?
        /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
        public let topP: Double?
        /// How many chat completion choices to generate for each input message.
        public let n: Int?
        /// If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only `server-sent events` as they become available, with the stream terminated by a data: [DONE] message.
        public let stream: Bool?
        /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
        public let stop: [String]?
        /// The maximum number of tokens to generate in the completion.
        public let maxTokens: Int?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
        public let presencePenalty: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
        public let frequencyPenalty: Double?
        /// Modify the likelihood of specified tokens appearing in the completion.
        public let logitBias: [String:Int]?
        /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
        public let user: String?
        
        enum CodingKeys: String, CodingKey {
            case model
            case messages
            case temperature
            case topP = "top_p"
            case n
            case stream
            case stop
            case maxTokens = "max_tokens"
            case presencePenalty = "presence_penalty"
            case frequencyPenalty = "frequency_penalty"
            case logitBias = "logit_bias"
            case user
        }
        
        public init(model: Model, messages: [Chat], temperature: Double? = nil, topP: Double? = nil, n: Int? = nil, stream: Bool? = nil, stop: [String]? = nil, maxTokens: Int? = nil, presencePenalty: Double? = nil, frequencyPenalty: Double? = nil, logitBias: [String : Int]? = nil, user: String? = nil) {
            self.model = model
            self.messages = messages
            self.temperature = temperature
            self.topP = topP
            self.n = n
            self.stream = stream
            self.stop = stop
            self.maxTokens = maxTokens
            self.presencePenalty = presencePenalty
            self.frequencyPenalty = frequencyPenalty
            self.logitBias = logitBias
            self.user = user
        }
        
    }
    
    
    struct ChatResult: Codable {
        public struct Choice: Codable {
            public let index: Int
            public let message: Chat
            public let finishReason: String
            
            enum CodingKeys: String, CodingKey {
                case index
                case message
                case finishReason = "finish_reason"
            }
        }
        
        public struct Usage: Codable {
            public let promptTokens: Int
            public let completionTokens: Int
            public let totalTokens: Int
            
            enum CodingKeys: String, CodingKey {
                case promptTokens = "prompt_tokens"
                case completionTokens = "completion_tokens"
                case totalTokens = "total_tokens"
            }
        }
        
        public let id: String
        public let object: String
        public let created: TimeInterval
        public let model: Model
        public let choices: [Choice]
        public let usage: Usage
        
        enum CodingKeys: String, CodingKey {
            case id
            case object
            case created
            case model
            case choices
            case usage
        }
        
        public init(id: String, object: String, created: TimeInterval, model: Model, choices: [Choice], usage: Usage) {
            self.id = id
            self.object = object
            self.created = created
            self.model = model
            self.choices = choices
            self.usage = usage
        }
    }
    
    func chats(query: ChatQuery, timeoutInterval: TimeInterval = 60.0, completion: @escaping (Result<ChatResult, Error>) -> Void) {
        performRequest(request: Request<ChatResult>(body: query, url: .chats, timeoutInterval: timeoutInterval), completion: completion)
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
