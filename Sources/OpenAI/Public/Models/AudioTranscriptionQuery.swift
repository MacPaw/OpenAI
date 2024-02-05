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
    public let file_name: String
    public let model: Model
    public let response_format: Self.ResponseFormat?
    
    public let prompt: String?
    public let temperature: Double?
    public let language: String?
    
    public init(file: Data, file_name: String, model: Model, prompt: String? = nil, temperature: Double? = nil, language: String? = nil, response_format: Self.ResponseFormat? = nil) {
        self.file = file
        self.file_name = file_name
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.language = language
        self.response_format = response_format
    }
}

extension AudioTranscriptionQuery: MultipartFormDataBodyEncodable {
    
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "file", file_name: file_name, fileData: file, contentType: "audio/mpeg"),
            .string(paramName: "model", value: model),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "temperature", value: temperature),
            .string(paramName: "language", value: language),
            .string(paramName: "response_format", value: response_format)
        ])
        return bodyBuilder.build()
    }
}
