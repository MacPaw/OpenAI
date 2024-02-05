//
//  AudioTranslationQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranslationQuery: Codable, Equatable {
    public typealias ResponseFormat = AudioResponseFormat
    
    public let file: Data
    public let file_name: String
    public let model: Model
    
    public let response_format: Self.ResponseFormat?
    public let prompt: String?
    public let temperature: Double?
    
    public init(file: Data, file_name: String, model: Model, prompt: String? = nil, temperature: Double? = nil, response_format: Self.ResponseFormat? = nil) {
        self.file = file
        self.file_name = file_name
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.response_format = response_format
    }
}

extension AudioTranslationQuery: MultipartFormDataBodyEncodable {
    
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "file", fileName: file_name, fileData: file, contentType: "audio/mpeg"),
            .string(paramName: "model", value: model),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "response_format", value: response_format),
            .string(paramName: "temperature", value: temperature)
        ])
        return bodyBuilder.build()
    }
}
