//
//  ResponseFunctionCallArgumentsDoneEvent.swift
//  OpenAI
//

/// Remove it once the generated `Components.Schemas.ResponseFunctionCallArgumentsDoneEvent`
/// includes `name`.
///
/// Per the [OpenAI docs](https://developers.openai.com/api/reference/resources/responses/streaming-events#response.function_call_arguments.done),
/// `response.function_call_arguments.done` carries a `name` identifying the
/// function whose arguments have been finalized. The OpenAPI spec used to
/// generate `Components.swift` is missing it, so we extract the type per
/// CONTRIBUTING.md and add the field here.
///
/// Emitted when function-call arguments are finalized.
///
/// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent`.
public struct ResponseFunctionCallArgumentsDoneEvent: Codable, Hashable, Sendable {
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/type`.
    @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
        case response_functionCallArguments_done = "response.function_call_arguments.done"
    }
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/type`.
    public var _type: _TypePayload
    /// The ID of the item.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/item_id`.
    public var itemId: Swift.String
    /// The index of the output item.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/output_index`.
    public var outputIndex: Swift.Int
    /// The sequence number of this event.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/sequence_number`.
    public var sequenceNumber: Swift.Int
    /// The function-call arguments.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/arguments`.
    public var arguments: Swift.String
    /// The name of the function being called. Optional for forward-compatibility
    /// with servers that haven't shipped the field on this event yet.
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/name`.
    public var name: Swift.String?
    /// Creates a new `ResponseFunctionCallArgumentsDoneEvent`.
    ///
    /// - Parameters:
    ///   - _type:
    ///   - itemId: The ID of the item.
    ///   - outputIndex: The index of the output item.
    ///   - sequenceNumber: The sequence number of this event.
    ///   - arguments: The function-call arguments.
    ///   - name: The name of the function being called.
    public init(
        _type: _TypePayload,
        itemId: Swift.String,
        outputIndex: Swift.Int,
        sequenceNumber: Swift.Int,
        arguments: Swift.String,
        name: Swift.String? = nil
    ) {
        self._type = _type
        self.itemId = itemId
        self.outputIndex = outputIndex
        self.sequenceNumber = sequenceNumber
        self.arguments = arguments
        self.name = name
    }
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
        case itemId = "item_id"
        case outputIndex = "output_index"
        case sequenceNumber = "sequence_number"
        case arguments
        case name
    }
}
