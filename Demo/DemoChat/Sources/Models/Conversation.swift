//
//  Conversation.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation

struct Conversation {
    init(id: String, messages: [Message] = [], type: ConversationType = .normal, assistantId: String? = nil) {
        self.id = id
        self.messages = messages
        self.type = type
        self.assistantId = assistantId
    }
    
    typealias ID = String
    
    let id: String
    var messages: [Message]
    var type: ConversationType
    var assistantId: String?
}

enum ConversationType {
    case normal
    case assistant
}

extension Conversation: Equatable, Identifiable {}
