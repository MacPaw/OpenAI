//
//  AudioSpeechQuery.swift
//
//
//  Created by Ihor Makhnyk on 13.11.2023.
//

import Foundation

/// Generates audio from the input text.
/// Learn more: [OpenAI Speech – Documentation](https://platform.openai.com/docs/api-reference/audio/createSpeech)
public struct SpeechCreateParams: Codable {
    public typealias Model = SpeechModel

    /// The text to generate audio for. The maximum length is 4096 characters.
    public let input: String
    /// One of the available TTS models: tts-1 or tts-1-hd
    public let model: Self.Model
    /// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer. Previews of the voices are available in the Text to speech guide.
    /// https://platform.openai.com/docs/guides/text-to-speech/voice-options
    public let voice: Self.Voice
    /// The format to audio in. Supported formats are mp3, opus, aac, and flac.
    /// Defaults to mp3
    public let response_format: Self.ResponseFormat?
    /// The speed of the generated audio. Select a value from **0.25** to **4.0**. **1.0** is the default.
    /// Defaults to 1
    public let speed: Double?

    public init(
        input: String,
        model: Self.Model,
        voice: Self.Voice,
        response_format: Self.ResponseFormat? = nil,
        speed: Double? = nil
    ) {
        self.model = model
        self.speed = Self.normalizeSpeechSpeed(speed)
        self.input = input
        self.voice = voice
        self.response_format = response_format
    }

    /// Encapsulates the voices available for audio generation.
    ///
    /// To get aquinted with each of the voices and listen to the samples visit:
    /// [OpenAI Text-to-Speech – Voice Options](https://platform.openai.com/docs/guides/text-to-speech/voice-options)
    public enum Voice: String, Codable, CaseIterable {
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
    public enum ResponseFormat: String, Codable, CaseIterable {
        case mp3
        case opus
        case aac
        case flac
    }
}

private extension SpeechCreateParams {

    private enum Speed {
        static let normal = 1.0
        static let max = 4.0
        static let min = 0.25
    }

    static func normalizeSpeechSpeed(_ inputSpeed: Double?) -> Double {
        guard let inputSpeed else { return Self.Speed.normal }
        let isSpeedOutOfBounds = inputSpeed <= Self.Speed.min || Self.Speed.max <= inputSpeed
        guard !isSpeedOutOfBounds else {
            print("[AudioSpeech] Speed value must be between 0.25 and 4.0. Setting value to closest valid.")
            return inputSpeed < Self.Speed.min ? Self.Speed.min : Self.Speed.max
        }
        return inputSpeed
    }
}
