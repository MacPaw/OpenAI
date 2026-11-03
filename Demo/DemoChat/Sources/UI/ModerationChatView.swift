//
//  ModerationChatView.swift
//  DemoChat
//
//  Created by Aled Samuel on 26/04/2023.
//

import SwiftUI

public struct ModerationChatView: View {
    @ObservedObject var store: MiscStore
    
    public init(store: MiscStore) {
        self.store = store
    }
    
    public var body: some View {
        DetailView(
            availableAssistants: [], requiresChatModel: false, conversation: store.moderationConversation, 
            error: store.moderationConversationError,
            sendMessage: { message, _, _, _ in
                Task {
                    await store.sendModerationMessage(
                        Message(
                            id: UUID().uuidString,
                            role: .user,
                            content: message,
                            createdAt: Date()
                        )
                    )
                }
            }, isSendingMessage: Binding.constant(false)
        )
    }
}
