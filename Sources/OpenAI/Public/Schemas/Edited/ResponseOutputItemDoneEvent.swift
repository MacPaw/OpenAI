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
    /// The sequence number of this event. The spec marks it required, but it's kept optional
    /// here so this hand-written wrapper's memberwise init and decoding stay source-compatible
    /// with callers/fixtures that predate this field.
    public let sequenceNumber: Int?
    /// The output item that was marked done.
    public let item: OutputItem
    /// Creates a new `ResponseOutputItemDoneEvent`.
    ///
    /// - Parameters:
    ///   - type: The type of the event. Always `response.output_item.done`.
    ///   - outputIndex: The index of the output item that was marked done.
    ///   - sequenceNumber: The sequence number of this event.
    ///   - item: The output item that was marked done.
    public init(
        type: String = "response.output_item.done",
        outputIndex: Int,
        sequenceNumber: Int? = nil,
        item: OutputItem
    ) {
        self.type = type
        self.outputIndex = outputIndex
        self.sequenceNumber = sequenceNumber
        self.item = item
    }

    public enum CodingKeys: String, CodingKey {
        case type
        case outputIndex = "output_index"
        case sequenceNumber = "sequence_number"
        case item
    }
}
