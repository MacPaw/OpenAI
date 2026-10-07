//
//  ModelSpec.swift
//  OpenAI
//

/// Capabilities of a model, as listed on its OpenAI docs page (e.g. https://developers.openai.com/api/docs/models/gpt-6-luna).
///
/// Models are defined in one `ModelSpec+<family>.swift` file per model family (e.g. `ModelSpec+GPT6.swift`, `ModelSpec+GPT56.swift`) and listed in ``all``.
public struct ModelSpec: Hashable, Sendable {
    /// Model ID to send in requests.
    public let id: Model
    public let endpoints: Set<Endpoint>
    public let features: Set<Feature>
    /// Tools supported when using the Responses API.
    public let tools: Set<Tool>
    /// Values accepted by `reasoning.effort`. Empty for models that don't reason.
    public let reasoningEfforts: Set<ReasoningEffort>
    /// Restrictions the docs note on top of the capabilities above.
    public let limitations: Set<Limitation>

    init(
        id: Model,
        endpoints: Set<Endpoint>,
        features: Set<Feature>,
        tools: Set<Tool>,
        reasoningEfforts: Set<ReasoningEffort>,
        limitations: Set<Limitation>
    ) {
        self.id = id
        self.endpoints = endpoints
        self.features = features
        self.tools = tools
        self.reasoningEfforts = reasoningEfforts
        self.limitations = limitations
    }
}

public extension ModelSpec {
    /// All models described by a ``ModelSpec``.
    static let all: [ModelSpec] = [
        .gpt6_astra,
        .gpt6_sol,
        .gpt6_luna,
        .gpt5_6_sol,
        .gpt5_6_terra,
        .gpt5_6_luna
    ]

    enum Endpoint: Hashable, Sendable {
        case chatCompletions
        case responses
    }

    enum Feature: Hashable, Sendable {}

    /// Tools a model supports when used with the Responses API.
    enum Tool: Hashable, Sendable {
        /// Remote MCP servers via the `mcp` tool.
        case mcp
    }

    /// A value of `reasoning.effort` (Responses API) or `reasoning_effort` (Chat Completions).
    enum ReasoningEffort: String, Hashable, Sendable, CaseIterable {
        case none
        case minimal
        case low
        case medium
        case high
        case xhigh
        case max
    }

    /// A restriction the docs note on top of a model's endpoints, features and tools.
    /// Each spec links the page that states it.
    enum Limitation: Hashable, Sendable {
        /// Chat Completions doesn't support function calling; use the Responses API.
        case chatCompletionsFunctionCallingUnsupported
        /// Function calling on Chat Completions works only with `reasoning_effort` set to `none`.
        case chatCompletionsFunctionCallingRequiresReasoningEffortNone
    }
}

extension ModelSpec {
    func satisfies(_ filter: Model.Filter) -> Bool {
        filter.supportedEndpoints.allSatisfy(endpoints.contains)
            && filter.requiredTools.allSatisfy(tools.contains)
    }
}

public extension Components.Schemas.ReasoningEffort {
    init(_ effort: ModelSpec.ReasoningEffort) {
        switch effort {
        case .none: self = .none
        case .minimal: self = .minimal
        case .low: self = .low
        case .medium: self = .medium
        case .high: self = .high
        case .xhigh: self = .xhigh
        case .max: self = .max
        }
    }
}

public extension ChatQuery.ReasoningEffort {
    init(_ effort: ModelSpec.ReasoningEffort) {
        switch effort {
        case .none: self = .none
        case .minimal: self = .minimal
        case .low: self = .low
        case .medium: self = .medium
        case .high: self = .high
        case .xhigh, .max: self = .customValue(effort.rawValue)
        }
    }
}
