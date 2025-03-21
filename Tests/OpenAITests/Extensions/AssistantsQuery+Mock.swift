//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 21.01.2025.
//

import Foundation
@testable import OpenAI

extension AssistantsQuery {
    static func makeMock() -> AssistantsQuery {
        .init(model: .gpt4, name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: [])
    }
}
