//
//  InjectorAgent.swift
//  OpenAIPackageContributions
//
//  Created by Dante Ausonio on 12/14/23.
//

import Foundation

class InjectorAgent {
    
    private let openAI = OpenAI(apiToken: APIKeys().OpenAIKey)
    let system: ChatSystem
    let memoryStrategy: MemoryStrategyInterface
    var scope: MemoryStrategyInterface = CMS_Scope()
    let checkInRate: Int
    var currentPhase = 0
    
    let knowledgeBase = ""
    let tools = ""
    
    
    
    
    init(process: ChatSystem, checkInRate: Int = 3, memoryStrategy: MemoryStrategyInterface = CMS_UserContext()) {
        self.system = process
        self.checkInRate = checkInRate
        self.memoryStrategy = memoryStrategy
    }
    
    
    
    
    func initChat() -> String {
        return "\(system.baseBehaviorPrompt)\n\(system.phases[0].prompt)"
    }
    
    
    func performCheckIn(on chat: Conversation) async throws -> String {
        print("\n\n----------------------- Perfomring Check In -----------------------\n")
        do {
            async let scopeString = try scope.setAndGetMemoryString(for: chat)
            async let memoryString = try memoryStrategy.setAndGetMemoryString(for: chat)
            async let phaseNumber = try self.getPhaseNumber(chat)
            
            try self.currentPhase = await phaseNumber
            let systemPromptInjection = try await self.formatInjectionPrompt(phaseNumber, await scopeString, await memoryString)
            
            return systemPromptInjection
        } catch {
            print("perform check in failed ", error)
            throw error
        }
    }
    
    
    private func getPhaseNumber(_ chat: Conversation) async throws -> Int {
        do {
            let agentMessage = chat.messages + [Chat(role: .system, content: self.phaseProgressionPrompt(for: chat))]
            let query = ChatQuery(model: .gpt3_5Turbo_1106, messages: agentMessage, n: 1)
            let result = try await openAI.chats(query: query)
            guard let response = result.choices.first?.message.content else { print("JSON FAILED"); return 0 }
            if let phaseNumber = Int(response) {
                return phaseNumber
            } else {
                return 0
            }
        } catch {
            throw error
        }
    }
    
    
    
    private func formatInjectionPrompt(_ phaseNumber: Int, _ scopeStr: String, _ memoryStr: String) -> String {
        let phasePrompt = system.phases[phaseNumber].prompt
        let systemPrompt = "\(system.baseBehaviorPrompt) You rely on the 3 following pieces of information to guide your interactions. Conversation Scope, Memory, and Instructions.\n\nConversation Scope:\n\(scopeStr)\n\nMemory:\n\(self.memoryStrategy.memoryDescription)\n\(memoryStr)\n\nInstructions:\n\(phasePrompt)"
        print("\n\n---------------------------Formatted System Prompt:----------------------------\n\(systemPrompt)")
        return systemPrompt
    }
    
    
}






// MARK: Helper Functions
extension InjectorAgent {
    func shouldCheckIn(on chat: Conversation) -> Bool {
        let chatCount = chat.chatHistory().count
        return (chatCount % self.checkInRate == 0 || (chatCount - 1) % self.checkInRate == 0) && (chatCount > 1)
    }
}








// MARK: Prompts
extension InjectorAgent {
    
    
    private func phaseProgressionPrompt(for chat: Conversation) -> String {
        var phaseDescriptions = ""
        var i = 0
        for phase in system.phases {
            phaseDescriptions.append("\(phase.name):\nIndex Number: \(i)\nPhase Description:\(phase.description)\n--------------------------------\n")
            i += 1
        }
        
        if let prgoressionInstructions = system.phaseProgressionInstruction {
            return prgoressionInstructions
        }
        
        switch system.progressionStyle {
        case .linear:
            return "You are a conversational manager. You manage the conversation between a Conversational AI Assistant and a User. There is a set of possible conversational phases the AI can enter. Each phase defines the behavior of the AI Assistant. The phases must progress in order from one to the next. It is your job to determine when to progress to the next phase. The AI is currently in phase number \(self.currentPhase). Decide if the conversation should progress to the next phase based on the scope of the conversation, the conversation so far, and the phase descriptions. Return an integer for the index number associated with the appropriate conversational phase the AI should enter. Return only the index number, and nothing else. In other words, your response should be a number between 0 and \(system.phases.count), and that number should be the index number of the phase the AI Assistant should enter. \n\n\nConversation Scope:\n \(self.scope.memoryString) \n\n\n Phase Descriptions:\(phaseDescriptions)"
        case .nonlinear:
            return "You are a conversational manager. You manage the conversation between a Conversational AI Assistant and a User. There is a set of possible conversational phases the AI can enter. Each phase defines the behavior of the AI Assistant. The phases can be entered in any order and do NOT have to come one after the other. It is your job to determine which phase is most useful at this point in the conversation. The AI is currently in phase number \(self.currentPhase). Decide phase the assistant should enter based on the scope of the conversation, the conversation so far, and the phase descriptions. Return an integer for the index number associated with the appropriate conversational phase the AI should enter. Return only the index number, and nothing else. In other words, your response should be a number between 0 and \(system.phases.count), and that number should be the index number of the phase the AI Assistant should enter. \n\n\nConversation Scope:\n \(self.scope.memoryString) \n\n\n Phase Descriptions:\(phaseDescriptions)"
        }
        
    }
}





// TODO: Figure out how to create a memory system using the Strategy Design Pattern. 
