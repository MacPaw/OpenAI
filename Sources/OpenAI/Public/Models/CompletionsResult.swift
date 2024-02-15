//
//  CompletionsResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct CompletionsResult: Decodable, Equatable {

    public struct Usage: Decodable, Equatable {
        public let promptTokens: Int
        public let completionTokens: Int
        public let totalTokens: Int

        public enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }

    public struct Choice: Decodable, Equatable {
        public let text: String
        public let index: Int
        public let finishReason: String?

        public enum CodingKeys: String, CodingKey {
            case text
            case index
            case finishReason = "finish_reason"
        }
    }

    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    public let usage: Usage?

    public enum CodingKeys: CodingKey {
        case id
        case object
        case created
        case model
        case choices
        case usage
    }
}
