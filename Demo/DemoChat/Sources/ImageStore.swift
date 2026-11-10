//
//  ImageStore.swift
//  DemoChat
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation
import OpenAI
import Combine
import CoreGraphics
import ImageIO

struct GeneratedImage: Identifiable {
    let id = UUID()
    let url: String?
    /// Decoded from `b64_json`, or `nil` when it is absent or not an image.
    let cgImage: CGImage?
    /// `b64_json` was present, so the view can tell a failed decode from a URL image.
    let hasBase64: Bool
    let revisedPrompt: String?
}

public final class ImageStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    
    @Published var imagesQueryInProgress = false
    @Published var images: [GeneratedImage] = []
    @Published var imagesQueryError: Error?
    
    private var subscription: AnyCancellable?
    
    public init(
        openAIClient: OpenAIProtocol
    ) {
        self.openAIClient = openAIClient
    }
    
    @MainActor
    func images(prompt: String, n: Int, size: ImagesQuery.Size) {
        cancelImagesQuery()
        imagesQueryInProgress = true
        images.removeAll()
        imagesQueryError = nil
        let query = ImagesQuery(prompt: prompt, model: .gpt_image_1_5, n: n, size: size)
        
        subscription = openAIClient
            .images(query: query)
            .map(Self.makeImages)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.imagesQueryInProgress = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    // `cancelImagesQuery()` cancels the subscription, so its cancellation never reaches here. A cancelled
                    // error still can when the request is cancelled underneath the subscription, for example when the
                    // URL session is invalidated, and that isn't a failure to show.
                    if !(failure is CancellationError), (failure as? URLError)?.code != .cancelled {
                        self.imagesQueryError = failure
                    }
                }
            }, receiveValue: { [weak self] in
                self?.images = $0
            })
    }

    // A function rather than a closure: a closure written in `images(prompt:n:size:)` would be
    // isolated to the main actor, but this runs on the URL session's queue.
    private static func makeImages(_ result: ImagesResult) -> [GeneratedImage] {
        result.data.map { image in
            GeneratedImage(
                url: image.url,
                cgImage: image.b64Json.flatMap(decode),
                hasBase64: image.b64Json != nil,
                revisedPrompt: image.revisedPrompt
            )
        }
    }

    private static func decode(_ base64: String) -> CGImage? {
        guard let data = Data(base64Encoded: base64),
              let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        // Decode the pixels here, off the main thread, rather than on first draw
        return CGImageSourceCreateImageAtIndex(source, 0, [kCGImageSourceShouldCacheImmediately: true] as CFDictionary)
    }
    
    @MainActor
    func cancelImagesQuery() {
        subscription?.cancel()
        subscription = nil
        imagesQueryInProgress = false
    }
}
