//
//  ListView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import SwiftUI

struct ListView: View {
    let conversations: [Conversation]
    @Binding var selectedConversationId: Conversation.ID?
    /// Asks to delete the conversations with these IDs. The list shows `conversations`, so a row disappears only once
    /// it's removed from there.
    let deleteConversations: ([Conversation.ID]) -> Void

    var body: some View {
        List(selection: $selectedConversationId) {
            ForEach(conversations) { conversation in
                if let convoContent = conversation.messages.last?.content {
                    Text(
                        convoContent
                    )
                    .lineLimit(2)
                }
                else {
                    if conversation.type == .assistant {
                        Text(
                            "New Assistant"
                        )
                        .lineLimit(2)
                    }
                    else {
                        Text(
                            "New Conversation"
                        )
                        .lineLimit(2)
                    }
                }
            }
            .onDelete { offsets in
                deleteConversations(offsets.map { conversations[$0].id })
            }
        }
        .navigationTitle("Conversations")
    }
}
