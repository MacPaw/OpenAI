//
//  BatchesEndpointAsync.swift
//  OpenAI
//

import Foundation

public protocol BatchesEndpointAsync: Sendable {
    /// Creates and executes a batch from an uploaded JSONL file of requests.
    func create(query: Components.Schemas.CreateBatchRequest) async throws -> Components.Schemas.Batch

    /// Retrieves a batch.
    func retrieve(id: String) async throws -> Components.Schemas.Batch

    /// Lists your organization's batches.
    func list(query: ListBatchesQuery) async throws -> Components.Schemas.ListBatchesResponse

    /// Cancels an in-progress batch. The batch is `cancelling` for up to 10 minutes before it becomes `cancelled`,
    /// with partial results (if any) available in the output file.
    func cancel(id: String) async throws -> Components.Schemas.Batch
}

extension BatchesEndpointAsync {
    /// Lists the first page of your organization's batches.
    public func list() async throws -> Components.Schemas.ListBatchesResponse {
        try await list(query: .init())
    }
}
