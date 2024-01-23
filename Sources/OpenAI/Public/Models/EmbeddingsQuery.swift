//
//  EmbeddingsQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsQuery: Codable {
    /// ID of the model to use.
    public let model: EmbeddingsModel
    /// Input text to get embeddings for.
    public let input: [String]
    public let encoding_format: EncodingFormat?
    public let user: String?

    public init(model: EmbeddingsModel, input: [String], encoding_format: EncodingFormat? = .float, user: String? = nil) {
        self.model = model
        self.input = input
        self.encoding_format = encoding_format
        self.user = user
    }

    public init(model: EmbeddingsModel, input: String, encoding_format: EncodingFormat? = .float, user: String? = nil) {
        self.init(model: model, input: [input], encoding_format: encoding_format, user: user)
    }

    public enum EncodingFormat: String, Codable {
        case float
        case base64
    }
}
