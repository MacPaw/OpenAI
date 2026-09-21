//
//  CancelModelResponseQuery.swift
//  OpenAI
//
//  Created by Tqtifnypmb on 2026/8/8.
//

import Foundation

/// Cancels a model response with the given ID. Only responses created with the background parameter set to true can be cancelled.
public struct CancelModelResponseQuery: Codable, Equatable, Sendable {
    /// The ID of the response to cancel.
    public let responseId: String
    
    public init(responseId: String) {
        self.responseId = responseId
    }
    
    private enum CodingKeys: String, CodingKey {
        case responseId = "response_id"
    }
}
