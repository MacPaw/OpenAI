//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 24.01.2025.
//

import Foundation
@testable import OpenAI

extension AssistantResult {
    static func makeMock() -> AssistantResult {
        AssistantResult(id: "asst_9876", name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: nil, toolResources: nil)
    }
}
