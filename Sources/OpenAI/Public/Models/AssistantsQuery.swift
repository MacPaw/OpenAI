//
//  AssistantsQuery.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct AssistantsQuery: Codable, Equatable, Sendable {
    public let model: Model
    public let name: String?
    public let description: String?
    public let instructions: String?
    public let tools: [Tool]?
    public let toolResources: ToolResources?

    enum CodingKeys: String, CodingKey {
        case model
        case name
        case description
        case instructions
        case tools
        case toolResources = "tool_resources"
    }
    
    public init(
        model: Model,
        name: String?,
        description: String?,
        instructions: String?,
        tools: [Tool]?,
        toolResources: ToolResources? = nil
    ) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.toolResources = toolResources
    }
}
