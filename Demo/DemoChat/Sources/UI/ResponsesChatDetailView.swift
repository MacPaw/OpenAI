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
                    do {
                        try await store.send(message: draftMessage, stream: true)
                    } catch {
                        print("store.send(message) error: \(error)")
                    }
                }
        })
        .messageUseMarkdown(true)
    }
}

@MainActor
public final class ResponsesStore: ObservableObject {
    public var client: ResponsesEndpoint
    
    @Published var inProgress = false
    @Published var messages: [ExyteChat.Message] = []
    
    public init(client: ResponsesEndpoint) {
        self.client = client
        self.messages = messages
    }
    
    public func send(message: ExyteChat.DraftMessage, stream: Bool) async throws {
        guard !inProgress else {
            return
        }
        
        inProgress = true
        defer {
            inProgress = false
        }
        
//        messages.append(.makeMessage(id: UUID().uuidString, user: .init(id: "", name: <#T##String#>, avatarURL: <#T##URL?#>, isCurrentUser: <#T##Bool#>), status: <#T##Message.Status?#>, draft: <#T##DraftMessage#>))
        
        let query = CreateModelResponseQuery(
            input: .case1(message.text),
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
            // TODO: value1
            if let outputMessage = output.value1 {
                switch outputMessage.content[0] {
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
                    
                    let chatMessage = ExyteChat.Message(
                        id: outputMessage.id,
                        user: .init(
                            id: outputMessage.role.rawValue,
                            name: outputMessage.role.rawValue,
                            avatarURL: nil,
                            type: .system
                        ),
                        text: text
                    )
                    messages.append(chatMessage)
                case .Refusal(let refusal):
                    let message = ExyteChat.Message(
                        id: outputMessage.id,
                        user: .init(
                            id: outputMessage.role.rawValue,
                            name: outputMessage.role.rawValue,
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
        
        // Example of event stream with such a query:
        // let query = CreateModelResponseQuery(
        //    input: .case1(message.text),
        //    model: Model.gpt4_o,
        //    stream: stream,
        //    tools: [.WebSearchTool(.init(_type: .webSearchPreview))]
        // )
        //
        // Where "message.text" is "Search internet for the longest word. Reply only the word."
        //
        // Event 1  – Created:
        //   - Response initialized with model "gpt-4o-2024-08-06" and WebSearchTool
        //
        // Event 2  – In Progress:
        //   - Response status set to "in_progress"
        //
        // Event 3  – Output Item Added – Web Search Tool Call:
        //   - WebSearchToolCall (ID: "ws_...") added to output
        //
        // Event 4  – Web Search Call In Progress:
        //   - Tool call status: inProgress
        //
        // Event 5  – Web Search Call Searching:
        //   - Search action started
        //
        // Event 6  – Web Search Call Completed:
        //   - Search completed successfully
        //
        // Event 7  – Output Item Done – Web Search Tool Call:
        //   - Tool call output marked as complete
        //
        // Event 8  – Output Item Added – Assistant Message:
        //   - Message (ID: "msg_...") with role: assistant begins
        //
        // Event 9  – Content Part Added:
        //   - Message content streaming started
        //
        // Events 10–25 – Output Text Delta:
        //   - Text streamed incrementally: "pneumonoultramicroscopicsilicovolcanoconiosis"
        //
        // Event 26 – Output Text Done:
        //   - Full text chunk assembled
        //
        // Event 27 – Content Part Done:
        //   - Text content part finalized
        //
        // Event 28 – Output Item Done – Assistant Message:
        //   - Message marked as complete
        //
        // Event 29 – Completed:
        //   - Entire response finalized with tool and message outputs
        //   - Token usage: 313 in, 35 out, 348 total
        
        var eventNumber = 1
        for try await event in stream {
            print("--- Event \(eventNumber) ---")
            eventNumber += 1
            print(event)
            print("\n")
            
            switch event {
            case .created(let responseCreatedEvent):
                // #1
                break
            case .inProgress(let responseInProgressEvent):
                // #2
                break
            case .outputItem(.added(let outputItemAddedEvent)):
                // #3 - Web Search Tool Call
                // #8 - Message, role: assistant
                break
            case .webSearchCall(let webSearchCallEvent):
                switch webSearchCallEvent {
                case .inProgress(let inProgressEvent):
                    // #4
                    break
                case .searching(let searchingEvent):
                    // #5
                    break
                case .completed(let completedEvent):
                    // #6
                    break
                }
            case .outputItem(.done(let outputItemDoneEvent)):
                // #7 - Web Search Tool Call
                // #28 - Message, role: assistant
                break
            case .contentPart(.added(let addedEvent)):
                // # 9
                break
            case .outputText(.delta(let responseTextDeltaEvent)):
                // # 10 - 25
                break
            case .outputText(.done(let responseTextDoneEvent)):
                // # 26
                break
            case .contentPart(.done(let contentPartDoneEvent)):
                // # 27
                break
            case .completed(let responseEvent):
                // # 29
                break
            default:
                break
            }
        }
    }
}
