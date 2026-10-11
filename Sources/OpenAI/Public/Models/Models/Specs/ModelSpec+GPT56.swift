//
//  ModelSpec+GPT56.swift
//  OpenAI
//

public extension ModelSpec {
    /// https://developers.openai.com/api/docs/models/gpt-5.6-sol
    static let gpt5_6_sol = ModelSpec(
        id: .gpt5_6_sol,
        endpoints: [.chatCompletions, .responses],
        features: [],
        tools: [.mcp],
        reasoningEfforts: [.none, .low, .medium, .high, .xhigh, .max],
        // Not on the model page: the API rejects function tools on Chat Completions unless `reasoning_effort` is `none`
        // ("Function tools with reasoning_effort are not supported for gpt-5.6-sol in /v1/chat/completions.
        // To use function tools, use /v1/responses or set reasoning_effort to 'none'.")
        limitations: [.chatCompletionsFunctionCallingRequiresReasoningEffortNone]
    )

    /// https://developers.openai.com/api/docs/models/gpt-5.6-terra
    static let gpt5_6_terra = ModelSpec(
        id: .gpt5_6_terra,
        endpoints: [.chatCompletions, .responses],
        features: [],
        tools: [.mcp],
        reasoningEfforts: [.none, .low, .medium, .high, .xhigh, .max],
        // Same API error as `gpt5_6_sol`
        limitations: [.chatCompletionsFunctionCallingRequiresReasoningEffortNone]
    )

    /// https://developers.openai.com/api/docs/models/gpt-5.6-luna
    static let gpt5_6_luna = ModelSpec(
        id: .gpt5_6_luna,
        endpoints: [.chatCompletions, .responses],
        features: [],
        tools: [.mcp],
        reasoningEfforts: [.none, .low, .medium, .high, .xhigh, .max],
        // Same API error as `gpt5_6_sol`
        limitations: [.chatCompletionsFunctionCallingRequiresReasoningEffortNone]
    )
}
