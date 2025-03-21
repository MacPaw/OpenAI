//
//  FilesQuery.swift
//  
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

public struct FilesQuery: Codable, Sendable {

    public let purpose: String

    public let file: Data
    public let fileName: String

    public let contentType: String

    enum CodingKeys: String, CodingKey {
        case purpose
        case file
        case fileName
        case contentType
    }
    
    public init(purpose: String, file: Data, fileName: String, contentType: String) {
        self.purpose = purpose
        self.file = file
        self.fileName = fileName
        self.contentType = contentType
    }
}

extension FilesQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .string(paramName: "purpose", value: purpose),
            .file(paramName: "file", fileName: fileName, fileData: file, contentType: contentType),
        ])
        return bodyBuilder.build()
    }
}
