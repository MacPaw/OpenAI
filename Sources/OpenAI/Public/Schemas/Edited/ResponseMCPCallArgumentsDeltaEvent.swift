//
//  ResponseMCPCallArgumentsDeltaEvent.swift
//  OpenAI
//
//  Created by Tony Li on 25/6/25.
//

/// Remove it once OpenAI fixed the response issue
/// Why need this separate file instead of using the schema under Generated/Components:
///  OpenAI's documentation https://platform.openai.com/docs/api-reference/responses-streaming/response/mcp_call/arguments/delta
///  2 issues
///     - namsspace they used is `response.mcp_call_arguments.delta` instead of `response.mcp_call.arguments.delta`
///     - delta type should be `Swift.String` instead of `OpenAPIRuntime.OpenAPIObjectContainer`
///
/// Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
///
///
/// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent`.
public struct ResponseMCPCallArgumentsDeltaEvent: Codable, Hashable, Sendable {
    /// The type of the event. Always 'response.mcp_call.arguments_delta'.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/type`.
    @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
        case response_mcpCallArguments_delta = "response.mcp_call_arguments.delta"
    }
    /// The type of the event. Always 'response.mcp_call.arguments_delta'.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/type`.
    public var _type: ResponseMCPCallArgumentsDeltaEvent._TypePayload
    /// The index of the output item in the response's output array.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/output_index`.
    public var outputIndex: Swift.Int
    /// The unique identifier of the MCP tool call item being processed.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/item_id`.
    public var itemId: Swift.String
    /// The partial update to the arguments for the MCP tool call.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/delta`.
    public var delta: Swift.String
    /// The sequence number of this event.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/sequence_number`.
    public var sequenceNumber: Swift.Int
    /// Creates a new `ResponseMCPCallArgumentsDeltaEvent`.
    ///
    /// - Parameters:
    ///   - _type: The type of the event. Always 'response.mcp_call.arguments_delta'.
    ///   - outputIndex: The index of the output item in the response's output array.
    ///   - itemId: The unique identifier of the MCP tool call item being processed.
    ///   - delta: The partial update to the arguments for the MCP tool call.
    ///   - sequenceNumber: The sequence number of this event.
    public init(
        _type: ResponseMCPCallArgumentsDeltaEvent._TypePayload,
        outputIndex: Swift.Int,
        itemId: Swift.String,
        delta: Swift.String,
        sequenceNumber: Swift.Int
    ) {
        self._type = _type
        self.outputIndex = outputIndex
        self.itemId = itemId
        self.delta = delta
        self.sequenceNumber = sequenceNumber
    }
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
        case outputIndex = "output_index"
        case itemId = "item_id"
        case delta
        case sequenceNumber = "sequence_number"
    }
}
