//
//  ChatStreamResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 15/05/2023.
//

import Foundation

public struct ChatStreamResult: Codable, Equatable {
    
    public struct Choice: Codable, Equatable {
        public struct Delta: Codable, Equatable {
            public let content: String?
            public let role: Chat.Role?
            /// The name of the author of this message. `name` is required if role is `function`, and it should be the name of the function whose response is in the `content`. May contain a-z, A-Z, 0-9, and underscores, with a maximum length of 64 characters.
            public let name: String?
            public let function_call: ChatFunctionCall?
        }
        
        public let index: Int
        public let delta: Delta
        public let finish_reason: String?
    }
    
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    
    init(id: String, object: String, created: TimeInterval, model: Model, choices: [Choice]) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.choices = choices
    }
}
