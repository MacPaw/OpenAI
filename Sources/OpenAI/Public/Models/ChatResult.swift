//
//  ChatResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ChatResult: Codable, Equatable {

    public struct Choice: Codable, Equatable {
        public typealias ChatCompletionMessage = ChatQuery.ChatCompletionMessageParam

        /// The index of the choice in the list of choices.
        public let index: Int
        /// Log probability information for the choice.
        public let logprobs: Self.ChoiceLogprobs?
        /// Exists only if it is a complete message.
        public let message: Self.ChatCompletionMessage
        /// Exists only if it is a complete message.
        public let finish_reason: String?

        public enum FinishReason: String, Codable, Equatable {
            case stop
            case length
            case tool_calls
            case content_filter
            case function_call
        }

        public struct ChoiceLogprobs: Codable, Equatable {

            public let content: [Self.ChatCompletionTokenLogprob]?

            public struct ChatCompletionTokenLogprob: Codable, Equatable {

                /// The token.
                public let token: String
                /// A list of integers representing the UTF-8 bytes representation of the token.
                /// Useful in instances where characters are represented by multiple tokens and
                /// their byte representations must be combined to generate the correct text
                /// representation. Can be `null` if there is no bytes representation for the token.
                public let bytes: [Int]?
                /// The log probability of this token.
                public let logprob: Double
                /// List of the most likely tokens and their log probability, at this token position.
                /// In rare cases, there may be fewer than the number of requested `top_logprobs` returned.
                public let top_logprobs: [TopLogprob]

                public struct TopLogprob: Codable, Equatable {

                    /// The token.
                    public let token: String
                    /// A list of integers representing the UTF-8 bytes representation of the token.
                    /// Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
                    public let bytes: [Int]?
                    /// The log probability of this token.
                    public let logprob: Double
                }
            }
        }
    }

    public struct CompletionUsage: Codable, Equatable {

        /// Number of tokens in the generated completion.
        public let completion_tokens: Int
        /// Number of tokens in the prompt.
        public let prompt_tokens: Int
        /// Total number of tokens used in the request (prompt + completion).
        public let total_tokens: Int
    }

    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: String
    public let choices: [Choice]
    public let usage: Self.CompletionUsage?
    /// This fingerprint represents the backend configuration that the model runs with.
    /// Can be used in conjunction with the seed request parameter to understand when backend changes have been made that might impact determinism.
    public let system_fingerprint: String?
}

extension ChatResult: Identifiable {}

extension ChatQuery.ChatCompletionMessageParam {

    public init(from decoder: Decoder) throws {
        let messageContainer = try decoder.container(keyedBy: Self.ChatCompletionMessageParam.CodingKeys.self)
        switch try messageContainer.decode(Role.self, forKey: .role) {
        case .system:
            self = try .system(.init(from: decoder))
        case .user:
            self = try .user(.init(from: decoder))
        case .assistant:
            self = try .assistant(.init(from: decoder))
        case .tool:
            self = try .tool(.init(from: decoder))
        }
    }
}

extension ChatQuery.ChatCompletionMessageParam.ChatCompletionUserMessageParam.Content {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let string = try container.decode(String.self)
            self = .string(string)
            return
        } catch {}
        do {
            let text = try container.decode(ChatCompletionContentPartTextParam.self)
            self = .chatCompletionContentPartTextParam(text)
            return
        } catch {}
        do {
            let image = try container.decode(ChatCompletionContentPartImageParam.self)
            self = .chatCompletionContentPartImageParam(image)
            return
        } catch {}
        throw DecodingError.typeMismatch(Self.self, .init(codingPath: [Self.CodingKeys.string, CodingKeys.chatCompletionContentPartTextParam, CodingKeys.chatCompletionContentPartImageParam], debugDescription: "Content: expected String, ChatCompletionContentPartTextParam, ChatCompletionContentPartImageParam"))
    }
}
