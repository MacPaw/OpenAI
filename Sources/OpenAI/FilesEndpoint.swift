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

    public func content(
        id: String,
        completion: @escaping @Sendable (Result<Data, Error>) -> Void
    ) -> CancellableRequest {
        client.performRawDataRequest(request: makeContentRequest(id: id), completion: completion)
    }

    public func delete(
        id: String,
        completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void
    ) -> CancellableRequest {
        client.performRequest(request: makeDeleteRequest(id: id), completion: completion)
    }

    func makeContentRequest(id: String) -> JSONRequest<Data> {
        .init(url: buildURL(path: .fileContent(id)), method: "GET")
    }

    func makeDeleteRequest(id: String) -> JSONRequest<Components.Schemas.DeleteFileResponse> {
        .init(url: buildURL(path: .file(id)), method: "DELETE")
    }

    private func buildURL(path: String) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path)
            .buildURL()
    }
}
