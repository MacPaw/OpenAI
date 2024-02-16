//
//  EmbeddingsResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsResult: Decodable, Equatable {

    public struct Embedding: Decodable, Equatable {
        /// The object type, which is always "embedding".
        public let object: String
        /// The embedding vector, which is a list of floats. The length of vector depends on the model as listed in the embedding guide.
        /// https://platform.openai.com/docs/guides/embeddings
        public let embedding: [Double]
        /// The index of the embedding in the list of embeddings.
        public let index: Int

        public enum CodingKeys: CodingKey {
            case object
            case embedding
            case index
        }
    }
    
    public struct Usage: Decodable, Equatable {
        public let promptTokens: Int
        public let totalTokens: Int
        
        public enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case totalTokens = "total_tokens"
        }
    }
    
    public let data: [Embedding]
    public let model: String
    public let usage: Usage
    /// The object type, which is always "list".
    public let object: String

    public enum CodingKeys: CodingKey {
        case data
        case model
        case usage
        case object
    }
}
