//
//  ResponsesEndpoint+Combine.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

#if canImport(Combine)
import Combine
import Foundation

extension ResponsesEndpoint: ResponsesEndpointCombine {
    public func createResponse(query: CreateModelResponseQuery) -> AnyPublisher<ResponseObject, any Error> {
        combineClient.performRequest(
            request: makeCreateResponseRequest(query: query)
        )
    }
    
    public func createResponseStreaming(query: CreateModelResponseQuery) -> AnyPublisher<Result<ResponseStreamEvent, any Error>, any Error> {
        let progress = SendablePassthroughSubject(
            passthroughSubject: PassthroughSubject<Result<ResponseStreamEvent, Error>, Error>()
        )
        
        let cancellable = createResponseStreaming(query: query) { result in
            progress.send(result)
        } completion: { error in
            if let error {
                progress.send(completion: .failure(error))
            } else {
                progress.send(completion: .finished)
            }
        }
        return progress
            .publisher()
            .handleEvents(receiveCancel: {
                cancellable.cancelRequest()
            })
            .eraseToAnyPublisher()
    }
}
#endif
