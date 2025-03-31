//
//  ChatView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Combine
import SwiftUI

public struct ChatView: View {
    @ObservedObject var store: ChatStore
    @ObservedObject var assistantStore: AssistantStore

    @Environment(\.dateProviderValue) var dateProvider
    @Environment(\.idProviderValue) var idProvider
    
    @State private var sendMessageTask: Task<Void, Never>?

    public init(store: ChatStore, assistantStore: AssistantStore) {
        self.store = store
        self.assistantStore = assistantStore
    }

    public var body: some View {
        ZStack {
            NavigationSplitView {
                ListView(
                    conversations: $store.conversations,
                    selectedConversationId: Binding<Conversation.ID?>(
                        get: {
                            store.selectedConversationID
                        }, set: { newId in
                            store.selectConversation(newId)
                        })
                )
                .toolbar {
                    ToolbarItem(
                        placement: .primaryAction
                    ) {
                        Menu {
                            Button("Create Chat") {
                                store.createConversation()
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            } detail: {
                if let conversation = store.selectedConversation {
                    DetailView(
                        availableAssistants: assistantStore.availableAssistants, conversation: conversation,
                        error: store.conversationErrors[conversation.id],
                        sendMessage: { message, selectedModel, streamEnabled in
                            self.sendMessageTask = Task {
                                await store.sendMessage(
                                    Message(
                                        id: idProvider(),
                                        role: .user,
                                        content: message,
                                        createdAt: dateProvider()
                                    ),
                                    conversationId: conversation.id,
                                    model: selectedModel,
                                    isStreamEnabled: streamEnabled
                                )
                            }
                        }, isSendingMessage: $store.isSendingMessage
                    )
                }
            }
        }.onDisappear {
            // It may not produce an ideal behavior, but it's here for demonstrating that cancellation works as expected
            sendMessageTask?.cancel()
        }
    }
}
