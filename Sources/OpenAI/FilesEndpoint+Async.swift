//
//  FilesEndpoint+Async.swift
//  OpenAI
//

import Foundation

extension FilesEndpoint: FilesEndpointAsync {
    public func content(id: String) async throws -> Data {
        try await asyncClient.performRawDataRequest(request: makeContentRequest(id: id))
    }

    public func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse {
        try await asyncClient.performRequest(request: makeDeleteRequest(id: id))
    }
}
