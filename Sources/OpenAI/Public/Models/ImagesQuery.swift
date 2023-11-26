//
//  ImagesQuery.swift
//
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation


public enum ImageResponseFormat: String, Codable, Equatable {
    case url
    case b64_json
}

public struct ImagesQuery: Codable {
    public typealias ResponseFormat = ImageResponseFormat
    
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    
    /// ID of the model to use.
    public let model: Model?
    /// The format in which the generated images are returned
    public let responseFormat: Self.ResponseFormat?
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    public let user: String?
    /// The style of the generated images. Must be one of vivid or natural. Vivid causes the model to lean towards generating hyper-real and dramatic images. Natural causes the model to produce more natural, less hyper-real looking images. This param is only supported for dall-e-3.
    public let style: String?
    /// The quality of the image that will be generated. hd creates images with finer details and greater consistency across the image. This param is only supported for dall-e-3.
    public let quality: String?
    
    public init(prompt: String, model: Model?=nil, responseFormat: Self.ResponseFormat?=nil, n: Int?, size: String?, style: String?=nil, user:String?=nil, quality:String?=nil) {
        self.style = style
        self.prompt = prompt
        self.n = n
        self.size = size
        self.model = model
        self.responseFormat = responseFormat
        self.user = user
        self.quality = quality
    }
    
    public enum CodingKeys: String, CodingKey {
        case model
        case prompt
        case n
        case size
        case user
        case style
        case responseFormat = "response_format"
        case quality
    }
}
