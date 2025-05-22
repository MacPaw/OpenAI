//
//  Tool.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.04.2025.
//

@_spi(Generated) import OpenAPIRuntime

@frozen public enum Tool: Codable, Hashable, Sendable {
    public typealias Schemas = Components.Schemas
    
    /// A tool that searches for relevant content from uploaded files.
    /// Learn more about the [file search tool](/docs/guides/tools-file-search).
    case fileSearchTool(Schemas.FileSearchTool)
    /// Defines a function in your own code the model can choose to call. Learn more
    /// about [function calling](/docs/guides/function-calling).
    case functionTool(FunctionTool)
    /// A tool that controls a virtual computer. Learn more about the
    /// [computer tool](/docs/guides/tools-computer-use).
    case computerTool(Schemas.ComputerUsePreviewTool)
    /// This tool searches the web for relevant results to use in a response.
    /// Learn more about the [web search tool](/docs/guides/tools-web-search).
    case webSearchTool(Schemas.WebSearchPreviewTool)
    
    public init(from decoder: any Decoder) throws {
        var errors: [any Error] = []
        do {
            self = .fileSearchTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .functionTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .computerTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .webSearchTool(try .init(from: decoder))
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
        case let .fileSearchTool(value):
            try value.encode(to: encoder)
        case let .functionTool(value):
            try value.encode(to: encoder)
        case let .computerTool(value):
            try value.encode(to: encoder)
        case let .webSearchTool(value):
            try value.encode(to: encoder)
        }
    }
}
