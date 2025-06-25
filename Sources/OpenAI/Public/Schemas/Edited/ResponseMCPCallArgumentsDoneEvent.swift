//
//  ResponseMCPCallArgumentsDoneEvent.swift
//  OpenAI
//
//  Created by Tony Li on 25/6/25.
//

/// Remove it once OpenAI fixed the response issue
/// Why need this separate file instead of using the schema under Generated/Components:
///  OpenAI's documentation https://platform.openai.com/docs/api-reference/responses-streaming/response/mcp_call/arguments/done
///  2 issues
///     - namsspace they used is `response.mcp_call_arguments.done` instead of `response.mcp_call.arguments.done`
///     - delta type should be `Swift.String` instead of `OpenAPIRuntime.OpenAPIObjectContainer`
///
/// Emitted when the arguments for an MCP tool call are finalized.
///
///
/// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent`.
public struct ResponseMCPCallArgumentsDoneEvent: Codable, Hashable, Sendable {
    /// The type of the event. Always 'response.mcp_call.arguments_done'.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/type`.
    @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
        case response_mcpCallArguments_done = "response.mcp_call_arguments.done"
    }
    /// The type of the event. Always 'response.mcp_call.arguments_done'.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/type`.
    public var _type: ResponseMCPCallArgumentsDoneEvent._TypePayload
    /// The index of the output item in the response's output array.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/output_index`.
    public var outputIndex: Swift.Int
    /// The unique identifier of the MCP tool call item being processed.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/item_id`.
    public var itemId: Swift.String
    /// The finalized arguments for the MCP tool call.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/arguments`.
    public var arguments: Swift.String
    /// The sequence number of this event.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/sequence_number`.
    public var sequenceNumber: Swift.Int
    /// Creates a new `ResponseMCPCallArgumentsDoneEvent`.
    ///
    /// - Parameters:
    ///   - _type: The type of the event. Always 'response.mcp_call.arguments_done'.
    ///   - outputIndex: The index of the output item in the response's output array.
    ///   - itemId: The unique identifier of the MCP tool call item being processed.
    ///   - arguments: The finalized arguments for the MCP tool call.
    ///   - sequenceNumber: The sequence number of this event.
    public init(
        _type: ResponseMCPCallArgumentsDoneEvent._TypePayload,
        outputIndex: Swift.Int,
        itemId: Swift.String,
        arguments: Swift.String,
        sequenceNumber: Swift.Int
    ) {
        self._type = _type
        self.outputIndex = outputIndex
        self.itemId = itemId
        self.arguments = arguments
        self.sequenceNumber = sequenceNumber
    }
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
        case outputIndex = "output_index"
        case itemId = "item_id"
        case arguments
        case sequenceNumber = "sequence_number"
    }
}
