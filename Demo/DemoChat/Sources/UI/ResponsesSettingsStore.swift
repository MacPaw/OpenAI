//
//  ResponsesSettingsStore.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

import SwiftUI
import OpenAI

class ResponsesSettingsStore: ObservableObject {
    @Published public var selectedModel: Model = .gpt4_o
    @Published public var stream = true
    @Published public var webSearchEnabled = true
    
    public let models = Model.allModels(satisfying: .init(supportedEndpoints: [.responses]))
}
