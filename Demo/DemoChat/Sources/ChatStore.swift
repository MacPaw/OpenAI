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
    func sendMessage(
        _ message: Message,
        conversationId: Conversation.ID,
        model: Model
    ) async {
        guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationId }) else {
            return
        }
        conversations[conversationIndex].messages.append(message)

        await completeChat(
            conversationId: conversationId,
            model: model
        )
    }
    
    @MainActor
    func completeChat(
        conversationId: Conversation.ID,
        model: Model
    ) async {
        guard let conversation = conversations.first(where: { $0.id == conversationId }) else {
            return
        }
                
        conversationErrors[conversationId] = nil

        do {
            guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationId }) else {
                return
            }

            let chatsStream = openAIClient.chatsStream(
                query: ChatQuery(
                    model: model,
                    messages: conversation.messages.map { message in
                        Chat(role: message.role, content: message.content)
                    },
                    stream: true
                )
            )

            for try await partialChatResult in chatsStream {
                for choice in partialChatResult.choices {
                    let existingMessages = conversations[conversationIndex].messages

                    let message: Message
                    if let delta = choice.delta {
                        message = Message(
                            id: partialChatResult.id,
                            role: delta.role ?? .assistant,
                            content: delta.content ?? "",
                            createdAt: Date(timeIntervalSince1970: TimeInterval(partialChatResult.created))
                        )
                        if let existingMessageIndex = existingMessages.firstIndex(where: { $0.id == partialChatResult.id }) {
                            // Meld into previous message
                            let previousMessage = existingMessages[existingMessageIndex]
                            let combinedMessage = Message(
                                id: message.id, // id stays the same for different deltas
                                role: message.role,
                                content: previousMessage.content + message.content,
                                createdAt: message.createdAt
                            )
                            conversations[conversationIndex].messages[existingMessageIndex] = combinedMessage
                        } else {
                            conversations[conversationIndex].messages.append(message)
                        }
                    } else {
                        let choiceMessage = choice.message!

                        message = Message(
                            id: partialChatResult.id,
                            role: choiceMessage.role,
                            content: choiceMessage.content,
                            createdAt: Date(timeIntervalSince1970: TimeInterval(partialChatResult.created))
                        )

                        if existingMessages.contains(message) {
                            continue
                        }
                        conversations[conversationIndex].messages.append(message)
                    }
                }
            }
        } catch {
            conversationErrors[conversationId] = error
        }
    }
}
