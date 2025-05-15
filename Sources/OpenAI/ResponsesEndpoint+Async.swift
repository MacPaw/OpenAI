//
//  ResponsesEndpoint.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import Foundation

extension ResponsesEndpoint: ResponsesEndpointAsync {
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
}
