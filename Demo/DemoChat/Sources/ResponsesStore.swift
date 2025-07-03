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
    struct ConversationTurn: Identifiable, Hashable, Sendable {
        public enum TurnType: Sendable {
            case userInput
            case response
        }
        
        let id: String
        let type: TurnType
        let chatMessage: ExyteChat.Message
    }
    
    struct WeatherFunctionCall: Identifiable {
        let id = UUID()
        let functionName: String
        let location: String
        let unit: String
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
        case unknownFunctionCalled(name: String)
        case noFunctionToolCallToReply
    }
    
    private class ResponseData {
        let id: String
        
        var message: MessageData?
        var functionCall: WeatherFunctionCall?
        
        init(id: String, message: MessageData? = nil, functionCall: WeatherFunctionCall? = nil) {
            self.id = id
            self.message = message
            self.functionCall = functionCall
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
    
    private let weatherFunctionTool = FunctionTool(
        name: "get_current_weather",
        description: "Get the current weather in a given location",
        parameters: .init(
            .type(.object),
            .properties([
                "location": .init(
                    .type(.string),
                    .description("The city and state, e.g. San Francisco, CA")
                ),
                "unit": .init(
                    .type(.string),
                    .enumValues(["celsius", "fahrenheit"])
                )
            ]),
            .required(["location", "unit"]),
            .additionalProperties(.boolean(false))
        ),
        // all fields must be required and additionalProperties set to false, see property's documentation comment on more details
        strict: true
    )
    
    private var responseBeingStreamed: ResponseData?
    private var currentUpdateTask: Task<Void, Never>?
    private var conversationTurnForNextUpdateTask: ConversationTurn?
    private var conversationTurns: [ConversationTurn] = [] {
        didSet {
            chatMessages = conversationTurns.map(\.chatMessage)
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
    
    private var lastFinishedFunctionToolCall: OutputItem.Schemas.FunctionToolCall? {
        didSet {
            guard let call = lastFinishedFunctionToolCall else {
                functionCall = nil
                return
            }
            
            let parsedArguments = parseWeatherFunctionCall(functionName: call.name, arguments: call.arguments)
            functionCall = parsedArguments
        }
    }
    
    public var client: ResponsesEndpointProtocol
    
    @Published private(set) var chatMessages: [ExyteChat.Message] = []
    @Published private(set) var inProgress = false
    @Published var webSearchInProgress = false
    @Published private(set) var functionCall: WeatherFunctionCall? = nil {
        didSet {
            if functionCall != nil {
                onFunctionCalled?()
            }
        }
    }

    // MCP approval request handling
    @Published var pendingMCPApprovalRequest: Components.Schemas.MCPApprovalRequest?
    @Published var showMCPApprovalDialog = false
    private var mcpApprovalRequestResponseId: String?

    // Track the actual OpenAI response IDs for API continuity (separate from conversation turn IDs)
    private var lastOpenAIResponseId: String?

    var onFunctionCalled: (() -> Void)?
    
    /// Reference to MCP tools store for getting enabled tools
    public weak var mcpToolsStore: MCPToolsStore?

    public init(client: ResponsesEndpointProtocol) {
        self.client = client
    }
    
    public func send(message: ExyteChat.DraftMessage, model: Model, stream: Bool, webSearchEnabled: Bool, functionCallingEnabled: Bool, mcpEnabled: Bool = false) async throws {
        guard !inProgress else {
            return
        }
        
        inProgress = true
        defer {
            inProgress = false
        }
        
        let messageId = UUID().uuidString
        let currentUserId = UUID().uuidString
        
        await conversationTurns.append(.init(
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
        
        try await createResponse(
            input: input,
            model: model,
            stream: stream,
            webSearchEnabled: webSearchEnabled,
            functionCallingEnabled: functionCallingEnabled,
            mcpEnabled: mcpEnabled
        )
    }
    
    func replyFunctionCall(result: String, model: Model, stream: Bool, webSearchEnabled: Bool, functionCallingEnabled: Bool, mcpEnabled: Bool = false) async throws {
        guard let toolCall = lastFinishedFunctionToolCall else {
            throw StoreError.noFunctionToolCallToReply
        }
        
        try await createResponse(
            input: .inputItemList([
                .item(.functionToolCall(toolCall)),
                .item(.functionCallOutputItemParam(.init(
                    callId: toolCall.callId,
                    _type: .functionCallOutput,
                    output: result
                )))
            ]),
            model: model,
            stream: stream,
            webSearchEnabled: webSearchEnabled,
            functionCallingEnabled: functionCallingEnabled,
            mcpEnabled: mcpEnabled
        )
        
        lastFinishedFunctionToolCall = nil
    }
    
    func cancelFunctionCall() {
        lastFinishedFunctionToolCall = nil
    }

    // MARK: - MCP Approval Request Handling

    private func handleMCPApprovalRequest(_ approvalRequest: Components.Schemas.MCPApprovalRequest) {
        print("🔐 MCP Approval Request received:")
        print("  ID: \(approvalRequest.id)")
        print("  Server: \(approvalRequest.serverLabel)")
        print("  Tool: \(approvalRequest.name)")
        print("  Arguments: \(approvalRequest.arguments)")

        // Store the approval request and show dialog
        pendingMCPApprovalRequest = approvalRequest
        showMCPApprovalDialog = true

        // Store the current response ID for the approval response
        mcpApprovalRequestResponseId = responseBeingStreamed?.id
    }

    func respondToMCPApprovalRequest(approve: Bool, model: Model, stream: Bool, webSearchEnabled: Bool, functionCallingEnabled: Bool, mcpEnabled: Bool = true) async throws {
        guard let approvalRequest = pendingMCPApprovalRequest else {
            print("❌ No pending MCP approval request to respond to")
            return
        }

        print("\(approve ? "✅" : "❌") Responding to MCP approval request: \(approve ? "APPROVED" : "DENIED")")

        // Create approval response
        let approvalResponse = InputItem.item(.mcpApprovalResponse(.init(_type: .mcpApprovalResponse, approvalRequestId: approvalRequest.id, approve: approve)))

        // Get the stored response ID for the approval response
        let responseIdForApproval = mcpApprovalRequestResponseId

        // Clear the pending request and hide dialog
        pendingMCPApprovalRequest = nil
        showMCPApprovalDialog = false
        mcpApprovalRequestResponseId = nil

        // Send the approval response to continue the conversation
        try await createResponseWithSpecificPreviousId(
            input: .inputItemList([approvalResponse]),
            model: model,
            stream: stream,
            webSearchEnabled: webSearchEnabled,
            functionCallingEnabled: functionCallingEnabled,
            mcpEnabled: mcpEnabled,
            previousResponseId: responseIdForApproval
        )
    }

    func cancelMCPApprovalRequest() {
        pendingMCPApprovalRequest = nil
        showMCPApprovalDialog = false
        mcpApprovalRequestResponseId = nil
    }
    
    private func createResponse(input: CreateModelResponseQuery.Input, model: Model, stream: Bool, webSearchEnabled: Bool, functionCallingEnabled: Bool, mcpEnabled: Bool = false) async throws {
        // Use the actual OpenAI response ID for API continuity, not the conversation turn ID
        let previousResponseId = lastOpenAIResponseId
        try await createResponseWithSpecificPreviousId(
            input: input,
            model: model,
            stream: stream,
            webSearchEnabled: webSearchEnabled,
            functionCallingEnabled: functionCallingEnabled,
            mcpEnabled: mcpEnabled,
            previousResponseId: previousResponseId
        )
    }

    private func createResponseWithSpecificPreviousId(input: CreateModelResponseQuery.Input, model: Model, stream: Bool, webSearchEnabled: Bool, functionCallingEnabled: Bool, mcpEnabled: Bool = false, previousResponseId: String?) async throws {
        var tools: [Tool] = []

        if webSearchEnabled {
            tools.append(.webSearchTool(.init(_type: .webSearchPreview)))
        }

        if functionCallingEnabled {
            tools.append(.functionTool(weatherFunctionTool))
        }

        if mcpEnabled {
            // Check if model supports MCP tools
            let mcpCompatibleModels: Set<String> = [
                Model.gpt4_o, Model.gpt4_1, Model.chatgpt_4o_latest,
                Model.gpt4_o_mini, Model.gpt4_1_mini, Model.gpt4_1_nano
            ]

            if !mcpCompatibleModels.contains(model) {
                print("Warning: Model '\(model)' may not support MCP tools. Recommended models: \(mcpCompatibleModels.joined(separator: ", "))")
            }
            
            // make it flexiable

            // Add GitHub MCP server tool using OpenAI's native MCP support
            let enabledTools = mcpToolsStore?.enabledTools ?? []
            let authHeaders = mcpToolsStore?.authHeaders

            if !enabledTools.isEmpty, let authHeaders = authHeaders {

                let githubMCPTool = Tool.mcpTool(
                    .init(
                        _type: .mcp,
                        serverLabel: "GitHub_MCP_Server",
                        serverUrl: "https://api.githubcopilot.com/mcp/",
                        headers: .init(additionalProperties: authHeaders),
                        allowedTools: mcpToolsStore?.allowedTools,
                        requireApproval: .case2(.always)
                    )
                )
                
                tools.append(githubMCPTool)
                print("Added GitHub MCP server tool with \(enabledTools.count) enabled tools: \(enabledTools)")
                print("MCP tool includes authentication headers: \(authHeaders.keys.joined(separator: ", "))")
            } else if enabledTools.isEmpty {
                print("MCP enabled but no tools selected. Please configure tools in the MCP Tools tab.")
            } else if authHeaders == nil {
                print("MCP enabled but no GitHub token provided. Please enter your GitHub token in the MCP Tools tab.")
            }
        }

        // Debug: Check if previousResponseId might be causing issues
        if let prevId = previousResponseId {
            print("🔍 Using previous OpenAI response ID: \(prevId)")
        } else {
            print("🔍 No previous response ID (first message in conversation)")
        }

        let query = CreateModelResponseQuery(
            input: input,
            model: model,
            previousResponseId: previousResponseId,
            stream: stream,
            toolChoice: tools.isEmpty ? nil : .ToolChoiceOptions(.auto),
            tools: tools.isEmpty ? nil : tools
        )

        // Debug logging
        print("=== OpenAI Request Debug ===")
        print("Model: \(model)")
        print("Stream: \(stream)")
        print("Tools count: \(tools.count)")
        if !tools.isEmpty {
            for (index, tool) in tools.enumerated() {
                print("Tool \(index): \(tool)")
            }
        }

        // Try to serialize the query to JSON for debugging
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(query)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request JSON:")
                print(jsonString)
            }
        } catch {
            print("Failed to serialize request to JSON: \(error)")
        }
        print("==========================")

        do {
            if stream {
                try await createResponseStreaming(query: query)
            } else {
                try await createResponse(query: query)
            }
        } catch {
            print("=== OpenAI Request Error ===")
            print("Error: \(error)")
            if let statusError = error as? OpenAIError {
                print("OpenAI Error: \(statusError)")
            }

            // Check if it's an unhandled event error
            if let storeError = error as? StoreError,
               case .unhandledResponseStreamEvent(let event) = storeError {
                print("❌ Unhandled ResponseStreamEvent: \(event)")
                print("Event type: \(type(of: event))")
            }

            // Provide specific guidance for common errors
            if let urlResponse = (error as NSError).userInfo["response"] as? HTTPURLResponse {
                switch urlResponse.statusCode {
                case 400:
                    print("❌ 400 Bad Request - This could be due to:")
                    print("   • MCP tools not being supported by the current OpenAI API")
                    print("   • Invalid tool configuration format")
                    print("   • Unsupported model for the requested features")
                    print("   • Try disabling MCP tools or using a different model")
                case 401:
                    print("❌ 401 Unauthorized - Check your OpenAI API key")
                case 429:
                    print("❌ 429 Rate Limited - Too many requests, try again later")
                default:
                    print("❌ HTTP \(urlResponse.statusCode) - Unexpected error")
                }
            }
            print("===========================")
            throw error
        }
    }
    
    private func createResponse(query: CreateModelResponseQuery) async throws {
        let response = try await client.createResponse(query: query)

        // Track the actual OpenAI response ID for API continuity
        lastOpenAIResponseId = response.id

        for output in response.output {
            switch output {
            case .outputMessage(let outputMessage):
                let message = chatMessage(
                    fromOutputContent: outputMessage.content[0],
                    messageId: outputMessage.id,
                    userId: outputMessage.role.rawValue,
                    username: outputMessage.role.rawValue
                )

                // Generate a unique ID for each conversation turn to prevent duplicates
                let conversationTurnId = UUID().uuidString

                conversationTurns.append(
                    .init(
                        id: conversationTurnId,
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
            print("---event number: \(eventNumber)---")
            print(event)
            print("\n\n")
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
            // Track the actual OpenAI response ID for API continuity
            lastOpenAIResponseId = responseEvent.response.id
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
        case .functionCallArguments(_ /* let functionCallArgumentsEvent */):
            break
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
        case .mcpCall(let mcpCallEvent):
            try handleMCPCallEvent(mcpCallEvent)
        case .mcpCallArguments(let mcpCallArgumentsEvent):
            try handleMCPCallArgumentsEvent(mcpCallArgumentsEvent)
        case .mcpListTools(let mcpListToolsEvent):
            try handleMCPListToolsEvent(mcpListToolsEvent)
        case .queued(_ /* let responseEvent */):
            // Response is queued - no action needed
            break
        case .failed(_ /* let responseEvent */):
            // Response failed - could show error in UI
            print("Response failed")
            break
        case .incomplete(_ /* let responseEvent */):
            // Response incomplete - could show warning in UI
            print("Response incomplete")
            break
        case .error(let errorEvent):
            // Error event - log the error
            print("Response error: \(errorEvent)")
            break
        case .refusal(let refusalEvent):
            // Refusal event - handle refusal
            print("Response refusal: \(refusalEvent)")
            break
        case .outputTextAnnotation(let annotationEvent):
            // Handle text annotations
            switch annotationEvent {
            case .added(let event):
                // TODO: Implement proper annotation handling when type conversion is resolved
                print("Text annotation added: itemId=\(event.itemId), annotationIndex=\(event.annotationIndex)")
            }
        case .reasoning(let reasoningEvent):
            // Handle reasoning events - could show reasoning in UI
            switch reasoningEvent {
            case .delta(let event):
                print("Reasoning delta: \(event.sequenceNumber)")
            case .done(let event):
                print("Reasoning done: \(event.sequenceNumber)")
            }
        case .reasoningSummary(let reasoningSummaryEvent):
            // Handle reasoning summary events
            switch reasoningSummaryEvent {
            case .delta(let event):
                print("Reasoning summary delta: \(event.sequenceNumber)")
            case .done(let event):
                print("Reasoning summary done: \(event.sequenceNumber)")
            }
        case .audio(_ /* let audioEvent */):
            // Audio events - not implemented yet
            print("Audio event received (not implemented)")
            break
        case .audioTranscript(_ /* let audioTranscriptEvent */):
            // Audio transcript events - not implemented yet
            print("Audio transcript event received (not implemented)")
            break
        case .codeInterpreterCall(_ /* let codeInterpreterCallEvent */):
            // Code interpreter events - not implemented yet
            print("Code interpreter call event received (not implemented)")
            break
        case .fileSearchCall(_ /* let fileSearchCallEvent */):
            // File search events - not implemented yet
            print("File search call event received (not implemented)")
            break
        case .imageGenerationCall(_ /* let imageGenerationCallEvent */):
            // Image generation events - not implemented yet
            print("Image generation call event received (not implemented)")
            break
        case .reasoningSummaryPart(_ /* let reasoningSummaryPartEvent */):
            // Reasoning summary part events - not implemented yet
            print("Reasoning summary part event received (not implemented)")
            break
        case .reasoningSummaryText(_ /* let reasoningSummaryTextEvent */):
            // Reasoning summary text events - not implemented yet
            print("Reasoning summary text event received (not implemented)")
            break
        }
    }
    
    private func handleOutputItemEvent(_ event: ResponseStreamEvent.OutputItemEvent) throws {
        switch event {
        case .added(let outputItemAddedEvent):
            try handleOutputItemAdded(outputItemAddedEvent.item)
        case .done(let outputItemDoneEvent):
            try handleOutputItemDone(outputItemDoneEvent.item)
        }
    }
    
    private func handleOutputItemAdded(_ outputItem: OutputItem) throws {
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
        case .functionToolCall(_ /* let functionToolCall */):
            break
        case .mcpApprovalRequest(let approvalRequest):
            // Handle MCP approval request - show approval prompt to user
            handleMCPApprovalRequest(approvalRequest)
        case .mcpListTools(_ /* let mcpListTools */):
            // MCP tools listed - no UI action needed
            break
        case .mcpToolCall(_ /* let mcpCall */):
            // MCP tool call in progress - no UI action needed
            break
        default:
            throw StoreError.unhandledOutputItem(outputItem)
        }
    }
    
    private func handleOutputItemDone(_ outputItem: OutputItem) throws {
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
        case .functionToolCall(let functionToolCall):
            guard functionToolCall.name == weatherFunctionTool.name else {
                throw StoreError.unknownFunctionCalled(name: functionToolCall.name)
            }

            lastFinishedFunctionToolCall = functionToolCall
        case .mcpApprovalRequest(_ /* let approvalRequest */):
            // MCP approval request completed - no additional action needed
            break
        case .mcpListTools(_ /* let mcpListTools */):
            // MCP tools listing completed - no additional action needed
            break
        case .mcpToolCall(let mcpCall):
            // MCP tool call completed - could show result in UI
            print("MCP tool call completed: \(mcpCall.name)")
            if let output = mcpCall.output {
                print("Result: \(output)")
            }
        default:
            throw StoreError.unhandledOutputItem(outputItem)
        }
    }
    
    private func handleOutputTextEvent(_ outputTextEvent: ResponseStreamEvent.OutputTextEvent) throws {
        switch outputTextEvent {
        case .delta(let responseTextDeltaEvent):
            try applyOutputTextDeltaToMessageBeingStreamed(
                messageId: responseTextDeltaEvent.itemId,
                newText: responseTextDeltaEvent.delta
            )
        // Note: Annotations are now handled via separate outputTextAnnotation events
        case .done(let responseTextDoneEvent):
            if messageBeingStreamed?.text != responseTextDoneEvent.text {
                throw StoreError.incompleteLocalTextOnOutputTextDoneEvent(
                    local: messageBeingStreamed?.text ?? "",
                    remote: responseTextDoneEvent.text
                )
            }
        }
    }
    
    private func handleMCPCallArgumentsEvent(_ mcpCallEvent: ResponseStreamEvent.MCPCallArgumentsEvent) throws {
        switch mcpCallEvent {
        case .delta(let event):
            print("MCP Call Arguments Delta, sequence: \(event.sequenceNumber)")
        case .done(let event):
            print("MCP Call Arguments Done, sequence: \(event.sequenceNumber)")
        }
    }

    private func handleMCPCallEvent(_ mcpCallEvent: ResponseStreamEvent.MCPCallEvent) throws {
        switch mcpCallEvent {
        case .completed(let event):
            print("MCP Tool Call Completed, sequence: \(event.sequenceNumber)")
        case .failed(let event):
            print("MCP Tool Call Failed, sequence: \(event.sequenceNumber)")
        case .inProgress(let event):
            print("MCP Tool Call In Progress, sequence: \(event.sequenceNumber)")
        }
    }

    private func handleMCPListToolsEvent(_ mcpListToolsEvent: ResponseStreamEvent.MCPListToolsEvent) throws {
        switch mcpListToolsEvent {
        case .completed(let event):
            print("MCP Tools Listed, sequence: \(event.sequenceNumber)")
        case .failed(let event):
            print("MCP List Tools Failed, sequence: \(event.sequenceNumber)")
        case .inProgress(let event):
            print("MCP List Tools In Progress, sequence: \(event.sequenceNumber)")
        }
    }
    
    private func setMessageBeingStreamed(message: MessageData) throws {
        guard let responseBeingStreamed else {
            fatalError()
        }

        if let messageBeingStreamed, message.id == messageBeingStreamed.id {
            conversationTurns.removeLast()
        }
        
        messageBeingStreamed = message
        conversationTurns.append(
            .init(
                id: responseBeingStreamed.id,
                type: .response,
                chatMessage: chatMessage(from: message)
            )
        )
    }
    
    private func updateMessageBeingStreamed(
        messageId: String,
        outputContent: ResponseStreamEvent.Schemas.OutputContent
    ) throws {
        try updateMessageBeingStreamed(messageId: messageId) { message in
            switch outputContent {
            case .OutputTextContent(let outputText):
                message.text = outputText.text
                message.annotations = outputText.annotations
            case .RefusalContent(let refusal):
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
            
            var turns = self.conversationTurns
            turns.removeLast()
            turns.append(updatedTurn)
            self.conversationTurns = turns
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
    
    private func parseWeatherFunctionCall(functionName: String, arguments: String) -> WeatherFunctionCall? {
        guard let data = arguments.data(using: .utf8) else {
            print("outputItem functionToolCall - done, error: can't create data from arguments string: \(arguments)")
            return nil
        }
        
        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("outputItem functionToolCall - done, error, can't create jsonObject from data: \(data)")
                return nil
            }
            
            guard let location = dictionary["location"] as? String else {
                print("outputItem functionToolCall - done, error: location argument (string) not found in dictionary: \(dictionary)")
                return nil
            }
            
            guard let unit = dictionary["unit"] as? String else {
                print("outputItem functionToolCall - done, error: unit argument (string) not found in dictionary: \(dictionary)")
                return nil
            }
            
            return .init(functionName: functionName, location: location, unit: unit)
        } catch {
            print("outputItem functionToolCall - done, error parsing JSON: \(error)")
            return nil
        }
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
        case .OutputTextContent(let outputText):
            return makeChatMessage(
                withText: outputText.text,
                annotations: outputText.annotations,
                messageId: messageId,
                user: systemUser(withId: userId, username: username)
            )
        case .RefusalContent(let refusal):
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
            avatarURL: .init(string: "https://openai.com/apple-icon.png"),
            type: .system
        )
    }
}
