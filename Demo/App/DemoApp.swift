//
//  DemoApp.swift
//  Demo
//
//  Created by Sihao Lu on 4/6/23.
//

import DemoChat
import OpenAI
import SwiftUI

@main
struct DemoApp: App {
    @AppStorage("apiKey") var apiKey: String = ""
    @AppStorage("apiProvider") var providerRawValue = APIProvider.openAI.rawValue
    @AppStorage("apiBaseURL") var baseURL = APIProvider.openAI.defaultBaseURL ?? ""
    @AppStorage("apiConfiguration") var configurationData = Data()
    @AppStorage("githubToken") var githubToken: String = ""
    @State var isShowingAPIConfigModal: Bool = true
    /// Credentials from the launch environment, used until the user saves a configuration in this session. Never stored.
    @State private var launchConfiguration = DemoLaunchEnvironment.configuration(from: ProcessInfo.processInfo.environment)
    @State private var launchGitHubToken = DemoLaunchEnvironment.githubToken(from: ProcessInfo.processInfo.environment)

    let idProvider: () -> String
    let dateProvider: () -> Date

    init() {
        self.idProvider = {
            UUID().uuidString
        }
        self.dateProvider = Date.init
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if let sdkConfiguration = configuration.wrappedValue.sdkConfiguration {
                    APIProvidedView(
                        configuration: configuration,
                        sdkConfiguration: sdkConfiguration,
                        githubToken: githubTokenBinding,
                        idProvider: idProvider
                    )
                } else {
                    Button("Configure an API provider") { isShowingAPIConfigModal = true }
                }
            }
            .environment(\.showAPIConfiguration, { isShowingAPIConfigModal = true })
            #if os(iOS)
            .fullScreenCover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(
                    configuration: configuration,
                    isMandatory: configuration.wrappedValue.sdkConfiguration == nil
                )
            }
            #elseif os(macOS)
            .popover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(
                    configuration: configuration,
                    isMandatory: configuration.wrappedValue.sdkConfiguration == nil
                )
            }
            #endif
        }
    }

    private var configuration: Binding<DemoAPIConfiguration> {
        Binding(
            get: {
                if let launchConfiguration {
                    return launchConfiguration
                }
                if configurationData.isEmpty {
                    return .migrating(apiKey: apiKey, providerRawValue: providerRawValue, baseURL: baseURL)
                }
                // A corrupt saved configuration must not silently select another provider.
                return (try? JSONDecoder().decode(DemoAPIConfiguration.self, from: configurationData))
                    ?? DemoAPIConfiguration(provider: .custom)
            },
            set: { value in
                launchConfiguration = nil
                if let data = try? JSONEncoder().encode(value.normalized) {
                    configurationData = data
                }
            }
        )
    }

    private var githubTokenBinding: Binding<String> {
        Binding(
            get: { launchGitHubToken ?? githubToken },
            set: { value in
                launchGitHubToken = nil
                githubToken = value
            }
        )
    }
}
