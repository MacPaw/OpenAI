//
//  AudioTranscriptionResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranscriptionResult: Codable, Equatable {

    /// The transcribed text.
    public let text: String
}
