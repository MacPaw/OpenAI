//
//  ThreadsRunsQuery.swift
//
//
//  Created by Brent Whitman on 2024-01-29.
//

import Foundation

public struct ThreadRunQuery: Equatable, Codable {
    
    public let assistantId: String
    public let thread: ThreadsQuery
    public let model: Model?
    public let instructions: String?
    public let tools: [Tool]?

    enum CodingKeys: String, CodingKey {
        case assistantId = "assistant_id"
        case thread
        case model
        case instructions
        case tools
    }

    public init(
        assistantId: String,
        thread: ThreadsQuery,
        model: Model? = nil,
        instructions: String? = nil,
        tools: [Tool]? = nil
    ) {
        self.assistantId = assistantId
        self.thread = thread
        self.model = model
        self.instructions = instructions
        self.tools = tools
    }
}
