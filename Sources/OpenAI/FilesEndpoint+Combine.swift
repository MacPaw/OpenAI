//
//  FilesEndpoint+Combine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine
import Foundation

extension FilesEndpoint: FilesEndpointCombine {
    public func create(query: CreateFileQuery) -> AnyPublisher<OpenAIFile, Error> {
        combineClient.performRequest(request: makeCreateRequest(query: query))
    }

    public func retrieve(id: String) -> AnyPublisher<OpenAIFile, Error> {
        combineClient.performRequest(request: makeRetrieveRequest(id: id))
    }

    public func list(query: ListFilesQuery) -> AnyPublisher<ListFilesResponse, Error> {
        combineClient.performRequest(request: makeListRequest(query: query))
    }

    public func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error> {
        combineClient.performRequest(request: makeDeleteRequest(id: id))
    }

    public func content(id: String) -> AnyPublisher<Data, Error> {
        combineClient.performRawDataRequest(request: makeContentRequest(id: id))
    }
}
#endif
