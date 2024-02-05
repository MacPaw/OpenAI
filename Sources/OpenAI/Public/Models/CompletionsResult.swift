//
//  CompletionsResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct CompletionsResult: Codable, Equatable {
    
    public struct Usage: Codable, Equatable {
        public let prompt_tokens: Int
        public let completion_tokens: Int
        public let total_tokens: Int
    }
    
    public struct Choice: Codable, Equatable {
        public let text: String
        public let index: Int
        public let finish_reason: String?
    }

    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    public let usage: Usage?
}
