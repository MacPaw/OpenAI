//
//  AudioTranscriptionResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranscriptionResult: Codable, Equatable, Sendable {
    /// The transcribed text.
    public let text: String
    /// The log probabilities of the tokens in the transcription. Only returned with the models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added to the `include` array.
    public let logprobs: Components.Schemas.CreateTranscriptionResponseJson.LogprobsPayload?
    
    init(
        text: String,
        logprobs: Components.Schemas.CreateTranscriptionResponseJson.LogprobsPayload? = nil
    ) {
        self.text = text
        self.logprobs = logprobs
    }
}
