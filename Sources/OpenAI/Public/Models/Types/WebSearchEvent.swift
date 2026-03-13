//
//  WebSearchEvent.swift
//  OpenAI
//
//  Created on 01/02/2026.
//

import Foundation

/// Represents a web search event during streaming.
/// These events indicate the status of web search operations triggered by the model.
public struct WebSearchEvent: Codable, Equatable, Sendable {
    /// The type of event, typically "web_search_call"
    public let type: String

    /// Unique ID for the output item associated with the web search call
    public let itemId: String?

    /// The index of the output item that the web search call is associated with
    public let outputIndex: Int?

    /// The status of the web search operation
    public let status: Status

    /// The action being performed (contains the search query)
    public let action: Action?

    /// Reason for blocked or failed searches
    public let reason: String?

    /// Possible statuses for a web search event
    public enum Status: String, Codable, Sendable {
        case inProgress = "in_progress"
        case searching
        case completed
        case failed
        case blocked
    }

    /// The action associated with the web search
    public struct Action: Codable, Equatable, Sendable {
        /// The type of action: "search", "open_page", or "find_in_page"
        public let type: String?
        /// The search query being executed (for "search" actions)
        public let query: String?
        /// The URL being fetched (for "open_page" actions)
        public let url: String?
    }

    private enum CodingKeys: String, CodingKey {
        case type
        case itemId = "item_id"
        case outputIndex = "output_index"
        case status
        case action
        case reason
    }
}
