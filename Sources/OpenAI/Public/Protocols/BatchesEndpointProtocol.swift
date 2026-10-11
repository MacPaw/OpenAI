//
//  BatchesEndpointProtocol.swift
//  OpenAI
//

import Foundation

/// The [Batch API](https://platform.openai.com/docs/api-reference/batch): run large groups of requests asynchronously at a lower cost.
public protocol BatchesEndpointProtocol: BatchesEndpointModern {
    /// Creates and executes a batch from an uploaded JSONL file of requests.
    @discardableResult
    func create(
        query: Components.Schemas.CreateBatchRequest,
        completion: @escaping @Sendable (Result<Components.Schemas.Batch, Error>) -> Void
    ) -> CancellableRequest

    /// Retrieves a batch.
    @discardableResult
    func retrieve(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.Batch, Error>) -> Void
    ) -> CancellableRequest

    /// Lists your organization's batches.
    @discardableResult
    func list(
        query: ListBatchesQuery,
        completion: @escaping @Sendable (Result<Components.Schemas.ListBatchesResponse, Error>) -> Void
    ) -> CancellableRequest

    /// Cancels an in-progress batch. The batch is `cancelling` for up to 10 minutes before it becomes `cancelled`,
    /// with partial results (if any) available in the output file.
    @discardableResult
    func cancel(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.Batch, Error>) -> Void
    ) -> CancellableRequest
}

extension BatchesEndpointProtocol {
    /// Lists the first page of your organization's batches.
    @discardableResult
    public func list(
        completion: @escaping @Sendable (Result<Components.Schemas.ListBatchesResponse, Error>) -> Void
    ) -> CancellableRequest {
        list(query: .init(), completion: completion)
    }
}
