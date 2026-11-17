//
//  AnyJSONDocument.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

public struct AnyJSONDocument: JSONDocument {
    /// A wrapped JSON `null` value.
    public static let null = AnyJSONDocument(JSONNullValue())

    /// The wrapped JSON value.
    public let value: any JSONDocument

    public init(_ value: any JSONDocument) {
        self.value = (value as? AnyJSONDocument)?.value ?? value
    }

    public func encode(to encoder: Encoder) throws {
        // Encoding through a container preserves JSONEncoder's special handling of Decimal
        // as a JSON number. Calling value.encode(to:) directly encodes its stored properties.
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            self.value = JSONNullValue()
        } else if let value = try container.decodeJSONCandidate(Int.self, allowNumericOverflow: true) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(Decimal.self, allowNumericOverflow: true) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(Double.self) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(Bool.self) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(String.self) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate([AnyJSONDocument].self) {
            self.value = value
        } else {
            self.value = try container.decode(JSONObject.self)
        }
    }
}

extension AnyJSONDocument: Equatable {
    private static func equals<T: JSONDocument>(_ lhs: T, _ rhs: any JSONDocument) -> Bool {
        guard let rhs = rhs as? T else { return false }
        return lhs == rhs
    }

    public static func == (lhs: AnyJSONDocument, rhs: AnyJSONDocument) -> Bool {
        switch (lhs.value, rhs.value) {
        case (let l as Int, let r as Int): return l == r
        case (let l as Decimal, let r as Decimal): return l == r
        case (let l as Double, let r as Double): return l == r
        case (let l as String, let r as String): return l == r
        case (let l as Bool, let r as Bool): return l == r
        case (_ as JSONNullValue, _ as JSONNullValue): return true
        case (let l as [any JSONDocument], let r as [any JSONDocument]):
            return l.count == r.count && zip(l, r).allSatisfy { AnyJSONDocument($0) == AnyJSONDocument($1) }
        case (let l as [String: any JSONDocument], let r as [String: any JSONDocument]):
            return l.count == r.count &&
                   l.keys.allSatisfy { key in
                       if let lv = l[key], let rv = r[key] {
                           return AnyJSONDocument(lv) == AnyJSONDocument(rv)
                       }
                       return false
                   }
        default: return equals(lhs.value, rhs.value)
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
            value.hash(into: &hasher)
        }
    }
}

private extension SingleValueDecodingContainer {
    func decodeJSONCandidate<T: Decodable>(_ type: T.Type, allowNumericOverflow: Bool = false) throws -> T? {
        do {
            return try decode(type)
        } catch DecodingError.typeMismatch {
            // JSON values have no type tag; try the next supported representation.
            return nil
        } catch where allowNumericOverflow {
            // Foundation can throw a private JSONError for an unrepresentable number,
            // rather than DecodingError. Retry a wider numeric representation; Double
            // decoding below still propagates an error if no representation succeeds.
            return nil
        }
    }
}
