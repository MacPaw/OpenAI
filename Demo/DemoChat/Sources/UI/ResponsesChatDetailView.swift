//
//  ResponsesChatDetailView.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 29.03.2025.
//

import SwiftUI
import ExyteChat
import OpenAI
import Combine

public struct ResponsesChatDetailView: View {
    @State private var errorTitle = ""
    @State private var errorAlertPresented = false
    @StateObject private var settingsStore = ResponsesSettingsStore()
    
    private var settingsDescription: String {
        var elements: [String] = ["Model: \(settingsStore.selectedModel)"]
        
        elements.append("stream: \(settingsStore.stream ? "true" : "false")")
        
        if settingsStore.webSearchEnabled {
            elements.append("tools: Web Search")
        }
        
        return elements.joined(separator: ", ")
    }
    
    @ObservedObject var store: ResponsesStore
    
    public init(store: ResponsesStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            chatView()
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        HStack {
                            if store.webSearchInProgress {
                                Image(systemName: "globe")
                                Text("Searching Web…")
                                    
                            } else if store.inProgress {
                                Text("Streaming…")
                            } else {
                                Text("Responses API")
                            }
                        }.fontWeight(.semibold)
                        
                        Text(settingsDescription)
                            .font(.caption)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ResponsesChatSettingsView(store: settingsStore)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .alert(errorTitle, isPresented: $errorAlertPresented, actions: {})
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
                        try await store.send(
                            message: draftMessage,
                            model: settingsStore.selectedModel,
                            stream: settingsStore.stream,
                            webSearchEnabled: settingsStore.webSearchEnabled
                        )
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

#Preview {
    @Previewable @State var store: ResponsesStore = {
        let store = ResponsesStore(client: PreviewMockResponsesEndpointProtocol())
        store.webSearchInProgress = true
        return store
    }()
    
    ResponsesChatDetailView(store: store)
}

private struct PreviewMockResponsesEndpointProtocol: ResponsesEndpointProtocol {
    func createResponse(query: CreateModelResponseQuery) -> AnyPublisher<ResponseObject, any Error> {
        fatalError()
    }
    
    func createResponseStreaming(query: CreateModelResponseQuery) -> AnyPublisher<Result<ResponseStreamEvent, any Error>, any Error> {
        fatalError()
    }
    
    func createResponse(query: CreateModelResponseQuery, completion: @escaping @Sendable (Result<ResponseObject, any Error>) -> Void) -> any CancellableRequest {
        fatalError()
    }
    
    func createResponse(query: CreateModelResponseQuery) async throws -> ResponseObject {
        fatalError()
    }
    
    func createResponseStreaming(query: CreateModelResponseQuery) -> AsyncThrowingStream<ResponseStreamEvent, any Error> {
        fatalError()
    }
    
    func createResponseStreaming(query: CreateModelResponseQuery, onResult: @escaping @Sendable (Result<ResponseStreamEvent, any Error>) -> Void, completion: (@Sendable ((any Error)?) -> Void)?) -> any CancellableRequest {
        fatalError()
    }
}
