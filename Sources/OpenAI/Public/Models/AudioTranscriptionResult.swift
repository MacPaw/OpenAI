//
//  AudioTranscriptionResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranscriptionResult: Codable, Equatable {
    /// The task type (always "transcribe" for transcriptions)
    public let task: String?
    /// The detected language
    public let language: String?
    /// The duration of the audio in seconds
    public let duration: Double?
    /// The transcribed text
    public let text: String
    /// The segments containing detailed information (only present in verbose_json format)
    public let segments: [Segment]?

    public init(
        task: String? = nil,
        language: String? = nil,
        duration: Double? = nil,
        text: String,
        segments: [Segment]? = nil
    ) {
        self.task = task
        self.language = language
        self.duration = duration
        self.text = text
        self.segments = segments
    }
        
    public struct Segment: Codable, Equatable {
        public let id: Int
        public let seek: Int
        public let start: Double
        public let end: Double
        public let text: String
        public let tokens: [Int]
        public let temperature: Double
        public let avg_logprob: Double
        public let compression_ratio: Double
        public let no_speech_prob: Double
    }
}
