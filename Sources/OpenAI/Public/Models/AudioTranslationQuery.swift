//
//  AudioTranslationQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

/// Translates audio into English.
public struct AudioTranslationQuery: Codable, Sendable {
    public typealias FileType = AudioTranscriptionQuery.FileType
    public typealias ResponseFormat = AudioTranscriptionQuery.ResponseFormat

    /// The audio file object (not file name) translate, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
    public let file: Data
    public let fileType: Self.FileType
    /// ID of the model to use. Only whisper-1 is currently available.
    public let model: Model
    /// The format of the transcript output, in one of these options: json, text, srt, verbose_json, or vtt.
    /// Defaults to json
    public let responseFormat: Self.ResponseFormat?
    /// An optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.
    /// https://platform.openai.com/docs/guides/speech-to-text/prompting
    public let prompt: String?
    /// The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
    /// Defaults to 0
    public let temperature: Double?
    
    public init(file: Data, fileType: Self.FileType, model: Model, prompt: String? = nil, temperature: Double? = nil, responseFormat: Self.ResponseFormat? = nil) {
        self.file = file
        self.fileType = fileType
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.responseFormat = responseFormat
    }
}

extension AudioTranslationQuery: MultipartFormDataBodyEncodable {
    
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "file", fileName: fileType.fileName, fileData: file, contentType: fileType.contentType),
            .string(paramName: "model", value: model),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "response_format", value: responseFormat),
            .string(paramName: "temperature", value: temperature)
        ])
        return bodyBuilder.build()
    }
}
