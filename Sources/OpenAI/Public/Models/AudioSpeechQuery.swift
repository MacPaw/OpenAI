//
//  AudioSpeechQuery.swift
//  
//
//  Created by Ihor Makhnyk on 13.11.2023.
//

import Foundation

/// Learn more: [OpenAI Speech – Documentation](https://platform.openai.com/docs/api-reference/audio/createSpeech)
public struct AudioSpeechQuery: Codable, Equatable {
    
    /// Encapsulates the voices available for audio generation.
    ///
    /// To get aquinted with each of the voices and listen to the samples visit:
    /// [OpenAI Text-to-Speech – Voice Options](https://platform.openai.com/docs/guides/text-to-speech/voice-options)
    public enum AudioSpeechVoice: String, Codable, CaseIterable {
        case alloy
        case echo
        case fable
        case onyx
        case nova
        case shimmer
    }
    
    /// Encapsulates the response formats available for audio data.
    ///
    /// **Formats:**
    /// -  mp3
    /// -  opus
    /// -  aac
    /// -  flac
    public enum AudioSpeechResponseFormat: String, Codable, CaseIterable {
        case mp3
        case opus
        case aac
        case flac
    }
    /// One of the available TTS models: tts-1 or tts-1-hd
    public let model: AudioSpeechModel
    /// The text to generate audio for. The maximum length is 4096 characters.
    public let input: String?
    /// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer.
    public let voice: AudioSpeechVoice
    /// The format to audio in. Supported formats are mp3, opus, aac, and flac.
    public let responseFormat: AudioSpeechResponseFormat
    /// The speed of the generated audio. Enter a value between **0.25** and **4.0**. Default: **1.0**
    public let speed: Double?
    
    public enum CodingKeys: String, CodingKey {
        case model
        case input
        case voice
        case responseFormat = "response_format"
        case speed
    }
    
    private enum Constants {
        static let normalSpeed = 1.0
        static let maxSpeed = 4.0
        static let minSpeed = 0.25
    }
    
    public init(model: AudioSpeechModel, input: String, voice: AudioSpeechVoice, responseFormat: AudioSpeechResponseFormat = .mp3, speed: Double? = nil) {
        self.model = model
        self.speed = AudioSpeechQuery.normalizeSpeechSpeed(speed)
        self.input = input
        self.voice = voice
        self.responseFormat = responseFormat
    }
}

private extension AudioSpeechQuery {

    private enum Speed {
        static let normal = 1.0
        static let max = 4.0
        static let min = 0.25
    }

    static func normalizeSpeechSpeed(_ inputSpeed: Double?) -> Double {
        guard let inputSpeed else { return Self.Speed.normal }
        let isSpeedOutOfBounds = inputSpeed <= Self.Speed.min || Self.Speed.max <= inputSpeed
        guard !isSpeedOutOfBounds else {
            print("[AudioSpeech] Speed value must be between \(Speed.min) and \(Speed.max). Setting value to closest valid.")
            return inputSpeed < Self.Speed.min ? Self.Speed.min : Self.Speed.max
        }
        return inputSpeed
    }
}
