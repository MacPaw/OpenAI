//
//  AudioTranscriptionResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranscriptionResult: Codable, Equatable, Sendable {
    
    public struct Word: Codable, Equatable, Sendable {
        /// The text content of the word.
        public let word: String
        /// Start time of the word in seconds.
        public let start: Float
        /// End time of the word in seconds.
        public let end: Float
    }
    
    public struct Segment: Codable, Equatable, Sendable {
        /// Unique identifier of the segment.
        public let id: Int
        /// Seek offset of the segment.
        public let seek: Int
        /// Start time of the segment in seconds.
        public let start: Float
        /// End time of the segment in seconds.
        public let end: Float
        /// Text content of the segment.
        public let text: String
        /// Array of token IDs for the text content.
        public let tokens: [Int]
        /// Temperature parameter used for generating the segment.
        public let temperature: Float
        /// Average logprob of the segment. If the value is lower than -1, consider the logprobs failed.
        public let avgLogprob: Float
        /// Compression ratio of the segment. If the value is greater than 2.4, consider the compression failed.
        public let compressionRatio: Float
        /// Probability of no speech in the segment. If the value is higher than 1.0 and the avg_logprob is below -1, consider this segment silent.
        public let noSpeechProb: Float
        
        enum CodingKeys: String, CodingKey {
            case id
            case seek
            case start
            case end
            case text
            case tokens
            case temperature
            case avgLogprob = "avg_logprob"
            case compressionRatio = "compression_ratio"
            case noSpeechProb = "no_speech_prob"
        }
    }
    
    /// The transcribed text.
    public let text: String
    
    
    public let task: String?
    
    /// The language of the input audio.
    public let language: String?
    
    /// The duration of the input audio.
    public let duration: Float?
    
    /// Extracted words and their corresponding timestamps.
    public let words: [Word]?
    
    /// Segments of the transcribed text and their corresponding details.
    public let segments: [Segment]?
    
    public init(
        task: String? = nil,
        language: String? = nil,
        duration: Float? = nil,
        text: String,
        words: [Word]? = nil,
        segments: [Segment]? = nil
    ) {
        self.task = task
        self.language = language
        self.duration = duration
        self.text = text
        self.words = words
        self.segments = segments
    }
}
