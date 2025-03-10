//
//  Model.swift
//
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

/// The model object matching the specified ID.
public struct ModelResult: Codable, Equatable {

    /// The model identifier, which can be referenced in the API endpoints.
    public let id: String
    /// The Unix timestamp (in seconds) when the model was created.
    public let created: TimeInterval?
    /// The object type, which is always "model".
    public let object: String
    /// The organization that owns the model.
    public let ownedBy: String

    public enum CodingKeys: String, CodingKey {
        case id
        case created
        case object
        case ownedBy = "owned_by"
    }
}
