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
    public let input: Input
    public let encoding_format: EncodingFormat?
    public let user: String?

    public init(
        input: Input,
        model: EmbeddingsModel,
        encoding_format: Self.EncodingFormat? = nil,
        user: String? = nil
    ) {
        self.model = model
        self.input = input
        self.encoding_format = encoding_format
        self.user = user
    }

    public enum Input: Codable, Equatable {
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

    public enum EncodingFormat: String, Codable {
        case float
        case base64
    }
}
