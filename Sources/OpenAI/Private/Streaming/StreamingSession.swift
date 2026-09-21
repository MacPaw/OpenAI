//
//  StreamingSession.swift
//
//
//  Created by Sergii Kryvoblotskyi on 18/04/2023.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Real API error bodies are at most a few KB. Cap how much of a non-2xx body we'll buffer so a
/// malformed or malicious server can't force unbounded memory growth by never ending the response.
private let maxErrorBodyByteCount = 256 * 1024

final class StreamingSession<Interpreter: StreamInterpreter>: NSObject, Identifiable, URLSessionDataDelegateProtocol, @unchecked Sendable {
    typealias ResultType = Interpreter.ResultType
    
    private let urlSessionFactory: URLSessionFactory
    private let urlRequest: URLRequest
    private let interpreter: Interpreter
    private let sslDelegate: SSLDelegateProtocol?
    private let middlewares: [OpenAIMiddleware]
    private let executionSerializer: ExecutionSerializer
    private let onReceiveContent: (@Sendable (StreamingSession, ResultType) -> Void)?
    private let onProcessingError: (@Sendable (StreamingSession, Error) -> Void)?
    private let onComplete: (@Sendable (StreamingSession, Error?) -> Void)?

    /// Set once a response with a non-2xx status code is received.
    /// While set, incoming data is treated as an error body rather than being fed to the interpreter.
    private var errorResponse: HTTPURLResponse?
    private var errorData = Data()

    init(
        urlSessionFactory: URLSessionFactory = FoundationURLSessionFactory(),
        urlRequest: URLRequest,
        interpreter: Interpreter,
        sslDelegate: SSLDelegateProtocol?,
        middlewares: [OpenAIMiddleware],
        executionSerializer: ExecutionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated),
        onReceiveContent: @escaping @Sendable (StreamingSession, ResultType) -> Void,
        onProcessingError: @escaping @Sendable (StreamingSession, Error) -> Void,
        onComplete: @escaping @Sendable (StreamingSession, Error?) -> Void
    ) {
        self.urlSessionFactory = urlSessionFactory
        self.urlRequest = urlRequest
        self.interpreter = interpreter
        self.sslDelegate = sslDelegate
        self.middlewares = middlewares
        self.executionSerializer = executionSerializer
        self.onReceiveContent = onReceiveContent
        self.onProcessingError = onProcessingError
        self.onComplete = onComplete
        super.init()
        subscribeToParser()
    }
    
    func makeSession() -> PerformableSession & InvalidatableSession {
        let urlSession = urlSessionFactory.makeUrlSession(delegate: self)
        return DataTaskPerformingURLSession(urlRequest: urlRequest, urlSession: urlSession)
    }
    
    func urlSession(_ session: any URLSessionProtocol, task: any URLSessionTaskProtocol, didCompleteWithError error: (any Error)?) {
        executionSerializer.dispatch {
            if let httpResponse = self.errorResponse {
                let decodedError = JSONResponseErrorDecoder(decoder: JSONDecoder()).decodeErrorResponse(data: self.errorData) as (any Error)?
                let resolvedError = decodedError
                    ?? OpenAIError.statusError(response: httpResponse, statusCode: httpResponse.statusCode)
                self.onProcessingError?(self, resolvedError)
                self.onComplete?(self, resolvedError)
                return
            }
            self.onComplete?(self,error)
        }
    }

    func urlSession(_ session: any URLSessionProtocol, dataTask: any URLSessionDataTaskProtocol, didReceive data: Data) {
        executionSerializer.dispatch {
            let data = self.middlewares.reduce(data) { current, middleware in
                middleware.interceptStreamingData(request: dataTask.originalRequest, current)
            }

            if self.errorResponse != nil {
                self.errorData.append(data)
                if self.errorData.count > maxErrorBodyByteCount {
                    // Give up on this body: stop letting the server grow it further and let
                    // didCompleteWithError fall back to statusError with whatever we have.
                    dataTask.cancel()
                }
                return
            }

            self.interpreter.processData(data)
        }
    }

    func urlSession(
        _ session: URLSessionProtocol,
        dataTask: URLSessionDataTaskProtocol,
        didReceive response: URLResponse,
        completionHandler: @escaping @Sendable (URLSession.ResponseDisposition) -> Void
    ) {
        executionSerializer.dispatch {
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
                // Keep the connection open so the error body (with the actual failure reason) can be
                // read in didReceive(data:) and decoded once the task completes in didCompleteWithError.
                self.errorResponse = httpResponse
                completionHandler(.allow)
                return
            }
            completionHandler(.allow)
        }
    }

    func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping @Sendable (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        guard let sslDelegate else { return completionHandler(.performDefaultHandling, nil) }
        sslDelegate.urlSession(session, didReceive: challenge, completionHandler: completionHandler)
    }

    private func subscribeToParser() {
        interpreter.setCallbackClosures { [weak self] content in
            guard let self else { return }
            self.onReceiveContent?(self, content)
        } onError: { [weak self] error in
            guard let self else { return }
            self.onProcessingError?(self, error)
        }
    }
}
