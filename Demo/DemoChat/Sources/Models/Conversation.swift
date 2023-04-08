//
//  Conversation.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation

struct Conversation {
    init(id: String, messages: [Message] = []) {
        self.id = id
        self.messages = messages
    }
    
    typealias ID = String
    
    let id: String
    var messages: [Message]
}

extension Conversation: Equatable, Identifiable {}
