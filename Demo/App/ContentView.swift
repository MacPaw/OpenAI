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
    @State private var selectedTab = 0
    @Environment(\.idProviderValue) var idProvider

    var body: some View {
        TabView(selection: $selectedTab) {
            ChatView(
                store: chatStore
            )
            .tabItem {
                Label("Chats", systemImage: "message")
            }
            .tag(0)

            TranscribeView(
            )
            .tabItem {
                Label("Transcribe", systemImage: "mic")
            }
            .tag(1)

            ImageView(
            )
            .tabItem {
                Label("Image", systemImage: "photo")
            }
            .tag(2)
        }
    }
}

struct ChatsView: View {
    var body: some View {
        Text("Chats")
            .font(.largeTitle)
    }
}

struct TranscribeView: View {
    var body: some View {
        Text("Transcribe: TBD")
            .font(.largeTitle)
    }
}

struct ImageView: View {
    var body: some View {
        Text("Image: TBD")
            .font(.largeTitle)
    }
}
