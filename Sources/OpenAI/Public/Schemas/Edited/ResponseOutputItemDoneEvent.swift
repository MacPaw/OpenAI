//
//  ResponseOutputItemDoneEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 16.04.2025.
//

/// Emitted when an output item is marked done.
public struct ResponseOutputItemDoneEvent: Codable, Hashable, Sendable {
    /// The type of the event. Always `response.output_item.done`.
    public let type: String
    /// The index of the output item that was marked done.
    public let outputIndex: Int
    /// The output item that was marked done.
    public let item: OutputItem
    /// Creates a new `ResponseOutputItemDoneEvent`.
    ///
    /// - Parameters:
    ///   - type: The type of the event. Always `response.output_item.done`.
    ///   - outputIndex: The index of the output item that was marked done.
    ///   - item: The output item that was marked done.
    public init(
        type: String = "response.output_item.done",
        outputIndex: Int,
        item: OutputItem
    ) {
        self.type = type
        self.outputIndex = outputIndex
        self.item = item
    }
    
    public enum CodingKeys: String, CodingKey {
        case type
        case outputIndex = "output_index"
        case item
    }
}
