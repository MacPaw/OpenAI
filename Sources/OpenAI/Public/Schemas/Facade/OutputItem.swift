//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 15.04.2025.
//

import Foundation

/// Improved interface to use instead of generated `Components.Schemas.OutputItem`
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
    
    public init(from decoder: any Decoder) throws {
        let generated = try Schemas.OutputItem(from: decoder)
        if let v1 = generated.value1 {
            self = .outputMessage(v1)
        } else if let v2 = generated.value2 {
            self = .fileSearchToolCall(v2)
        } else if let v3 = generated.value3 {
            self = .functionToolCall(v3)
        } else if let v4 = generated.value4 {
            self = .webSearchToolCall(v4)
        } else if let v5 = generated.value5 {
            self = .computerToolCall(v5)
        } else if let v6 = generated.value6 {
            self = .reasoning(v6)
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
