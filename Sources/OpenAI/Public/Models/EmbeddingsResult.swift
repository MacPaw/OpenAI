//
//  EmbeddingsResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsResult: Codable, Equatable {

    public struct Embedding: Codable, Equatable {
        public let object: String
        public let embedding: [Double]
        public let index: Int
    }
    
    public struct Usage: Codable, Equatable {
        public let promptTokens: Int
        public let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case totalTokens = "total_tokens"
        }
    }
    
    public let data: [Embedding]
    public let usage: Usage
}
