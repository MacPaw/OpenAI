//
//  CombineClientTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.06.2025.
//

#if canImport(Combine)
import Testing
import Foundation
@testable import OpenAI
import Combine

struct CombineClientTests {
    
    private let configuration = OpenAI.Configuration(token: "")
    private let mockSession = URLSessionMock()
    private let mockMiddleware = MockMiddleware()
    private let client: CombineClient
    
    private let originalURL = URL(string: "original")!
    private let interceptedURL = URL(string: "intercepted")!
    
    init() {
        self.client = CombineClient(
            configuration: configuration,
            session: mockSession,
            middlewares: [mockMiddleware],
            responseHandler: .init(middlewares: [mockMiddleware], configuration: configuration)
        )
    }

    @Test func interceptRequest() async throws {
        mockSession.dataTask = try DataTaskMock.successfulJson(with: ChatResult.mock)
        mockMiddleware.interceptRequestReturnValue = .init(url: interceptedURL)
        let _: AnyPublisher<ChatResult, Error> = client.performRequest(request: JSONRequest<ChatResult>(url: originalURL))
        #expect(mockSession.dataTaskPublisherCalls[0].request.url == interceptedURL)
    }
    
    @Test func interceptSpeechRequest() async throws {
        mockSession.dataTask = try DataTaskMock.successfulJson(with: AudioSpeechResult(audio: .init()))
        mockMiddleware.interceptRequestReturnValue = .init(url: interceptedURL)
        let _: AnyPublisher<AudioSpeechResult, Error> = client.performSpeechRequest(request: JSONRequest<AudioSpeechResult>(url: originalURL))
        #expect(mockSession.dataTaskPublisherCalls[0].request.url == interceptedURL)
    }
}
#endif
