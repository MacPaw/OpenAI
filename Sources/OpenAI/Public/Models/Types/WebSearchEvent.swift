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

    /// The status of the web search operation
    public let status: Status

    /// The action being performed (contains the search query)
    public let action: Action?

    /// Reason for blocked or failed searches
    public let reason: String?

    /// Possible statuses for a web search event
    public enum Status: String, Codable, Sendable {
        case inProgress = "in_progress"
        case completed
        case failed
        case blocked
    }

    /// The action associated with the web search
    public struct Action: Codable, Equatable, Sendable {
        /// The search query being executed
        public let query: String?
    }
}
