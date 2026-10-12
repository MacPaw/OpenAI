//
//  FilesEndpointProtocol.swift
//  OpenAI
//

import Foundation

/// Files are used to upload documents that can be used with features like Assistants and Fine-tuning.
///
/// [Files API reference](https://platform.openai.com/docs/api-reference/files)
public protocol FilesEndpointProtocol: FilesEndpointModern {
    /// Upload a file that can be used across various endpoints. Individual files
    /// can be up to 512 MB, and each project can store up to 2.5 TB of files in
    /// total. There is no organization-wide storage limit. Uploads to this
    /// endpoint are rate-limited to 1,000 requests per minute per authenticated
    /// user.
    @discardableResult
    func create(
        query: CreateFileQuery,
        completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void
    ) -> CancellableRequest

    /// Returns information about a specific file.
    /// - Parameter id: The ID of the file to use for this request.
    @discardableResult
    func retrieve(
        id: String,
        completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void
    ) -> CancellableRequest

    /// Returns a list of files.
    @discardableResult
    func list(
        query: ListFilesQuery,
        completion: @escaping @Sendable (Result<ListFilesResponse, Error>) -> Void
    ) -> CancellableRequest

    /// Delete a file and remove it from all vector stores.
    /// - Parameter id: The ID of the file to use for this request.
    @discardableResult
    func delete(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void
    ) -> CancellableRequest

    /// Returns a response containing the contents of the specified file.
    /// - Parameter id: The ID of the file to use for this request.
    @discardableResult
    func content(
        id: String,
        completion: @escaping @Sendable (Result<Data, Error>) -> Void
    ) -> CancellableRequest
}

extension FilesEndpointProtocol {
    /// Lists files with the API's default parameters: ``ListFilesQuery`` with no values set.
    @discardableResult
    public func list(
        completion: @escaping @Sendable (Result<ListFilesResponse, Error>) -> Void
    ) -> CancellableRequest {
        list(query: .init(), completion: completion)
    }
}
