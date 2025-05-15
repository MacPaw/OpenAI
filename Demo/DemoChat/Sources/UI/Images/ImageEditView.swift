//
//  ImageEditView.swift
//  DemoChat
//
//  Created by Jim Wang on 2025/5/9.
//

import SwiftUI
import PhotosUI
import OpenAI

public struct ImageEditView: View {
    @ObservedObject var store: ImageStore

    @State private var maxPhotos = 2
    @State private var selectedPhotoItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []

    @State private var selectedMaskItem: PhotosPickerItem?
    @State private var maskImage: UIImage?

    @State private var prompt: String = "Generate a photorealistic image of a gift basket on a white background labeled \"Relax & Unwind\" with a ribbon and handwriting-like font, containing all the items in the reference pictures'"

    @State private var resultImage: UIImage?
    @State private var resultUrl: URL?

    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    @State private var selectedModel: Model = .gpt_image_1
    private let models: [Model] = [.gpt_image_1, .dall_e_2]

    public init(store: ImageStore) {
        self.store = store
    }

    public var body: some View {
        List {
            Section {
                VStack {
                    if let resultImage {
                        Image(uiImage: resultImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(12)
                    } else if let resultUrl, UIApplication.shared.canOpenURL(resultUrl) {
                        LinkPreview(previewURL: resultUrl)
                            .aspectRatio(contentMode: .fit)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 200)
                            .overlay(Text("Result will appear here").foregroundColor(.gray))
                    }

                    if isLoading || errorMessage != nil {
                        Divider()

                        if isLoading {
                            HStack {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            }
                        }

                        if let errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.top, 4)
                        }
                    }
                }
            }

            Section(header: Text("Model")) {
                Picker("Select Model", selection: $selectedModel) {
                    ForEach(models, id: \.self) { model in
                        Text(model).tag(model)
                    }
                }
                .pickerStyle(.menu)
            }

            Section(header: Text("Prompt")) {
                TextField("Enter your prompt...", text: $prompt)
            }

            Section(header: Text("Input Image")) {
                HStack(spacing: 8) {
                    PhotosPicker(selection: $selectedPhotoItems, maxSelectionCount: maxPhotos, matching: .images) {
                        Label("", systemImage: "photo")
                            .foregroundStyle(Color.black)
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0..<maxPhotos, id: \.self) { index in
                                if index < selectedImages.count {
                                    Image(uiImage: selectedImages[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 64, height: 64)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                } else {
                                    placeholderImage()
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(8)
                .frame(height: 80)
                .cornerRadius(16)
            }

            Section(header: Text("Mask Image")) {
                HStack(spacing: 8) {
                    PhotosPicker(selection: $selectedMaskItem, matching: .images) {
                        Label("", systemImage: "photo")
                            .foregroundStyle(Color.black)
                    }
                    if let maskImage {
                        Image(uiImage: maskImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        placeholderImage()
                    }

                    Spacer()
                }
                .padding(8)
                .frame(height: 80)
                .cornerRadius(16)
            }

            Section {
                Button("Generate Image") {
                    Task {
                        await generateImage()
                    }
                }
                .disabled(prompt.isEmpty || selectedImages.isEmpty || isLoading)
            }
        }
        .onChange(of: selectedModel) { newModel in
            switch newModel {
            case .gpt_image_1:
                selectedPhotoItems = []
                selectedImages = []
                maxPhotos = 2
            default:
                selectedPhotoItems = []
                selectedImages = []
                maxPhotos = 1
            }
        }
        .onChange(of: selectedMaskItem) { newMaskItem in
            Task {
                await loadMaskImage(from: newMaskItem)
            }
        }
        .onChange(of: selectedPhotoItems) { newItems in
            Task {
                await loadSelectedImages(from: newItems)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Create Image Edit")
    }

    private func placeholderImage() -> some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .frame(width: 64, height: 64)
            .overlay(Image(systemName: "photo").foregroundColor(.gray))
    }

    private func loadSelectedImages(from items: [PhotosPickerItem]) async {
        var images: [UIImage] = []
        for item in items.prefix(maxPhotos) {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                images.append(image)
            }
        }
        selectedImages = images
    }

    private func loadMaskImage(from item: PhotosPickerItem?) async {
        guard let item,
                let data = try? await item.loadTransferable(type: Data.self),
                let mask = UIImage(data: data) else {
            maskImage = nil
            return
        }
        maskImage = mask
    }

    @MainActor
    private func generateImage() async {
        isLoading = true
        errorMessage = nil
        resultImage = nil
        defer {
            isLoading = false
        }

        let inputImages: [ImageEditsQuery.InputImage] = selectedImages
            .compactMap { $0.pngData() }
            .map { .png($0) }

        let query = ImageEditsQuery(
            images: inputImages,
            prompt: prompt,
            mask: maskImage?.pngData(),
            model: selectedModel
        )

        do {
            let imageResult = try await store.openAIClient.imageEdits(query: query)
            guard let image = imageResult.data.first else {
                errorMessage = "No image"
                return
            }

            if let b64JSON = image.b64Json {
                guard let data = Data(base64Encoded: b64JSON), let result = UIImage(data: data) else {
                    errorMessage = "Failed to decode image."
                    return
                }
                resultImage = result
            } else if let url = image.url {
                resultUrl = URL(string: url)!
            } else {
                errorMessage = "No image"
            }
        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }
    }
}
