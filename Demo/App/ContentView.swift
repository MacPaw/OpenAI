//
//  ContentView.swift
//  Demo
//
//  Created by Sihao Lu on 4/7/23.
//

import DemoChat
import OpenAI
import SwiftUI

struct ContentView: View {
    @ObservedObject var chatStore: ChatStore
    @ObservedObject var imageStore: ImageStore
    @ObservedObject var assistantStore: AssistantStore
    @ObservedObject var miscStore: MiscStore
    @ObservedObject var responsesStore: ResponsesStore
    @ObservedObject var mcpToolsStore: MCPToolsStore
    
    @State private var selectedTab = 0
    @Environment(\.idProviderValue) var idProvider

    var body: some View {
        TabView(selection: $selectedTab) {
            ChatView(
                store: chatStore,
                assistantStore: assistantStore
            )
            .tabItem {
                Label("Chats", systemImage: "message")
            }
            .tag(0)

            ResponsesChatDetailView(
                store: responsesStore
            ).tabItem {
                Label("Responses", systemImage: "message.circle")
            }.tag(1)

            TranscribeView(
            )
            .tabItem {
                Label("Transcribe", systemImage: "mic")
            }
            .tag(2)

            ImageView(
                store: imageStore
            )
            .tabItem {
                Label("Image", systemImage: "photo")
            }
            .tag(3)

            MCPToolsView(mcpStore: mcpToolsStore)
            .tabItem {
                Label("Github MCP", systemImage: "wrench.and.screwdriver")
            }
            .tag(4)

            MiscView(
                store: miscStore,
                chatStore: chatStore,
                assistantStore: assistantStore
            )
            .tabItem {
                Label("Misc", systemImage: "ellipsis")
            }
            .tag(5)
        }
    }
}

struct TranscribeView: View {
    var body: some View {
        Text("Transcribe: TBD")
            .font(.largeTitle)
    }
}
