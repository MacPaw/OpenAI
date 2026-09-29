//
//  APIProvider.swift
//  DemoChat
//

import Foundation
import OpenAI

public enum APIProvider: String, CaseIterable, Identifiable, Sendable {
    case openAI
    case gemini
    case custom

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .openAI:
            return "OpenAI"
        case .gemini:
            return "Gemini"
        case .custom:
            return "Custom"
        }
    }

    public var defaultBaseURL: String? {
        switch self {
        case .openAI:
            return "https://api.openai.com/v1"
        case .gemini:
            return "https://generativelanguage.googleapis.com/v1beta/openai"
        case .custom:
            return nil
        }
    }

    public var parsingOptions: ParsingOptions {
        switch self {
        case .openAI:
            return []
        case .gemini, .custom:
            return .relaxed
        }
    }
}

public struct APIEndpoint: Equatable, Sendable {
    public let scheme: String
    public let host: String
    public let port: Int
    public let basePath: String

    public init?(baseURL: String) {
        let trimmedBaseURL = baseURL.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedBaseURL.isEmpty else {
            return nil
        }

        let hasScheme = trimmedBaseURL.contains("://")
        if !hasScheme {
            let lowercasedBaseURL = trimmedBaseURL.lowercased()
            guard !lowercasedBaseURL.hasPrefix("http:"), !lowercasedBaseURL.hasPrefix("https:") else {
                return nil
            }
        }

        let valueWithScheme = hasScheme
            ? trimmedBaseURL
            : "https://\(trimmedBaseURL)"

        guard
            let components = URLComponents(string: valueWithScheme),
            let scheme = components.scheme?.lowercased(),
            scheme == "http" || scheme == "https",
            let host = components.host,
            !host.isEmpty,
            scheme == "https" || Self.isLoopbackHost(host),
            components.user == nil,
            components.password == nil,
            components.query == nil,
            components.fragment == nil,
            components.url != nil
        else {
            return nil
        }

        let port = components.port ?? (scheme == "https" ? 443 : 80)
        guard (1...65_535).contains(port) else {
            return nil
        }

        self.scheme = scheme
        self.host = host
        self.port = port
        self.basePath = components.path.isEmpty ? "/v1" : components.path
    }

    private static func isLoopbackHost(_ host: String) -> Bool {
        let lowercasedHost = host.lowercased()
        if lowercasedHost == "localhost" || lowercasedHost == "[::1]" {
            return true
        }

        let octets = lowercasedHost.split(separator: ".", omittingEmptySubsequences: false)
        return octets.count == 4 && octets[0] == "127" && octets.allSatisfy { octet in
            guard let value = UInt8(octet) else {
                return false
            }
            // Only accept canonical decimal octets, not shorthand, signed, or octal forms.
            return String(value) == octet
        }
    }

    public func configuration(
        token: String?,
        parsingOptions: ParsingOptions = []
    ) -> OpenAI.Configuration {
        OpenAI.Configuration(
            token: token,
            host: host,
            port: port,
            scheme: scheme,
            basePath: basePath,
            parsingOptions: parsingOptions
        )
    }
}
