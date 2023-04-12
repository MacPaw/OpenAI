//
//  Store.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation
import Combine
import OpenAI

public final class ChatStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    let idProvider: () -> String

    @Published var conversations: [Conversation] = []
    @Published var conversationErrors: [Conversation.ID: Error] = [:]
    @Published var selectedConversationID: Conversation.ID?

    var selectedConversation: Conversation? {
        selectedConversationID.flatMap { id in
            conversations.first { $0.id == id }
        }
    }

    var selectedConversationPublisher: AnyPublisher<Conversation?, Never> {
        $selectedConversationID.receive(on: RunLoop.main).map { id in
            self.conversations.first(where: { $0.id == id })
        }
        .eraseToAnyPublisher()
    }

    public init(
        openAIClient: OpenAIProtocol,
        idProvider: @escaping () -> String
    ) {
        self.openAIClient = openAIClient
        self.idProvider = idProvider
    }

    // MARK: - Events
    func createConversation() {
        let conversation = Conversation(id: idProvider(), messages: [])
        conversations.append(conversation)
    }
    
    func selectConversation(_ conversationId: Conversation.ID?) {
        selectedConversationID = conversationId
    }
    
    func deleteConversation(_ conversationId: Conversation.ID) {
        conversations.removeAll(where: { $0.id == conversationId })
    }
    
    @MainActor
    func sendMessage(_ message: Message, conversationId: Conversation.ID) async {
        guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationId }) else {
            return
        }
        conversations[conversationIndex].messages.append(message)

        await completeChat(conversationId: conversationId)
    }
    
    @MainActor
    func completeChat(conversationId: Conversation.ID) async {
        guard let conversation = conversations.first(where: { $0.id == conversationId }) else {
            return
        }
                
        conversationErrors[conversationId] = nil

        do {
            let response = try await openAIClient.chats(
                query: ChatQuery(
                    model: .gpt3_5Turbo,
                    messages: conversation.messages.map { message in
                        Chat(role: message.role, content: message.content)
                    }
                )
            )
            
            guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationId }) else {
                return
            }
                    
            let existingMessages = conversations[conversationIndex].messages
            
            for completionMessage in response.choices.map(\.message) {
                let message = Message(
                    id: response.id,
                    role: completionMessage.role,
                    content: completionMessage.content,
                    createdAt: Date(timeIntervalSince1970: TimeInterval(response.created))
                )
                                
                if existingMessages.contains(message) {
                    continue
                }
                conversations[conversationIndex].messages.append(message)
            }
            
        } catch {
            conversationErrors[conversationId] = error
        }
    }
}
