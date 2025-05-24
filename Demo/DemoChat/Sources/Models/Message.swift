//
//  Message.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation
import OpenAI
import ExyteChat

struct Message {
    struct Image: Codable, Hashable {
        let attachmentId: String
        let thumbnailURL: URL
        let data: Data
    }
    
    var id: String
    var role: ChatQuery.ChatCompletionMessageParam.Role
    var content: String
    var createdAt: Date
    var isRefusal: Bool = false
    var image: Image?

    var isLocal: Bool?
    var isRunStep: Bool?
}

extension Message: Codable, Hashable, Identifiable {}
