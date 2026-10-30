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
    @State private var deletionError: Error?

    public init(store: ChatStore, assistantStore: AssistantStore) {
        self.store = store
        self.assistantStore = assistantStore
    }

    public var body: some View {
        ZStack {
            NavigationSplitView {
                ListView(
                    conversations: store.conversations,
                    selectedConversationId: Binding<Conversation.ID?>(
                        get: {
                            store.selectedConversationID
                        }, set: { newId in
                            store.selectConversation(newId)
                        }),
                    deleteConversations: { ids in
                        do {
                            for id in ids {
                                try store.deleteConversation(id)
                            }
                        } catch {
                            deletionError = error
                        }
                    }
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
                        availableAssistants: assistantStore.availableAssistants,
                        conversation: conversation,
                        error: store.conversationErrors[conversation.id],
                        sendMessage: { message, image, selectedModel, streamEnabled in
                            self.sendMessageTask = Task {
                                await store.sendMessage(
                                    Message(
                                        id: idProvider(),
                                        role: .user,
                                        content: message,
                                        createdAt: dateProvider(),
                                        image: image
                                    ),
                                    conversationId: conversation.id,
                                    model: selectedModel,
                                    isStreamEnabled: streamEnabled
                                )
                            }
                        },
                        isSendingMessage: $store.isSendingMessage
                    )
                    // Each conversation gets its own view state (chosen model, streaming, draft); without this SwiftUI reuses one DetailView across chats.
                    .id(conversation.id)
                }
            }
        }.onDisappear {
            // It may not produce an ideal behavior, but it's here for demonstrating that cancellation works as expected
            sendMessageTask?.cancel()
        }
        .alert(
            "Can't Delete Conversation",
            isPresented: Binding(
                get: { deletionError != nil },
                set: { if !$0 { deletionError = nil } }
            ),
            presenting: deletionError
        ) { _ in
            Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}
