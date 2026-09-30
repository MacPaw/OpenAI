//
//  ModelSpec+GPT6.swift
//  OpenAI
//

public extension ModelSpec {
    /// https://developers.openai.com/api/docs/models/gpt-6-astra
    static let gpt6_astra = ModelSpec(
        id: .gpt6_astra,
        endpoints: [.chatCompletions, .responses],
        features: [],
        tools: [.mcp],
        reasoningEfforts: [.low, .medium, .high, .xhigh, .max],
        // https://developers.openai.com/api/docs/guides/reasoning#reasoning-effort
        limitations: [.chatCompletionsFunctionCallingUnsupported]
    )

    /// https://developers.openai.com/api/docs/models/gpt-6-sol
    static let gpt6_sol = ModelSpec(
        id: .gpt6_sol,
        endpoints: [.chatCompletions, .responses],
        features: [],
        tools: [.mcp],
        reasoningEfforts: [.none, .low, .medium, .high, .xhigh, .max],
        // Stated in the model page's description
        limitations: [.chatCompletionsFunctionCallingRequiresReasoningEffortNone]
    )

    /// https://developers.openai.com/api/docs/models/gpt-6-luna
    static let gpt6_luna = ModelSpec(
        id: .gpt6_luna,
        endpoints: [.chatCompletions, .responses],
        features: [],
        tools: [.mcp],
        reasoningEfforts: [.none, .low, .medium, .high, .xhigh, .max],
        // Stated in the model page's description
        limitations: [.chatCompletionsFunctionCallingRequiresReasoningEffortNone]
    )
}
