//
//  ListView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import SwiftUI

struct ListView: View {
    @Binding var conversations: [Conversation]
    @Binding var selectedConversationId: Conversation.ID?
    
    var body: some View {
        List(
            $conversations,
            editActions: [.delete],
            selection: $selectedConversationId
        ) { $conversation in
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
        .navigationTitle("Conversations")
    }
}
