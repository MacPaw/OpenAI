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
    @Binding var configuration: DemoAPIConfiguration
    @Binding var githubToken: String
    @StateObject var chatStore: ChatStore
    @StateObject var imageStore: ImageStore
    @StateObject var assistantStore: AssistantStore
    @StateObject var miscStore: MiscStore
    @StateObject var responsesStore: ResponsesStore
    @StateObject var mcpToolsStore: MCPToolsStore

    @Environment(\.idProviderValue) var idProvider
    @Environment(\.dateProviderValue) var dateProvider

    init(
        configuration: Binding<DemoAPIConfiguration>,
        sdkConfiguration: OpenAI.Configuration,
        githubToken: Binding<String>,
        ignoresSavedData: Bool,
        idProvider: @escaping () -> String
    ) {
        self._configuration = configuration
        self._githubToken = githubToken

        let client = APIProvidedView.makeClient(
            configuration: sdkConfiguration
        )
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
                client: client.responses
            )
        )
        self._mcpToolsStore = StateObject(
            wrappedValue: MCPToolsStore(githubToken: githubToken, loadsSavedTools: !ignoresSavedData)
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
        .environment(\.apiProvider, configuration.provider)
        .onAppear {
            // Connect MCP tools store to responses store
            responsesStore.mcpToolsStore = mcpToolsStore
        }
        .onChange(of: configuration) { _, _ in rewireClient() }
    }

    private func rewireClient() {
        guard let sdkConfiguration = configuration.sdkConfiguration else { return }
        let client = APIProvidedView.makeClient(configuration: sdkConfiguration)
        chatStore.openAIClient = client
        imageStore.openAIClient = client
        assistantStore.openAIClient = client
        miscStore.openAIClient = client
        responsesStore.client = client.responses
    }

    private static func makeClient(
        configuration: OpenAI.Configuration
    ) -> OpenAI {
        OpenAI(
            configuration: configuration,
            middlewares: [LoggingMiddleware()]
        )
    }
}
