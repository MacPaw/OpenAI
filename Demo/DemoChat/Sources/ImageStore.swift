//
//  ImageStore.swift
//  DemoChat
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation
import OpenAI

public final class ImageStore: ObservableObject {
    public var openAIClient: OpenAIProtocol

    @Published var images: [ImagesResponse.URLResult] = []

    public init(
        openAIClient: OpenAIProtocol
    ) {
        self.openAIClient = openAIClient
    }

    @MainActor
    func images(query: ImageGenerateParams) async {
        images.removeAll()
        do {
            let response = try await openAIClient.images(query: query)
            images = response.data
        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
    }
}
