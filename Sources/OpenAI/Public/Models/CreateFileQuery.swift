//
//  CreateFileQuery.swift
//
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

@available(*, deprecated, renamed: "CreateFileQuery")
public typealias FilesQuery = CreateFileQuery

/// Uploads a file. https://platform.openai.com/docs/api-reference/files/create
public struct CreateFileQuery: Codable, Sendable {

    /// The intended purpose of the file: `assistants`, `batch`, `fine-tune`, `vision`, `user_data` or `evals`.
    public let purpose: String

    public let file: Data
    public let fileName: String

    public let contentType: String

    /// When the file expires. By default, files with purpose `batch` expire after 30 days and all others are kept
    /// until you delete them.
    public let expiresAfter: Components.Schemas.FileExpirationAfter?

    enum CodingKeys: String, CodingKey {
        case purpose
        case file
        case fileName
        case contentType
        case expiresAfter
    }

    public init(purpose: String, file: Data, fileName: String, contentType: String) {
        self.init(purpose: purpose, file: file, fileName: fileName, contentType: contentType, expiresAfter: nil)
    }

    public init(
        purpose: String,
        file: Data,
        fileName: String,
        contentType: String,
        expiresAfter: Components.Schemas.FileExpirationAfter?
    ) {
        self.purpose = purpose
        self.file = file
        self.fileName = fileName
        self.contentType = contentType
        self.expiresAfter = expiresAfter
    }
}

extension CreateFileQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .string(paramName: "purpose", value: purpose),
            .file(paramName: "file", fileName: fileName, fileData: file, contentType: contentType),
            .string(paramName: "expires_after[anchor]", value: expiresAfter?.anchor.rawValue),
            .string(paramName: "expires_after[seconds]", value: expiresAfter?.seconds),
        ])
        return bodyBuilder.build()
    }
}
