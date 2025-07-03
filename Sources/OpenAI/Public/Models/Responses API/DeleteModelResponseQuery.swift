//
//  Delete.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.03.2025.
//

import Foundation

public struct DeleteModelResponseQuery: Codable, Equatable, Sendable {
    /// The ID of the response to delete.
    public let responseId: String
    
    private enum CodingKeys: String, CodingKey {
        case responseId = "response_id"
    }
}
