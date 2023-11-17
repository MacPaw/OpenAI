//
//  Conversation.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation

struct Conversation {
    init(id: String, messages: [MessageModel] = []) {
        self.id = id
        self.messages = messages
    }
    
    typealias ID = String
    
    let id: String
    var messages: [MessageModel]
}

extension Conversation: Equatable, Identifiable {}
