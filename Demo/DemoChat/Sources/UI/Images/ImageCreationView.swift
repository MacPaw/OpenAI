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

    // The sizes the GPT image models accept. `ImageStore` always requests `gpt_image_1_5`, and the other
    // `ImagesQuery.Size` cases are for dall-e-2 (256 and 512) or dall-e-3 (1792), which the API rejects for it.
    private let sizes: [ImagesQuery.Size] = [._1024, ._1536x1024, ._1024x1536, .auto]
    
    public init(store: ImageStore) {
        self.store = store
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
                    if store.imagesQueryInProgress {
                        ProgressView()
                    }
                }
                if let error = store.imagesQueryError {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            if !store.images.isEmpty {
                Section("Images") {
                    ForEach(Array(store.images.enumerated()), id: \.offset) { index, image in
                        if image.b64Json != nil {
                            if index < store.decodedImages.count, let result = store.decodedImages[index] {
                                Image(uiImage: result)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else {
                                Text("Failed to decode image.")
                                    .foregroundColor(.red)
                            }
                        } else if let urlString = image.url, let imageURL = URL(string: urlString), UIApplication.shared.canOpenURL(imageURL) {
                            LinkPreview(previewURL: imageURL)
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Text(image.url ?? "No image returned.")
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
                store.images(prompt: prompt, n: n, size: size)
            }
        }
    }
}
