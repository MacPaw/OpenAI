//
//  ChatResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ChatResult: Codable, Equatable {
    
    public struct Choice: Codable, Equatable {
      
        public let index: Int
        /// Exists only if it is a complete message.
        public let message: Chat
        /// Exists only if it is a complete message.
        public let finish_reason: String?
    }
    
    public struct Usage: Codable, Equatable {
        public let prompt_tokens: Int
        public let completion_tokens: Int
        public let total_tokens: Int
    }
    
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    public let usage: Usage?
    
    init(id: String, object: String, created: TimeInterval, model: Model, choices: [Choice], usage: Usage) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.choices = choices
        self.usage = usage
    }
}
