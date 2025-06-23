//
//  OutputItem.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 15.04.2025.
//

import Foundation

/// Improved interface to use instead of generated `Components.Schemas.OutputItem`
/// When editing the list of tool calls - also check Tool type if the list of tools should be updated
public enum OutputItem: Codable, Hashable, Sendable {
    public typealias Schemas = Components.Schemas
    
    /// An output message from the model.
    case outputMessage(Schemas.OutputMessage)
    /// The results of a file search tool call. See the `file search guide` for more information:
    /// https://platform.openai.com/docs/guides/tools-file-search
    case fileSearchToolCall(Schemas.FileSearchToolCall)
    /// A tool call to run a function. See the `function calling guide` for more information:
    /// https://platform.openai.com/docs/guides/function-calling
    case functionToolCall(Schemas.FunctionToolCall)
    /// The results of a web search tool call. See the `web search guide` for more information.
    /// https://platform.openai.com/docs/guides/tools-web-search
    case webSearchToolCall(Schemas.WebSearchToolCall)
    /// A tool call to a computer use tool. See the `computer use guide` for more information.
    /// https://platform.openai.com/docs/guides/tools-computer-use
    case computerToolCall(Schemas.ComputerToolCall)
    /// A description of the chain of thought used by a reasoning model while generating a response.
    case reasoning(Schemas.ReasoningItem)
    /// An image generation request made by the model.
    case imageGenerationCall(Schemas.ImageGenToolCall)
    /// A tool call to run code.
    case codeInterpreterToolCall(Schemas.CodeInterpreterToolCall)
    /// A tool call to run a command on the local shell.
    case localShellCall(Schemas.LocalShellToolCall)
    /// An invocation of a tool on an MCP server.
    case mcpToolCall(Schemas.MCPToolCall)
    /// A list of tools available on an MCP server.
    case mcpListTools(Schemas.MCPListTools)
    /// A request for human approval of a tool invocation.
    case mcpApprovalRequest(Schemas.MCPApprovalRequest)
    
    public init(from decoder: any Decoder) throws {
        let generated = try Schemas.OutputItem(from: decoder)
        if let value = generated.value1 {
            self = .outputMessage(value)
        } else if let value = generated.value2 {
            self = .fileSearchToolCall(value)
        } else if let value = generated.value3 {
            self = .functionToolCall(value)
        } else if let value = generated.value4 {
            self = .webSearchToolCall(value)
        } else if let value = generated.value5 {
            self = .computerToolCall(value)
        } else if let value = generated.value6 {
            self = .reasoning(value)
        } else if let value = generated.value7 {
            self = .imageGenerationCall(value)
        } else if let value = generated.value8 {
            self = .codeInterpreterToolCall(value)
        } else if let value = generated.value9 {
            self = .localShellCall(value)
        } else if let value = generated.value10 {
            self = .mcpToolCall(value)
        } else if let value = generated.value11 {
            self = .mcpListTools(value)
        } else if let value = generated.value12 {
            self = .mcpApprovalRequest(value)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "None of the known OutputItem cases could be decoded."
                )
            )
        }
    }
}
