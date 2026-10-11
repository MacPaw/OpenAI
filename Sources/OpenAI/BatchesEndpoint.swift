//
//  BatchesEndpoint.swift
//  OpenAI
//

import Foundation

public final class BatchesEndpoint: BatchesEndpointProtocol, Sendable {
    private let client: Client
    let asyncClient: AsyncClient
    let combineClient: CombineClient
    private let configuration: OpenAI.Configuration

    init(
        client: Client,
        asyncClient: AsyncClient,
        combineClient: CombineClient,
        configuration: OpenAI.Configuration
    ) {
        self.client = client
        self.asyncClient = asyncClient
        self.combineClient = combineClient
        self.configuration = configuration
    }

    public func create(
        query: Components.Schemas.CreateBatchRequest,
        completion: @escaping @Sendable (Result<Components.Schemas.Batch, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeCreateRequest(query: query), completion: completion)
    }

    public func retrieve(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.Batch, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeRetrieveRequest(id: id), completion: completion)
    }

    public func list(
        query: ListBatchesQuery,
        completion: @escaping @Sendable (Result<Components.Schemas.ListBatchesResponse, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeListRequest(query: query), completion: completion)
    }

    public func cancel(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.Batch, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeCancelRequest(id: id), completion: completion)
    }

    func makeCreateRequest(query: Components.Schemas.CreateBatchRequest) -> JSONRequest<Components.Schemas.Batch> {
        .init(body: query, url: buildURL(path: .batches))
    }

    func makeRetrieveRequest(id: String) -> JSONRequest<Components.Schemas.Batch> {
        .init(url: buildURL(path: .batch(id)), method: "GET")
    }

    func makeListRequest(query: ListBatchesQuery) -> JSONRequest<Components.Schemas.ListBatchesResponse> {
        var queryItems: [URLQueryItem] = []
        if let after = query.after {
            queryItems.append(.init(name: "after", value: after))
        }
        if let limit = query.limit {
            queryItems.append(.init(name: "limit", value: String(limit)))
        }
        return .init(url: buildURL(path: .batches, queryItems: queryItems), method: "GET")
    }

    func makeCancelRequest(id: String) -> JSONRequest<Components.Schemas.Batch> {
        .init(url: buildURL(path: .batchCancel(id)))
    }

    private func buildURL(path: String, queryItems: [URLQueryItem] = []) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path, queryItems: queryItems)
            .buildURL()
    }
}
