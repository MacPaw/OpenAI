//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.03.2025.
//

import Foundation
@testable import OpenAI

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class MockStreamingSessionFactory: StreamingSessionFactory {
    var urlSessionFactory = MockURLSessionFactory()
    
    func makeServerSentEventsStreamingSession<ResultType>(
        urlRequest: URLRequest,
        onReceiveContent: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, ResultType) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, any Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, (any Error)?) -> Void
    ) -> StreamingSession<ServerSentEventsStreamInterpreter<ResultType>> where ResultType : Decodable, ResultType : Encodable, ResultType : Sendable {
        .init(
            urlSessionFactory: urlSessionFactory,
            urlRequest: urlRequest,
            interpreter: .init(executionSerializer: NoDispatchExecutionSerializer()),
            sslDelegate: nil,
            onReceiveContent: onReceiveContent,
            onProcessingError: onProcessingError,
            onComplete: onComplete
        )
    }
    
    func makeAudioSpeechStreamingSession(
        urlRequest: URLRequest,
        onReceiveContent: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, AudioSpeechResult) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, any Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, (any Error)?) -> Void
    ) -> StreamingSession<AudioSpeechStreamInterpreter> {
        .init(
            urlSessionFactory: urlSessionFactory,
            urlRequest: urlRequest,
            interpreter: .init(),
            sslDelegate: nil,
            onReceiveContent: onReceiveContent,
            onProcessingError: onProcessingError,
            onComplete: onComplete
        )
    }
}

struct NoDispatchExecutionSerializer: ExecutionSerializer {
    func dispatch(_ closure: @escaping () -> Void) {
        closure()
    }
}
