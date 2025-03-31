//
//  URLSessionDataDelegateForwarder.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class URLSessionDataDelegateForwarder: NSObject, URLSessionDataDelegate {
    let target: URLSessionDataDelegateProtocol
    
    init(target: URLSessionDataDelegateProtocol) {
        self.target = target
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        target.urlSession(session, task: task, didCompleteWithError: error)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        target.urlSession(session, dataTask: dataTask, didReceive: data)
    }
}
