//
//  ImageCreationView.swift
//  DemoChat
//
//  Created by Aled Samuel on 24/04/2023.
//

import SwiftUI
import OpenAI

public struct ImageCreationView: View {
    @ObservedObject var store: ImageStore
    
    @State private var prompt: String = ""
    @State private var n: Int = 1
    @State private var size: String
    
    private var sizes = ["256x256", "512x512", "1024x1024"]
    
    public init(store: ImageStore) {
        self.store = store
        size = sizes[0]
    }
    
    public var body: some View {
        List {
            Section {
                HStack {
                    Text("Prompt")
                    Spacer()
                    TextEditor(text: $prompt)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Stepper("Amount: \(n)", value: $n, in: 1...10)
                }
                HStack {
                    Picker("Size", selection: $size) {
                        ForEach(sizes, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            Section {
                HStack {
                    Button("Create Image" + (n == 1 ? "" : "s")) {
                        Task {
                            let query = ImagesQuery(prompt: prompt, n: n, size: size)
                            await store.images(query: query)
                        }
                    }
                    .foregroundColor(.accentColor)
                    Spacer()
                }
            }
            if !$store.images.isEmpty {
                Section("Images") {
                    ForEach($store.images, id: \.self) { image in
                        let urlString = image.wrappedValue.url
                        if let imageURL = URL(string: urlString), UIApplication.shared.canOpenURL(imageURL) {
                            LinkPreview(previewURL: imageURL)
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Text(urlString)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Create Image")
    }
}
