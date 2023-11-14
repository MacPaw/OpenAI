//
//  File.swift
//  
//
//  Created by Federico Vitale on 14/11/23.
//

import Foundation

public struct Tool: Codable, Equatable {
    /// The type of the tool.
    let type: ToolType
    let value: ToolValue
    
    init(type: ToolType, value: ToolValue) {
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
    
    
    enum CodingKeys: CodingKey {
        case type
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        self.type = try container.decode(Tool.ToolType.self, forKey: .type)
        
        switch self.type {
        case .function:
            self.value = try dynamicContainer.decode(Tool.ToolValue.self, forKey: .init(stringValue: "function"))
            break
        }
    }
}


extension Tool {
    public enum ToolType: String, Codable {
        case function
    }
    
    public struct Function: Codable, Equatable {
        /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
        let name: String
        
        /// The parameters the functions accepts, described as a JSON Schema object. See the guide for examples, and the JSON Schema reference for documentation about the format.
        let parameters: JSONSchema
        
        /// A description of what the function does, used by the model to choose when and how to call the function.
        let description: String?
        
        init(name: String, description: String? = nil, parameters: JSONSchema = .empty) {
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

