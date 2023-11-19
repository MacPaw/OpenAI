//
//  Message.swift
//  
//
//  Created by Federico Vitale on 14/11/23.
//

import Foundation

public struct Message: Codable, Equatable {
    public typealias StringOrChatContent = Codable
    
    public let role: Role
    /// The contents of the message. `content` is required for all messages except assistant messages with function calls.
    public let content: StringOrCodable<[ChatContent]>?
    
    /// The name of the author of this message. `name` is required if role is `function`, and it should be the name of the function whose response is in the `content`. May contain a-z, A-Z, 0-9, and underscores, with a maximum length of 64 characters.
    public let name: String?
    
    @available(*, deprecated, message: "use toolCalls instead")
    public let functionCall: ChatFunctionCall?
    
    public let toolCalls: [ToolCall]?
    
    public enum Role: String, Codable, Equatable {
        case system
        case assistant
        case user
        case function
    }
    
    enum CodingKeys: String, CodingKey {
        case role
        case content
        case name
        case functionCall = "function_call"
        case toolCalls = "tool_calls"
    }
    
    public init(
        role: Role,
        content codable: StringOrChatContent? = nil,
        name: String? = nil,
        toolCalls: [ToolCall]? = nil
    ) {
        let stringOrCodable: StringOrCodable<[ChatContent]>?
        
        if let string = codable as? String {
            stringOrCodable = .string(string)
        } else if let arr = codable as? [ChatContent] {
            stringOrCodable = .object(arr)
        } else {
            stringOrCodable = nil
        }
        
        self.init(role: role, content: stringOrCodable, name: name, toolCalls: toolCalls)
    }
    
    public init(
        role: Role,
        content codable: StringOrChatContent? = nil,
        name: String? = nil,
        functionCall: ChatFunctionCall? = nil
    ) {
        let stringOrCodable: StringOrCodable<[ChatContent]>?
        
        if let string = codable as? String {
            stringOrCodable = .string(string)
        } else if let arr = codable as? [ChatContent] {
            stringOrCodable = .object(arr)
        } else {
            stringOrCodable = nil
        }
        
        self.init(role: role, content: stringOrCodable, name: name, functionCall: functionCall)
    }
    
    public init(role: Role, content: StringOrCodable<[ChatContent]>? = nil, name: String? = nil) {
        self.role = role
        self.content = content
        self.name = name
        self.functionCall = nil
        self.toolCalls = []
    }
    
    public init(role: Role, content: StringOrCodable<[ChatContent]>? = nil, name: String? = nil, functionCall: ChatFunctionCall?) {
        self.role = role
        self.content = content
        self.name = name
        self.functionCall = functionCall
        self.toolCalls = []
    }
    
    public init(
        role: Role,
        content: StringOrCodable<[ChatContent]>? = nil,
        name: String? = nil,
        toolCalls: [ToolCall]?
    ) {
        self.role = role
        self.content = content
        self.name = name
        self.toolCalls = toolCalls
        self.functionCall = nil
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role, forKey: .role)

        if let name = name {
            try container.encode(name, forKey: .name)
        }

        if let functionCall = functionCall {
            try container.encode(functionCall, forKey: .functionCall)
        }
        
        if let toolCalls = toolCalls {
            try container.encode(toolCalls, forKey: .toolCalls)
        }

        // Should add 'nil' to 'content' property for function calling response
        // See https://openai.com/blog/function-calling-and-other-api-updates
        if content != nil || (role == .assistant && toolCalls != nil && functionCall != nil) {
            try container.encode(content, forKey: .content)
        }
    }
}
