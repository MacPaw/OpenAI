//
//  ResponsesChatDetailView.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 29.03.2025.
//

import SwiftUI
import ExyteChat
import OpenAI

class ResponsesSettingsStore: ObservableObject {
    @Published var selectedModel: Model = .gpt4_o
    @Published var stream = false
    @Published var webSearchEnabled = true
    
    
}

public struct ResponsesChatDetailView: View {
    @ObservedObject var store: ResponsesStore
    
    @State private var errorTitle = ""
    @State private var errorAlertPresented = false
    @State private var isSettingsDisplayed = false
    
    public init(store: ResponsesStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            chatView()
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        if store.webSearchInProgress {
                            Image(systemName: "globe")
                            Text("Searching Web…")
                        } else if store.inProgress {
                            Text("Streaming…")
                        } else {
                            Text("Responses API") // Or you could return Text("Ready") or similar
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSettingsDisplayed = true
                    } label: {
                        Image(systemName: "gearshape")
                    }

                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .alert(errorTitle, isPresented: $errorAlertPresented, actions: {})
            .sheet(isPresented: <#T##Binding<Bool>#>, content: <#T##() -> View#>)
        }
    }
    
    @ViewBuilder
    private func chatView() -> some View {
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
    }
}


