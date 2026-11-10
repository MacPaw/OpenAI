//
//  ImageStore.swift
//  DemoChat
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation
import OpenAI
import Combine

public final class ImageStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    
    @Published var imagesQueryInProgress = false
    @Published var images: [ImagesResult.Image] = []
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
            }, receiveValue: { [weak self] imagesResult in
                self?.images = imagesResult.data
            })
    }
    
    @MainActor
    func cancelImagesQuery() {
        subscription?.cancel()
        subscription = nil
        imagesQueryInProgress = false
    }
}
