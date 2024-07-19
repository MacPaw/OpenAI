//
//  AssistantResult.swift
//  
//
//  Created by Brent Whitman on 2024-01-29.
//

import Foundation

public struct AssistantResult: Codable, Equatable {
    public let id: String
    public let name: String?
    public let description: String?
    public let instructions: String?
    public let tools: [Tool]?
    public let fileIds: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case instructions
        case tools
        case fileIds = "file_ids"
    }
}
