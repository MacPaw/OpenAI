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

final class StreamingSession<Interpreter: StreamInterpreter>: NSObject, Identifiable, URLSessionDataDelegateProtocol {
    typealias ResultType = Interpreter.ResultType
    
    private let urlSessionFactory: URLSessionFactory
    private let urlRequest: URLRequest
    private let onReceiveContent: (@Sendable (StreamingSession, ResultType) -> Void)?
    private let onProcessingError: (@Sendable (StreamingSession, Error) -> Void)?
    private let onComplete: (@Sendable (StreamingSession, Error?) -> Void)?
    private let interpreter: Interpreter
    
    init(
        urlSessionFactory: URLSessionFactory = FoundationURLSessionFactory(),
        urlRequest: URLRequest,
        interpreter: Interpreter,
        onReceiveContent: @escaping @Sendable (StreamingSession, ResultType) -> Void,
        onProcessingError: @escaping @Sendable (StreamingSession, Error) -> Void,
        onComplete: @escaping @Sendable (StreamingSession, Error?) -> Void
    ) {
        self.urlSessionFactory = urlSessionFactory
        self.urlRequest = urlRequest
        self.interpreter = interpreter
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
        onComplete?(self, error)
    }
    
    func urlSession(_ session: any URLSessionProtocol, dataTask: any URLSessionDataTaskProtocol, didReceive data: Data) {
        interpreter.processData(data)
    }

    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400 {
            let error = OpenAIError.statusError(response: httpResponse, statusCode: httpResponse.statusCode)
            self.onProcessingError?(self, error)
            completionHandler(.cancel)
            return
        }
        completionHandler(.allow)
    }

    private func subscribeToParser() {
        interpreter.setCallbackClosures { [weak self] content in
            guard let self else { return }
            self.onReceiveContent?(self, content)
        } onError: { [weak self] error in
            guard let self else { return }
            onProcessingError?(self, error)
        }
    }
}
