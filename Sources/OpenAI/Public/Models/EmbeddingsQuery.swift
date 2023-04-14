//
//  EmbeddingsQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsQuery: Codable {
    /// ID of the model to use.
    public let model: Model
    /// Input text to get embeddings for.
    public let input: String

    public init(model: Model, input: String) {
        self.model = model
        self.input = input
    }
}
