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

public protocol JSONSchema: JSONDocument {}

extension Bool: JSONSchema {}
typealias JSONSchemaBoolean = Bool

extension Dictionary: JSONSchema where Key == String, Value: JSONDocument {}
typealias JSONSchemaObject = Dictionary<String, AnyJSONDocument>
