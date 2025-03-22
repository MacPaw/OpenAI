//
//  ModerationChatView.swift
//  DemoChat
//
//  Created by Aled Samuel on 26/04/2023.
//

import SwiftUI

public struct ModerationChatView: View {
    @ObservedObject var store: MiscStore
    
    @Environment(\.dateProviderValue) var dateProvider
    @Environment(\.idProviderValue) var idProvider

    public init(store: MiscStore) {
        self.store = store
    }
    
    public var body: some View {
        DetailView(
            availableAssistants: [], conversation: store.moderationConversation, 
            error: store.moderationConversationError,
            sendMessage: { message, _, _ in
                Task {
                    await store.sendModerationMessage(
                        Message(
                            id: idProvider(),
                            role: .user,
                            content: message,
                            createdAt: dateProvider()
                        )
                    )
                }
            }, isSendingMessage: Binding.constant(false)
        )
    }
}
