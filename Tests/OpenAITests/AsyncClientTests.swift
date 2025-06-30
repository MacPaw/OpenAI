//
//  Test.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.06.2025.
//

import Testing
import Foundation
@testable import OpenAI

struct AsyncClientTests {
    
    private let configuration = OpenAI.Configuration(token: "")
    private let mockSession = URLSessionMock()
    private let mockMiddleware = MockMiddleware()
    private let client: AsyncClient
    
    private let originalURL = URL(string: "original")!
    private let interceptedURL = URL(string: "intercepted")!
    
    init() {
        self.client = AsyncClient(
            configuration: configuration,
            session: mockSession,
            middlewares: [mockMiddleware],
            dataTaskFactory: DataTaskFactory(session: mockSession, responseHandler: .init(middlewares: [mockMiddleware], configuration: configuration)),
            responseHandler: .init(middlewares: [mockMiddleware], configuration: configuration)
        )
    }

    @Test func interceptRequest() async throws {
        mockSession.dataTask = try DataTaskMock.successfulJson(with: ChatResult.mock)
        mockMiddleware.interceptRequestReturnValue = .init(url: interceptedURL)
        let _: ChatResult = try await client.performRequest(request: JSONRequest<ChatResult>(url: originalURL))
        #expect(mockSession.dataAsyncCalls[0].request.url == interceptedURL)
    }
    
    @Test func interceptSpeechRequest() async throws {
        mockSession.dataTask = try DataTaskMock.successfulJson(with: AudioSpeechResult(audio: .init()))
        mockMiddleware.interceptRequestReturnValue = .init(url: interceptedURL)
        let _: AudioSpeechResult = try await client.performSpeechRequest(request: JSONRequest<AudioSpeechResult>(url: originalURL))
        #expect(mockSession.dataAsyncCalls[0].request.url == interceptedURL)
    }
}
