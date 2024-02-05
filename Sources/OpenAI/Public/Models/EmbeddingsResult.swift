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
        public let prompt_tokens: Int
        public let total_tokens: Int
    }
    
    public let data: [Embedding]
    public let model: Model
    public let usage: Usage
}
