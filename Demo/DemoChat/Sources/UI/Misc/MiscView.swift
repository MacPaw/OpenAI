//
//  MiscView.swift
//  DemoChat
//
//  Created by Aled Samuel on 22/04/2023.
//

import SwiftUI

public struct MiscView: View {
    @ObservedObject var store: MiscStore
    
    public init(store: MiscStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Models")) {
                    NavigationLink("List Models", destination: ListModelsView(store: store))
                    NavigationLink("Retrieve Model", destination: RetrieveModelView())
                }
                Section(header: Text("Moderations")) {
                    NavigationLink("Moderation Chat", destination: ModerationChatView(store: store))
                }
                Section(header: Text("Audio")) {
                    NavigationLink("Create Speech", destination: TextToSpeechView(store: SpeechStore(openAIClient: store.openAIClient)))
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Misc")
        }
    }
}

struct RetrieveModelView: View {
    var body: some View {
        Text("Retrieve Model: TBD")
            .font(.largeTitle)
    }
}
