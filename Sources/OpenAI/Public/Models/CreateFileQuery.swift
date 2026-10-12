//
//  CreateFileQuery.swift
//
//
//  Created by Chris Dillard on 11/07/2023.
//

import Foundation

@available(*, deprecated, renamed: "CreateFileQuery")
public typealias FilesQuery = CreateFileQuery

/// Parameters for ``FilesEndpointProtocol/create(query:completion:)``.
/// https://platform.openai.com/docs/api-reference/files/create
public struct CreateFileQuery: Codable, Sendable {

    /// The intended purpose of the uploaded file. One of:
    /// - `assistants`: Used in the Assistants API
    /// - `batch`: Used in the Batch API
    /// - `fine-tune`: Used for fine-tuning
    /// - `vision`: Images used for vision fine-tuning
    /// - `user_data`: Flexible file type for any purpose
    /// - `evals`: Used for eval data sets
    public let purpose: String

    /// The File object (not file name) to be uploaded.
    public let file: Data
    public let fileName: String

    public let contentType: String

    /// The expiration policy for a file. By default, files with `purpose=batch` expire after 30 days and all other
    /// files are persisted until they are manually deleted.
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
