//
//  ResponsesChatDetailView.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 29.03.2025.
//

import SwiftUI
import ExyteChat
import OpenAI

public struct ResponsesChatDetailView: View {
    @ObservedObject var store: ResponsesStore
    
    @State private var errorTitle = ""
    @State private var errorAlertPresented = false
    
    public init(store: ResponsesStore) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            ExyteChat.ChatView(
                messages: store.chatMessages,
                chatType: .conversation,
                replyMode: .answer,
                didSendMessage: { draftMessage in
                    Task {
                        do {
                            try await store.send(message: draftMessage, stream: true)
                        } catch {
                            errorTitle = error.localizedDescription
                            errorAlertPresented = true
                        }
                    }
            })
            .setAvailableInputs([.text, .media])
            .messageUseMarkdown(true)
            
            VStack {
                Text("Searching Web...")
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.init(uiColor: .secondarySystemBackground)
                    )
                    .opacity(store.webSearchInProgress ? 1 : 0)
                Spacer()
            }
        }.alert(errorTitle, isPresented: $errorAlertPresented, actions: {})
    }
}


