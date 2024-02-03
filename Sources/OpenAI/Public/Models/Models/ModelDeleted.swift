//
//  ModelDeleted.swift
//
//
//  Created by James J Kalafus on 2024-01-29.
//

import Foundation

public struct ModelDeleted: Codable, Equatable {

    public let id: String
    public let deleted: Bool
    public let object: String
}

extension ModelDeleted: Identifiable {}
