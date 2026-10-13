//
//  FilesEndpoint.swift
//  OpenAI
//

import Foundation

public final class FilesEndpoint: FilesEndpointProtocol, Sendable {
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
        query: CreateFileQuery,
        completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeCreateRequest(query: query), completion: completion)
    }

    public func retrieve(
        id: String,
        completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeRetrieveRequest(id: id), completion: completion)
    }

    public func list(
        query: ListFilesQuery,
        completion: @escaping @Sendable (Result<ListFilesResponse, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeListRequest(query: query), completion: completion)
    }

    public func delete(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeDeleteRequest(id: id), completion: completion)
    }

    public func content(
        id: String,
        completion: @escaping @Sendable (Result<Data, Error>) -> Void
    ) -> CancellableRequest {
        client.performRawDataRequest(request: makeContentRequest(id: id), completion: completion)
    }

    func makeCreateRequest(query: CreateFileQuery) -> MultipartFormDataRequest<OpenAIFile> {
        .init(body: query, url: buildURL(path: .files))
    }

    func makeRetrieveRequest(id: String) -> JSONRequest<OpenAIFile> {
        .init(url: buildURL(path: .file(fileId: id)), method: "GET")
    }

    func makeListRequest(query: ListFilesQuery) -> JSONRequest<ListFilesResponse> {
        var queryItems: [URLQueryItem] = []
        if let purpose = query.purpose {
            queryItems.append(.init(name: "purpose", value: purpose))
        }
        if let limit = query.limit {
            queryItems.append(.init(name: "limit", value: String(limit)))
        }
        if let order = query.order {
            queryItems.append(.init(name: "order", value: order.rawValue))
        }
        if let after = query.after {
            queryItems.append(.init(name: "after", value: after))
        }
        return .init(url: buildURL(path: .files, queryItems: queryItems), method: "GET")
    }

    func makeDeleteRequest(id: String) -> JSONRequest<Components.Schemas.DeleteFileResponse> {
        .init(url: buildURL(path: .file(fileId: id)), method: "DELETE")
    }

    func makeContentRequest(id: String) -> JSONRequest<Data> {
        .init(url: buildURL(path: .fileContent(fileId: id)), method: "GET")
    }

    private func buildURL(path: APIPath.Files, queryItems: [URLQueryItem] = []) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path.stringValue, queryItems: queryItems)
            .buildURL()
    }
}
