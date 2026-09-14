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
                APIProvidedView(
                    apiKey: $apiKey,
                    providerRawValue: $providerRawValue,
                    baseURL: $baseURL,
                    githubToken: $githubToken,
                    idProvider: idProvider
                )
            }
            #if os(iOS)
            .fullScreenCover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(
                    apiKey: $apiKey,
                    providerRawValue: $providerRawValue,
                    baseURL: $baseURL
                )
            }
            #elseif os(macOS)
            .popover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(
                    apiKey: $apiKey,
                    providerRawValue: $providerRawValue,
                    baseURL: $baseURL
                )
            }
            #endif
        }
    }
}
