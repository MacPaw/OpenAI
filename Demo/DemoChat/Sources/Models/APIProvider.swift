//
//  APIProvider.swift
//  DemoChat
//

import Foundation
import OpenAI

public enum APIProvider: String, CaseIterable, Codable, Identifiable, Sendable {
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

/// The demo saves provider, credentials and model as one configuration.
public struct DemoAPIConfiguration: Codable, Equatable, Sendable {
    public var provider: APIProvider
    public var apiKey: String
    public var customBaseURL: String
    public var chatModel: String

    public init(
        provider: APIProvider = .openAI,
        apiKey: String = "",
        customBaseURL: String = "",
        chatModel: String? = nil
    ) {
        self.provider = provider
        self.apiKey = apiKey
        self.customBaseURL = customBaseURL
        self.chatModel = chatModel ?? (provider == .openAI ? Model.gpt5_6_luna : "")
    }

    public var baseURL: String {
        provider.defaultBaseURL ?? customBaseURL
    }

    public var normalized: Self {
        Self(
            provider: provider,
            apiKey: apiKey.trimmingCharacters(in: .whitespacesAndNewlines),
            customBaseURL: customBaseURL.trimmingCharacters(in: .whitespacesAndNewlines),
            chatModel: chatModel.trimmingCharacters(in: .whitespacesAndNewlines)
        )
    }

    public var sdkConfiguration: OpenAI.Configuration? {
        let value = normalized
        guard !value.apiKey.isEmpty, !value.chatModel.isEmpty,
              let endpoint = APIEndpoint(baseURL: value.baseURL) else {
            return nil
        }
        return endpoint.configuration(token: value.apiKey, parsingOptions: value.provider.parsingOptions)
    }

    public mutating func selectProvider(_ newProvider: APIProvider) {
        guard provider != newProvider else { return }
        provider = newProvider
        // Never carry credentials or an OpenAI model to a different provider.
        apiKey = ""
        chatModel = newProvider == .openAI ? Model.gpt5_6_luna : ""
    }

    public static func migrating(apiKey: String, providerRawValue: String, baseURL: String) -> Self {
        let provider = APIProvider(rawValue: providerRawValue) ?? .custom
        return Self(
            provider: provider,
            apiKey: apiKey,
            customBaseURL: provider == .custom ? baseURL : ""
        )
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

        if let schemeEnd = valueWithScheme.range(of: "://") {
            let authority = valueWithScheme[schemeEnd.upperBound...].lowercased()
            guard !authority.hasPrefix("http:/"), !authority.hasPrefix("https:/") else {
                return nil
            }
        }

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
        var path = components.path
        while path.hasSuffix("/") {
            path.removeLast()
        }
        self.basePath = path
    }

    /// Display the effective scheme and endpoint, including HTTPS inferred for host-only input.
    public var baseURL: String {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port == (scheme == "https" ? 443 : 80) ? nil : port
        components.path = basePath
        return components.string ?? ""
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
