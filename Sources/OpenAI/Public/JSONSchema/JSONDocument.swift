//
//  JSONDocument.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

/// 4. [Definitions](https://json-schema.org/draft/2020-12/json-schema-core#name-definitions)
/// 4.1. [JSON Document](https://json-schema.org/draft/2020-12/json-schema-core#name-json-document)
/// 4.2.1. [Instance Data Model](https://json-schema.org/draft/2020-12/json-schema-core#name-instance-data-model)
public protocol JSONDocument: Codable, Hashable, Sendable {
}

/// [null](https://json-schema.org/draft/2020-12/json-schema-core#section-4.2.1-3.2)
/// A JSON "null" value
struct JSONNullValue: JSONDocument {
    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard container.decodeNil() else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected null.")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
extension Int: JSONDocument {}
extension Double: JSONDocument {}
extension String: JSONDocument {}
extension Bool: JSONDocument {}
/// [number](https://json-schema.org/draft/2020-12/json-schema-core#section-4.2.1-3.10)
/// An arbitrary-precision, base-10 decimal number value, from the JSON "number" value
extension Decimal: JSONDocument {}

extension Array: JSONDocument where Element: JSONDocument {}
extension Dictionary: JSONDocument where Key == String, Value: JSONDocument {}

typealias JSONObject = Dictionary<String, AnyJSONDocument>
