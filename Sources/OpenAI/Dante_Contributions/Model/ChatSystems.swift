//
//  ProcessDescriptions.swift
//  OpenAIPackageContributions
//
//  Created by Dante Ausonio on 12/24/23.
//

import Foundation

struct ChatSystem {
    let description: String /// Answers what the system does or is used for. It allows the observer to know why the process exists and why it might be chosen.
    
    let phases: [Phase] /// Each phase adjusts the behavior of the LLM allowing for an evolving conversation.
    
    let progressionStyle: phaseProgression /// How should the Observer progress through each phase? Linear = Progress through each phase in order, Nonlinear = jump to which ever phase seems fit.
    
    let baseBehaviorPrompt: String /// This sets the assistants behavior. It is used in all system prompts. This should set the role, identity and overall personality of the LLM. Each phase then adjusts the way this entity acts and provides more specific instructions.
    
    let phaseProgressionInstruction: String? = nil /// Instructs the Observer AI on how the phases should progress.
    
    
    /// Not yet fully implemented
    enum phaseProgression {
        case linear, nonlinear
        
        var prompt: String {
            switch self {
            case .linear: /// Each phase comes one after the other in order of placement in the phases array
                return ""
            case .nonlinear: /// No order to phases. Any phase can come at any time
                return ""
            }
        }
        
    }
}


/// Each phase defines a particular kind of behavior that the conversational AI can take on in a chat system
struct Phase {
    var name: String /// Name to identify or reference the phase
    
    var description: String  /// Describes the phase to the Observer AI so it knows when and why to chose it
    
    var prompt: String /// The system prompt to injected into the conversational ai that defines its behavior for the conversational phase
}
