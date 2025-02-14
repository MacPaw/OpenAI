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

final class StreamingSession<ResultType: Codable>: NSObject, Identifiable, URLSessionDelegate, URLSessionDataDelegate, InvalidatableSession {
    var onReceiveContent: ((StreamingSession, ResultType) -> Void)?
    var onProcessingError: ((StreamingSession, Error) -> Void)?
    var onComplete: ((StreamingSession, Error?) -> Void)?
    
    private let urlRequest: URLRequest
    private lazy var urlSession: URLSession = {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        return session
    }()
    
    private let interpreter = StreamInterpreter<ResultType>()

    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        super.init()
        subscribeToParser()
    }
    
    func perform() {
        self.urlSession
            .dataTask(with: self.urlRequest)
            .resume()
    }
    
    func invalidateAndCancel() {
        urlSession.invalidateAndCancel()
    }
    
    func finishTasksAndInvalidate() {
        urlSession.finishTasksAndInvalidate()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        onComplete?(self, error)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        do {
            try interpreter.processData(data)
        } catch {
            onProcessingError?(self, error)
        }
    }
    
    private func subscribeToParser() {
        interpreter.onEventDispatched = { [weak self] content in
            guard let self else { return }
            self.onReceiveContent?(self, content)
        }
    }
}
