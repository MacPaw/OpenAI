//
//  AudioTranscriptionQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct AudioTranscriptionQuery: Codable, Equatable {
    
    public let file: Data
    public let fileName: String
    public let model: Model
    
    public let prompt: String?
    public let temperature: Double?
    public let language: String?
    
    public init(file: Data, fileName: String, model: Model, prompt: String?, temperature: Double?, language: String?) {
        self.file = file
        self.fileName = fileName
        self.model = model
        self.prompt = prompt
        self.temperature = temperature
        self.language = language
    }
}

extension AudioTranscriptionQuery: MultipartFormDataBodyEncodable {
    
    func encode(boundary: String) -> Data {
        let bodyBuilder = MutlipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "file", fileName: fileName, fileData: file, contentType: "audio/mpeg"),
            .string(paramName: "model", value: model),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "temperature", value: temperature),
            .string(paramName: "language", value: language)
        ])
        return bodyBuilder.build()
    }
}
