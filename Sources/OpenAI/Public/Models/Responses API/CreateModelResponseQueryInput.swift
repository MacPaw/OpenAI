//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.04.2025.
//

import Foundation
@_spi(Generated) import OpenAPIRuntime

extension CreateModelResponseQuery {
    /// Text, image, or file inputs to the model, used to generate a response.
    ///
    /// Learn more:
    /// - [Text inputs and outputs](/docs/guides/text)
    /// - [Image inputs](/docs/guides/images)
    /// - [File inputs](/docs/guides/pdf-files)
    /// - [Conversation state](/docs/guides/conversation-state)
    /// - [Function calling](/docs/guides/function-calling)
    public enum Input: Codable, Hashable, Sendable {
        /// A text input to the model, equivalent to a text input with the
        /// `user` role.
        case textInput(String)
        /// A list of one or many input items to the model, containing
        /// different content types.
        case inputItemList([InputItem])
        
        public init(from decoder: any Decoder) throws {
            var errors: [any Error] = []
            do {
                self = .textInput(try decoder.decodeFromSingleValueContainer())
                return
            } catch {
                errors.append(error)
            }
            do {
                self = .inputItemList(try decoder.decodeFromSingleValueContainer())
                return
            } catch {
                errors.append(error)
            }
            throw Swift.DecodingError.failedToDecodeOneOfSchema(
                type: Self.self,
                codingPath: decoder.codingPath,
                errors: errors
            )
        }
        
        public func encode(to encoder: any Encoder) throws {
            switch self {
            case let .textInput(value):
                try encoder.encodeToSingleValueContainer(value)
            case let .inputItemList(value):
                try encoder.encodeToSingleValueContainer(value)
            }
        }
    }
    
    
}
