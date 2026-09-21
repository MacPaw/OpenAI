//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

#if canImport(Combine)
import Foundation
import Combine

public protocol ResponsesEndpointCombine: Sendable {
    func createResponse(query: CreateModelResponseQuery) -> AnyPublisher<ResponseObject, Error>
    func createResponseStreaming(query: CreateModelResponseQuery) -> AnyPublisher<Result<ResponseStreamEvent, Error>, Error>
    func retrieveResponse(query: GetModelResponseQuery) -> AnyPublisher<ResponseObject, Error>
    func cancelResponse(query: CancelModelResponseQuery) -> AnyPublisher<ResponseObject, Error>
}
#endif
