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
    
    public init(store: ResponsesStore) {
        self.store = store
    }
    
    public var body: some View {
        ExyteChat.ChatView(
            messages: store.messages,
            chatType: .conversation,
            replyMode: .answer,
            didSendMessage: { draftMessage in
                Task {
                    try! await store.send(message: draftMessage, stream: true)
                }
        })
        .messageUseMarkdown(true)
    }
}

@MainActor
public final class ResponsesStore: ObservableObject {
    public var client: ResponsesEndpoint
    
    @Published var messages: [ExyteChat.Message] = []
    
    public init(client: ResponsesEndpoint) {
        self.client = client
        self.messages = messages
    }
    
    public func send(message: ExyteChat.DraftMessage, stream: Bool) async throws {
        let query = CreateModelResponseQuery(
            input: .case1("What was a positive news story from today?"),
            model: Model.gpt4_o,
            stream: stream,
            tools: [.WebSearchTool(.init(_type: .webSearchPreview))]
        )
        
        if stream {
            try await createResponseStreaming(query: query)
        } else {
            try await createResponse(query: query)
        }
    }
    
    private func createResponse(query: CreateModelResponseQuery) async throws {
        let response = try await client.createResponse(query: query)
        for output in response.output {
            if let message = output.value1 {
                switch message.content[0] {
                case .OutputText(let outputText):
                    var text = outputText.text
                    
                    if !outputText.annotations.isEmpty {
                        text += "\n\nAnnotations:"
                    }
                    
                    for annotation in outputText.annotations {
                        switch annotation {
                        case .FileCitation(let fileCitation):
                            text += "\nFile citation. File ID: \(fileCitation.fileId)"
                        case .FilePath(let filePath):
                            text += "\nFile path. File ID: \(filePath.fileId)"
                        case .UrlCitation(let urlCitation):
                            text += "\nURL citation. Title: \(urlCitation.title), URL: \(urlCitation.url)"
                        }
                    }
                    
                    let message = ExyteChat.Message(
                        id: message.id,
                        user: .init(
                            id: message.role.rawValue,
                            name: message.role.rawValue,
                            avatarURL: nil,
                            type: .system
                        ),
                        text: text
                    )
                    messages.append(message)
                case .Refusal(let refusal):
                    let message = ExyteChat.Message(
                        id: message.id,
                        user: .init(
                            id: message.role.rawValue,
                            name: message.role.rawValue,
                            avatarURL: nil,
                            type: .system
                        ),
                        text: refusal.refusal
                    )
                    messages.append(message)
                }
            } else if let webSearchCall = output.value4 {
                print(webSearchCall)
            }
        }
    }
    
    private func createResponseStreaming(query: CreateModelResponseQuery) async throws {
        let stream = client.createResponseStreaming(query: query)
        for try await event in stream {
            print(event)
        }
    }
}
