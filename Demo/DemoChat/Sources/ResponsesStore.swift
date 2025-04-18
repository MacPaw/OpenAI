//
//  ResponsesStore.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 08.04.2025.
//

import SwiftUI
import ExyteChat
import OpenAI

@MainActor
public final class ResponsesStore: ObservableObject {
    public struct ConversationTurn: Identifiable, Hashable, Sendable {
        public enum TurnType: Sendable {
            case userInput
            case response
        }
        
        public let id: String
        public let type: TurnType
        public let chatMessage: ExyteChat.Message
    }
    
    public enum StoreError: DescribedError {
        case unhandledOutputItem(OutputItem)
        case noResponseToUpdate
        case noMessageToUpdate
        case messageBeingUpdatedIsExpectedToBeLastInArray
        case unexpectedMessage(id: String, expectedId: String)
        case unhandledResponseStreamEvent(ResponseStreamEvent)
        case incompleteLocalTextOnOutputTextDoneEvent(local: String, remote: String)
        case noInputImageData(Sendable)
        case couldNotResizeInputImage
    }
    
    private class ResponseData {
        let id: String
        
        var message: MessageData?
        
        init(id: String, message: MessageData? = nil) {
            self.id = id
            self.message = message
        }
    }
    
    private class MessageData {
        let id: String
        let user: User
        
        var text: String = ""
        var refusalText: String = ""
        var annotations: [ResponseStreamEvent.Annotation] = []
        
        init(id: String, user: User, text: String, annotations: [ResponseStreamEvent.Annotation]) {
            self.id = id
            self.user = user
            self.text = text
            self.annotations = annotations
        }
    }
    
    private var responseBeingStreamed: ResponseData?
    private var currentUpdateTask: Task<Void, Never>?
    private var conversationTurnForNextUpdateTask: ConversationTurn?
    private var responses: [ConversationTurn] = [] {
        didSet {
            chatMessages = responses.map(\.chatMessage)
        }
    }
    
    private var messageBeingStreamed: MessageData? {
        get {
            responseBeingStreamed?.message
        }
        
        set {
            assert(responseBeingStreamed != nil)
            responseBeingStreamed?.message = newValue
        }
    }
    
    public var client: ResponsesEndpointProtocol
    
    @Published var chatMessages: [ExyteChat.Message] = []
    @Published var inProgress = false
    @Published var webSearchInProgress = false
    
    public init(client: ResponsesEndpointProtocol) {
        self.client = client
    }
    
    public func send(message: ExyteChat.DraftMessage, model: Model, stream: Bool, webSearchEnabled: Bool) async throws {
        guard !inProgress else {
            return
        }
        
        inProgress = true
        defer {
            inProgress = false
        }
        
        let messageId = UUID().uuidString
        let currentUserId = UUID().uuidString
        await responses.append(.init(
            id: messageId,
            type: .userInput,
            chatMessage: .makeMessage(
                id: messageId,
                user: .init(
                    id: currentUserId,
                    name: "Me",
                    avatarURL: nil,
                    isCurrentUser: true),
                status: .none,
                draft: message
            )
        ))
        
        let input: CreateModelResponseQuery.Input
        
        if let media = message.medias.first, media.type == .image {
            guard let imageData = await media.getData() else {
                throw StoreError.noInputImageData(media)
            }
            
            guard let image = UIImage(data: imageData) else {
                throw StoreError.noInputImageData(media)
            }
            
            let resizedImage = image.resizedToFit()
            guard let resizedImageData = resizedImage.pngData() else {
                throw StoreError.couldNotResizeInputImage
            }
            
            input = .inputItemList([
                .inputMessage(.init(
                    role: .user,
                    content: .textInput(message.text)
                )),
                .inputMessage(.init(
                    role: .user,
                    content: .inputItemContentList([
                        .inputImage(
                            .init(imageData: resizedImageData, detail: .auto)
                        )
                    ]))
                )
            ])
        } else {
            input = .textInput(message.text)
        }
        
        let previousResponseId = responses.last(where: { $0.type == .response })?.id
        let query = CreateModelResponseQuery(
            input: input,
            model: model,
            previousResponseId: previousResponseId,
            stream: stream,
            tools: webSearchEnabled ? [.WebSearchTool(.init(_type: .webSearchPreview))] : []
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
            switch output {
            case .outputMessage(let outputMessage):
                let message = chatMessage(
                    fromOutputContent: outputMessage.content[0],
                    messageId: outputMessage.id,
                    userId: outputMessage.role.rawValue,
                    username: outputMessage.role.rawValue
                )
                
                responses.append(
                    .init(
                        id: response.id,
                        type: .response,
                        chatMessage: message
                    )
                )
            default:
                throw StoreError.unhandledOutputItem(output)
            }
        }
    }
    
    private func createResponseStreaming(query: CreateModelResponseQuery) async throws {
        let stream: AsyncThrowingStream<ResponseStreamEvent, Error> = client.createResponseStreaming(query: query)
        
        var eventNumber = 1
        for try await event in stream {
            try handleResponseStreamEvent(event)
            eventNumber += 1
        }
    }
    
    private func handleResponseStreamEvent(_ event: ResponseStreamEvent) throws {
        switch event {
        case .created(let responseEvent):
            // #1
            inProgress = true
            responseBeingStreamed = .init(id: responseEvent.response.id)
        case .inProgress(_ /* let responseInProgressEvent */):
            // #2
            inProgress = true
        case .outputItem(let outputItemEvent):
            try handleOutputItemEvent(outputItemEvent)
        case .webSearchCall(let webSearchCallEvent):
            switch webSearchCallEvent {
            case .inProgress(_ /* let inProgressEvent */):
                webSearchInProgress = true
            case .searching(_ /* let searchingEvent */):
                webSearchInProgress = true
            case .completed(_ /* let completedEvent */):
                webSearchInProgress = false
            }
        case .contentPart(.added(let contentPartAddedEvent)):
            try updateMessageBeingStreamed(
                messageId: contentPartAddedEvent.itemId,
                outputContent: contentPartAddedEvent.part
            )
        case .outputText(let outputTextEvent):
            try handleOutputTextEvent(outputTextEvent)
        case .contentPart(.done(let contentPartDoneEvent)):
            try updateMessageBeingStreamed(
                messageId: contentPartDoneEvent.itemId,
                outputContent: contentPartDoneEvent.part,
            )
        case .completed(_ /* let responseEvent */):
            // # 29
            responseBeingStreamed = nil
            inProgress = false
        default:
            throw StoreError.unhandledResponseStreamEvent(event)
        }
    }
    
    private func handleOutputItemEvent(_ event: ResponseStreamEvent.OutputItemEvent) throws {
        switch event {
        case .added(let outputItemAddedEvent):
            let outputItem = outputItemAddedEvent.item
            
            switch outputItem {
            case .outputMessage(let outputMessage):
                // Message, role: assistant
                let role = outputMessage.role.rawValue
                // outputMessage.content is empty, but we can add empty message just to show a progress
                try setMessageBeingStreamed(message: .init(
                    id: outputMessage.id,
                    user: systemUser(withId: role, username: role),
                    text: "",
                    annotations: []
                ))
            case .webSearchToolCall(_ /* let webSearchToolCall */):
                webSearchInProgress = true
            default:
                throw StoreError.unhandledOutputItem(outputItem)
            }
        case .done(let outputItemDoneEvent):
            let outputItem: OutputItem = outputItemDoneEvent.item
            
            switch outputItem {
            case .outputMessage(let outputMessage):
                // Message. Role: assistant
                assert(outputMessage.id == messageBeingStreamed?.id)
                for content in outputMessage.content {
                    try updateMessageBeingStreamed(
                        messageId: outputMessage.id,
                        outputContent: content
                    )
                }
                messageBeingStreamed = nil
            case .webSearchToolCall(_ /* let webSearchToolCall */):
                webSearchInProgress = false
            default:
                throw StoreError.unhandledOutputItem(outputItem)
            }
        }
    }
    
    private func handleOutputTextEvent(_ outputTextEvent: ResponseStreamEvent.OutputTextEvent) throws {
        switch outputTextEvent {
        case .delta(let responseTextDeltaEvent):
            try applyOutputTextDeltaToMessageBeingStreamed(
                messageId: responseTextDeltaEvent.itemId,
                newText: responseTextDeltaEvent.delta
            )
        case .annotationAdded(let annotationDeltaEvent):
            try applyOutputTextAnnotationDeltaToMessageBeingStreamed(
                messageId: annotationDeltaEvent.itemId,
                addedAnnotation: annotationDeltaEvent.annotation
            )
        case .done(let responseTextDoneEvent):
            if messageBeingStreamed?.text != responseTextDoneEvent.text {
                throw StoreError.incompleteLocalTextOnOutputTextDoneEvent(
                    local: messageBeingStreamed?.text ?? "",
                    remote: responseTextDoneEvent.text
                )
            }
        }
    }
    
    private func setMessageBeingStreamed(message: MessageData) throws {
        guard let responseBeingStreamed else {
            fatalError()
        }
        
        if let messageBeingStreamed, message.id == messageBeingStreamed.id {
            responses.removeLast()
        }
        
        messageBeingStreamed = message
        responses.append(
            .init(
                id: responseBeingStreamed.id,
                type: .response,
                chatMessage: chatMessage(from: message)
            )
        )
    }
    
    private func updateMessageBeingStreamed(
        messageId: String,
        outputContent: ResponseStreamEvent.Schemas.OutputContent,
    ) throws {
        try updateMessageBeingStreamed(messageId: messageId) { message in
            switch outputContent {
            case .OutputText(let outputText):
                message.text = outputText.text
                message.annotations = outputText.annotations
            case .Refusal(let refusal):
                message.refusalText = refusal.refusal
            }
        }
    }
    
    private func conversationTurn(withResponseData responseData: ResponseData, messageData: MessageData) -> ConversationTurn {
        .init(
            id: responseData.id,
            type: .response,
            chatMessage: chatMessage(from: messageData)
        )
    }
    
    private func chatMessage(from messageData: MessageData) -> ExyteChat.Message {
        makeChatMessage(
            withText: messageData.text,
            annotations: messageData.annotations,
            messageId: messageData.id,
            user: messageData.user
        )
    }
    
    private func replaceLastConversationTurn(with updatedTurn: ConversationTurn) {
        if currentUpdateTask == nil {
            scheduleReplaceConversationTurnTask(withUpdatedTurn: updatedTurn)
        } else {
            conversationTurnForNextUpdateTask = updatedTurn
        }
    }
    
    private func scheduleReplaceConversationTurnTask(withUpdatedTurn updatedTurn: ConversationTurn) {
        currentUpdateTask = .init(operation: {
            // Debouncing because otherwise it's hard for ExyteChat to handle very quick updates
            do {
                // 1000 nano == 1 micro, 1000 micro == 1 milli, 100 milli = 0.1s
                try await Task.sleep(nanoseconds: 1000 * 1000 * 100)
            } catch {
                assert(error is CancellationError)
                return
            }
            
            var messages = self.responses
            messages.removeLast()
            messages.append(updatedTurn)
            self.responses = messages
            self.currentUpdateTask = nil
            
            if let pendingItem = conversationTurnForNextUpdateTask {
                conversationTurnForNextUpdateTask = nil
                scheduleReplaceConversationTurnTask(withUpdatedTurn: pendingItem)
            }
        })
    }
    
    private func applyOutputTextDeltaToMessageBeingStreamed(messageId: String, newText: String) throws {
        try updateMessageBeingStreamed(messageId: messageId) { message in
            message.text += newText
        }
    }
    
    private func applyOutputTextAnnotationDeltaToMessageBeingStreamed(messageId: String, addedAnnotation: ResponseStreamEvent.Annotation) throws {
        try updateMessageBeingStreamed(messageId: messageId) { message in
            message.annotations.append(addedAnnotation)
        }
    }
    
    private func updateMessageBeingStreamed(messageId: String, _ updateClosure: (MessageData) -> Void) throws {
        guard let responseBeingStreamed else {
            throw StoreError.noResponseToUpdate
        }
        
        guard let messageBeingStreamed else {
            throw StoreError.noMessageToUpdate
        }
        
        guard messageBeingStreamed.id == messageId else {
            throw StoreError.unexpectedMessage(id: messageId, expectedId: messageBeingStreamed.id)
        }
        
        updateClosure(messageBeingStreamed)
        replaceLastConversationTurn(
            with: conversationTurn(withResponseData: responseBeingStreamed, messageData: messageBeingStreamed)
        )
    }
    
    private func conversationTurn(
        fromOutputContent outputContent: ResponseStreamEvent.Schemas.OutputContent,
        messageId: String,
        userId: String,
        username: String
    ) throws -> ConversationTurn {
        guard let responseBeingStreamed else {
            throw StoreError.noResponseToUpdate
        }
        
        return .init(
            id: responseBeingStreamed.id,
            type: .response,
            chatMessage: chatMessage(
                fromOutputContent: outputContent,
                messageId: messageId,
                userId: userId,
                username: username
            )
        )
    }
    
    private func chatMessage(
        fromOutputContent outputContent: ResponseStreamEvent.Schemas.OutputContent,
        messageId: String,
        userId: String,
        username: String
    ) -> ExyteChat.Message {
        switch outputContent {
        case .OutputText(let outputText):
            return makeChatMessage(
                withText: outputText.text,
                annotations: outputText.annotations,
                messageId: messageId,
                user: systemUser(withId: userId, username: username)
            )
        case .Refusal(let refusal):
            let message = ExyteChat.Message(
                id: messageId,
                user: systemUser(withId: userId, username: username),
                text: refusal.refusal
            )
            
            return message
        }
    }
    
    private func makeChatMessage(
        withText text: String,
        annotations: [ResponseStreamEvent.Annotation],
        messageId: String,
        user: ExyteChat.User
    ) -> ExyteChat.Message {
        let chatMessage = ExyteChat.Message(
            id: messageId,
            user: user,
            text: text
        )
        return chatMessage
    }
    
    private func systemUser(withId id: String, username: String) -> ExyteChat.User {
        .init(
            id: id,
            name: username,
            avatarURL: .init(string: "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/openai-icon.png"),
            type: .system
        )
    }
}
