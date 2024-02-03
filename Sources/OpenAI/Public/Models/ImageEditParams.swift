//
//  ImageEditParams.swift
//
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageEditParams: Codable {
    public typealias ResponseFormat = ImageGenerateParams.ResponseFormat
    public typealias Model = ImageModel
    public typealias Size = ImageGenerateParams.Size

    /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
    public let image: Data
    /// An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
    public let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    public let mask: Data?
    /// The model to use for image generation.
    /// Defaults to dall-e-2
    public let model: Self.Model?
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let n: Int?
    /// The format in which the generated images are returned. Must be one of url or b64_json.
    /// Defaults to url
    public let response_format: Self.ResponseFormat?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: Size?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids
    public let user: String?

    public init(
        image: Data,
        prompt: String,
        mask: Data? = nil,
        model: Self.Model? = nil,
        n: Int? = nil,
        response_format: Self.ResponseFormat? = nil,
        size: Self.Size? = nil,
        user: String? = nil
    ) {
        self.image = image
        self.prompt = prompt
        self.mask = mask
        self.model = model
        self.n = n
        self.response_format = response_format
        self.size = size
        self.user = user
    }
}

extension ImageEditParams: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        var entries: [MultipartFormDataEntry] = [
            .file(paramName: "image", fileName: "image.png", fileData: image, contentType: "image/png"),
            .string(paramName: "prompt", value: prompt)]
        if mask != nil {
            entries.append(.file(paramName: "mask", fileName: "mask.png", fileData: mask, contentType: "image/png"))
        }
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
