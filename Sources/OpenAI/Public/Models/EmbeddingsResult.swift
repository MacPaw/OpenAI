//
//  EmbeddingsResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsResult: Codable, Equatable, Sendable {

    public struct Embedding: Codable, Equatable, Sendable {
        /// The object type, which is always "embedding".
        public let object: String
        /// The embedding vector, which is a list of floats. The length of vector depends on the model as listed in the embedding guide.
        /// https://platform.openai.com/docs/guides/embeddings
        public let embedding: [Double]
        /// The index of the embedding in the list of embeddings.
        public let index: Int
    }
    
    public struct Usage: Codable, Equatable, Sendable {
        public let promptTokens: Int
        public let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case totalTokens = "total_tokens"
        }
    }

    enum CodingKeys: String, CodingKey {
        case data
        case model
        case usage
        case object
    }
    
    public let data: [Embedding]
    public let model: String
    public let usage: Usage
    /// The object type, which is always "list".
    public let object: String
}

// The decoding initializers live in extensions so that the memberwise initializers are kept.
extension EmbeddingsResult {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsingOptions = decoder.userInfo[.parsingOptions] as? ParsingOptions ?? []
        self.data = try container.decode([Embedding].self, forKey: .data)
        self.model = try container.decodeString(forKey: .model, parsingOptions: parsingOptions)
        self.usage = try container.decode(Usage.self, forKey: .usage, parsingOptions: parsingOptions, defaultValue: .init(promptTokens: 0, totalTokens: 0))
        self.object = try container.decode(String.self, forKey: .object, parsingOptions: parsingOptions, defaultValue: "list")
    }
}

extension EmbeddingsResult.Usage {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsingOptions = decoder.userInfo[.parsingOptions] as? ParsingOptions ?? []
        self.promptTokens = try container.decodeInt(forKey: .promptTokens, parsingOptions: parsingOptions)
        self.totalTokens = try container.decodeInt(forKey: .totalTokens, parsingOptions: parsingOptions)
    }
}
