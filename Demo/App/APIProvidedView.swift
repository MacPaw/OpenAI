//
//  APIProvidedView.swift
//  Demo
//
//  Created by Sihao Lu on 4/7/23.
//

import DemoChat
import OpenAI
import SwiftUI

struct APIProvidedView: View {
    @Binding var apiKey: String
    @Binding var proxy: String
    @StateObject var chatStore: ChatStore
    @StateObject var imageStore: ImageStore
    @StateObject var miscStore: MiscStore
    @State var isShowingAPIConfigModal: Bool = true

    @Environment(\.idProviderValue) var idProvider
    @Environment(\.dateProviderValue) var dateProvider

    init(
        apiKey: Binding<String>,
        proxy: Binding<String>,
        idProvider: @escaping () -> String
    ) {
        self._apiKey = apiKey
        self._proxy = proxy
        var client: OpenAI? = nil
        if apiKey.wrappedValue.isEmpty && !proxy.wrappedValue.isEmpty {
            client = OpenAI(proxy: proxy.wrappedValue)
        } else {
            client = OpenAI(apiToken: apiKey.wrappedValue)
        }

        self._chatStore = StateObject(
            wrappedValue: ChatStore(
                openAIClient: client!,
                idProvider: idProvider
            )
        )
        self._imageStore = StateObject(
            wrappedValue: ImageStore(
                openAIClient: client!
            )
        )
        self._miscStore = StateObject(
            wrappedValue: MiscStore(
                openAIClient: client!
            )
        )
    }

    var body: some View {
        ContentView(
            chatStore: chatStore,
            imageStore: imageStore,
            miscStore: miscStore
        )
        .onChange(of: apiKey) { newApiKey in
            let client = OpenAI(apiToken: newApiKey)
            chatStore.openAIClient = client
            imageStore.openAIClient = client
            miscStore.openAIClient = client
        }
        .onChange(of: proxy) { newProxy in
            let client = OpenAI(apiToken: newProxy)
            chatStore.openAIClient = client
            imageStore.openAIClient = client
            miscStore.openAIClient = client
        }
    }
}
