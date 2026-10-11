//
//  FilesEndpoint+Async.swift
//  OpenAI
//

import Foundation

extension FilesEndpoint: FilesEndpointAsync {
    public func create(query: CreateFileQuery) async throws -> Components.Schemas.OpenAIFile {
        try await asyncClient.performRequest(request: makeCreateRequest(query: query))
    }

    public func retrieve(id: String) async throws -> Components.Schemas.OpenAIFile {
        try await asyncClient.performRequest(request: makeRetrieveRequest(id: id))
    }

    public func list(query: ListFilesQuery) async throws -> Components.Schemas.ListFilesResponse {
        try await asyncClient.performRequest(request: makeListRequest(query: query))
    }

    public func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse {
        try await asyncClient.performRequest(request: makeDeleteRequest(id: id))
    }

    public func content(id: String) async throws -> Data {
        try await asyncClient.performRawDataRequest(request: makeContentRequest(id: id))
    }
}
