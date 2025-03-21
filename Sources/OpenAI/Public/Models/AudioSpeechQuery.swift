//
//  AudioSpeechQuery.swift
//  
//
//  Created by Ihor Makhnyk on 13.11.2023.
//

import Foundation

/// Generates audio from the input text.
/// Learn more: [OpenAI Speech – Documentation](https://platform.openai.com/docs/api-reference/audio/createSpeech)
public struct AudioSpeechQuery: Codable, Sendable {
    
    /// Encapsulates the voices available for audio generation.
    ///
    /// To get aquinted with each of the voices and listen to the samples visit:
    /// [OpenAI Text-to-Speech – Voice Options](https://platform.openai.com/docs/guides/text-to-speech/voice-options)
    /// Hear and play with these voices in https://openai.fm/
    public enum AudioSpeechVoice: String, Codable, CaseIterable, Sendable {
        case alloy
        case ash
        case ballad
        case coral
        case echo
        case fable
        case onyx
        case nova
        case sage
        case shimmer
    }
    
    /// Encapsulates the response formats available for audio data.
    ///
    /// **Formats:**
    /// -  mp3
    /// -  opus
    /// -  aac
    /// -  flac
    /// -  wav
    /// -  pcm
    public enum AudioSpeechResponseFormat: String, Codable, CaseIterable, Sendable {
        case mp3
        case opus
        case aac
        case flac
        case wav
        case pcm
    }
    /// The text to generate audio for. The maximum length is 4096 characters.
    public let input: String
    /// One of the available TTS models: tts-1 or tts-1-hd
    public let model: Model
    /// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer. Previews of the voices are available in the Text to speech guide.
    /// https://platform.openai.com/docs/guides/text-to-speech/voice-options
    public let voice: AudioSpeechVoice
    /// The format to audio in. Supported formats are mp3, opus, aac, flac, and pcm.
    /// Defaults to mp3
    public let responseFormat: AudioSpeechResponseFormat?
    /// The speed of the generated audio. Select a value from **0.25** to **4.0**. **1.0** is the default.
    /// Defaults to 1
    public let speed: Double?
    ///  Control the voice of your generated audio with additional instructions. Does not work with tts-1 or tts-1-hd.
    public let instructions: String?

    public enum CodingKeys: String, CodingKey {
        case model
        case input
        case voice
        case responseFormat = "response_format"
        case speed
        case instructions
    }

    public init(model: Model, input: String, voice: AudioSpeechVoice, instructions: String = "", responseFormat: AudioSpeechResponseFormat = .mp3, speed: Double = 1.0) {
        self.model = AudioSpeechQuery.validateSpeechModel(model)
        self.speed = AudioSpeechQuery.normalizeSpeechSpeed(speed)
        self.input = input
        self.voice = voice
        self.responseFormat = responseFormat
        self.instructions = instructions
    }
}

private extension AudioSpeechQuery {
    
    static func validateSpeechModel(_ inputModel: Model) -> Model {
        let isModelOfIncorrentFormat = inputModel != .tts_1 && inputModel != .tts_1_hd && inputModel != .gpt_4o_mini_tts
        guard !isModelOfIncorrentFormat else {
            print("[AudioSpeech] 'AudioSpeechQuery' must have a valid Text-To-Speech model, 'tts-1' or 'tts-1-hd', or 'gpt-4o-mini-tts'. Setting model to 'tts-1'.")
            return .tts_1
        }
        return inputModel
    }
}

public extension AudioSpeechQuery {

    enum Speed: Double {
        case normal = 1.0
        case max = 4.0
        case min = 0.25
    }

    static func normalizeSpeechSpeed(_ inputSpeed: Double?) -> Double {
        guard let inputSpeed = inputSpeed else { return Self.Speed.normal.rawValue }
        let isSpeedOutOfBounds = inputSpeed <= Self.Speed.min.rawValue || Self.Speed.max.rawValue <= inputSpeed
        guard !isSpeedOutOfBounds else {
            print("[AudioSpeech] Speed value must be between 0.25 and 4.0. Setting value to closest valid.")
            return inputSpeed < Self.Speed.min.rawValue ? Self.Speed.min.rawValue : Self.Speed.max.rawValue
        }
        return inputSpeed
    }
}
