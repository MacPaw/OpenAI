//
//  AssistantsQuery.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct AssistantsQuery: Codable, Equatable {
    public let model: Model
    public let name: String?
    public let description: String?
    public let instructions: String?
    public let tools: [Tool]?
    public let fileIds: [String]?

    enum CodingKeys: String, CodingKey {
        case model
        case name
        case description
        case instructions
        case tools
        case fileIds = "file_ids"
    }
    
    public init(model: Model, name: String?, description: String?, instructions: String?, tools: [Tool]?, fileIds: [String]? = nil) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
    }
}
