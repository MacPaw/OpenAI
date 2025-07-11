//
//  JSONSchema.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

/*
 4.3. [JSON Schema Documents](https://json-schema.org/draft/2020-12/json-schema-core#name-json-schema-documents)
 
 ...
 
 A JSON Schema MUST be an `object` or a `boolean`.
 */

public typealias JSONSchemaBoolean = Bool
public typealias JSONSchemaObject = Dictionary<String, AnyJSONDocument>

public enum JSONSchema: JSONDocument {
    case boolean(JSONSchemaBoolean)
    case object(JSONSchemaObject)
    
    public static func schema(_ fields: JSONSchemaField...) -> JSONSchema {
        .init(fields: fields)
    }
    
    public init(_ fields: JSONSchemaField...) {
        self = .init(fields: fields)
    }
    
    public init(fields: [JSONSchemaField]) {
        let dictionarySchema = fields.reduce(into: JSONSchemaObject()) { partialResult, field in
            partialResult[field.keyword] = .init(field.value)
        }
        
        self = .object(dictionarySchema)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        // Try to decode as JSONSchemaBoolean
        if let booleanValue = try? container.decode(JSONSchemaBoolean.self) {
            self = .boolean(booleanValue)
            return
        }
        
        // Try to decode as JSONSchemaObject
        if let objectValue = try? container.decode(JSONSchemaObject.self) {
            self = .object(objectValue)
            return
        }
        
        // If neither matches, throw a decoding error
        throw DecodingError.typeMismatch(
            JSONSchema.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Expected a Boolean or an Object for JSONSchema"
            )
        )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .boolean(let booleanValue):
            try container.encode(booleanValue)
        case .object(let objectValue):
            try container.encode(objectValue)
        }
    }
}
