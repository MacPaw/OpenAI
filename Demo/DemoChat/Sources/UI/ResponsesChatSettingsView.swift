//
//  ResponsesChatSettingsView.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 13.04.2025.
//

import SwiftUI

struct ResponsesChatSettingsView: View {
    @ObservedObject var store: ResponsesSettingsStore

    var body: some View {
        Form {
            Section(header: Text("Model")) {
                NavigationLink(destination: ModelSelectionView(store: store)) {
                    HStack {
                        Text("Model")
                        Spacer()
                        Text(store.selectedModel)
                            .foregroundColor(.secondary)
                    }
                }
            }

            Section(header: Text("Options")) {
                Toggle("Stream", isOn: $store.stream)
                Toggle("Web Search", isOn: $store.webSearchEnabled)
                Toggle("Function Calling", isOn: $store.functionCallingEnabled)
                Toggle("MCP Tools", isOn: $store.mcpEnabled)
            }
        }
        .navigationTitle("Settings")
    }
}

private struct ModelSelectionView: View {
    @ObservedObject var store: ResponsesSettingsStore

    var body: some View {
        List(store.models, id: \.self) { model in
            Button {
                store.selectedModel = model
            } label: {
                HStack {
                    Text(model)
                    if model == store.selectedModel {
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
        .navigationTitle("Select Model")
    }
}

#Preview {
    ResponsesChatSettingsView(store: .init())
}
