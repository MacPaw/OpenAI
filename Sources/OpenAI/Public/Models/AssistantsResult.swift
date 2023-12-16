//
//  AssistantsResult.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct AssistantsResult: Codable, Equatable {

    public let id: String?

    public let data: [AssistantContent]?
    public let tools: [Tool]?

    enum CodingKeys: String, CodingKey {
        case data
        case id
        case tools
    }

    public struct AssistantContent: Codable, Equatable {

        public let id: String
        public let name: String
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
}
