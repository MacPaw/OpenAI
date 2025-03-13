//
//  ChatResult.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ChatResult: Codable, Equatable {

    public struct Choice: Codable, Equatable {
        /// The index of the choice in the list of choices.
        public let index: Int
        /// Log probability information for the choice.
        public let logprobs: Self.ChoiceLogprobs?
        /// A chat completion message generated by the model.
        public let message: Self.Message
        /// The reason the model stopped generating tokens. This will be stop if the model hit a natural stop point or a provided stop sequence, length if the maximum number of tokens specified in the request was reached, content_filter if content was omitted due to a flag from our content filters, tool_calls if the model called a tool, or function_call (deprecated) if the model called a function.
        public let finishReason: String
        
        public struct Message: Codable, Equatable {
            /// The contents of the message.
            public let content: String?
            /// The refusal message generated by the model.
            public let refusal: String?
            /// The role of the author of this message.
            public let role: String
            /// Annotations for the message, when applicable, as when using the web search tool.
            /// Web search tool: https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat
            public let annotations: [Annotation]
            /// If the audio output modality is requested, this object contains data about the audio response from the model.
            /// Learn more: https://platform.openai.com/docs/guides/audio
            public let audio: Audio?
            /// The tool calls generated by the model, such as function calls.
            public let toolCalls: [ChatQuery.ChatCompletionMessageParam.AssistantMessageParam.ToolCallParam]
            
            public enum CodingKeys: String, CodingKey {
                case content, refusal, role, annotations, audio, toolCalls = "tool_calls"
            }
            
            public struct Annotation: Codable, Equatable {
                /// The type of the URL citation. Always `url_citation`.
                let type: String
                /// A URL citation when using web search.
                let urlCitation: URLCitation
                
                public enum CodingKeys: String, CodingKey {
                    case type, urlCitation = "url_citation"
                }
                
                public struct URLCitation: Codable, Equatable {
                    /// The index of the last character of the URL citation in the message.
                    let endIndex: Int
                    /// The index of the first character of the URL citation in the message.
                    let startIndex: Int
                    /// The title of the web resource.
                    let title: String
                    /// The URL of the web resource.
                    let url: String
                    
                    public enum CodingKeys: String, CodingKey {
                        case endIndex = "end_index"
                        case startIndex = "start_index"
                        case title, url
                    }
                }
            }
            
            public struct Audio: Codable, Equatable {
                /// Base64 encoded audio bytes generated by the model, in the format specified in the request.
                public let data: String
                /// The Unix timestamp (in seconds) for when this audio response will no longer be accessible on the server for use in multi-turn conversations.
                public let expiresAt: Int
                /// Unique identifier for this audio response.
                public let id: String
                /// Transcript of the audio generated by the model.
                public let transcript: String
                
                public enum CodingKeys: String, CodingKey {
                    case data
                    case expiresAt = "expires_at"
                    case id, transcript
                }
            }
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
                public let topLogprobs: [TopLogprob]

                public struct TopLogprob: Codable, Equatable {

                    /// The token.
                    public let token: String
                    /// A list of integers representing the UTF-8 bytes representation of the token.
                    /// Useful in instances where characters are represented by multiple tokens and their byte representations must be combined to generate the correct text representation. Can be `null` if there is no bytes representation for the token.
                    public let bytes: [Int]?
                    /// The log probability of this token.
                    public let logprob: Double
                }

                public enum CodingKeys: String, CodingKey {
                    case token
                    case bytes
                    case logprob
                    case topLogprobs = "top_logprobs"
                }
            }
        }

        public enum CodingKeys: String, CodingKey {
            case index
            case logprobs
            case message
            case finishReason = "finish_reason"
        }

        public enum FinishReason: String, Codable, Equatable {
            case stop
            case length
            case toolCalls = "tool_calls"
            case contentFilter = "content_filter"
            case functionCall = "function_call"
        }
    }

    public struct CompletionUsage: Codable, Equatable {

        /// Number of tokens in the generated completion.
        public let completionTokens: Int
        /// Number of tokens in the prompt.
        public let promptTokens: Int
        /// Total number of tokens used in the request (prompt + completion).
        public let totalTokens: Int

        enum CodingKeys: String, CodingKey {
            case completionTokens = "completion_tokens"
            case promptTokens = "prompt_tokens"
            case totalTokens = "total_tokens"
        }
    }

    /// A unique identifier for the chat completion.
    public let id: String
    /// The Unix timestamp (in seconds) of when the chat completion was created.
    public let created: Int
    /// The model used for the chat completion.
    public let model: String
    /// The object type, which is always `chat.completion`.
    public let object: String
    /// The service tier used for processing the request.
    public let serviceTier: String?
    /// This fingerprint represents the backend configuration that the model runs with.
    /// Can be used in conjunction with the seed request parameter to understand when backend changes have been made that might impact determinism.
    public let systemFingerprint: String
    /// A list of chat completion choices. Can be more than one if n is greater than 1.
    public let choices: [Choice]
    /// Usage statistics for the completion request.
    public let usage: Self.CompletionUsage?
    
    /// Following are fields that are not part of OpenAI API Reference, but are present in responses from other providers
    ///
    /// Perplexity
    /// Citations for the generated answer.
    /// https://docs.perplexity.ai/api-reference/chat-completions#response-citations
    public let citations: [String]?

    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case created
        case model
        case choices
        case serviceTier = "service_tier"
        case systemFingerprint = "system_fingerprint"
        case usage
        case citations
    }
}

extension ChatQuery.ChatCompletionMessageParam {

    public init(from decoder: Decoder) throws {
        let messageContainer = try decoder.container(keyedBy: Self.ChatCompletionMessageParam.CodingKeys.self)
        switch try messageContainer.decode(Role.self, forKey: .role) {
        case .system:
            self = try .system(.init(from: decoder))
        case .developer:
            self = try .developer(.init(from: decoder))
        case .user:
            self = try .user(.init(from: decoder))
        case .assistant:
            self = try .assistant(.init(from: decoder))
        case .tool:
            self = try .tool(.init(from: decoder))
        }
    }
}

extension ChatQuery.ChatCompletionMessageParam.UserMessageParam.Content {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let string = try container.decode(String.self)
            self = .string(string)
            return
        } catch {}
        do {
            let vision = try container.decode([VisionContent].self)
            self = .vision(vision)
            return
        } catch {}
        throw DecodingError.typeMismatch(Self.self, .init(codingPath: [Self.CodingKeys.string, Self.CodingKeys.vision], debugDescription: "Content: expected String || Vision"))
    }
}
