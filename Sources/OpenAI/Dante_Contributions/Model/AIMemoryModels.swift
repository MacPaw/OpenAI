//
//  AIMemoryModel.swift
//  OpenAIPackageContributions
//
//  Created by Dante Ausonio on 12/28/23.
//

import Foundation

protocol MemoryStrategyInterface {
    var memoryDescription: String { get set } /// This goes in the system prompt next to memory: to describe the way the memory system works to the conversational AI
    var memoryString: String { get set }
    
    func setAndGetMemoryString(for chat: Conversation) async throws -> String
    func setMemoryString(for chat: Conversation) async throws
    func queryMemory(query: String) -> String
    
}


// CMS = Concrete Memory Strategy

//MARK: Scope Memory
class CMS_Scope: MemoryStrategyInterface {
    
    private let openAI = OpenAI(apiToken: APIKeys().OpenAIKey)
    private var updateScopePrompt: String = ""
    var memoryString: String = ""
    var memoryDescription: String
    
    private var defaultUpdateScopePrompt: String {
        return "You are a conversational manager. You manage the conversation between a User and a conversational AI Assistant. Your task is to update the Scope Description for the conversation in order give the AI conversational memory. This memory is used to determine which conversational paths should be chosen. The Scope Description tells the AI Assistant what the topic of conversation is, what the conversation is about, what has been discussed, what should be discussed and serves as an overall summary for the conversation thus far. The cope should be abstract enough to capture the essence of the conversation with out getting bogged down in the details. It is a high level overview of the conversation, meant for keeping the AI on track. If there is no new relevant information, simply return the original context description. Don't generate repetative information. Keep everything concise and to the point. \nHere is the current Scope Description: \(self.memoryString)\nReturn json containing the updated Scope Description in the form {'description': string value}."
    }
    private var defaultMemoryDescription: String = "Your memory describes the scope of the conversation"
    
    init(customUpdateScopePrompt: String? = nil, customMemoryDescription: String? = nil) {
        self.memoryDescription = customMemoryDescription ?? defaultMemoryDescription
        self.updateScopePrompt = customUpdateScopePrompt ?? defaultUpdateScopePrompt
        
    }
    
    func setAndGetMemoryString(for chat: Conversation) async throws -> String {
        do {
            try await setMemoryString(for: chat)
            return self.memoryString
        } catch {
            print("CMS_Scope.getMemoryString Failed! \(error)")
            throw error
        }
    }
    
    func setMemoryString(for chat: Conversation) async throws {
        do {
            let agentMessage = chat.messages + [Chat(role: .system, content: self.updateScopePrompt)]
            let query = ChatQuery(model: .gpt3_5Turbo_1106, messages: agentMessage, responseFormat: .jsonObject, n: 1)
            
            let result = try await openAI.chats(query: query)
            guard let json = result.choices.first?.message.content?.data(using: .utf8) else { return }
            let decodedJSON = try JSONDecoder().decode([String: String].self, from: json)
            self.memoryString = decodedJSON["description"] ?? ""
        } catch {
            print("CMS_Scope.getMemoryString Failed! \(error)")
            throw error
        }
    }
    
    func queryMemory(query: String = "") -> String {
        return memoryString
    }
}



// MARK: User Context Memory
class CMS_UserContext: MemoryStrategyInterface {
    private let openAI = OpenAI(apiToken: APIKeys().OpenAIKey)
    private var updateMemoryPrompt: String = ""
    var memoryDescription: String
    var memoryString: String = ""
    
    var defaultMemoryDescription: String = "Your memory provides a list of facts known about the user."
    var defautUpdateMemoryPrompt: String {"You are a conversational manager. You manage a conversation held between a conversational AI assistnat and a user. Your task is to update the user context memory of the conversational AI using the conversation so far. The User Context Memory is a bullet point list of facts learned about the user during the conversation that contain key details and information about the user. It should contain specific details not general statements. remembered If there is no new relevant information, simply return the original context description. Don't generate repetative information. Keep everything concise and to the point. \nHere is the current user context memory: \(self.memoryString)\n Return JSON containing the the updated User Context Memory in the form {'description': context} where context is the fact list formatted as a string."
    }
    
    init(customUpdateScopePrompt: String? = nil, customMemoryDescription: String? = nil) {
        self.memoryDescription = customMemoryDescription ?? defaultMemoryDescription
        self.updateMemoryPrompt = customUpdateScopePrompt ?? defautUpdateMemoryPrompt
        
    }
    
    func setAndGetMemoryString(for chat: Conversation) async throws -> String {
        try await setMemoryString(for: chat)
        return self.memoryString
    }
    
    func setMemoryString(for chat: Conversation) async throws {
        do {
            let agentMessage = chat.messages + [Chat(role: .system, content: self.updateMemoryPrompt)]
            let query = ChatQuery(model: .gpt3_5Turbo_1106, messages: agentMessage, responseFormat: .jsonObject, n: 1)
            
            let result = try await openAI.chats(query: query)
            guard let json = result.choices.first?.message.content?.data(using: .utf8) else { return }
            let decodedJSON = try JSONDecoder().decode([String: String].self, from: json)
            self.memoryString = decodedJSON["description"] ?? ""
            print("\nCMS_UserContext memory Decoded and Formatted Result:\n", decodedJSON)
        } catch {
            print("CMS_UserContext.getMemoryString() Failed! \(error)")
            throw error
        }
    }
    
    func queryMemory(query: String = "") -> String {
        return memoryString
    }
}



// MARK: More Memory Strategies...







