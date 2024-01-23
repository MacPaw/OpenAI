//
//  AudioTranscriptionQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public enum AudioResponseFormat: String, Codable, Equatable {
    case json
    case text
    case verboseJson = "verbose_json"
    case srt
    case vtt
}

public struct AudioTranscriptionQuery: Codable, Equatable {
    public typealias ResponseFormat = AudioResponseFormat
    
    public let file: Data
    public let fileName: String
    public let model: AudioTranscriptionModel
    public let responseFormat: Self.ResponseFormat?
    
    public let prompt: String?
    public let temperature: Double?
    public let language: String?
    
    public init(file: Data, fileName: String, model: AudioTranscriptionModel, prompt: String? = nil, temperature: Double? = nil, language: String? = nil, responseFormat: Self.ResponseFormat? = nil) {
        self.file = file
        self.fileName = fileName
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.language = language
        self.responseFormat = responseFormat
    }
}

extension AudioTranscriptionQuery: MultipartFormDataBodyEncodable {
    
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "file", fileName: fileName, fileData: file, contentType: "audio/mpeg"),
            .string(paramName: "model", value: model),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "temperature", value: temperature),
            .string(paramName: "language", value: language),
            .string(paramName: "response_format", value: responseFormat)
        ])
        return bodyBuilder.build()
    }
}
