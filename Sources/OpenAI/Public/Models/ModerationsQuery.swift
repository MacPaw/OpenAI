//
//  ModerationsQuery.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationsQuery: Codable, Sendable {
    /// The input text to classify.
    public let input: String
    /// ID of the model to use.
    public let model: Model?

    public init(input: String, model: Model? = nil) {
        self.input = input
        self.model = model
    }
}
