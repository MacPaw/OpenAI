//
//  AudioChatQuery.swift
//
//
//  Created by OpenAI SDK Contributors.
//

import Foundation

/// Creates an audio chat completion request for the gpt-4o-audio-preview model
/// Enables audio-to-audio conversations with a single API call, replacing the traditional STT→Chat→TTS pipeline
///
/// **Format Requirements:**
/// - Input audio: Only `wav` and `mp3` formats are supported
/// - Output audio: `wav`, `mp3`, `flac`, `opus`, `pcm16` are supported
/// - Recommended for streaming: Use `pcm16` for output to get optimal performance
///
/// https://platform.openai.com/docs/guides/audio
public struct AudioChatQuery: Codable, Equatable, Streamable, Sendable {

    /// ID of the model to use. Currently only `gpt-4o-audio-preview` and its variants support audio chat.
    public let model: Model

    /// A list of messages comprising the conversation so far.
    public let messages: [Message]

    /// Output types to enable for this request. Can include text and audio.
    /// Defaults to [.text, .audio]
    public let modalities: [Modality]?

    /// Configuration for audio output
    public let audio: AudioConfig?

    /// What sampling temperature to use, between 0 and 2.
    /// Defaults to 1
    public let temperature: Double?

    /// The maximum number of tokens to generate in the completion.
    public let maxTokens: Int?

    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency.
    /// Defaults to 0
    public let frequencyPenalty: Double?

    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text.
    /// Defaults to 0
    public let presencePenalty: Double?

    /// Up to 4 sequences where the API will stop generating further tokens.
    public let stop: [String]?

    /// If specified, our system will make a best effort to sample deterministically.
    public let seed: Int?

    /// If set to true, the response will be streamed as Server-Sent Events.
    /// Defaults to false
    public var stream: Bool

    public init(
        model: Model,
        messages: [Message],
        modalities: [Modality]? = [.text, .audio],
        audio: AudioConfig? = nil,
        temperature: Double? = nil,
        maxTokens: Int? = nil,
        frequencyPenalty: Double? = nil,
        presencePenalty: Double? = nil,
        stop: [String]? = nil,
        seed: Int? = nil,
        stream: Bool = false
    ) {
        self.model = model
        self.messages = messages
        self.modalities = modalities
        self.audio = audio
        self.temperature = temperature
        self.maxTokens = maxTokens
        self.frequencyPenalty = frequencyPenalty
        self.presencePenalty = presencePenalty
        self.stop = stop
        self.seed = seed
        self.stream = stream
    }

    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case modalities
        case audio
        case temperature
        case maxTokens = "max_tokens"
        case frequencyPenalty = "frequency_penalty"
        case presencePenalty = "presence_penalty"
        case stop
        case seed
        case stream
    }

    /// Audio output configuration
    public struct AudioConfig: Codable, Equatable, Sendable {
        /// The voice to use for audio output
        public let voice: Voice

        /// The format of the audio output
        /// Default is pcm16 which is optimal for streaming
        public let format: AudioFormat

        public init(voice: Voice = .alloy, format: AudioFormat = .pcm16) {
            self.voice = voice
            self.format = format
        }

        enum CodingKeys: String, CodingKey {
            case voice
            case format
        }

        /// Voice options for audio output
        public enum Voice: String, Codable, Sendable {
            case alloy
            case echo
            case fable
            case onyx
            case nova
            case shimmer
        }
    }

    /// A message in the conversation
    public struct Message: Codable, Equatable, Sendable {
        /// The role of the message author (system, user, assistant)
        public let role: ChatQuery.ChatCompletionMessageParam.Role

        /// The content of the message
        public let content: Content

        public init(role: ChatQuery.ChatCompletionMessageParam.Role, content: Content) {
            self.role = role
            self.content = content
        }

        enum CodingKeys: String, CodingKey {
            case role
            case content
        }

        /// Message content can be either simple text or an array of content parts
        public enum Content: Codable, Equatable, Sendable {
            case text(String)
            case parts([ContentPart])

            public init(from decoder: Decoder) throws {
                let container = try decoder.singleValueContainer()

                if let text = try? container.decode(String.self) {
                    self = .text(text)
                } else if let parts = try? container.decode([ContentPart].self) {
                    self = .parts(parts)
                } else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Content must be either a string or an array of parts"
                    )
                }
            }

            public func encode(to encoder: Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .text(let text):
                    try container.encode(text)
                case .parts(let parts):
                    try container.encode(parts)
                }
            }
        }

        /// A content part can be text or audio input
        public struct ContentPart: Codable, Equatable, Sendable {
            public let type: String
            public let text: String?
            public let inputAudio: InputAudio?

            /// Create a text content part
            public init(text: String) {
                self.type = "text"
                self.text = text
                self.inputAudio = nil
            }

            /// Create an audio input content part
            public init(inputAudio: InputAudio) {
                self.type = "input_audio"
                self.text = nil
                self.inputAudio = inputAudio
            }

            enum CodingKeys: String, CodingKey {
                case type
                case text
                case inputAudio = "input_audio"
            }
        }

        /// Audio input data
        public struct InputAudio: Codable, Equatable, Sendable {
            /// Base64-encoded audio data
            public let data: String

            /// Format of the audio data
            /// Note: Only wav and mp3 are supported for input audio
            public let format: AudioFormat

            public init(data: String, format: AudioFormat = .wav) {
                self.data = data
                self.format = format
            }

            enum CodingKeys: String, CodingKey {
                case data
                case format
            }
        }
    }
}

/// Audio format options for both input and output
///
/// **Input audio formats:** Only `wav` and `mp3` are supported
/// **Output audio formats:** `wav`, `mp3`, `flac`, `opus`, `pcm16`
/// **Recommended for streaming:** Use `pcm16` for output to get optimal streaming performance
public enum AudioFormat: String, Codable, Sendable {
    case wav
    case mp3
    case flac
    case opus
    case pcm16
}

/// Output modality options for audio chat requests
///
/// Specifies which types of output the model should generate
public enum Modality: String, Codable, Sendable {
    /// Text output
    case text
    /// Audio output
    case audio
}
