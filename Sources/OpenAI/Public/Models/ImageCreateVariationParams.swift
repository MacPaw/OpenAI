//
//  ImageCreateVariationParams.swift
//
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageCreateVariationParams: Codable {
    public typealias ResponseFormat = ImageGenerateParams.ResponseFormat
    public typealias Model = ImageModel

    /// The image to edit. Must be a valid PNG file, less than 4MB, and square.
    public let image: Data
    /// The model to use for image generation. Only dall-e-2 is supported at this time.
    /// Defaults to dall-e-2
    public let model: Self.Model?
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
        model: Self.Model? = nil,
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

extension ImageCreateVariationParams: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        var entries: [MultipartFormDataEntry] = [
            .file(paramName: "image", fileName: "image.png", fileData: image, contentType: "image/png")]
        if model != nil {
            entries.append(.string(paramName: "model", value: model))
        }
        if n != nil {
            entries.append(.string(paramName: "n", value: n))
        }
        if response_format != nil {
            entries.append(.string(paramName: "response_format", value: response_format))
        }
        if size != nil {
            entries.append(.string(paramName: "size", value: size))
        }
        if user != nil {
            entries.append(.string(paramName: "user", value: user))
        }

        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: entries)

        return bodyBuilder.build()
    }
}
