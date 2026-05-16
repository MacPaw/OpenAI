//
//  ResponseOutputItemAddedEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 16.04.2025.
//

/// Emitted when a new output item is added.
public struct ResponseOutputItemAddedEvent: Codable, Hashable, Sendable {
    /// The type of the event. Always `response.output_item.added`.
    public let type: String
    /// The index of the output item that was added.
    public let outputIndex: Int
    /// The output item that was added.
    public let item: OutputItem
    /// Creates a new `ResponseOutputItemAddedEvent`.
    ///
    /// - Parameters:
    ///   - type: The type of the event. Always `response.output_item.added`.
    ///   - outputIndex: The index of the output item that was added.
    ///   - item:The output item that was added.
    public init(
        type: String = "response.output_item.added",
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
