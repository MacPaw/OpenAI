//
//  ModelQuery.swift
//  
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

/// Retrieves a model instance, providing basic information about the model such as the owner and permissioning.
public struct ModelQuery: Codable, Equatable {
    /// The ID of the model to use for this request.
    public let model: Model

    public init(model: Model) {
        self.model = model
    }
}
