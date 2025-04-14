//
//  ResponsesEndpoint.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.03.2025.
//

import Foundation

public protocol ResponsesEndpointProtocol: Sendable {
    func createResponse(query: CreateModelResponseQuery) async throws -> ResponseObject
    func createResponseStreaming(query: CreateModelResponseQuery) -> AsyncThrowingStream<ResponseStreamEvent, Error>
    func createResponseStreaming(
        query: CreateModelResponseQuery,
        onResult: @escaping @Sendable (Result<ResponseStreamEvent, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest
}

public struct ResponsesEndpoint: ResponsesEndpointProtocol {
    enum CreateResponseError: Error {
        case invalidQueryExpectedStreamTrue
    }
    
    private let syncClient: StreamingClient
    private let asyncClient: AsyncClient
    private let configuration: OpenAI.Configuration
    
    init(syncClient: StreamingClient, asyncClient: AsyncClient, configuration: OpenAI.Configuration) {
        self.syncClient = syncClient
        self.asyncClient = asyncClient
        self.configuration = configuration
    }
    
    public func createResponse(query: CreateModelResponseQuery) async throws -> ResponseObject {
        try await asyncClient.performRequest(request: makeCreateResponseRequest(query: query))
    }
    
    public func createResponseStreaming(query: CreateModelResponseQuery) -> AsyncThrowingStream<ResponseStreamEvent, Error> {
        return AsyncThrowingStream { continuation in
            let cancellableRequest = createResponseStreaming(query: query)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
            
            continuation.onTermination = { termination in
                switch termination {
                case .cancelled:
                    cancellableRequest.cancelRequest()
                case .finished:
                    break
                @unknown default:
                    break
                }
            }
        }
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
        
        return syncClient.performResponsesStreamingRequest(
            request: JSONRequest<CreateModelResponseQuery>(
                body: query,
                url: buildURL(path: .Responses.createModelResponse.stringValue)
            ),
            onResult: onResult,
            completion: completion
        )
    }
    
    private func makeCreateResponseRequest(query: CreateModelResponseQuery) -> JSONRequest<ResponseObject> {
        .init(body: query, url: buildURL(path: .Responses.createModelResponse.stringValue))
    }
    
    private func buildURL(path: String, after: String? = nil) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path, after: after)
            .buildURL()
    }
}
