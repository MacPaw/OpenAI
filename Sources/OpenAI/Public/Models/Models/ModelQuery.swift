//
//  ModelQuery.swift
//  
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

public struct ModelQuery: Codable, Equatable {
    /// The ID of the model to use for this request.
    public let model: Model

    public init(model: Model) {
        self.model = model
    }
}
