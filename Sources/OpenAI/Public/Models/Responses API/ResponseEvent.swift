//
//  ResponseEvent.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 06.04.2025.
//

import Foundation

public struct ResponseEvent: Codable, Equatable, Sendable {
    public let response: ResponseObject
    public let sequenceNumber: Int
    public let type: String

    public enum CodingKeys: String, CodingKey {
        case response
        case sequenceNumber = "sequence_number"
        case type
    }
}
