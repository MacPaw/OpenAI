//
//  DemoLaunchEnvironment.swift
//  DemoChat
//

import Foundation

/// Configuration the demo can take from its launch environment instead of asking for it, and a switch to start from
/// a clean slate.
///
/// The configuration is used for the current launch; the app does not write it to storage itself. When it is usable,
/// the app also skips the API Configuration screen it otherwise opens at launch. ``resetVariable`` clears everything
/// the app saved before it reads any of it. Set the variables in the Xcode scheme, or pass them to
/// `xcrun simctl launch` with a `SIMCTL_CHILD_` prefix.
public enum DemoLaunchEnvironment {
    /// An ``APIProvider`` raw value (`openAI`, `gemini` or `custom`), compared ignoring case. Defaults to OpenAI.
    public static let providerVariable = "DEMO_API_PROVIDER"
    /// The provider's API key. Without it, no configuration is taken from the environment.
    public static let apiKeyVariable = "DEMO_API_KEY"
    /// The base URL, used only with the `custom` provider.
    public static let baseURLVariable = "DEMO_API_BASE_URL"
    public static let githubTokenVariable = "GITHUB_TOKEN"

    /// When true (`1`, `true` or `yes`), the app erases everything it saved before reading any of it, so a run
    /// doesn't depend on previous state.
    public static let resetVariable = "DEMO_RESET_SAVED_DATA"

    /// Whether `environment` asks to erase the saved data.
    public static func shouldResetSavedData(in environment: [String: String]) -> Bool {
        guard let value = value(of: resetVariable, in: environment)?.lowercased() else { return false }
        return ["1", "true", "yes"].contains(value)
    }

    /// Erases everything saved in the defaults domain `domain` (the app's bundle identifier).
    public static func resetSavedData(domain: String) {
        UserDefaults.standard.removePersistentDomain(forName: domain)
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
