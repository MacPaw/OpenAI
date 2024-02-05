//
//  MiscStore.swift
//  DemoChat
//
//  Created by Aled Samuel on 22/04/2023.
//

import UIKit
import OpenAI

public final class MiscStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    
    @Published var availableModels: [ModelResult] = []
    
    public init(
        openAIClient: OpenAIProtocol
    ) {
        self.openAIClient = openAIClient
    }
    
    // MARK: - Models
    
    @MainActor
    func getModels() async {
        do {
            let response = try await openAIClient.models()
            availableModels = response.data
        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Moderations
    
    @Published var moderationConversation = Conversation(id: "", messages: [])
    @Published var moderationConversationError: Error?
    
    @MainActor
    func sendModerationMessage(_ message: Message) async {
        moderationConversation.messages.append(message)
        await completeModerationChat(message: message)
    }
    
    @MainActor
    func completeModerationChat(message: Message) async {
        
        moderationConversationError = nil
        
        do {
            let response = try await openAIClient.moderations(
                query: ModerationsQuery(
                    input: message.content,
                    model: .textModerationLatest
                )
            )
            
            let categoryResults = response.results
            
            let existingMessages = moderationConversation.messages
            
            func circleEmoji(for resultType: Bool) -> String {
                resultType ? "🔴" : "🟢"
            }
            
            for result in categoryResults {
                var content = Mirror(reflecting: result.categories).children.map { (label, value) in
                    "\(circleEmoji(for: value as! Bool)) \(label!.replacingOccurrences(of: "_", with: " ").capitalized)"
                }
                content.append("")
                content.insert("", at: 0)

                let message = Message(
                    id: response.id,
                    role: .assistant,
                    content: content.joined(separator: "\n"),
                    createdAt: message.createdAt)
                
                if existingMessages.contains(message) {
                    continue
                }
                moderationConversation.messages.append(message)
            }
            
        } catch {
            moderationConversationError = error
        }
    }
}
