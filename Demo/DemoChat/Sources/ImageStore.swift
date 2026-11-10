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
            .map { result in (result, Self.decode(result.data)) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.imagesQueryInProgress = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
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

    #if canImport(UIKit)
    private static func decode(_ images: [ImagesResult.Image]) -> [UIImage?] {
        images.map { image in
            image.b64Json.flatMap { Data(base64Encoded: $0) }.flatMap(UIImage.init(data:))
        }
    }
    #else
    private static func decode(_ images: [ImagesResult.Image]) -> Void {}
    #endif
    
    @MainActor
    func cancelImagesQuery() {
        subscription?.cancel()
        subscription = nil
        imagesQueryInProgress = false
    }
}
