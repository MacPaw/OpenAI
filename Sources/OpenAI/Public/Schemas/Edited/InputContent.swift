//
//  InputContent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.04.2025.
//

@_spi(Generated) import OpenAPIRuntime
import Foundation

public enum InputContent: Codable, Hashable, Sendable {
    /// A text input to the model.
    case inputText(Components.Schemas.InputTextContent)
    /// An image input to the model.
    /// Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
    case inputImage(InputImage)
    /// A file input to the model.
    case inputFile(Components.Schemas.InputFileContent)
    
    public init(from decoder: any Decoder) throws {
        var errors: [any Error] = []
        do {
            self = .inputText(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .inputImage(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .inputFile(try .init(from: decoder))
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
        case let .inputText(value):
            try value.encode(to: encoder)
        case let .inputImage(value):
            try value.encode(to: encoder)
        case let .inputFile(value):
            try value.encode(to: encoder)
        }
    }
}
