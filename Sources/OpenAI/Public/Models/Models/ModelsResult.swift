//
//  ModelsResult.swift
//
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

/// A list of model objects.
public struct ModelsResult: Codable, Equatable, Sendable {

    /// A list of model objects.
    public let data: [ModelResult]
    /// The object type, which is always `list`
    public let object: String

    public init(data: [ModelResult], object: String) {
        self.data = data
        self.object = object
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsingOptions = decoder.userInfo[.parsingOptions] as? ParsingOptions ?? []
        self.data = try container.decode([ModelResult].self, forKey: .data)
        self.object = try container.decode(String.self, forKey: .object, parsingOptions: parsingOptions, defaultValue: "list")
    }
}
