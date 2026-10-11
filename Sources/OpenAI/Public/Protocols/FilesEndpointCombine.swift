//
//  FilesEndpointCombine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine
import Foundation

public protocol FilesEndpointCombine: Sendable {
    /// Uploads a file.
    func create(query: CreateFileQuery) -> AnyPublisher<Components.Schemas.OpenAIFile, Error>

    /// Retrieves information about a file.
    func retrieve(id: String) -> AnyPublisher<Components.Schemas.OpenAIFile, Error>

    /// Lists your organization's files.
    func list(query: ListFilesQuery) -> AnyPublisher<Components.Schemas.ListFilesResponse, Error>

    /// Deletes a file.
    func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error>

    /// Downloads the contents of a file, for example the JSONL output of a batch.
    func content(id: String) -> AnyPublisher<Data, Error>
}

extension FilesEndpointCombine {
    /// Lists your organization's files with the API's default parameters.
    public func list() -> AnyPublisher<Components.Schemas.ListFilesResponse, Error> {
        list(query: .init())
    }
}
#endif
