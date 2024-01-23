//
//  ModerationsQuery.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationsQuery: Codable {
    /// The input text to classify.
    public let input: String
    /// ID of the model to use.
    public let model: ModerationsModel?

    public init(input: String, model: ModerationsModel? = nil) {
        self.input = input
        self.model = model
    }
}
