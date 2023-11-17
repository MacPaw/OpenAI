//
//  ChatQuery+.swift
//  
//
//  Created by Federico Vitale on 14/11/23.
//

import Foundation


extension ChatQuery {
    // See more https://platform.openai.com/docs/guides/text-generation/json-mode
    public struct ResponseFormat: Codable, Equatable {
        public static let jsonObject = ResponseFormat(type: .jsonObject)
        public static let text = ResponseFormat(type: .text)
        
        public let type: Self.ResponseFormatType
        
        public enum ResponseFormatType: String, Codable, Equatable {
            case jsonObject = "json_object"
            case text
        }
    }
    
    public enum FunctionCall: Codable, Equatable {
        case none
        case auto
        case function(String)
        
        enum CodingKeys: String, CodingKey {
            case none
            case auto
            case function = "name"
        }
        
        public func encode(to encoder: Encoder) throws {
            switch self {
            case .none:
                var container = encoder.singleValueContainer()
                try container.encode(CodingKeys.none.rawValue)
            case .auto:
                var container = encoder.singleValueContainer()
                try container.encode(CodingKeys.auto.rawValue)
            case .function(let name):
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(name, forKey: .function)
            }
        }
    }
}
