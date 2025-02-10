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
    
    private var subscription: AnyCancellable?
    
    public init(
        openAIClient: OpenAIProtocol
    ) {
        self.openAIClient = openAIClient
    }
    
    @MainActor
    func images(query: ImagesQuery) {
        imagesQueryInProgress = true
        images.removeAll()
        
        subscription = openAIClient
            .images(query: query)
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCancel: {
                self.imagesQueryInProgress = false
            })
            .sink(receiveCompletion: { completion in
                self.imagesQueryInProgress = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    // TODO: Better error handling
                    print(failure)
                }
            }, receiveValue: { imagesResult in
                self.images = imagesResult.data
            })
    }
    
    func cancelImagesQuery() {
        subscription?.cancel()
        subscription = nil
    }
}
