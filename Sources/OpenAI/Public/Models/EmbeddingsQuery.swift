//
//  EmbeddingsQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct EmbeddingsQuery: Codable, Sendable {

    /// Input text to embed, encoded as a string or array of tokens. To embed multiple inputs in a single request, pass an array of strings or array of token arrays. The input must not exceed the max input tokens for the model (8192 tokens for text-embedding-ada-002), cannot be an empty string, and any array must be 2048 dimensions or less.
    public let input: Self.Input
    /// ID of the model to use. You can use the List models API to see all of your available models, or see our Model overview for descriptions of them.
    /// https://platform.openai.com/docs/api-reference/models/list
    /// https://platform.openai.com/docs/models/overview
    public let model: Model
    /// The number of dimensions the resulting output embeddings should have. Only supported in text-embedding-3 and later models.
    public let dimensions: Int?
    /// The format to return the embeddings in. Can be either float or base64.
    /// https://pypi.org/project/pybase64/
    public let encodingFormat: Self.EncodingFormat?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids
    public let user: String?

    public init(
        input: Self.Input,
        model: Model,
        dimensions: Int? = nil,
        encodingFormat: Self.EncodingFormat? = nil,
        user: String? = nil
    ) {
        self.input = input
        self.model = model
        self.dimensions = dimensions
        self.encodingFormat = encodingFormat
        self.user = user
    }

    public enum Input: Codable, Equatable, Sendable {
        case string(String)
        case stringList([String])
        case intList([Int])
        case intMatrix([[Int]])

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let a0):
                try container.encode(a0)
            case .stringList(let a0):
                try container.encode(a0)
            case .intList(let a0):
                try container.encode(a0)
            case .intMatrix(let a0):
                try container.encode(a0)
            }
        }

        public init(string: String) {
            self = .string(string)
        }

        public init(stringList: [String]) {
            self = .stringList(stringList)
        }

        public init(intList: [Int]) {
            self = .intList(intList)
        }

        public init(intMatrix: [[Int]]) {
            self = .intMatrix(intMatrix)
        }
    }

    public enum EncodingFormat: String, Codable, Sendable {
        case float
        case base64
    }

    public enum CodingKeys: String, CodingKey, Sendable {
        case input
        case model
        case dimensions
        case encodingFormat = "encoding_format"
        case user
    }
}
