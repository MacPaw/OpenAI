//
//  EmbeddingsResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsResult: Decodable, Equatable {

    public struct Embedding: Decodable, Equatable {
        public let object: String
        public let embedding: [Double]
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
    public let model: Model
    public let usage: Usage

    public enum CodingKeys: CodingKey {
        case data
        case model
        case usage
    }
}
