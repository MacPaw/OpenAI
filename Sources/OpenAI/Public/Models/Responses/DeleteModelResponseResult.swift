//
//  DeleteModelResponseResult.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.03.2025.
//

import Foundation

public struct DeleteModelResponseResult: Codable, Equatable, Sendable {
    public let id: String
    public let object: String
    public let deleted: Bool
}
