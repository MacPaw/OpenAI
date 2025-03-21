//
//  URLComponents+.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 24.01.2025.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLComponents {
    static func components(perConfiguration configuration: OpenAI.Configuration, path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.port = configuration.port
        
        let pathComponents = [configuration.basePath, path]
            .filter { !$0.isEmpty }
            .map { $0.trimmingCharacters(in: ["/"]) }
        
        components.path = "/" + pathComponents.joined(separator: "/")
        return components
    }
    
    var urlSafe: URL {
        if let url {
            return url
        } else {
            // We're expecting components.url to be not nil
            // But if it isn't, let's just use some URL api that returns non-nil url
            // Let all requests fail, but so that we don't crash on explicit unwrapping
            return URL(fileURLWithPath: "")
        }
    }
}
