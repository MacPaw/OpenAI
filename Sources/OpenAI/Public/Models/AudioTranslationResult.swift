//
//  AudioTranslationResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 03/04/2023.
//

import Foundation

public struct AudioTranslationResult: Codable, Equatable, Sendable {

    /// The translated text.
    public let text: String
}
