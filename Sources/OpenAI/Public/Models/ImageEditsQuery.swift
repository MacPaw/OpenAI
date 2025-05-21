//
//  ImageEditsQuery.swift
//  
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageEditsQuery: Codable, Hashable, Sendable {

    public typealias InputImage = ImagesQuery.InputImage
    public typealias ResponseFormat = ImagesQuery.ResponseFormat
    public typealias Size = ImagesQuery.Size
    public typealias Quality = ImagesQuery.Quality

    /// The images to edit. Must be a supported image file or an array of images.
    /// For gpt-image-1, each image should be a png, webp, or jpg file less than 25MB.
    /// For dall-e-2, you can only provide one image, and it should be a square png file less than 4MB.
    public let images: [InputImage]

    /// An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
    public let mask: Data?
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The model to use for image generation.
    /// Defaults to dall-e-2
    public let model: Model?
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The quality of the image that will be generated.
    /// high, medium and low are only supported for gpt-image-1.
    /// dall-e-2, dall-e-3 only supports standard quality. Defaults to auto.
    public let quality: Quality?
    /// The format in which the generated images are returned. Must be one of url or b64_json.
    /// Defaults to url
    public let responseFormat: Self.ResponseFormat?
    /// The size of the generated images. Must be one of 256x256, 512x512, 1024x1024, 1536x
    /// - For gpt-image-1, one of `1024x1024`, `1536x1024` (landscape), `1024x1536` (portrait), or `auto` (default value)
    /// - For dall-e-2, one of `256x256`, `512x512`, or `1024x1024`
    public let size: Size?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids
    public let user: String?

    @available(*, deprecated, message: "Use init(images:prompt:mask:model:n:quality:responseFormat:size:user:) instead. This initializer is kept for backward compatibility.")
    // For backward compatibility, the image must be a square PNG file smaller than 4MB.
    public init(
        image: Data,
        prompt: String,
        mask: Data? = nil,
        model: Model? = nil,
        n: Int? = nil,
        quality: Quality? = nil,
        responseFormat: Self.ResponseFormat? = nil,
        size: Self.Size? = nil,
        user: String? = nil
    ) {
        self.init(
            images: [.png(image)],
            prompt: prompt,
            mask: mask,
            model: model,
            n: n,
            quality: quality,
            responseFormat: responseFormat,
            size: size,
            user: user
        )
    }

    public init(
        images: [InputImage],
        prompt: String,
        mask: Data? = nil,
        model: Model? = nil,
        n: Int? = nil,
        quality: Quality? = nil,
        responseFormat: Self.ResponseFormat? = nil,
        size: Self.Size? = nil,
        user: String? = nil
    ) {
        self.images = images
        self.mask = mask
        self.prompt = prompt
        self.model = model
        self.n = n
        self.quality = quality
        self.responseFormat = responseFormat
        self.size = size
        self.user = user
    }

    public enum CodingKeys: String, CodingKey {
        case images
        case mask
        case prompt
        case model
        case n
        case responseFormat = "response_format"
        case quality
        case size
        case user
    }
}

extension ImageEditsQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        var entries: [MultipartFormDataEntry] = [
            .file(paramName: "mask", fileName: "mask.png", fileData: mask, contentType: "image/png"),
            .string(paramName: "model", value: model),
            .string(paramName: "response_format", value: responseFormat),
            .string(paramName: "user", value: user),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "n", value: n),
            .string(paramName: "size", value: size),
            .string(paramName: "quality", value: quality?.rawValue)
        ]

        // Only gpt-image-1 supports multiple images, so fallback to single image upload for others
        if images.count > 1 {
            for (index, image) in images.enumerated() {
                entries.append(
                    .file(
                        paramName: "image[]",
                        fileName: "tmpfile\(index)",
                        fileData: image.content,
                        contentType: image.contentType
                    )
                )
            }
        } else if images.count == 1 {
            let image = images[0].content
            entries.append(
                .file(
                    paramName: "image",
                    fileName: "image.png",
                    fileData: image,
                    contentType: "image/png"
                )
            )
        }

        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: entries)
        return bodyBuilder.build()
    }
}
