//
//  ChatResult+Mock.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 20.03.2025.
//

import Foundation
@testable import OpenAI

extension ChatResult {
    static let mock = ChatResult(id: "id-12312", created: 100, model: .gpt3_5Turbo, object: "foo", serviceTier: nil, systemFingerprint: "fing", choices: [
        .init(index: 0, logprobs: nil, message: mockChatResultChoiceMessage(content: "bar", role: "system"), finishReason: "baz"),
        .init(index: 0, logprobs: nil, message: mockChatResultChoiceMessage(content: "bar1", role: "user"), finishReason: "baz1"),
        .init(index: 0, logprobs: nil, message: mockChatResultChoiceMessage(content: "bar2", role: "assistant"), finishReason: "baz2")
    ], usage: .init(completionTokens: 200, promptTokens: 100, totalTokens: 300), citations: nil)
    
    static func mockChatResultChoiceMessage(content: String, role: String) -> ChatResult.Choice.Message {
        .init(content: content, refusal: nil, role: role, annotations: [], audio: nil, toolCalls: [], _reasoning: nil, _reasoningContent: nil)
    }
}
