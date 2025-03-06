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
}
