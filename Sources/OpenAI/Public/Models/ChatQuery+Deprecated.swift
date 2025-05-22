//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.05.2025.
//

import Foundation

extension ChatQuery {
    @available(*, deprecated, message: "max_tokens is deprecated, use a different initializer")
    public init(
        messages: [Self.ChatCompletionMessageParam],
        model: Model,
        modalities: [Self.ChatCompletionModalities]? = nil,
        audioOptions: Self.AudioOptions? = nil,
        reasoningEffort: ReasoningEffort? = nil,
        frequencyPenalty: Double? = nil,
        logitBias: [String : Int]? = nil,
        logprobs: Bool? = nil,
        maxTokens: Int? = nil,
        maxCompletionTokens: Int? = nil,
        metadata: [String: String]? = nil,
        n: Int? = nil,
        parallelToolCalls: Bool? = nil,
        prediction: PredictedOutputConfig? = nil,
        presencePenalty: Double? = nil,
        responseFormat: Self.ResponseFormat? = nil,
        seed: Int? = nil,
        stop: Self.Stop? = nil,
        temperature: Double? = nil,
        toolChoice: Self.ChatCompletionFunctionCallOptionParam? = nil,
        tools: [Self.ChatCompletionToolParam]? = nil,
        topLogprobs: Int? = nil,
        topP: Double? = nil,
        user: String? = nil,
        stream: Bool = false,
        streamOptions: StreamOptions? = nil
    ) {
        self.messages = messages
        self.model = model
        self.reasoningEffort = reasoningEffort
        self.frequencyPenalty = frequencyPenalty
        self.logitBias = logitBias
        self.logprobs = logprobs
        self.maxTokens = maxTokens
        self.maxCompletionTokens = maxCompletionTokens
        self.metadata = metadata
        self.n = n
        self.parallelToolCalls = parallelToolCalls
        self.prediction = prediction
        self.presencePenalty = presencePenalty
        self.responseFormat = responseFormat
        self.seed = seed
        self.stop = stop
        self.temperature = temperature
        self.toolChoice = toolChoice
        self.tools = tools
        self.topLogprobs = topLogprobs
        self.topP = topP
        self.user = user
        self.stream = stream
        self.streamOptions = streamOptions
        self.audioOptions = audioOptions
        self.modalities = modalities
    }
}
