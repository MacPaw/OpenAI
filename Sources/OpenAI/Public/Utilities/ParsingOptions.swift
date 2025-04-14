//
//  ParsingOptions.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.03.2025.
//

import Foundation

public struct ParsingOptions: OptionSet, Sendable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let fillRequiredFieldIfKeyNotFound = ParsingOptions(rawValue: 1 << 0)
    public static let fillRequiredFieldIfValueNotFound = ParsingOptions(rawValue: 1 << 1)
    
    public static let relaxed: ParsingOptions = [.fillRequiredFieldIfKeyNotFound, .fillRequiredFieldIfValueNotFound]
}
