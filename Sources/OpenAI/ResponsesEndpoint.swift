//
//  ResponsesEndpoint.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.03.2025.
//

import Foundation

public final class ResponsesEndpoint: ResponsesEndpointProtocol, Sendable {
    enum CreateResponseError: DescribedError {
        case invalidQueryExpectedStreamTrue
    }
    
    private let client: Client
    private let streamingClient: StreamingClient
    
    let asyncClient: AsyncClient
    let combineClient: CombineClient
    private let configuration: OpenAI.Configuration
    
    init(
        client: Client,
        streamingClient: StreamingClient,
        asyncClient: AsyncClient,
        combineClient: CombineClient,
        configuration: OpenAI.Configuration
    ) {
        self.client = client
        self.streamingClient = streamingClient
        self.asyncClient = asyncClient
        self.combineClient = combineClient
        self.configuration = configuration
    }
    
    public func createResponse(query: CreateModelResponseQuery, completion: @Sendable @escaping (Result<ResponseObject, any Error>) -> Void) -> any CancellableRequest {
        client.performRequest(
            request: makeCreateResponseRequest(query: query),
            completion: completion
        )
    }
    
    public func createResponseStreaming(
        query: CreateModelResponseQuery,
        onResult: @escaping @Sendable (Result<ResponseStreamEvent, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest {
        guard query.stream == true else {
            completion?(CreateResponseError.invalidQueryExpectedStreamTrue)
            return NoOpCancellableRequest()
        }
        
        return streamingClient.performResponsesStreamingRequest(
            request: JSONRequest<CreateModelResponseQuery>(
                body: query,
                url: buildURL(path: .Responses.createModelResponse.stringValue)
            ),
            onResult: onResult,
            completion: completion
        )
    }
    
    func makeCreateResponseRequest(query: CreateModelResponseQuery) -> JSONRequest<ResponseObject> {
        .init(body: query, url: buildURL(path: .Responses.createModelResponse.stringValue))
    }
    
    private func buildURL(path: String, after: String? = nil) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path, after: after)
            .buildURL()
    }
}

// MARK: - Retrieve Response

extension ResponsesEndpoint {
    
    public func retrieveResponse(query: GetModelResponseQuery, completion: @escaping @Sendable (Result<ResponseObject, any Error>) -> Void) -> any CancellableRequest {
        client.performRequest(request: makeRetrieveResponseRequest(query: query),
                              completion: completion)
    }
    
    func makeRetrieveResponseRequest(query: GetModelResponseQuery) -> JSONRequest<ResponseObject> {
        let path = String.Responses.getModelResponse(responseId: query.responseId).stringValue
        return .init(url: buildURL(path: path), method: "GET")
    }
}

// MARK: - Cancel Response

extension ResponsesEndpoint {
    
    public func cancelResponse(query: CancelModelResponseQuery, completion: @escaping (Result<ResponseObject, any Error>) -> Void) -> any CancellableRequest {
        client.performRequest(request: makeCancelResponseRequest(query: query),
                              completion: completion)
    }
    
    func makeCancelResponseRequest(query: CancelModelResponseQuery) -> JSONRequest<ResponseObject> {
        let path = String.Responses.cancelModelResponse(responseId: query.responseId).stringValue
        return .init(body: query, url: buildURL(path: path))
    }
}
