//
//  EmbeddingResponse.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingResponse: Codable, Equatable {

    public let data: [Self.Embedding]
    public let model: String
    /// The object type, which is always "list".
    public let object: String
    public let usage: Usage

    public struct Embedding: Codable, Equatable {
        /// The embedding vector, which is a list of floats. The length of vector depends on the model as listed in the embedding guide.
        /// https://platform.openai.com/docs/guides/embeddings
        public let embedding: [Float] // Double or String
        /// The index of the embedding in the list of embeddings.
        public let index: Int
        /// The object type, which is always "embedding".
        public let object: String
    }

    public struct Usage: Codable, Equatable {

        public let prompt_tokens: Int
        public let total_tokens: Int
    }
}
