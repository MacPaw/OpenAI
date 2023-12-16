//
//  ThreadsQuery.swift
//
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct ThreadsQuery: Equatable, Codable {
    public let messages: [Chat]

    enum CodingKeys: String, CodingKey {
        case messages
    }

    public init(messages: [Chat]) {
        self.messages = messages
    }
}
