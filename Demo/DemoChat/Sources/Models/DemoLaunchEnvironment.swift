//
//  DemoLaunchEnvironment.swift
//  DemoChat
//

import Foundation

/// Credentials the demo can take from its launch environment instead of asking for them.
///
/// They are used for the current launch only and are not saved. Set them in the Xcode scheme, or pass them to
/// `xcrun simctl launch` as `SIMCTL_CHILD_OPENAI_API_KEY` / `SIMCTL_CHILD_GITHUB_TOKEN`.
public enum DemoLaunchEnvironment {
    public static let apiKeyVariable = "OPENAI_API_KEY"
    public static let githubTokenVariable = "GITHUB_TOKEN"

    /// An OpenAI configuration using the API key from `environment`, or `nil` if none is set.
    public static func configuration(from environment: [String: String]) -> DemoAPIConfiguration? {
        value(of: apiKeyVariable, in: environment).map { DemoAPIConfiguration(provider: .openAI, apiKey: $0) }
    }

    public static func githubToken(from environment: [String: String]) -> String? {
        value(of: githubTokenVariable, in: environment)
    }

    private static func value(of name: String, in environment: [String: String]) -> String? {
        guard let value = environment[name]?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
            return nil
        }
        return value
    }
}
