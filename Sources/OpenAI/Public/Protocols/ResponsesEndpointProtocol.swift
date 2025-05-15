//
//  ResponsesEndpointProtocol.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import Foundation

public protocol ResponsesEndpointProtocol: ResponsesEndpointModern {
    func createResponse(
        query: CreateModelResponseQuery,
        completion: @escaping @Sendable (Result<ResponseObject, Error>) -> Void
    ) -> CancellableRequest
    
    func createResponseStreaming(
        query: CreateModelResponseQuery,
        onResult: @escaping @Sendable (Result<ResponseStreamEvent, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest
}
