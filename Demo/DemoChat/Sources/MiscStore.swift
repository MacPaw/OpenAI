//
//  MiscStore.swift
//  DemoChat
//
//  Created by Aled Samuel on 22/04/2023.
//

import Foundation
import OpenAI

public final class MiscStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    
    @Published var availableModels: [ModelResult] = []
    
    public init(
        openAIClient: OpenAIProtocol
    ) {
        self.openAIClient = openAIClient
    }
    
    @MainActor
    func getModels() async {
        do {
            let response = try await openAIClient.models()
            availableModels = response.data
        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
    }
}
