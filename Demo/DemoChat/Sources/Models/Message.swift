//
//  Message.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation
import OpenAI

struct MessageModel {
    var id: String
    var role: Message.Role
    var content: String
    var createdAt: Date
}

extension MessageModel: Equatable, Codable, Hashable, Identifiable {}
