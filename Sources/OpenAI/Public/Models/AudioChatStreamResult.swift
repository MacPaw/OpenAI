//
//  AudioChatStreamResult.swift
//
//
//  Created by OpenAI SDK Contributors.
//

import Foundation

/// A chunk of an audio chat completion stream response
public struct AudioChatStreamResult: Codable, Equatable, Sendable {
    /// A unique identifier for the chat completion
    public let id: String

    /// The object type, always "chat.completion.chunk"
    public let object: String

    /// The Unix timestamp (in seconds) of when the chat completion was created
    public let created: Int

    /// The model used for the chat completion
    public let model: Model

    /// A list of chat completion choices. Can be more than one if n > 1.
    public let choices: [Choice]

    /// The service tier used for processing the request
    public let serviceTier: String?

    /// This fingerprint represents the backend configuration that the model runs with
    public let systemFingerprint: String?

    enum CodingKeys: String, CodingKey {
        case id
        case object
        case created
        case model
        case choices
        case serviceTier = "service_tier"
        case systemFingerprint = "system_fingerprint"
    }

    public init(
        id: String,
        object: String,
        created: Int,
        model: Model,
        choices: [Choice],
        serviceTier: String? = nil,
        systemFingerprint: String? = nil
    ) {
        self.id = id
        self.object = object
        self.created = created
        self.model = model
        self.choices = choices
        self.serviceTier = serviceTier
        self.systemFingerprint = systemFingerprint
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsingOptions = decoder.userInfo[.parsingOptions] as? ParsingOptions ?? []
        self.id = try container.decodeString(forKey: .id, parsingOptions: parsingOptions)
        self.object = try container.decodeString(forKey: .object, parsingOptions: parsingOptions)
        self.created = try container.decode(Int.self, forKey: .created)
        self.model = try container.decode(Model.self, forKey: .model)
        self.choices = try container.decode([Choice].self, forKey: .choices)
        self.serviceTier = try container.decodeIfPresent(String.self, forKey: .serviceTier)
        self.systemFingerprint = try container.decodeIfPresent(String.self, forKey: .systemFingerprint)
    }

    public struct Choice: Codable, Equatable, Sendable {
        /// The index of the choice in the list of choices
        public let index: Int

        /// A chunk of the message being generated
        public let delta: Delta

        /// The reason the model stopped generating tokens
        public let finishReason: String?

        enum CodingKeys: String, CodingKey {
            case index
            case delta
            case finishReason = "finish_reason"
        }
    }

    /// Delta containing the incremental changes to the message
    public struct Delta: Codable, Equatable, Sendable {
        /// The role of the author of this message (only present in first chunk)
        public let role: String?

        /// The text content delta
        public let content: String?

        /// Audio output delta
        public let audio: AudioDelta?

        enum CodingKeys: String, CodingKey {
            case role
            case content
            case audio
        }
    }

    /// Incremental audio output
    public struct AudioDelta: Codable, Equatable, Sendable {
        /// Unique identifier for the audio response (only present in first audio chunk)
        public let id: String?

        /// Base64-encoded chunk of audio data
        public let data: String?

        /// Chunk of the transcript
        public let transcript: String?

        /// Unix timestamp when this audio data expires (only present in first audio chunk)
        public let expiresAt: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case data
            case transcript
            case expiresAt = "expires_at"
        }
    }
}
