//
//  BatchesEndpoint+Combine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine
import Foundation

extension BatchesEndpoint: BatchesEndpointCombine {
    public func create(query: Components.Schemas.CreateBatchRequest) -> AnyPublisher<Components.Schemas.Batch, Error> {
        combineClient.performRequest(request: makeCreateRequest(query: query))
    }

    public func retrieve(id: String) -> AnyPublisher<Components.Schemas.Batch, Error> {
        combineClient.performRequest(request: makeRetrieveRequest(id: id))
    }

    public func list(query: ListBatchesQuery) -> AnyPublisher<Components.Schemas.ListBatchesResponse, Error> {
        combineClient.performRequest(request: makeListRequest(query: query))
    }

    public func cancel(id: String) -> AnyPublisher<Components.Schemas.Batch, Error> {
        combineClient.performRequest(request: makeCancelRequest(id: id))
    }
}
#endif
