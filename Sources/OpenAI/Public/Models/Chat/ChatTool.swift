//
//  ChatTool.swift
//
//
//  Created by Federico Vitale on 14/11/23.
//

import Foundation

public struct ChatTool: Codable, Equatable {
    public let type: ToolType
    public let value: ToolValue
    
    enum CodingKeys: CodingKey {
        case type
        case value
    }
    
    public init(type: ToolType, value: ToolValue) {
        self.type = type
        self.value = value
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dynamicContainer = encoder.container(keyedBy: DynamicKey.self)

        try container.encode(type, forKey: .type)
        
        switch value {
        case .function(let function):
            try dynamicContainer.encode(function, forKey: .init(stringValue: "function"))
            break
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        self.type = try container.decode(ChatTool.ToolType.self, forKey: .type)
        
        switch self.type {
        case .function:
            self.value = try dynamicContainer.decode(ChatTool.ToolValue.self, forKey: .init(stringValue: "function"))
            break
        }
    }
}


extension ChatTool {
    public enum ToolType: String, Codable {
        case function
    }
    
    public struct Function: Codable, Equatable {
        /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
        public let name: String
        
        /// The parameters the functions accepts, described as a JSON Schema object. See the guide for examples, and the JSON Schema reference for documentation about the format.
        public let parameters: JSONSchema
        
        /// A description of what the function does, used by the model to choose when and how to call the function.
        public let description: String?
        
        public init(name: String, description: String? = nil, parameters: JSONSchema = .empty) {
            self.name = name
            self.parameters = parameters
            self.description = description
        }
    }
    
    public enum ToolValue: Codable, Equatable {
        case function(Function)
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            
            switch self {
            case .function(let function):
                try container.encode(function)
                break
            }
        }
        
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let function = try? container.decode(Function.self) {
                self = .function(function)
            }  else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Invalid data encountered when decoding StringOrCodable<T>"
                    )
                )
            }
        }
    }
}

public struct ToolCall: Codable, Equatable {
    public let index: Int
    public let id: String
    public let type: ChatTool.ToolType
    public let value: ToolCallValue
    
    public init(index: Int, id: String, type: ChatTool.ToolType, value: ToolCallValue) {
        self.index = index
        self.id = id
        self.type = type
        self.value = value
    }
    
    enum CodingKeys: CodingKey {
        case index
        case id
        case type
        case value
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var dynamicContainer = encoder.container(keyedBy: DynamicKey.self)

        try container.encode(type, forKey: .type)
        try container.encode(id, forKey: .id)
        try container.encode(index, forKey: .index)
        
        switch value {
        case .function(let function):
            try dynamicContainer.encode(function, forKey: .init(stringValue: "function"))
            break
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        self.type = try container.decode(ChatTool.ToolType.self, forKey: .type)
        self.id = try container.decode(String.self, forKey: .id)
        self.index = try container.decode(Int.self, forKey: .index)
        
        switch self.type {
        case .function:
            self.value = try dynamicContainer.decode(ToolCallValue.self, forKey: .init(stringValue: "function"))
            break
        }
    }
    
    public enum ToolCallValue: Codable, Equatable {
        case function(Function)
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            
            switch self {
            case .function(let function):
                try container.encode(function)
                break
            }
        }
        
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            
            if let function = try? container.decode(Function.self) {
                self = .function(function)
            }  else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Invalid data encountered when decoding StringOrCodable<T>"
                    )
                )
            }
        }
    }
    
    public struct Function : Codable, Equatable {
        public let name: String?
        public let arguments: String?
        
        public static func withName(_ name: String, arguments: String? = nil) -> Self {
            return Function(name: name, arguments: arguments)
        }
    }
}
