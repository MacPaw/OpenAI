//
//  ResponseObject+Mock.swift
//  OpenAI
//

import Foundation
@testable import OpenAI

extension ResponseObject {
    static func makeMock(
        output: [OutputItem] = [],
        tools: [Tool] = [],
        status: Status? = .completed
    ) -> ResponseObject {
        .init(
            background: nil,
            completedAt: nil,
            conversation: nil,
            createdAt: 123,
            error: nil,
            id: "resp-1",
            incompleteDetails: nil,
            instructions: nil,
            maxOutputTokens: nil,
            maxToolCalls: nil,
            metadata: [:],
            model: "test-model",
            object: "response",
            output: output,
            outputText: nil,
            parallelToolCalls: false,
            previousResponseId: nil,
            prompt: nil,
            promptCacheKey: nil,
            promptCacheRetention: nil,
            reasoning: nil,
            safetyIdentifier: nil,
            serviceTier: nil,
            status: status,
            temperature: nil,
            text: .init(format: nil),
            toolChoice: .ToolChoiceOptions(.auto),
            tools: tools,
            topLogprobs: nil,
            topP: nil,
            truncation: nil,
            usage: nil,
            user: nil
        )
    }
}
