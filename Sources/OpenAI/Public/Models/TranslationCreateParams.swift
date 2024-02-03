//
//  TranslationCreateParams.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

/// Translates audio into English.
public struct TranslationCreateParams: Codable {
    public typealias FileType = TranscriptionCreateParams.FileType
    public typealias Model = AudioTranslationModel
    public typealias ResponseFormat = TranscriptionCreateParams.ResponseFormat

    /// The audio file object (not file name) translate, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
    public let file: Data
    public let fileType: Self.FileType
    /// ID of the model to use. Only whisper-1 is currently available.
    public let model: Self.Model
    /// An optional text to guide the model's style or continue a previous audio segment. The prompt should be in English.
    /// https://platform.openai.com/docs/guides/speech-to-text/prompting
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
        prompt: String? = nil,
        response_format: Self.ResponseFormat? = nil,
        temperature: Double? = nil
    ) {
        self.file = file
        self.fileType = fileType
        self.model = model
        self.prompt = prompt
        self.response_format = response_format
        self.temperature = temperature
    }
}

extension TranslationCreateParams: MultipartFormDataBodyEncodable {

    func encode(boundary: String) -> Data {
        var entries: [MultipartFormDataEntry] = [
            .file(paramName: "file", fileName: fileType.fileName, fileData: file, contentType: fileType.contentType),
            .string(paramName: "model", value: model.rawValue)]

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
