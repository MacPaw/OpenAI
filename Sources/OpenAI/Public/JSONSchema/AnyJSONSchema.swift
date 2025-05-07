//
//  AnyJSONSchema.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//


public struct AnyJSONSchema: JSONSchema {
    let value: any JSONSchema

    public init(schema: any JSONSchema) {
        self.value = schema
    }
    
    public init(fields: [JSONSchemaField]) {
        let dictionarySchema = fields.reduce(into: JSONSchemaObject()) { partialResult, field in
            partialResult[field.keyword] = .init(field.value)
        }
        
        value = dictionarySchema
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let bool = try? container.decode(JSONSchemaBoolean.self) {
            value = bool
        } else if let dict = try? container.decode(JSONSchemaObject.self) {
            value = dict
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type")
        }
    }

    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
}

extension AnyJSONSchema: Equatable {
    public static func == (lhs: AnyJSONSchema, rhs: AnyJSONSchema) -> Bool {
        switch (lhs.value, rhs.value) {
        case (let l as JSONSchemaBoolean, let r as JSONSchemaBoolean):
            return l == r
        case (let l as JSONSchemaObject, let r as JSONSchemaObject):
            return l == r
        default:
            return false
        }
    }
}

extension AnyJSONSchema: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch value {
        case let v as JSONSchemaBoolean:
            hasher.combine(0)
            hasher.combine(v)
        case let v as JSONSchemaObject:
            hasher.combine(1)
            hasher.combine(v)
        default:
            break
        }
    }
}
