//
//  MainChatModel.swift
//  Demo
//
//  Created by Dante Ausonio on 12/11/23.
//

import Foundation

class Conversation: Identifiable {
    var title: String = ""
    var id = UUID()
    var date = Date()
    var messages: [Chat] = [] // For AI
    var UIMessages : [Message] { //For UI
        return messages.map { data in
            return Message(role: data.role, content: data.content ?? "")
        }
    }
    
    init(title: String) {
        self.title = title
    }
    
    init(id: UUID, date: Date, conversation: [Chat], title: String) {
        self.id = id
        self.date = date
        self.messages = conversation
        self.title = title
    }
    
}


// MARK: Conversation Functions
extension Conversation {
    func appendSystemPrompt(_ prompt: String) {
        messages.append(Chat(role: .system, content: prompt))
    }
    
    func appendUserMessage(_ message: String) {
        messages.append(Chat(role: .user, content: message))
    }
    
    func appendAssistantResponse(_ response: String) {
        messages.append(Chat(role: .assistant, content: response))
    }
    
    
}




// MARK: Conversation History
extension Conversation {
    
    /// Returns all chats from the user or the assistant
    func chatHistory() -> [Chat] {
        return messages.filter { message in
            return message.role == Chat.Role.assistant || message.role == Chat.Role.user
        }
    }
    
    /// Returns last n chats with in a certain token limit, and the last system prompt.
    func bufferHistory(tokenLimit: Int) -> [Chat] {
        var bufferHistory = [Chat]()
        var tokenCount = 0
        
        for message in chatHistory().reversed() {
            tokenCount += message.content?.tokenCount ?? 0
            if tokenCount >= tokenLimit {
                break
            }
            bufferHistory.insert(message, at: 0)
        }
        
        if let systemPrompt = messages.last(where: { $0.role == .system }) {
            bufferHistory.insert(systemPrompt, at: 0)
        }
        
        return bufferHistory
    }
}


/// Object that contains a message in such a way that it can be used for display in UI
struct Message: Identifiable {
    let id = UUID()
    let date = Date()
    let role: Chat.Role
    let content: String
}




