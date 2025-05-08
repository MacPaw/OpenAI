//
//  AudioTranscriptionStreamResult.swift
//  
//
//  Created by Simon Liang on 08/05/2025.
//

import Foundation

public struct AudioTranscriptionStreamResult: Codable, Equatable, Sendable {
    /// The type of the event.
    public let type: EventType
    
    /// The text delta that was additionally transcribed. Only present for "transcript.text.delta" events.
    public let delta: String?
    
    /// The complete transcription text. Only present for "transcript.text.done" events.
    public let text: String?
    
    /// The log probabilities of the individual tokens in the transcription. Only included if you
    /// create a transcription with the include[] parameter set to logprobs.
    public let logprobs: [LogProb]?
    
    public enum EventType: String, Codable, Equatable, CaseIterable, Sendable {
        case delta = "transcript.text.delta"
        case done = "transcript.text.done"
    }
    
    public struct LogProb: Codable, Equatable, Sendable {
        /// The token.
        public let token: String
        /// A list of integers representing the UTF-8 bytes representation of the token.
        public let bytes: [Int]?
        /// The log probability of this token.
        public let logprob: Double
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let parsingOptions = decoder.userInfo[.parsingOptions] as? ParsingOptions ?? []
        
        let typeString = try container.decodeString(forKey: .type, parsingOptions: parsingOptions)
        self.type = EventType(rawValue: typeString) ?? .delta
        self.delta = try container.decodeIfPresent(String.self, forKey: .delta)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.logprobs = try container.decodeIfPresent([LogProb].self, forKey: .logprobs)
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case delta
        case text
        case logprobs
    }
}
