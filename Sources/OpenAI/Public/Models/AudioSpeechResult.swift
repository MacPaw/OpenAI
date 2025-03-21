//
//  AudioSpeechResult.swift
//
//
//  Created by Ihor Makhnyk on 13.11.2023.
//

import Foundation

/// The audio file content.
/// Learn more: [OpenAI Speech – Documentation](https://platform.openai.com/docs/api-reference/audio/createSpeech)
public struct AudioSpeechResult: Codable, Equatable, Sendable {

    /// Audio data for one of the following formats :`mp3`, `opus`, `aac`, `flac`, `pcm`
    public let audio: Data
}
