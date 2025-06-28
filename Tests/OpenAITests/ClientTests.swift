//
//  Test.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.06.2025.
//

import Testing
import Foundation
@testable import OpenAI

struct ClientTests {
    
    private let configuration = OpenAI.Configuration(token: "")
    private let mockSession = URLSessionMock()
    private let mockMiddleware = MockMiddleware()
    private let client: Client
    
    private let originalURL = URL(string: "original")!
    private let interceptedURL = URL(string: "intercepted")!
    
    init() {
        self.client = Client(
            configuration: configuration,
            session: mockSession,
            middlewares: [mockMiddleware],
            dataTaskFactory: DataTaskFactory(session: mockSession, responseHandler: .init(middlewares: [mockMiddleware], configuration: configuration)),
            cancellablesFactory: MockCancellablesFactory()
        )
        
        mockSession.dataTask = DataTaskMock()
    }

    @Test func interceptRequest() async throws {
        mockMiddleware.interceptRequestReturnValue = .init(url: interceptedURL)
        _ = client.performRequest(request: JSONRequest<ChatResult>(url: originalURL), completion: { (result: Result<ChatResult, Error>) in })
        #expect(mockSession.dataTaskWithCompletionCalls[0].request.url == interceptedURL)
    }
    
    @Test func interceptSpeechRequest() async throws {
        mockMiddleware.interceptRequestReturnValue = .init(url: interceptedURL)
        _ = client.performSpeechRequest(request: JSONRequest<AudioSpeechResult>(url: originalURL), completion: { (result: Result<AudioSpeechResult, Error>) in })
        #expect(mockSession.dataTaskWithCompletionCalls[0].request.url == interceptedURL)
    }
}
