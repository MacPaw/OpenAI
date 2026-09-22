//
//  WebSearchToolCall.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.09.2026.
//

/// The results of a web search tool call. See the
/// [web search guide](https://developers.openai.com/api/docs/guides/tools-web-search)
/// for more information.
///
/// Hand-written replacement for `Components.Schemas.WebSearchToolCall`. The spec marks `action`
/// required, but the live API can emit this item without one, e.g. in a
/// `response.output_item.added` event while `status` is still `in_progress` and no action has
/// been decided on yet. This is an acknowledged upstream spec bug, not something we should try to
/// second-guess by status: see [openai/openai-openapi#572](https://github.com/openai/openai-openapi/issues/572).
public struct WebSearchToolCall: Codable, Hashable, Sendable {
    public typealias ActionPayload = Components.Schemas.WebSearchToolCall.ActionPayload

    /// The unique ID of the web search tool call.
    public let id: String
    /// The status of the web search tool call.
    public let status: Components.Schemas.WebSearchCallStatus
    /// An object describing the specific action taken in this web search call.
    /// `nil` when the server hasn't reported one yet.
    public let action: ActionPayload?

    public init(
        id: String,
        status: Components.Schemas.WebSearchCallStatus,
        action: ActionPayload?
    ) {
        self.id = id
        self.status = status
        self.action = action
    }

    public init(_ generated: Components.Schemas.WebSearchToolCall) {
        self.init(id: generated.id, status: generated.status, action: generated.action)
    }

    public enum CodingKeys: String, CodingKey {
        case id
        case type
        case status
        case action
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        status = try container.decode(Components.Schemas.WebSearchCallStatus.self, forKey: .status)
        action = try container.decodeIfPresent(ActionPayload.self, forKey: .action)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode("web_search_call", forKey: .type)
        try container.encode(status, forKey: .status)
        try container.encodeIfPresent(action, forKey: .action)
    }
}
