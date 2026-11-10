//
//  ImageStore.swift
//  DemoChat
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation
import OpenAI
import Combine
#if canImport(UIKit)
import UIKit
#endif

public final class ImageStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    
    @Published var imagesQueryInProgress = false
    @Published var images: [ImagesResult.Image] = []
    #if canImport(UIKit)
    /// `images[i].b64Json` decoded, or `nil` when it is absent or not an image.
    /// Decoded once per response, off the main thread, so the view doesn't decode on every body evaluation.
    @Published var decodedImages: [UIImage?] = []
    #endif
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
        #if canImport(UIKit)
        decodedImages.removeAll()
        #endif
        imagesQueryError = nil
        let query = ImagesQuery(prompt: prompt, model: .gpt_image_1_5, n: n, size: size)
        
        subscription = openAIClient
            .images(query: query)
            .map(Self.decodeImages)
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
            }, receiveValue: { [weak self] imagesResult, decoded in
                self?.images = imagesResult.data
                #if canImport(UIKit)
                self?.decodedImages = decoded
                #endif
            })
    }

    // A function rather than a closure: a closure written in `images(prompt:n:size:)` would be
    // isolated to the main actor, but this runs on the URL session's queue.
    #if canImport(UIKit)
    private static func decodeImages(_ result: ImagesResult) -> (ImagesResult, [UIImage?]) {
        let decoded = result.data.map { image in
            image.b64Json.flatMap { Data(base64Encoded: $0) }.flatMap(UIImage.init(data:))
        }
        return (result, decoded)
    }
    #else
    private static func decodeImages(_ result: ImagesResult) -> (ImagesResult, Void) {
        (result, ())
    }
    #endif
    
    @MainActor
    func cancelImagesQuery() {
        subscription?.cancel()
        subscription = nil
        imagesQueryInProgress = false
    }
}
