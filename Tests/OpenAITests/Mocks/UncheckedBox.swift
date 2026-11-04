//
//  UncheckedBox.swift
//  OpenAI
//

/// A mutable box that test callbacks can write a result into.
final class UncheckedBox<Value>: @unchecked Sendable {
    var value: Value?
}
