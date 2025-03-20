//
//  AssistantsResult.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct AssistantsResult: Codable, Equatable, Sendable {

    public let data: [AssistantResult]?
    public let firstId: String?
    public let lastId: String?
    public let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case data
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }
}
