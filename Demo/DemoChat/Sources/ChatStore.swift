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
        model: ChatModel
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
        model: ChatModel
    ) async {
        guard let conversation = conversations.first(where: { $0.id == conversationId }) else {
            return
        }

        conversationErrors[conversationId] = nil

        do {
            guard let conversationIndex = conversations.firstIndex(where: { $0.id == conversationId }) else {
                return
            }

            let weatherFunction = ChatCompletionCreateParams.ChatCompletionToolParam.FunctionDefinition(
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

            let tools = [ChatCompletionCreateParams.ChatCompletionToolParam(function: weatherFunction)]

            let chatsStream: AsyncThrowingStream<ChatCompletionChunk, Error> = openAIClient.chatsStream(
                query: ChatCompletionCreateParams(
                    messages: conversation.messages.compactMap { message in
                        ChatCompletionCreateParams.ChatCompletionMessageParam(role: message.role, content: message.content)
                    },
                    model: model,
                    tools: tools
                )
            )

            var functionCallNames = [String]()
            var functionCallArguments = [String]()
            for try await partialChatCompletion in chatsStream {
                for choice in partialChatCompletion.choices {
                    let existingMessages = conversations[conversationIndex].messages
                    // Function calls are also streamed, so we need to accumulate.
                    choice.delta.tool_calls?.forEach { toolCallDelta in
                        if let function = toolCallDelta.function {
                            if let name = function.name, let arguments = function.arguments {
                                functionCallNames.append(name)
                                functionCallArguments.append(arguments)
                            }
                        }
                    }
                    var messageText = choice.delta.content ?? ""
                    if let finishReason = choice.finish_reason,
                       finishReason == "function_call" {
                        messageText += "Function call: name=\(functionCallNames) arguments=\(functionCallArguments)"
                    }
                    let message = Message(
                        id: partialChatCompletion.id,
                        role: choice.delta.role ?? .assistant,
                        content: messageText,
                        createdAt: Date(timeIntervalSince1970: TimeInterval(partialChatCompletion.created))
                    )
                    if let existingMessageIndex = existingMessages.firstIndex(where: { $0.id == partialChatCompletion.id }) {
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
