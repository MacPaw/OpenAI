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
    @State private var size = ImagesQuery.Size._1024

    private var sizes = ImagesQuery.Size.allCases.dropLast(2)
    
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
                            Text($0.rawValue)
                        }
                    }
                }
            }
            Section {
                HStack {
                    actionButton
                    .foregroundColor(.accentColor)
                    Spacer()
                }
            }
            if !$store.images.isEmpty {
                Section("Images") {
                    ForEach($store.images, id: \.url) { image in
                        let urlString = image.wrappedValue.url ?? ""
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
    
    private var actionButton: some View {
        if store.imagesQueryInProgress {
            Button("Cancel") {
                store.cancelImagesQuery()
            }
        } else {
            Button("Create Image" + (n == 1 ? "" : "s")) {
                let query = ImagesQuery(prompt: prompt, n: n, size: size)
                store.images(query: query)
            }
        }
    }
}
