//
//  FilesEndpointCombine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine
import Foundation

public protocol FilesEndpointCombine: Sendable {
    /// Upload a file that can be used across various endpoints. Individual files
    /// can be up to 512 MB, and each project can store up to 2.5 TB of files in
    /// total. There is no organization-wide storage limit. Uploads to this
    /// endpoint are rate-limited to 1,000 requests per minute per authenticated
    /// user.
    func create(query: CreateFileQuery) -> AnyPublisher<OpenAIFile, Error>

    /// Returns information about a specific file.
    /// - Parameter id: The ID of the file to use for this request.
    func retrieve(id: String) -> AnyPublisher<OpenAIFile, Error>

    /// Returns a list of files.
    func list(query: ListFilesQuery) -> AnyPublisher<ListFilesResponse, Error>

    /// Delete a file and remove it from all vector stores.
    /// - Parameter id: The ID of the file to use for this request.
    func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error>

    /// Returns a response containing the contents of the specified file.
    /// - Parameter id: The ID of the file to use for this request.
    func content(id: String) -> AnyPublisher<Data, Error>
}

extension FilesEndpointCombine {
    /// Lists files with the API's default parameters: ``ListFilesQuery`` with no values set.
    public func list() -> AnyPublisher<ListFilesResponse, Error> {
        list(query: .init())
    }
}
#endif
