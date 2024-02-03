//
//  TranscriptionCreateParams.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct TranscriptionCreateParams: Codable {
    public typealias Model = AudioTranscriptionModel

    /// The audio file object (not file name) to transcribe, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
    public let file: Data
    public let fileType: Self.FileType
    /// ID of the model to use. Only whisper-1 is currently available.
    public let model: Self.Model
    /// The language of the input audio. Supplying the input language in ISO-639-1 format will improve accuracy and latency.
    /// https://platform.openai.com/docs/guides/speech-to-text/prompting
    public let language: String?
    /// An optional text to guide the model's style or continue a previous audio segment. The prompt should match the audio language.
    public let prompt: String?
    /// The format of the transcript output, in one of these options: json, text, srt, verbose_json, or vtt.
    /// Defaults to json
    public let response_format: Self.ResponseFormat?
    /// The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
    /// Defaults to 0
    public let temperature: Double?

    public init(
        file: Data,
        fileType: Self.FileType,
        model: Self.Model,
        language: String? = nil,
        prompt: String? = nil,
        response_format: Self.ResponseFormat? = nil,
        temperature: Double? = nil
    ) {
        self.file = file
        self.fileType = fileType
        self.model = model
        self.language = language
        self.prompt = prompt
        self.response_format = response_format
        self.temperature = temperature
    }

    public enum FileType: String, Codable, Equatable {
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
            case .m4a:
                fileName += Self.mp4.rawValue
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
            case .m4a:
                contentType += Self.mp4.rawValue
            default:
                contentType += self.rawValue
            }

            return contentType
        }}
    }

    public enum ResponseFormat: String, Codable, Equatable {
        case json
        case text
        case srt
        case verbose_json
        case vtt
    }
}

extension TranscriptionCreateParams: MultipartFormDataBodyEncodable {

    func encode(boundary: String) -> Data {
        var entries: [MultipartFormDataEntry] = [
            .file(paramName: "file", fileName: fileType.fileName, fileData: file, contentType: fileType.contentType),
            .string(paramName: "model", value: model.rawValue)]

        if language != nil {
            entries.append(.string(paramName: "language", value: language))
        }
        if prompt != nil {
            entries.append(.string(paramName: "prompt", value: prompt))
        }
        if response_format != nil {
            entries.append(.string(paramName: "response_format", value: response_format))
        }
        if temperature != nil {
            entries.append(.string(paramName: "temperature", value: temperature))
        }

        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: entries)

        return bodyBuilder.build()
    }
}
