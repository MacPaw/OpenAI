//
//  URLBuilder.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.01.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol URLBuilder {
    func buildURL() -> URL
}

struct DefaultURLBuilder: URLBuilder {
    private let configuration: OpenAI.Configuration
    private let path: String
    private let after: String?
    
    init(configuration: OpenAI.Configuration, path: String, after: String? = nil) {
        self.configuration = configuration
        self.path = path
        self.after = after
    }
    
    func buildURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = configuration.host
        components.path = path
        if let after {
            components.queryItems = [URLQueryItem(name: "after", value: after)]
        }
        return components.url!
    }
}

struct AssistantsURLBuilder: URLBuilder {
    let configuration: OpenAI.Configuration
    let path: APIPath.Assistants
    let assistantId: String
    
    func buildURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = configuration.host
        components.path = path.stringValue.replacingOccurrences(of: "ASST_ID", with: assistantId)

        return components.url!
    }
}

struct RunsURLBuilder: URLBuilder {
    let configuration: OpenAI.Configuration
    let path: APIPath.Assistants
    let threadId: String
    let before: String? = nil
    
    func buildURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = configuration.host
        components.path = path.stringValue.replacingOccurrences(of: "THREAD_ID", with: threadId)
        if let before {
            components.queryItems = [URLQueryItem(name: "before", value: before)]
        }
        return components.url!
    }
}

struct RunRetrieveURLBuilder: URLBuilder {
    private let configuration: OpenAI.Configuration
    private let path: APIPath.Assistants
    private let threadId: String
    private let runId: String
    private let before: String?
    
    init(configuration: OpenAI.Configuration, path: APIPath.Assistants, threadId: String, runId: String, before: String? = nil) {
        self.configuration = configuration
        self.path = path
        self.threadId = threadId
        self.runId = runId
        self.before = before
    }
    
    func buildURL() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = configuration.host
        components.path = path.stringValue.replacingOccurrences(of: "THREAD_ID", with: threadId)
                              .replacingOccurrences(of: "RUN_ID", with: runId)
        if let before {
            components.queryItems = [URLQueryItem(name: "before", value: before)]
        }
        return components.url!
    }
}
