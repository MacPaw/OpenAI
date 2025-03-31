//
//  Tool.swift
//  
//
//  Created by Brent Whitman on 2024-01-29.
//

import Foundation

/// The type of tool
///
/// Refer to the [documentation](https://platform.openai.com/docs/assistants/tools/tools-beta) for  more information on tools.
public enum Tool: Codable, Equatable, Sendable {
    /// Code Interpreter allows the Assistants API to write and run Python code in a sandboxed execution environment.
    case codeInterpreter
    /// Function calling allows you to describe functions to the Assistants and have it intelligently return the functions that need to be called along with their arguments.
    case function(FunctionDeclaration)
    /// File Search augments the Assistant with knowledge from outside its model, such as proprietary product information or documents provided by your users.
    case fileSearch
    
    enum CodingKeys: String, CodingKey {
        case type
        case function
    }
    
    fileprivate var rawValue: String {
        switch self {
        case .codeInterpreter:
            return "code_interpreter"
        case .function:
            return "function"
        case .fileSearch:
            return "file_search"
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let toolTypeString = try container.decode(String.self, forKey: .type)
        
        switch toolTypeString {
        case "code_interpreter":
            self = .codeInterpreter
        case "function":
            let functionDeclaration = try container.decode(FunctionDeclaration.self, forKey: .function)
            self = .function(functionDeclaration)
        case "file_search":
            self = .fileSearch
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid tool type")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rawValue, forKey: .type)
        switch self {
        case let .function(declaration):
            try container.encode(declaration, forKey: .function)
        default:
            break
        }
    }
}
