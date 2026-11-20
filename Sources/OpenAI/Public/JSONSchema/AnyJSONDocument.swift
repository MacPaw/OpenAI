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

    // The value is internal instead of private for testability
    let value: any JSONDocument

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
        } else if let value = try container.decodeJSONCandidate(Int.self, tryingNextTypeOnAnyError: true) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(Decimal.self, tryingNextTypeOnAnyError: true) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(Double.self) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(Bool.self) {
            self.value = value
        } else if let value = try container.decodeJSONCandidate(String.self) {
            self.value = value
        } else if let value = try container.decodeJSONArrayCandidate() {
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
    /// Decodes a scalar value as `type`, or returns `nil` if the value is of another JSON type.
    ///
    /// - Parameter tryingNextTypeOnAnyError: Return `nil` for any error, not only a type mismatch.
    ///   Used for `Int` and `Decimal`, so that a number they can't represent, such as `1.5` or `1e30`
    ///   for `Int`, is decoded as a wider numeric type instead.
    func decodeJSONCandidate<T: Decodable>(_ type: T.Type, tryingNextTypeOnAnyError: Bool = false) throws -> T? {
        do {
            return try decode(type)
        } catch DecodingError.typeMismatch {
            return nil
        } catch where tryingNextTypeOnAnyError {
            // Foundation's JSONDecoder doesn't report such a number as a DecodingError inside a
            // custom init(from:): it throws its internal JSONError.numberIsNotRepresentableInSwift,
            // which can't be matched by type. A scalar has no nested values, so the error is about
            // this value. Double is decoded without this option and reports a number that no
            // supported type can represent.
            return nil
        }
    }

    /// Decodes the value as an array, or returns `nil` if the value isn't an array.
    ///
    /// Only a type mismatch of this value itself means it isn't an array. An error from one of
    /// its elements propagates instead of the value being decoded as an object.
    func decodeJSONArrayCandidate() throws -> [AnyJSONDocument]? {
        do {
            return try decode([AnyJSONDocument].self)
        } catch DecodingError.typeMismatch(_, let context) where context.codingPath.count == codingPath.count {
            return nil
        }
    }
}
