//
//  ServerSentEventsStreamingSessionFactory.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.03.2025.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol StreamingSessionFactory {
    func makeServerSentEventsStreamingSession<ResultType: Codable & Sendable>(
        urlRequest: URLRequest,
        middlewares: [OpenAIMiddleware],
        onReceiveContent: @Sendable @escaping (StreamingSession<ServerSentEventsStreamDecoder<ResultType>>, ResultType) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<ServerSentEventsStreamDecoder<ResultType>>, Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<ServerSentEventsStreamDecoder<ResultType>>, Error?) -> Void
    ) -> StreamingSession<ServerSentEventsStreamDecoder<ResultType>>
    
    func makeAudioSpeechStreamingSession(
        urlRequest: URLRequest,
        middlewares: [OpenAIMiddleware],
        onReceiveContent: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, AudioSpeechResult) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, Error?) -> Void
    ) -> StreamingSession<AudioSpeechStreamInterpreter>
}

struct ImplicitURLSessionStreamingSessionFactory: StreamingSessionFactory {
    let sslDelegate: SSLDelegateProtocol?
    
    func makeServerSentEventsStreamingSession<ResultType>(
        urlRequest: URLRequest,
        middlewares: [OpenAIMiddleware],
        onReceiveContent: @Sendable @escaping (StreamingSession<ServerSentEventsStreamDecoder<ResultType>>, ResultType) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<ServerSentEventsStreamDecoder<ResultType>>, any Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<ServerSentEventsStreamDecoder<ResultType>>, (any Error)?) -> Void
    ) -> StreamingSession<ServerSentEventsStreamDecoder<ResultType>> where ResultType : Decodable, ResultType : Encodable, ResultType : Sendable {
        .init(
            urlRequest: urlRequest,
            interpreter: .init(),
            sslDelegate: sslDelegate,
            middlewares: middlewares,
            onReceiveContent: onReceiveContent,
            onProcessingError: onProcessingError,
            onComplete: onComplete
        )
    }
    
    func makeAudioSpeechStreamingSession(
        urlRequest: URLRequest,
        middlewares: [OpenAIMiddleware],
        onReceiveContent: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, AudioSpeechResult) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, any Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, (any Error)?) -> Void
    ) -> StreamingSession<AudioSpeechStreamInterpreter> {
        .init(
            urlRequest: urlRequest,
            interpreter: .init(),
            sslDelegate: sslDelegate,
            middlewares: middlewares,
            onReceiveContent: onReceiveContent,
            onProcessingError: onProcessingError,
            onComplete: onComplete
        )
    }
}
