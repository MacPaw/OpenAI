//
//  ResponsesEndpointAsync.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import Foundation

public protocol ResponsesEndpointAsync: Sendable {
    func createResponse(query: CreateModelResponseQuery) async throws -> ResponseObject
    func createResponseStreaming(query: CreateModelResponseQuery) -> AsyncThrowingStream<ResponseStreamEvent, Error>
    func retrieveResponse(query: RetrieveModelResponseQuery) async throws -> ResponseObject
    func cancelResponse(id: String) async throws -> ResponseObject
}
