//
//  AnyJSONDocument.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

public struct AnyJSONDocument: JSONDocument {
    private let value: any JSONDocument

    public init(_ value: any JSONDocument) {
        self.value = value
    }

    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self.value = JSONNullValue()
        } else if let intVal = try? container.decode(Int.self) {
            self.value = intVal
        } else if let decimalVal = try? container.decode(Decimal.self) {
            self.value = decimalVal
        } else if let boolVal = try? container.decode(Bool.self) {
            self.value = boolVal
        } else if let stringVal = try? container.decode(String.self) {
            self.value = stringVal
        } else if let arrayVal = try? container.decode([AnyJSONDocument].self) {
            self.value = arrayVal
        } else if let dictVal = try? container.decode([String: AnyJSONDocument].self) {
            self.value = dictVal
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported JSONDocument type.")
        }
    }
}

extension AnyJSONDocument: Equatable {
    public static func == (lhs: AnyJSONDocument, rhs: AnyJSONDocument) -> Bool {
        switch (lhs.value, rhs.value) {
        case (let l as Int, let r as Int): return l == r
        case (let l as Decimal, let r as Decimal): return l == r
        case (let l as String, let r as String): return l == r
        case (let l as Bool, let r as Bool): return l == r
        case (_ as JSONNullValue, _ as JSONNullValue): return true
        case (let l as [any JSONDocument], let r as [any JSONDocument]):
            return zip(l, r).allSatisfy { AnyJSONDocument($0) == AnyJSONDocument($1) }
        case (let l as [String: any JSONDocument], let r as [String: any JSONDocument]):
            return l.count == r.count &&
                   l.keys.allSatisfy { key in
                       if let lv = l[key], let rv = r[key] {
                           return AnyJSONDocument(lv) == AnyJSONDocument(rv)
                       }
                       return false
                   }
        default: return false
        }
    }
}

extension AnyJSONDocument: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch value {
        case let v as Int:
            hasher.combine(0); hasher.combine(v)
        case let v as Decimal:
            hasher.combine(1); hasher.combine(v)
        case let v as String:
            hasher.combine(2); hasher.combine(v)
        case let v as Bool:
            hasher.combine(3); hasher.combine(v)
        case _ as JSONNullValue:
            hasher.combine(4)
        case let v as [any JSONDocument]:
            hasher.combine(5)
            v.forEach { hasher.combine(AnyJSONDocument($0)) }
        case let v as [String: any JSONDocument]:
            hasher.combine(6)
            for (k, v) in v.sorted(by: { $0.key < $1.key }) {
                hasher.combine(k)
                hasher.combine(AnyJSONDocument(v))
            }
        default:
            break
        }
    }
}
