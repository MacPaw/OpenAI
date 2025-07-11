//
//  JSONSchemaDefinition.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 01.07.2025.
//

import Foundation

public enum JSONSchemaDefinition: Codable, Hashable, Sendable {
    case jsonSchema(JSONSchema)
    case derivedJsonSchema(any JSONSchemaConvertible.Type)
    case dynamicJsonSchema(Encodable & Sendable)
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .jsonSchema(let schema):
            hasher.combine(0) // Discriminator for case
            hasher.combine(schema)
        case .derivedJsonSchema(let schemaConvertible):
            hasher.combine(1) // Discriminator for case
            hasher.combine(String(describing: schemaConvertible))
        case .dynamicJsonSchema(let dynamicSchema):
            hasher.combine(2) // Discriminator for case
            hasher.combine(encodedDataHash(dynamicSchema))
        }
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = .jsonSchema(try container.decode(JSONSchema.self))
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .jsonSchema(let schema):
            try container.encode(schema)
        case .derivedJsonSchema(let type):
            try container.encode(PropertyValue(from: type.example))
        case .dynamicJsonSchema(let dynamicSchema):
            try container.encode(dynamicSchema)
        }
    }
    
    private func encodedDataHash(_ codable: any Encodable) -> Int {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys] // Ensure consistent ordering
            let data = try encoder.encode(codable)
            return data.hashValue
        } catch {
            // Fallback to object identifier if encoding fails
            return ObjectIdentifier(type(of: codable)).hashValue
        }
    }
    
    private static func encodedDataEqual(_ lhs: any Encodable, _ rhs: any Encodable) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.sortedKeys] // Ensure consistent ordering
            let lhsData = try encoder.encode(lhs)
            let rhsData = try encoder.encode(rhs)
            return lhsData == rhsData
        } catch {
            return false
        }
    }
    
    public static func == (lhs: JSONSchemaDefinition, rhs: JSONSchemaDefinition) -> Bool {
        switch (lhs, rhs) {
        case (.jsonSchema(let lhsJsonSchema), .jsonSchema(let rhsJsonSchema)):
            return lhsJsonSchema == rhsJsonSchema
        case (.derivedJsonSchema(let lhsJsonSchema), .derivedJsonSchema(let rhsJsonSchema)):
            do {
                return try PropertyValue(from: lhsJsonSchema) == PropertyValue(from: rhsJsonSchema)
            } catch {
                return false
            }
        case (.dynamicJsonSchema(let lhsJsonSchema), .dynamicJsonSchema(let rhsJsonSchema)):
            return encodedDataEqual(lhsJsonSchema, rhsJsonSchema)
        default:
            return false
        }
    }
}
