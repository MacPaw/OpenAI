//
//  AudioTranslationResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 03/04/2023.
//

import Foundation

public struct AudioTranslationResult: Decodable, Equatable {

    /// The translated text.
    public let text: String

    public enum CodingKeys: CodingKey {
        case text
    }
}
