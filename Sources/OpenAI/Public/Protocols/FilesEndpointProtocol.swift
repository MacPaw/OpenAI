//
//  FilesEndpointProtocol.swift
//  OpenAI
//

import Foundation

/// The [Files API](https://platform.openai.com/docs/api-reference/files): upload files for use with other APIs,
/// such as the Batch API, and manage them.
public protocol FilesEndpointProtocol: FilesEndpointModern {
    /// Uploads a file.
    @discardableResult
    func create(
        query: CreateFileQuery,
        completion: @escaping @Sendable (Result<Components.Schemas.OpenAIFile, Error>) -> Void
    ) -> CancellableRequest

    /// Retrieves information about a file.
    @discardableResult
    func retrieve(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.OpenAIFile, Error>) -> Void
    ) -> CancellableRequest

    /// Lists your organization's files.
    @discardableResult
    func list(
        query: ListFilesQuery,
        completion: @escaping @Sendable (Result<Components.Schemas.ListFilesResponse, Error>) -> Void
    ) -> CancellableRequest

    /// Deletes a file.
    @discardableResult
    func delete(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void
    ) -> CancellableRequest

    /// Downloads the contents of a file, for example the JSONL output of a batch.
    @discardableResult
    func content(
        id: String,
        completion: @escaping @Sendable (Result<Data, Error>) -> Void
    ) -> CancellableRequest
}

extension FilesEndpointProtocol {
    /// Lists your organization's files with the API's default parameters.
    @discardableResult
    public func list(
        completion: @escaping @Sendable (Result<Components.Schemas.ListFilesResponse, Error>) -> Void
    ) -> CancellableRequest {
        list(query: .init(), completion: completion)
    }
}
