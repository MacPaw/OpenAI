//
//  ModelsResponse.swift
//
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

/// A list of model objects.
public struct ModelsResponse: Codable, Equatable {
    
    /// A list of model objects.
    public let data: [Model]
    /// The object type, which is always `list`
    public let object: String
}
