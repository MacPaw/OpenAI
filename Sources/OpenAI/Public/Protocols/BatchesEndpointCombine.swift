//
//  BatchesEndpointCombine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine

public protocol BatchesEndpointCombine: Sendable {
    /// Creates and executes a batch from an uploaded JSONL file of requests.
    func create(query: Components.Schemas.CreateBatchRequest) -> AnyPublisher<Components.Schemas.Batch, Error>

    /// Retrieves a batch.
    func retrieve(id: String) -> AnyPublisher<Components.Schemas.Batch, Error>

    /// Lists your organization's batches.
    func list(query: ListBatchesQuery) -> AnyPublisher<Components.Schemas.ListBatchesResponse, Error>

    /// Cancels an in-progress batch. The batch is `cancelling` for up to 10 minutes before it becomes `cancelled`,
    /// with partial results (if any) available in the output file.
    func cancel(id: String) -> AnyPublisher<Components.Schemas.Batch, Error>
}

extension BatchesEndpointCombine {
    /// Lists the first page of your organization's batches.
    public func list() -> AnyPublisher<Components.Schemas.ListBatchesResponse, Error> {
        list(query: .init())
    }
}
#endif
