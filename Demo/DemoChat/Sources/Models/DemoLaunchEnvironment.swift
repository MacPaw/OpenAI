//
//  DemoLaunchEnvironment.swift
//  DemoChat
//

import Foundation

/// Configuration the demo can take from its launch environment instead of asking for it.
///
/// It is used as the configuration for the current launch; the app does not write it to storage itself. If any of
/// the variables is set, the app ignores all saved data for that launch (see ``isProvided(in:)``), and when the
/// configuration is usable it also skips the API Configuration screen it otherwise opens at launch. Set the
/// variables in the Xcode scheme, or pass them to `xcrun simctl launch` with a `SIMCTL_CHILD_` prefix.
public enum DemoLaunchEnvironment {
    /// An ``APIProvider`` raw value (`openAI`, `gemini` or `custom`), compared ignoring case. Defaults to OpenAI.
    public static let providerVariable = "DEMO_API_PROVIDER"
    /// The provider's API key. Without it, no configuration is taken from the environment.
    public static let apiKeyVariable = "DEMO_API_KEY"
    /// The base URL, used only with the `custom` provider.
    public static let baseURLVariable = "DEMO_API_BASE_URL"
    public static let githubTokenVariable = "GITHUB_TOKEN"

    /// Whether `environment` supplies any part of the configuration, even an unusable one. The app then starts from
    /// exactly what the environment gives it and ignores everything it saved earlier (the configuration, the GitHub
    /// token, the enabled MCP tools, remembered model IDs), so a test run doesn't depend on previous state. Saving
    /// during the session still stores and uses the new values.
    public static func isProvided(in environment: [String: String]) -> Bool {
        [providerVariable, apiKeyVariable, baseURLVariable, githubTokenVariable]
            .contains { value(of: $0, in: environment) != nil }
    }

    /// The configuration described by `environment`, or `nil` if there is no API key or the provider isn't recognized.
    public static func configuration(from environment: [String: String]) -> DemoAPIConfiguration? {
        guard let apiKey = value(of: apiKeyVariable, in: environment) else {
            return nil
        }
        let provider: APIProvider
        if let name = value(of: providerVariable, in: environment) {
            guard let match = APIProvider.allCases.first(where: { $0.rawValue.lowercased() == name.lowercased() }) else {
                return nil
            }
            provider = match
        } else {
            provider = .openAI
        }
        return DemoAPIConfiguration(
            provider: provider,
            apiKey: apiKey,
            customBaseURL: provider == .custom ? value(of: baseURLVariable, in: environment) ?? "" : ""
        )
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
