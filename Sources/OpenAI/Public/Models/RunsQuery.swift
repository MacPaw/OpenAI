//
//  AssistantsQuery.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct RunsQuery: Codable, Sendable {

    public let assistantId: String

    enum CodingKeys: String, CodingKey {
        case assistantId = "assistant_id"
    }
    
    public init(assistantId: String) {

        self.assistantId = assistantId
    }
}
