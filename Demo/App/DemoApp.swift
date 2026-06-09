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
    @AppStorage("apiProvider") var providerRaw: String = APIProvider.openAI.rawValue
    @AppStorage("apiHost") var host: String = APIProvider.openAI.defaultHost ?? "api.openai.com"
    @AppStorage("apiBasePath") var basePath: String = APIProvider.openAI.defaultBasePath ?? "/v1"
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
                    providerRaw: $providerRaw,
                    host: $host,
                    basePath: $basePath,
                    githubToken: $githubToken,
                    idProvider: idProvider
                )
            }
            #if os(iOS)
            .fullScreenCover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(
                    apiKey: $apiKey,
                    providerRaw: $providerRaw,
                    host: $host,
                    basePath: $basePath
                )
            }
            #elseif os(macOS)
            .popover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(
                    apiKey: $apiKey,
                    providerRaw: $providerRaw,
                    host: $host,
                    basePath: $basePath
                )
            }
            #endif
        }
    }
}
