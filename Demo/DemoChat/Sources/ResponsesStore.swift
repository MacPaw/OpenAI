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
    
    private var messageBeingStreamed: MessageData?
    
    public var client: ResponsesEndpoint
    
    @Published var inProgress = false
    @Published var messages: [ExyteChat.Message] = []
    @Published var webSearchInProgress = false
    
    enum StoreError: DescribedError {
        case unhandledOutputItem(ResponseStreamEvent.Schemas.OutputItem)
        case noMessageToUpdate
        case messageBeingUpdatedIsExpectedToBeLastInArray
        case unexpectedMessage(id: String, expectedId: String)
        case unhandledResponseStreamEvent(ResponseStreamEvent)
        case incompleteLocalTextOnOutputTextDoneEvent(local: String, remote: String)
        case noInputImageData(Sendable)
        case imageExceedsSizeLimits(CGSize)
    }
    
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
        
        await messages.append(
            .makeMessage(
                id: UUID().uuidString,
                user: .init(
                    id: UUID().uuidString,
                    name: "Me",
                    avatarURL: nil,
                    isCurrentUser: true),
                status: .none,
                draft: message
            )
        )
        
        let input: CreateModelResponseQuery.Input
        
        if let media = message.medias.first, media.type == .image {
            guard let imageData = await media.getData() else {
                throw StoreError.noInputImageData(media)
            }
            
            guard let image = UIImage(data: imageData) else {
                throw StoreError.noInputImageData(media)
            }
            
            let biggerSideSize = max(image.size.height, image.size.width)
            let smallerSideSize = min(image.size.height, image.size.width)
            
            guard biggerSideSize <= 2000, smallerSideSize <= 768 else {
                throw StoreError.imageExceedsSizeLimits(image.size)
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
                            .init(imageData: imageData, detail: .auto)
                        )
                    ]))
                )
            ])
        } else {
            input = .textInput(message.text)
        }
        
        let query = CreateModelResponseQuery(
            input: input,
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
            guard let outputMessage = output.value1 else {
                continue
            }
            
            let message = chatMessage(
                fromOutputContent: outputMessage.content[0],
                messageId: outputMessage.id,
                userId: outputMessage.role.rawValue,
                username: outputMessage.role.rawValue
            )
            
            messages.append(message)
        }
    }
    
    private func createResponseStreaming(query: CreateModelResponseQuery) async throws {
        let stream = client.createResponseStreaming(query: query)
        
        var eventNumber = 1
        for try await event in stream {
            print("--- Event \(1) ---")
            print(event)
            try handleResponseStreamEvent(event)
            eventNumber += 1
            print("\n")
        }
    }
    
    private func handleResponseStreamEvent(_ event: ResponseStreamEvent) throws {
        switch event {
        case .created(_ /* let responseEvent */):
            // #1
            inProgress = true
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
                withOutputContent: contentPartAddedEvent.part,
                messageId: contentPartAddedEvent.itemId
            )
        case .outputText(let outputTextEvent):
            try handleOutputTextEvent(outputTextEvent)
        case .contentPart(.done(let contentPartDoneEvent)):
            try updateMessageBeingStreamed(
                withOutputContent: contentPartDoneEvent.part,
                messageId: contentPartDoneEvent.itemId
            )
        case .completed(_ /* let responseEvent */):
            // # 29
            inProgress = false
        default:
            throw StoreError.unhandledResponseStreamEvent(event)
        }
    }
    
    private func handleOutputItemEvent(_ event: ResponseStreamEvent.OutputItemEvent) throws {
        switch event {
        case .added(let outputItemAddedEvent):
            let outputItem = outputItemAddedEvent.item
            // TODO: improve naming (value4)
            let webSearchToolCall = outputItem.value4
            if webSearchToolCall != nil {
                webSearchInProgress = true
                // TODO: improve naming (value1)
            } else if let outputMessage = outputItem.value1 {
                // Message, role: assistant
                let role = outputMessage.role.rawValue
                // outputMessage.content is empty, but we can add empty message just to show a progress
                setMessageBeingStreamed(message: .init(
                    id: outputMessage.id,
                    user: systemUser(withId: role, username: role),
                    text: "",
                    annotations: []
                ))
            } else {
                throw StoreError.unhandledOutputItem(outputItem)
            }
        case .done(let outputItemDoneEvent):
            let outputItem: Components.Schemas.OutputItem = outputItemDoneEvent.item
            // TODO: improve naming (value4)
            let webSearchToolCall = outputItem.value4
            if webSearchToolCall != nil {
                // Web Search Tool Call
                webSearchInProgress = false
                // TODO: improve naming (value1)
            } else if let outputMessage = outputItem.value1 {
                // Message, role: assistant
            } else {
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
    
    private func setMessageBeingStreamed(message: MessageData) {
        if let messageBeingStreamed, messages.last?.id == messageBeingStreamed.id {
            messages.removeLast()
        }
        
        messageBeingStreamed = message
        messages.append(
            chatMessage(from: message)
        )
    }
    
    private func updateMessageBeingStreamed(
        withOutputContent outputContent: ResponseStreamEvent.Schemas.OutputContent,
        messageId: String
    ) throws {
        guard let messageBeingStreamed else {
            throw StoreError.noMessageToUpdate
        }
        
        guard messageBeingStreamed.id == messageId else {
            throw StoreError.unexpectedMessage(id: messageId, expectedId: messageBeingStreamed.id)
        }
        
        switch outputContent {
        case .OutputText(let outputText):
            messageBeingStreamed.text = outputText.text
            messageBeingStreamed.annotations = outputText.annotations
        case .Refusal(let refusal):
            messageBeingStreamed.refusalText = refusal.refusal
        }
        
        replaceLastChatMessage(
            with: chatMessage(from: messageBeingStreamed)
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
    
    private var currentUpdateTask: Task<Void, Never>?
    private var messageForNextUpdateTask: ExyteChat.Message?
    
    private func replaceLastChatMessage(with chatMessage: ExyteChat.Message) {
        if currentUpdateTask == nil {
            scheduleTask(withMessage: chatMessage)
        } else {
            messageForNextUpdateTask = chatMessage
        }
    }
    
    private func scheduleTask(withMessage chatMessage: ExyteChat.Message) {
        currentUpdateTask = .init(operation: {
            // Debouncing because otherwise it's hard for ExyteChat to handle very quick updates
            do {
                // 1000 nano == 1 micro, 1000 micro == 1 milli, 100 milli = 0.1s
                try await Task.sleep(nanoseconds: 1000 * 1000 * 100)
            } catch {
                assert(error is CancellationError)
                return
            }
            
            var messages = self.messages
            messages.removeLast()
            messages.append(chatMessage)
            self.messages = messages
            self.currentUpdateTask = nil
            
            if let nextMessage = messageForNextUpdateTask {
                messageForNextUpdateTask = nil
                scheduleTask(withMessage: nextMessage)
            }
        })
    }
    
    private func applyOutputTextDeltaToMessageBeingStreamed(messageId: String, newText: String) throws {
        guard let messageBeingStreamed else {
            throw StoreError.noMessageToUpdate
        }
        
        guard messageBeingStreamed.id == messageId else {
            throw StoreError.unexpectedMessage(id: messageId, expectedId: messageBeingStreamed.id)
        }
        
        messageBeingStreamed.text += newText
        replaceLastChatMessage(
            with: chatMessage(from: messageBeingStreamed)
        )
    }
    
    private func applyOutputTextAnnotationDeltaToMessageBeingStreamed(messageId: String, addedAnnotation: ResponseStreamEvent.Annotation) throws {
        guard let messageBeingStreamed else {
            throw StoreError.noMessageToUpdate
        }
        
        guard messageBeingStreamed.id == messageId else {
            throw StoreError.unexpectedMessage(id: messageId, expectedId: messageBeingStreamed.id)
        }
        
        messageBeingStreamed.annotations.append(addedAnnotation)
        replaceLastChatMessage(
            with: chatMessage(from: messageBeingStreamed)
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
        var finalText = text
        
        // TODO: decide what to do with annotations
//        if !annotations.isEmpty {
//            finalText += "\n\nAnnotations:"
//        }
//        
//        for annotation in annotations {
//            switch annotation {
//            case .FileCitation(let fileCitation):
//                finalText += "\nFile citation. File ID: \(fileCitation.fileId)"
//            case .FilePath(let filePath):
//                finalText += "\nFile path. File ID: \(filePath.fileId)"
//            case .UrlCitation(let urlCitation):
//                finalText += "\nURL citation. Title: \(urlCitation.title), URL: \(urlCitation.url)"
//            }
//        }
        
        let chatMessage = ExyteChat.Message(
            id: messageId,
            user: user,
            text: finalText
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
