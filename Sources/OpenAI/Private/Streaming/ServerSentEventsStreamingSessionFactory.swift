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
        onReceiveContent: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, ResultType) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, Error?) -> Void
    ) -> StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>
    
    func makeAudioSpeechStreamingSession(
        urlRequest: URLRequest,
        onReceiveContent: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, AudioSpeechResult) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<AudioSpeechStreamInterpreter>, Error?) -> Void
    ) -> StreamingSession<AudioSpeechStreamInterpreter>
}

struct ImplicitURLSessionStreamingSessionFactory: StreamingSessionFactory {
    let sslDelegate: SSLDelegateProtocol?
    
    func makeServerSentEventsStreamingSession<ResultType>(
        urlRequest: URLRequest,
        onReceiveContent: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, ResultType) -> Void,
        onProcessingError: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, any Error) -> Void,
        onComplete: @Sendable @escaping (StreamingSession<ServerSentEventsStreamInterpreter<ResultType>>, (any Error)?) -> Void
    ) -> StreamingSession<ServerSentEventsStreamInterpreter<ResultType>> where ResultType : Decodable, ResultType : Encodable, ResultType : Sendable {
        .init(
            urlRequest: urlRequest,
            interpreter: .init(),
            sslDelegate: sslDelegate,
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
            urlRequest: urlRequest,
            interpreter: .init(),
            sslDelegate: sslDelegate,
            onReceiveContent: onReceiveContent,
            onProcessingError: onProcessingError,
            onComplete: onComplete
        )
    }
}
