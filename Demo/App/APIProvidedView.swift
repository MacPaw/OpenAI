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
    @Binding var githubToken: String
    @StateObject var chatStore: ChatStore
    @StateObject var imageStore: ImageStore
    @StateObject var assistantStore: AssistantStore
    @StateObject var miscStore: MiscStore
    @StateObject var responsesStore: ResponsesStore
    @StateObject var mcpToolsStore: MCPToolsStore

    @State var isShowingAPIConfigModal: Bool = true

    @Environment(\.idProviderValue) var idProvider
    @Environment(\.dateProviderValue) var dateProvider

    init(
        apiKey: Binding<String>,
        githubToken: Binding<String>,
        idProvider: @escaping () -> String
    ) {
        self._apiKey = apiKey
        self._githubToken = githubToken
        
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
        self._responsesStore = StateObject(
            wrappedValue: ResponsesStore(
                client: OpenAI(
                    configuration: .init(token: apiKey.wrappedValue),
                    middlewares: [LoggingMiddleware()]
                ).responses
            )
        )
        self._mcpToolsStore = StateObject(
            wrappedValue: MCPToolsStore(githubToken: githubToken)
        )
    }

    var body: some View {
        ContentView(
            chatStore: chatStore,
            imageStore: imageStore,
            assistantStore: assistantStore,
            miscStore: miscStore,
            responsesStore: responsesStore,
            mcpToolsStore: mcpToolsStore
        )
        .onAppear {
            // Connect MCP tools store to responses store
            responsesStore.mcpToolsStore = mcpToolsStore
        }
        .onChange(of: apiKey) { _, newApiKey in
            let client = APIProvidedView.makeClient(apiKey: newApiKey)
            chatStore.openAIClient = client
            imageStore.openAIClient = client
            assistantStore.openAIClient = client
            miscStore.openAIClient = client
            responsesStore.client = client.responses
        }
    }
    
    private static func makeClient(apiKey: String) -> OpenAIProtocol {
        OpenAI(apiToken: apiKey)
    }
}
