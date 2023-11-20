//
//  AudioSpeechResult.swift
//
//
//  Created by Ihor Makhnyk on 13.11.2023.
//

import Foundation

public struct AudioSpeechResult {
    
    /// Audio data for one of the following formats :`mp3`, `opus`, `aac`, `flac`
    public let audioData: Data?
}
