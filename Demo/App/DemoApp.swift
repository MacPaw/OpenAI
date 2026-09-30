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
                        githubToken: $githubToken,
                        idProvider: idProvider
                    )
                    .safeAreaInset(edge: .bottom) {
                        Button("API Configuration") { isShowingAPIConfigModal = true }
                            .buttonStyle(.bordered)
                    }
                } else {
                    Button("Configure an API provider") { isShowingAPIConfigModal = true }
                }
            }
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
                if configurationData.isEmpty {
                    return .migrating(apiKey: apiKey, providerRawValue: providerRawValue, baseURL: baseURL)
                }
                // A corrupt saved configuration must not silently select another provider.
                return (try? JSONDecoder().decode(DemoAPIConfiguration.self, from: configurationData))
                    ?? DemoAPIConfiguration(provider: .custom)
            },
            set: { value in
                if let data = try? JSONEncoder().encode(value.normalized) {
                    configurationData = data
                }
            }
        )
    }
}
