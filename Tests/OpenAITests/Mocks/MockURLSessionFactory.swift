//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 10.03.2025.
//

import Foundation
@testable import OpenAI

class MockURLSessionFactory: URLSessionFactory, @unchecked Sendable {
    var urlSession: URLSessionMock = .init()
    
    func makeUrlSession(delegate: any URLSessionDataDelegateProtocol) -> any URLSessionProtocol {
        urlSession.delegate = delegate
        return urlSession
    }
}
