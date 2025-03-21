//
//  File.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol URLRequestBuildable {
    func build(
        token: String?,
        organizationIdentifier: String?,
        timeoutInterval: TimeInterval,
        customHeaders: [String: String]
    ) throws -> URLRequest
}

extension URLRequestBuildable {
    func build(
        configuration: OpenAI.Configuration
    ) throws -> URLRequest {
        try build(
            token: configuration.token,
            organizationIdentifier: configuration.organizationIdentifier,
            timeoutInterval: configuration.timeoutInterval,
            customHeaders: configuration.customHeaders
        )
    }
}
