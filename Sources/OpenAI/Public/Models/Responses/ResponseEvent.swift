//
//  ResponseEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 06.04.2025.
//

import Foundation

/// An event that is emitted when a response is created.
public struct ResponseEvent: Codable, Equatable, Sendable {
    /// The response that was created.
    public let response: ResponseObject
    
    public let type: String

    public enum CodingKeys: String, CodingKey {
        case type
        case response
    }
}
