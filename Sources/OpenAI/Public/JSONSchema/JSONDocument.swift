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
struct JSONNullValue: JSONDocument {}
extension Int: JSONDocument {}
extension String: JSONDocument {}
extension Bool: JSONDocument {}
extension Array: JSONDocument where Element: JSONDocument {}
extension Dictionary: JSONDocument where Key == String, Value: JSONDocument {}

/// [number](https://json-schema.org/draft/2020-12/json-schema-core#section-4.2.1-3.10)
/// An arbitrary-precision, base-10 decimal number value, from the JSON "number" value
extension Decimal: JSONDocument {}
