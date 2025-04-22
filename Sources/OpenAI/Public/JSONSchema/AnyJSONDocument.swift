//
//  AnyJSONDocument.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

public struct AnyJSONDocument: JSONDocument {
    private let value: any JSONDocument
    
    init(_ value: any JSONDocument) {
        self.value = value
    }
    
    // Encoding
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
    
    // Decoding
    public init(from decoder: Decoder) throws {
        // Attempt to decode in order of most specific to least specific
        let container = try decoder.singleValueContainer()
        
        if let intVal = try? container.decode(Int.self) {
            self.value = intVal
        } else if let stringVal = try? container.decode(String.self) {
            self.value = stringVal
        } else if let boolVal = try? container.decode(Bool.self) {
            self.value = boolVal
        } else if container.decodeNil() {
            self.value = JSONNullValue()
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported JSONDocument type.")
        }
    }
}

extension AnyJSONDocument: Equatable {
    public static func == (lhs: AnyJSONDocument, rhs: AnyJSONDocument) -> Bool {
        switch (lhs.value, rhs.value) {
        case (let l as Int, let r as Int): return l == r
        case (let l as String, let r as String): return l == r
        case (let l as Bool, let r as Bool): return l == r
        case (_ as JSONNullValue, _ as JSONNullValue): return true
        default: return false
        }
    }
}

extension AnyJSONDocument: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch value {
        case let v as Int: hasher.combine(0); hasher.combine(v)
        case let v as String: hasher.combine(1); hasher.combine(v)
        case let v as Bool: hasher.combine(2); hasher.combine(v)
        case _ as JSONNullValue: hasher.combine(3)
        default: break
        }
    }
}
