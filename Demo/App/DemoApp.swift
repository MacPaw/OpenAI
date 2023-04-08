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
                    idProvider: idProvider
                )
            }
            #if os(iOS)
            .fullScreenCover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(apiKey: $apiKey)
            }
            #elseif os(macOS)
            .popover(isPresented: $isShowingAPIConfigModal) {
                APIKeyModalView(apiKey: $apiKey)
            }
            #endif
        }
    }
}
