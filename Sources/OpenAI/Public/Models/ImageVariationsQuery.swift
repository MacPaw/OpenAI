//
//  ImageVariationsQuery.swift
//  
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageVariationsQuery: Codable {
    public typealias ResponseFormat = ImagesQuery.ResponseFormat

    /// The image to edit. Must be a valid PNG file, less than 4MB, and square.
    public let image: Data
    /// The model to use for image generation. Only dall-e-2 is supported at this time.
    /// Defaults to dall-e-2
    public let model: Model?
    /// The number of images to generate. Must be between 1 and 10.
    /// Defaults to 1
    public let n: Int?
    /// The format in which the generated images are returned. Must be one of url or b64_json.
    /// Defaults to url
    public let response_format: Self.ResponseFormat?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    /// Defaults to 1024x1024
    public let size: String?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids
    public let user: String?

    public init(
        image: Data,
        model: Model? = nil,
        n: Int? = nil,
        response_format: Self.ResponseFormat? = nil,
        size: String? = nil,
        user: String? = nil
    ) {
        self.image = image
        self.model = model
        self.n = n
        self.response_format = response_format
        self.size = size
        self.user = user
    }
}

extension ImageVariationsQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "image", fileName: "image.png", fileData: image, contentType: "image/png"),
            .string(paramName: "model", value: model),
            .string(paramName: "response_format", value: response_format),
            .string(paramName: "user", value: user),
            .string(paramName: "n", value: n),
            .string(paramName: "size", value: size)
        ])
        return bodyBuilder.build()
    }
}
