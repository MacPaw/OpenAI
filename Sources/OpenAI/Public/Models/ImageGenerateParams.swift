//
//  ImageGenerateParams.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

/// Given a prompt and/or an input image, the model will generate a new image.
/// https://platform.openai.com/docs/guides/images
public struct ImageGenerateParams: Codable {
    public typealias Model = ImageModel

    /// A text description of the desired image(s). The maximum length is 1000 characters for dall-e-2 and 4000 characters for dall-e-3.
    public let prompt: String
    /// The model to use for image generation.
    /// Defaults to dall-e-2
    public let model: Self.Model?
    /// The number of images to generate. Must be between 1 and 10. For dall-e-3, only n=1 is supported.
    /// Defaults to 1
    public let n: Int?
    /// The quality of the image that will be generated. hd creates images with finer details and greater consistency across the image. This param is only supported for dall-e-3.
    /// Defaults to standard
    public let quality: Self.Quality?
    /// The format in which the generated images are returned. Must be one of url or b64_json.
    /// Defaults to url
    public let response_format: Self.ResponseFormat?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024 for dall-e-2. Must be one of 1024x1024, 1792x1024, or 1024x1792 for dall-e-3 models.
    /// Defaults to 1024x1024
    public let size: Self.Size?
    /// The style of the generated images. Must be one of vivid or natural. Vivid causes the model to lean towards generating hyper-real and dramatic images. Natural causes the model to produce more natural, less hyper-real looking images. This param is only supported for dall-e-3.
    /// Defaults to vivid
    public let style: Self.Style?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// https://platform.openai.com/docs/guides/safety-best-practices/end-user-ids
    public let user: String?

    public init(
        prompt: String,
        model: Self.Model? = nil,
        n: Int? = nil,
        quality:Self.Quality? = nil,
        response_format: Self.ResponseFormat? = nil,
        size: Size? = nil,
        style: Self.Style? = nil,
        user:String? = nil
    ) {
        self.prompt = prompt
        self.model = model
        self.n = n
        self.quality = quality
        self.response_format = response_format
        self.size = size
        self.style = style
        self.user = user
    }

    public enum Style: String, Codable, CaseIterable {
        case natural
        case vivid
    }

    public enum Quality: String, Codable, CaseIterable {
        case standard
        case hd
    }

    public enum ResponseFormat: String, Codable, Hashable {
        case url
        case b64_json
    }

    public enum Size: String, Codable, CaseIterable {
        case _256 = "256x256"
        case _512 = "512x512"
        case _1024 = "1024x1024"
//        case _1792_1024 = "1792x1024" // for dall-e-3 models
//        case _1024_1792 = "1024x1792" // for dall-e-3 models
    }
}
