//
//  FilesEndpointAsync.swift
//  OpenAI
//

import Foundation

public protocol FilesEndpointAsync: Sendable {
    /// Uploads a file.
    func create(query: CreateFileQuery) async throws -> Components.Schemas.OpenAIFile

    /// Retrieves information about a file.
    func retrieve(id: String) async throws -> Components.Schemas.OpenAIFile

    /// Lists your organization's files.
    func list(query: ListFilesQuery) async throws -> Components.Schemas.ListFilesResponse

    /// Deletes a file.
    func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse

    /// Downloads the contents of a file, for example the JSONL output of a batch.
    func content(id: String) async throws -> Data
}

extension FilesEndpointAsync {
    /// Lists your organization's files with the API's default parameters.
    public func list() async throws -> Components.Schemas.ListFilesResponse {
        try await list(query: .init())
    }
}
