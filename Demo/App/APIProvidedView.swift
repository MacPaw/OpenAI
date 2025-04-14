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

    @State var isShowingAPIConfigModal: Bool = true

    @Environment(\.idProviderValue) var idProvider
    @Environment(\.dateProviderValue) var dateProvider

    init(
        apiKey: Binding<String>,
        idProvider: @escaping () -> String
    ) {
        self._apiKey = apiKey
        
        let client = APIProvidedView.makeClient(apiKey: apiKey.wrappedValue)
        self._chatStore = StateObject(
            wrappedValue: ChatStore(
                openAIClient: client,
                idProvider: idProvider
            )
        )
        self._imageStore = StateObject(
            wrappedValue: ImageStore(
                openAIClient: client
            )
        )
        self._assistantStore = StateObject(
            wrappedValue: AssistantStore(
                openAIClient: client,
                idProvider: idProvider
            )
        )
        self._miscStore = StateObject(
            wrappedValue: MiscStore(
                openAIClient: client
            )
        )
    }

    var body: some View {
        ContentView(
            chatStore: chatStore,
            imageStore: imageStore,
            assistantStore: assistantStore,
            miscStore: miscStore
        )
        .onChange(of: apiKey) { newApiKey in
            let client = APIProvidedView.makeClient(apiKey: newApiKey)
            chatStore.openAIClient = client
            imageStore.openAIClient = client
            assistantStore.openAIClient = client
            miscStore.openAIClient = client
        }
    }
    
    private static func makeClient(apiKey: String) -> OpenAIProtocol {
        OpenAI(apiToken: apiKey)
    }
}
