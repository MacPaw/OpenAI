//
//  ModerationsQuery.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationsQuery: Codable {
    /// The input text to classify.
    public let input: Input
    /// ID of the model to use.
    public let model: ModerationsModel?

    public init(input: Input, model: ModerationsModel? = nil) {
        self.input = input
        self.model = model
    }

    public enum Input: Codable {
        case string(String)
        case stringList([String])

        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .string(let a0):
                try container.encode(a0)
            case .stringList(let a0):
                try container.encode(a0)
            }
        }

        public init(string: String) {
            self = .string(string)
        }

        public init(stringList: [String]) {
            self = .stringList(stringList)
        }
    }
}
