//
//  AnyJSONSchema.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//


public struct AnyJSONSchema: JSONSchema {
    private let value: any JSONSchema

    public init(schema: any JSONSchema) {
        self.value = schema
    }
    
    public init(fields: [JSONSchemaField]) {
        let dictionarySchema = fields.reduce(into: [String: AnyJSONDocument]()) { partialResult, field in
            partialResult[field.keyword] = .init(field.value)
        }
        
        value = dictionarySchema
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let dict = try? container.decode([String: AnyJSONSchema].self) {
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
        case (let l as Bool, let r as Bool):
            return l == r
        case (let l as [String: AnyJSONSchema], let r as [String: AnyJSONSchema]):
            return l == r
        default:
            return false
        }
    }
}

extension AnyJSONSchema: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch value {
        case let v as Bool:
            hasher.combine(0)
            hasher.combine(v)
        case let v as [String: AnyJSONSchema]:
            hasher.combine(1)
            hasher.combine(v)
        default:
            break
        }
    }
}
