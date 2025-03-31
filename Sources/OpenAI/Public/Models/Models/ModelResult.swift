//
//  Model.swift
//
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

/// The model object matching the specified ID.
public struct ModelResult: Codable, Equatable, Sendable {

    /// The model identifier, which can be referenced in the API endpoints.
    public let id: String
    /// The Unix timestamp (in seconds) when the model was created.
    public let created: TimeInterval
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
    
    public init(id: String, created: TimeInterval, object: String, ownedBy: String) {
        self.id = id
        self.created = created
        self.object = object
        self.ownedBy = ownedBy
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsingOptions = decoder.userInfo[.parsingOptions] as? ParsingOptions ?? []
        self.id = try container.decode(String.self, forKey: .id)
        self.created = try container.decodeTimeInterval(forKey: .created, parsingOptions: parsingOptions)
        self.object = try container.decode(String.self, forKey: .object)
        self.ownedBy = try container.decode(String.self, forKey: .ownedBy)
    }
}
