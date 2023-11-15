//
//  ChatStore.swift
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

            let weatherFunction = ChatFunctionDeclaration(
                name: "getWeatherData",
                description: "Get the current weather in a given location",
                parameters: .init(
                  type: .object,
                  properties: [
                    "location": .init(type: .string, description: "The city and state, e.g. San Francisco, CA")
                  ],
                  required: ["location"]
                )
            )

            let functions = [weatherFunction]
            
            let chatsStream: AsyncThrowingStream<ChatStreamResult, Error> = openAIClient.chatsStream(
                query: ChatQuery(
                    model: model,
                    messages: conversation.messages.map { message in
                        Chat(role: message.role, content: message.content)
                    },
                    functions: functions
                )
            )

            var functionCallName = ""
            var functionCallArguments = ""
            for try await partialChatResult in chatsStream {
                for choice in partialChatResult.choices {
                    let existingMessages = conversations[conversationIndex].messages
                    // Function calls are also streamed, so we need to accumulate.
                    if let functionCallDelta = choice.delta.functionCall {
                        if let nameDelta = functionCallDelta.name {
                          functionCallName += nameDelta
                        }
                        if let argumentsDelta = functionCallDelta.arguments {
                          functionCallArguments += argumentsDelta
                        }
                    }
                    var messageText = choice.delta.content ?? ""
                    if let finishReason = choice.finishReason,
                       finishReason == "function_call" {
                        messageText += "Function call: name=\(functionCallName) arguments=\(functionCallArguments)"
                    }
                    let message = Message(
                        id: partialChatResult.id,
                        role: choice.delta.role ?? .assistant,
                        content: messageText,
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
                }
            }
        } catch {
            conversationErrors[conversationId] = error
        }
    }
}
