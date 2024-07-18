//
//  ImageEditsQuery.swift
//  
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageEditsQuery: Codable {
    public typealias ResponseFormat = ImagesQuery.ResponseFormat
    public typealias Size = ImagesQuery.Size

    /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
    public let image: Data
    /// An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
    public let mask: Data?
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The model to use for image generation.
    /// Defaults to dall-e-2
    public let model: Model?
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The format in which the generated images are returned. Must be one of url or b64_json.
    /// Defaults to url
    public let responseFormat: Self.ResponseFormat?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: Size?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids
    public let user: String?

    public init(
        image: Data,
        prompt: String,
        mask: Data? = nil,
        model: Model? = nil,
        n: Int? = nil,
        responseFormat: Self.ResponseFormat? = nil,
        size: Self.Size? = nil,
        user: String? = nil
    ) {
        self.image = image
        self.mask = mask
        self.prompt = prompt
        self.model = model
        self.n = n
        self.responseFormat = responseFormat
        self.size = size
        self.user = user
    }

    public enum CodingKeys: String, CodingKey {
        case image
        case mask
        case prompt
        case model
        case n
        case responseFormat = "response_format"
        case size
        case user
    }
}

extension ImageEditsQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "image", fileName: "image.png", fileData: image, contentType: "image/png"),
            .file(paramName: "mask", fileName: "mask.png", fileData: mask, contentType: "image/png"),
            .string(paramName: "model", value: model),
            .string(paramName: "response_format", value: responseFormat),
            .string(paramName: "user", value: user),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "n", value: n),
            .string(paramName: "size", value: size)
        ])
        return bodyBuilder.build()
    }
}
