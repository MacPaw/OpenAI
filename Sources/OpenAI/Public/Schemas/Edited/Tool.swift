//
//  Tool.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.04.2025.
//

@_spi(Generated) import OpenAPIRuntime

/// Reason for editing: Generated FunctionTool type is not user friendly.
@frozen public enum Tool: Codable, Hashable, Sendable {
    public typealias Schemas = Components.Schemas

    /// A tool that searches for relevant content from uploaded files.
    /// Learn more about the [file search tool](/docs/guides/tools-file-search).
    case fileSearch(Schemas.FileSearchTool)
    /// Defines a function in your own code the model can choose to call. Learn more
    /// about [function calling](/docs/guides/function-calling).
    case function(FunctionTool)
    /// A tool that controls a virtual computer. Learn more about the
    /// [computer tool](/docs/guides/tools-computer-use).
    case computer(Schemas.ComputerTool)
    /// A tool that controls a virtual computer (preview version).
    case computerUsePreview(Schemas.ComputerUsePreviewTool)
    /// This tool searches the web for relevant results to use in a response.
    /// Learn more about the [web search tool](/docs/guides/tools-web-search).
    case webSearch(Schemas.WebSearchTool)
    /// This tool searches the web for relevant results to use in a response (preview version).
    case webSearchPreview(Schemas.WebSearchPreviewTool)
    /// Give the model access to additional tools via remote Model Context Protocol (MCP) servers.
    /// [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp)
    case mcp(Schemas.MCPTool)
    /// A tool that runs Python code to help generate a response to a prompt.
    case codeInterpreter(Schemas.CodeInterpreterTool)
    /// A tool that generates images using a model like `gpt-image-1`.
    case imageGeneration(Schemas.ImageGenTool)
    /// A tool that allows the model to execute shell commands in a local environment.
    case localShell(Schemas.LocalShellToolParam)
    /// A tool that allows the model to execute shell commands via a function.
    case functionShell(Schemas.FunctionShellToolParam)
    /// A custom tool defined by the user.
    case custom(Schemas.CustomToolParam)
    /// A namespace-scoped tool.
    case namespace(Schemas.NamespaceToolParam)
    /// A tool that performs tool searches.
    case toolSearch(Schemas.ToolSearchToolParam)
    /// A tool that applies patches.
    case applyPatch(Schemas.ApplyPatchToolParam)

    public init(from decoder: any Decoder) throws {
        var errors: [any Error] = []
        do {
            self = .fileSearch(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .function(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .computer(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .computerUsePreview(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .webSearch(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .webSearchPreview(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .mcp(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .codeInterpreter(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .imageGeneration(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .localShell(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .functionShell(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .custom(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .namespace(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .toolSearch(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .applyPatch(try .init(from: decoder))
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
        case let .fileSearch(value):
            try value.encode(to: encoder)
        case let .function(value):
            try value.encode(to: encoder)
        case let .computer(value):
            try value.encode(to: encoder)
        case let .computerUsePreview(value):
            try value.encode(to: encoder)
        case let .webSearch(value):
            try value.encode(to: encoder)
        case let .webSearchPreview(value):
            try value.encode(to: encoder)
        case let .mcp(value):
            try value.encode(to: encoder)
        case let .codeInterpreter(value):
            try value.encode(to: encoder)
        case let .imageGeneration(value):
            try value.encode(to: encoder)
        case let .localShell(value):
            try value.encode(to: encoder)
        case let .functionShell(value):
            try value.encode(to: encoder)
        case let .custom(value):
            try value.encode(to: encoder)
        case let .namespace(value):
            try value.encode(to: encoder)
        case let .toolSearch(value):
            try value.encode(to: encoder)
        case let .applyPatch(value):
            try value.encode(to: encoder)
        }
    }
}
