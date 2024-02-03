//
//  ModerationCreateParams.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationCreateParams: Codable {
    public typealias Model = ModerationsModel

    /// The input text to classify.
    public let input: Input
    /// Two content moderations models are available: text-moderation-stable and text-moderation-latest.
    /// The default is text-moderation-latest which will be automatically upgraded over time. This ensures you are always using our most accurate model. If you use text-moderation-stable, we will provide advanced notice before updating the model. Accuracy of text-moderation-stable may be slightly lower than for text-moderation-latest.
    /// Defaults to text-moderation-latest
    public let model: Self.Model?

    public init(
        input: Input,
        model: Self.Model? = nil
    ) {
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
