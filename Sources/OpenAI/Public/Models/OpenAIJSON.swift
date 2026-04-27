//
//  OpenAIJSON.swift
//
//  A small, recursive Codable representation of any JSON value. Used to
//  carry arbitrary vendor-specific request fields (for example
//  `chat_template_kwargs` on vLLM-served reasoning models) through
//  `ChatQuery.extraBody` without needing a typed Swift property for
//  every possible parameter.
//
//  The name is deliberately distinct from a more natural "JSONValue" so
//  that downstream apps with their own JSON enum (e.g. used for
//  streaming-event payloads) can use the SDK's type without collision.
//

import Foundation

public enum OpenAIJSON: Codable, Equatable, Sendable {
    case null
    case bool(Bool)
    case int(Int)
    case double(Double)
    case string(String)
    case array([OpenAIJSON])
    case object([String: OpenAIJSON])

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
            return
        }
        if let value = try? container.decode(Bool.self) {
            self = .bool(value)
            return
        }
        if let value = try? container.decode(Int.self) {
            self = .int(value)
            return
        }
        if let value = try? container.decode(Double.self) {
            self = .double(value)
            return
        }
        if let value = try? container.decode(String.self) {
            self = .string(value)
            return
        }
        if let value = try? container.decode([OpenAIJSON].self) {
            self = .array(value)
            return
        }
        if let value = try? container.decode([String: OpenAIJSON].self) {
            self = .object(value)
            return
        }
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Unsupported JSON value"
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .null:
            try container.encodeNil()
        case .bool(let value):
            try container.encode(value)
        case .int(let value):
            try container.encode(value)
        case .double(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
}

extension OpenAIJSON: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) { self = .null }
}

extension OpenAIJSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) { self = .bool(value) }
}

extension OpenAIJSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) { self = .int(value) }
}

extension OpenAIJSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) { self = .double(value) }
}

extension OpenAIJSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) { self = .string(value) }
}

extension OpenAIJSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: OpenAIJSON...) { self = .array(elements) }
}

extension OpenAIJSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, OpenAIJSON)...) {
        var dict: [String: OpenAIJSON] = [:]
        for (k, v) in elements { dict[k] = v }
        self = .object(dict)
    }
}
