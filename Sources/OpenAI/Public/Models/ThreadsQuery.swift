//
//  ThreadsQuery.swift
//
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct ThreadsQuery: Equatable, Codable, Sendable {
    public let messages: [ChatQuery.ChatCompletionMessageParam]

    enum CodingKeys: String, CodingKey {
        case messages
    }

    public init(messages: [ChatQuery.ChatCompletionMessageParam]) {
        self.messages = messages
    }
}
