//
//  OpenAIOnlyView.swift
//  DemoChat
//

import SwiftUI

/// Shown in place of a feature that only works with OpenAI when another provider is configured.
public struct OpenAIOnlyView: View {
    let feature: String
    let provider: APIProvider

    public init(feature: String, provider: APIProvider) {
        self.feature = feature
        self.provider = provider
    }

    public var body: some View {
        ContentUnavailableView(
            "\(feature) is OpenAI-only",
            systemImage: "lock",
            description: Text("The current provider is \(provider.displayName). Switch to OpenAI in Misc > API Configuration to use \(feature).")
        )
    }
}
