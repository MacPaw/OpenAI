//
//  Conversation.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation
import ExyteChat

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
    
    var exyteChatMessages: [ExyteChat.Message] {
        messages.map {
            let attachments: [Attachment] = if let image = $0.image {
                [.init(id: image.attachmentId, url: image.thumbnailURL, type: .image)]
            } else {
                []
            }
            
            let userType: UserType
            
            switch $0.role {
            case .user:
                userType = .current
            case .assistant:
                userType = .system
            default:
                userType = .other
            }
            
            return .init(
                id: $0.id,
                user: .init(
                    id: $0.role.rawValue,
                    name: $0.role.rawValue,
                    avatarURL: userType == .system ? .init(string: "https://openai.com/apple-icon.png") : nil,
                    type: userType
                ),
                createdAt: $0.createdAt,
                text: $0.content,
                attachments: attachments
            )
        }
    }
}

enum ConversationType {
    case normal
    case assistant
}

extension Conversation: Equatable, Identifiable {}
