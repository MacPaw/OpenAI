//
//  ThreadsMessagesResult.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct ThreadsMessagesResult: Codable, Equatable, Sendable {

    public struct ThreadsMessage: Codable, Equatable, Sendable {

        public struct ThreadsMessageContent: Codable, Equatable, Sendable {

            public struct ThreadsMessageContentText: Codable, Equatable, Sendable {

                public let value: String?

                enum CodingKeys: String, CodingKey {
                    case value
                }
            }

            public struct ImageFileContentText: Codable, Equatable {

                public let fildId: String

                enum CodingKeys: String, CodingKey {
                    case fildId = "file_id"
                }
            }
            
            public enum ContentType: String, Codable, Sendable {
                case text
                case imageFile = "image_file"
            }

            public let type: ContentType
            public let text: ThreadsMessageContentText?
            public let imageFile: ThreadsMessageContentText?

            enum CodingKeys: String, CodingKey {
                case type
                case text
                case imageFile = "image_file"
            }
        }

        public let id: String
        public let role: ChatQuery.ChatCompletionMessageParam.Role
        public let content: [ThreadsMessageContent]

        enum CodingKeys: String, CodingKey {
            case id
            case content
            case role
        }
    }

    public let data: [ThreadsMessage]

    enum CodingKeys: String, CodingKey {
        case data
    }
}
