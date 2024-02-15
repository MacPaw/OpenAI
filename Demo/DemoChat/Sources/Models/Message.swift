//
//  Message.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation
import OpenAI

struct Message {
    var id: String
    var role: ChatQuery.ChatCompletionMessageParam.Role
    var content: String
    var createdAt: Date
}

extension Message: Equatable, Codable, Hashable, Identifiable {}
