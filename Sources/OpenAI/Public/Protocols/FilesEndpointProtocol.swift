//
//  FilesEndpointProtocol.swift
//  OpenAI
//

import Foundation

/// The [Files API](https://platform.openai.com/docs/api-reference/files).
///
/// Uploading a file is ``OpenAIProtocol/files(query:completion:)``.
public protocol FilesEndpointProtocol: FilesEndpointModern {
    /// Downloads the contents of a file, for example the JSONL output of a batch.
    @discardableResult
    func content(
        id: String,
        completion: @escaping @Sendable (Result<Data, Error>) -> Void
    ) -> CancellableRequest

    /// Deletes a file.
    @discardableResult
    func delete(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void
    ) -> CancellableRequest
}
