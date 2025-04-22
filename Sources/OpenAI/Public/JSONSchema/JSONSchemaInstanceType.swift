//
//  JSONSchemaInstanceType.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

public enum JSONSchemaInstanceType: Codable, Hashable, Sendable, JSONDocument {
    case integer
    case string
    case boolean
    case array
    case object
    case number
    case null
    case types([String])
    
    private enum CodingKeys: String {
        case integer, string, boolean, array, object, number, null, types
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let single = try? container.decode(String.self) {
            switch single {
            case "integer": self = .integer
            case "string": self = .string
            case "boolean": self = .boolean
            case "array": self = .array
            case "object": self = .object
            case "number": self = .number
            case "null": self = .null
            default:
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown instance type: \(single)")
            }
        } else if let array = try? container.decode([String].self) {
            self = .types(array)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "InstanceType must be a string or array of strings")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .integer: try container.encode("integer")
        case .string: try container.encode("string")
        case .boolean: try container.encode("boolean")
        case .array: try container.encode("array")
        case .object: try container.encode("object")
        case .number: try container.encode("number")
        case .null: try container.encode("null")
        case .types(let types): try container.encode(types)
        }
    }
}
