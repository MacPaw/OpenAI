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
    case fileSearchTool(Schemas.FileSearchTool)
    /// Defines a function in your own code the model can choose to call. Learn more
    /// about [function calling](/docs/guides/function-calling).
    case functionTool(FunctionTool)
    /// A tool that controls a virtual computer. Learn more about the
    /// [computer tool](/docs/guides/tools-computer-use).
    case computerTool(Schemas.ComputerTool)
    /// A tool that controls a virtual computer (preview version).
    case computerUsePreviewTool(Schemas.ComputerUsePreviewTool)
    /// This tool searches the web for relevant results to use in a response.
    /// Learn more about the [web search tool](/docs/guides/tools-web-search).
    case webSearchTool(Schemas.WebSearchTool)
    /// This tool searches the web for relevant results to use in a response (preview version).
    case webSearchPreviewTool(Schemas.WebSearchPreviewTool)
    /// Give the model access to additional tools via remote Model Context Protocol (MCP) servers.
    /// [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp)
    case mcpTool(Schemas.MCPTool)
    /// A tool that runs Python code to help generate a response to a prompt.
    case codeInterpreterTool(Schemas.CodeInterpreterTool)
    /// A tool that generates images using a model like `gpt-image-1`.
    case imageGenerationTool(Schemas.ImageGenTool)
    /// A tool that allows the model to execute shell commands in a local environment.
    case localShellTool(Schemas.LocalShellToolParam)
    /// A tool that allows the model to execute shell commands via a function.
    case functionShellTool(Schemas.FunctionShellToolParam)
    /// A custom tool defined by the user.
    case customTool(Schemas.CustomToolParam)
    /// A namespace-scoped tool.
    case namespaceTool(Schemas.NamespaceToolParam)
    /// A tool that performs tool searches.
    case toolSearchTool(Schemas.ToolSearchToolParam)
    /// A tool that applies patches.
    case applyPatchTool(Schemas.ApplyPatchToolParam)

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
            self = .computerUsePreviewTool(try .init(from: decoder))
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
        do {
            self = .webSearchPreviewTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .mcpTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .codeInterpreterTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .imageGenerationTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .localShellTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .functionShellTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .customTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .namespaceTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .toolSearchTool(try .init(from: decoder))
            return
        } catch {
            errors.append(error)
        }
        do {
            self = .applyPatchTool(try .init(from: decoder))
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
        case let .computerUsePreviewTool(value):
            try value.encode(to: encoder)
        case let .webSearchTool(value):
            try value.encode(to: encoder)
        case let .webSearchPreviewTool(value):
            try value.encode(to: encoder)
        case let .mcpTool(value):
            try value.encode(to: encoder)
        case let .codeInterpreterTool(value):
            try value.encode(to: encoder)
        case let .imageGenerationTool(value):
            try value.encode(to: encoder)
        case let .localShellTool(value):
            try value.encode(to: encoder)
        case let .functionShellTool(value):
            try value.encode(to: encoder)
        case let .customTool(value):
            try value.encode(to: encoder)
        case let .namespaceTool(value):
            try value.encode(to: encoder)
        case let .toolSearchTool(value):
            try value.encode(to: encoder)
        case let .applyPatchTool(value):
            try value.encode(to: encoder)
        }
    }
}
