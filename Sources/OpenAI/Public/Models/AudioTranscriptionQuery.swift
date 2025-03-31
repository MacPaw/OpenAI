//
//  AudioTranscriptionQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranscriptionQuery: Codable {
    
    public enum TimestampGranularities: String, Codable, Equatable, CaseIterable {
        case word
        case segment
    }

    public enum ResponseFormat: String, Codable, Equatable, CaseIterable {
        case json
        case text
        case verboseJson = "verbose_json"
        case srt
        case vtt
    }

    /// The audio file object (not file name) to transcribe, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
    public let file: Data
    public let fileType: Self.FileType
    /// ID of the model to use. Only whisper-1 is currently available.
    public let model: Model
    /// The format of the transcript output, in one of these options: json, text, srt, verbose_json, or vtt.
    /// Defaults to json
    public let responseFormat: Self.ResponseFormat?
    /// An optional text to guide the model's style or continue a previous audio segment. The prompt should match the audio language.
    public let prompt: String?
    /// The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
    /// Defaults to 0
    public let temperature: Double?
    /// The language of the input audio. Supplying the input language in ISO-639-1 format will improve accuracy and latency.
    /// https://platform.openai.com/docs/guides/speech-to-text/prompting
    public let language: String?
    /// The timestamp granularities to populate for this transcription. response_format must be set verbose_json to use timestamp granularities. Either or both of these options are supported: word, or segment. Note: There is no additional latency for segment timestamps, but generating word timestamps incurs additional latency.
    /// Defaults to segment
    public let timestampGranularities: [Self.TimestampGranularities]

    public init(file: Data, fileType: Self.FileType, model: Model, prompt: String? = nil, temperature: Double? = nil, language: String? = nil, responseFormat: Self.ResponseFormat? = nil, timestampGranularities: [Self.TimestampGranularities] = []) {
        self.file = file
        self.fileType = fileType
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.language = language
        self.responseFormat = responseFormat
        self.timestampGranularities = timestampGranularities
    }

    public enum FileType: String, Codable, Equatable, CaseIterable {
        case flac
        case mp3, mpga
        case mp4, m4a
        case mpeg
        case ogg
        case wav
        case webm

        var fileName: String { get {
            var fileName = "speech."
            switch self {
            case .mpga:
                fileName += Self.mp3.rawValue
            default:
                fileName += self.rawValue
            }

            return fileName
        }}

        var contentType: String { get {
            var contentType = "audio/"
            switch self {
            case .mpga:
                contentType += Self.mp3.rawValue
            default:
                contentType += self.rawValue
            }

            return contentType
        }}
    }
}

extension AudioTranscriptionQuery: MultipartFormDataBodyEncodable {
    
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "file", fileName: fileType.fileName, fileData: file, contentType: fileType.contentType),
            .string(paramName: "model", value: model),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "temperature", value: temperature),
            .string(paramName: "language", value: language),
            .string(paramName: "response_format", value: responseFormat?.rawValue),
            ] + timestampGranularities.map({.string(paramName: "timestamp_granularities[]", value: $0)})
        )
        
        return bodyBuilder.build()
    }
}
