//
//  MessageQuery.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct MessageQuery: Equatable, Codable, Sendable {
    public let role: ChatQuery.ChatCompletionMessageParam.Role
    public let content: String
    public let fileIds: [String]?

    enum CodingKeys: String, CodingKey {
        case role
        case content
        case fileIds = "file_ids"
    }
    
    public init(role: ChatQuery.ChatCompletionMessageParam.Role, content: String, fileIds: [String]? = nil) {
        self.role = role
        self.content = content
        self.fileIds = fileIds
    }
}
