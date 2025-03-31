//
//  ResponsesEndpoint.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.03.2025.
//

import Foundation

public struct ResponsesEndpoint {
    let client: AsyncClient
    let configuration: OpenAI.Configuration
    
    init(client: AsyncClient, configuration: OpenAI.Configuration) {
        self.client = client
        self.configuration = configuration
    }
    
    public func create(query: CreateModelResponseQuery) async throws -> ResponseObject {
        try await client.performRequest(request: makeCreateResponseRequest(query: query))
    }
    
    private func makeCreateResponseRequest(query: CreateModelResponseQuery) -> JSONRequest<ResponseObject> {
        .init(body: query, url: buildURL(path: .Responses.createModelResponse.stringValue))
    }
    
    private func buildURL(path: String, after: String? = nil) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path, after: after)
            .buildURL()
    }
}
