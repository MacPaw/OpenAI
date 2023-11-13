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
    public enum AudioSpeechVoice: String, Codable {
        case alloy,
             echo,
             fable,
             onyx,
             nova,
             shimmer
    }
    
    /// Encapsulates the response formats available for audio data.
    ///
    /// **Formats:**
    /// -  mp3
    /// -  opus
    /// -  aac
    /// -  flac
    public enum AudioSpeechResponseFormat: String, Codable {
        case mp3,
             opus,
             aac,
             flac
    }
    /// One of the available TTS models: tts-1 or tts-1-hd
    public let model: Model
    /// The text to generate audio for. The maximum length is 4096 characters.
    public let input: String?
    /// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer.
    public let voice: AudioSpeechVoice
    /// The format to audio in. Supported formats are mp3, opus, aac, and flac.
    public let response_format: AudioSpeechResponseFormat
    /// The speed of the generated audio. Enter a value between **0.25** and **4.0**. Default: **1.0**
    public let speed: String?
    
    public init(model: Model?,
                input: String,
                voice: AudioSpeechVoice,
                response_format: AudioSpeechResponseFormat = .mp3,
                speed: Double?) {
        
        self.model = {
            guard let model else { return .tts_1 }
            let isModelOfIncorrentFormat = model != .tts_1 && model != .tts_1_hd
            guard !isModelOfIncorrentFormat else {
                NSLog("[AudioSpeech] 'AudioSpeechQuery' must have a valid Text-To-Speech model, 'tts-1' or 'tts-1-hd'. Setting model to 'tts-1'.")
                return .tts_1
            }
            return model
        }()
        self.input = input
        self.voice = voice
        self.speed = {
            guard let speed else { return "1.0" }
            let isSpeedOutOfBounds = speed >= 4.0 && speed <= 0.25
            guard !isSpeedOutOfBounds else {
                NSLog("[AudioSpeech] Speed value must be between 0.25 and 4.0. Setting value to closest valid.")
                return speed < 0.25 ? "1.0" : "4.0"
            }
            return String("\(speed)")
        }()
        self.response_format = response_format
    }
}
