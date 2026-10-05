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
    private static let environment = ProcessInfo.processInfo.environment
    /// The launch environment supplied (part of) the configuration, so everything saved earlier is ignored for this launch.
    private let ignoresSavedData = DemoLaunchEnvironment.isProvided(in: DemoApp.environment)
    /// The API Configuration screen opens at launch, except when the launch environment supplies a usable configuration (that skips it so automated runs don't have to dismiss it).
    @State var isShowingAPIConfigModal: Bool = DemoLaunchEnvironment.configuration(from: DemoApp.environment)?.sdkConfiguration == nil
    /// Set when saved data is ignored: the configuration from the environment (or an empty one if it doesn't give a usable one), replaced when the user saves in this session. Nothing here writes it to storage; Save stores whatever the form contains.
    @State private var sessionConfiguration: DemoAPIConfiguration? = DemoLaunchEnvironment.isProvided(in: DemoApp.environment)
        ? DemoLaunchEnvironment.configuration(from: DemoApp.environment) ?? DemoAPIConfiguration()
        : nil
    @State private var sessionGitHubToken: String? = DemoLaunchEnvironment.isProvided(in: DemoApp.environment)
        ? DemoLaunchEnvironment.githubToken(from: DemoApp.environment) ?? ""
        : nil

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
                        ignoresSavedData: ignoresSavedData,
                        idProvider: idProvider
                    )
                } else {
                    Button("Configure an API provider") { isShowingAPIConfigModal = true }
                }
            }
            .environment(\.showAPIConfiguration, { isShowingAPIConfigModal = true })
            .environment(\.ignoresSavedData, ignoresSavedData)
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
                if let sessionConfiguration {
                    return sessionConfiguration
                }
                if configurationData.isEmpty {
                    return .migrating(apiKey: apiKey, providerRawValue: providerRawValue, baseURL: baseURL)
                }
                // A corrupt saved configuration must not silently select another provider.
                return (try? JSONDecoder().decode(DemoAPIConfiguration.self, from: configurationData))
                    ?? DemoAPIConfiguration(provider: .custom)
            },
            set: { value in
                if sessionConfiguration != nil {
                    sessionConfiguration = value.normalized
                }
                if let data = try? JSONEncoder().encode(value.normalized) {
                    configurationData = data
                }
            }
        )
    }

    private var githubTokenBinding: Binding<String> {
        Binding(
            get: { sessionGitHubToken ?? githubToken },
            set: { value in
                if sessionGitHubToken != nil {
                    sessionGitHubToken = value
                }
                githubToken = value
            }
        )
    }
}
