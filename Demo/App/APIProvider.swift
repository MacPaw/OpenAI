//
//  APIProvider.swift
//  Demo
//
//  Predefined provider configurations for the OpenAI-compatible Demo client.
//

import Foundation

enum APIProvider: String, CaseIterable, Identifiable {
    case openAI
    case gemini
    case groq
    case openRouter
    case custom

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .openAI: return "OpenAI"
        case .gemini: return "Gemini (OpenAI-compatible)"
        case .groq: return "Groq"
        case .openRouter: return "OpenRouter"
        case .custom: return "Custom…"
        }
    }

    /// Default host for the provider. `nil` for `.custom` (user fills in).
    var defaultHost: String? {
        switch self {
        case .openAI: return "api.openai.com"
        case .gemini: return "generativelanguage.googleapis.com"
        case .groq: return "api.groq.com"
        case .openRouter: return "openrouter.ai"
        case .custom: return nil
        }
    }

    /// Default basePath for the provider (matches the OpenAI SDK's path style).
    var defaultBasePath: String? {
        switch self {
        case .openAI: return "/v1"
        case .gemini: return "/v1beta/openai"
        case .groq: return "/openai/v1"
        case .openRouter: return "/api/v1"
        case .custom: return nil
        }
    }
}
