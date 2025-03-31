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
    @StateObject var chatStore: ChatStore
    @StateObject var imageStore: ImageStore
    @StateObject var assistantStore: AssistantStore
    @StateObject var miscStore: MiscStore
    @StateObject var responsesStore: ResponsesStore

    @State var isShowingAPIConfigModal: Bool = true

    @Environment(\.idProviderValue) var idProvider
    @Environment(\.dateProviderValue) var dateProvider

    init(
        apiKey: Binding<String>,
        idProvider: @escaping () -> String
    ) {
        self._apiKey = apiKey
        self._chatStore = StateObject(
            wrappedValue: ChatStore(
                openAIClient: OpenAI(apiToken: apiKey.wrappedValue),
                idProvider: idProvider
            )
        )
        self._imageStore = StateObject(
            wrappedValue: ImageStore(
                openAIClient: OpenAI(apiToken: apiKey.wrappedValue)
            )
        )
        self._assistantStore = StateObject(
            wrappedValue: AssistantStore(
                openAIClient: OpenAI(apiToken: apiKey.wrappedValue),
                idProvider: idProvider
            )
        )
        self._miscStore = StateObject(
            wrappedValue: MiscStore(
                openAIClient: OpenAI(apiToken: apiKey.wrappedValue)
            )
        )
        self._responsesStore = StateObject(
            wrappedValue: ResponsesStore(
                client: OpenAI(apiToken: apiKey.wrappedValue).responses
            )
        )
    }

    var body: some View {
        ContentView(
            chatStore: chatStore,
            imageStore: imageStore,
            assistantStore: assistantStore,
            miscStore: miscStore,
            responsesStore: responsesStore
        )
        .onChange(of: apiKey) { _, newApiKey in
            let client = OpenAI(apiToken: newApiKey)
            chatStore.openAIClient = client
            imageStore.openAIClient = client
            assistantStore.openAIClient = client
            miscStore.openAIClient = client
            responsesStore.client = client.responses
        }
    }
}
