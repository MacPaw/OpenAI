//
//  BatchesEndpoint+Async.swift
//  OpenAI
//

import Foundation

extension BatchesEndpoint: BatchesEndpointAsync {
    public func create(query: Components.Schemas.CreateBatchRequest) async throws -> Components.Schemas.Batch {
        try await asyncClient.performRequest(request: makeCreateRequest(query: query))
    }

    public func retrieve(id: String) async throws -> Components.Schemas.Batch {
        try await asyncClient.performRequest(request: makeRetrieveRequest(id: id))
    }

    public func list(query: ListBatchesQuery) async throws -> Components.Schemas.ListBatchesResponse {
        try await asyncClient.performRequest(request: makeListRequest(query: query))
    }

    public func cancel(id: String) async throws -> Components.Schemas.Batch {
        try await asyncClient.performRequest(request: makeCancelRequest(id: id))
    }
}
