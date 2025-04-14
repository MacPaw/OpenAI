//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import Foundation

final class StreamingClient: @unchecked Sendable {
    private let configuration: OpenAI.Configuration
    private let middlewares: [OpenAIMiddleware]
    private let streamingSessionFactory: StreamingSessionFactory
    private let cancellablesFactory: CancellablesFactory
    private let executionSerializer: ExecutionSerializer
    private var streamingSessions: [NSObject: InvalidatableSession] = [:]
    
    init(
        configuration: OpenAI.Configuration,
        middlewares: [OpenAIMiddleware],
        streamingSessionFactory: StreamingSessionFactory,
        cancellablesFactory: CancellablesFactory,
        executionSerializer: ExecutionSerializer
    ) {
        self.configuration = configuration
        self.middlewares = middlewares
        self.streamingSessionFactory = streamingSessionFactory
        self.cancellablesFactory = cancellablesFactory
        self.executionSerializer = executionSerializer
    }
    
    func performStreamingRequest<ResultType: Codable & Sendable>(
        request: any URLRequestBuildable,
        onResult: @escaping @Sendable (Result<ResultType, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }

            let session = streamingSessionFactory.makeServerSentEventsStreamingSession(
                urlRequest: interceptedRequest
            ) { _, object in
                onResult(.success(object))
            } onProcessingError: { _, error in
                onResult(.failure(error))
            } onComplete: { [weak self] session, error in
                completion?(error)
                self?.invalidateSession(session)
            }
            
            return runSession(session)
        } catch {
            completion?(error)
            return NoOpCancellableRequest()
        }
    }
    
    func performSpeechStreamingRequest(
        request: any URLRequestBuildable,
        onResult: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }

            let session = streamingSessionFactory.makeAudioSpeechStreamingSession(
                urlRequest: interceptedRequest
            ) { _, object in
                onResult(.success(object))
            } onProcessingError: { _, error in
                onResult(.failure(error))
            } onComplete: { [weak self] session, error in
                completion?(error)
                self?.invalidateSession(session)
            }
            
            return runSession(session)
        } catch {
            completion?(error)
            return NoOpCancellableRequest()
        }
    }
    
    func performResponsesStreamingRequest(
        request: any URLRequestBuildable,
        onResult: @escaping @Sendable (Result<ResponseStreamEvent, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
                middleware.intercept(request: current)
            }

            let session = streamingSessionFactory.makeModelResponseStreamingSession(
                urlRequest: interceptedRequest
            ) { _, object in
                onResult(.success(object))
            } onProcessingError: { _, error in
                onResult(.failure(error))
            } onComplete: { [weak self] session, error in
                completion?(error)
                self?.invalidateSession(session)
            }
            
            return runSession(session)
        } catch {
            completion?(error)
            return NoOpCancellableRequest()
        }
    }
    
    private func runSession<I>(_ session: StreamingSession<I>) -> CancellableRequest {
        let performableSession = session.makeSession()
        
        executionSerializer.dispatch {
            self.streamingSessions[session] = performableSession
        }
        
        performableSession.performSession()
        
        return cancellablesFactory.makeSessionCanceller(
            session: performableSession
        )
    }
    
    private func invalidateSession(_ object: NSObject) {
        self.executionSerializer.dispatch {
            let invalidatableSession = self.streamingSessions.removeValue(forKey: object)
            invalidatableSession?.invalidateAndCancel()
        }
    }
}
