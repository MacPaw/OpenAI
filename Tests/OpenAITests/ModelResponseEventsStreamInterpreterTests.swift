//
//  Test.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.04.2025.
//

import Testing
@testable import OpenAI

@MainActor
struct Test {
    private let interpreter = ModelResponseEventsStreamInterpreter()
    
    @Test(.timeLimit(.minutes(1)))
    func parseApiError() async throws {
        var error: Error!
        
        await withCheckedContinuation { continuation in
            interpreter.setCallbackClosures { result in
            } onError: { apiError in
                Task {
                    await MainActor.run {
                        error = apiError
                        continuation.resume()
                    }
                }
            }
            
            interpreter.processData(
                MockServerSentEvent.chatCompletionError()
            )
        }
        
        #expect(error is APIErrorResponse)
    }
}
