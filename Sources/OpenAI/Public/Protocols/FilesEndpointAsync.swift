//
//  FilesEndpointAsync.swift
//  OpenAI
//

import Foundation

public protocol FilesEndpointAsync: Sendable {
    /// Upload a file that can be used across various endpoints. Individual files
    /// can be up to 512 MB, and each project can store up to 2.5 TB of files in
    /// total. There is no organization-wide storage limit. Uploads to this
    /// endpoint are rate-limited to 1,000 requests per minute per authenticated
    /// user.
    func create(query: CreateFileQuery) async throws -> OpenAIFile

    /// Returns information about a specific file.
    /// - Parameter id: The ID of the file to use for this request.
    func retrieve(id: String) async throws -> OpenAIFile

    /// Returns a list of files.
    func list(query: ListFilesQuery) async throws -> ListFilesResponse

    /// Delete a file and remove it from all vector stores.
    /// - Parameter id: The ID of the file to use for this request.
    func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse

    /// Returns a response containing the contents of the specified file.
    /// - Parameter id: The ID of the file to use for this request.
    func content(id: String) async throws -> Data
}

extension FilesEndpointAsync {
    /// Lists files with the API's default parameters: ``ListFilesQuery`` with no values set.
    public func list() async throws -> ListFilesResponse {
        try await list(query: .init())
    }
}
