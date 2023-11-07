//
//  ImagesQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ImagesQuery: Codable {
    /// ID of the model to use. 
    public let model: Model?

    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?
    
    /// The style of the generated images. Must be one of vivid or natural. Vivid causes the model to lean towards generating hyper-real and dramatic images. Natural causes the model to produce more natural, less hyper-real looking images. This param is only supported for dall-e-3.
    public let style: String?

    public init(prompt: String, model: Model?=nil, n: Int?, size: String?, style: String?) {
        self.style = style
        self.prompt = prompt
        self.n = n
        self.size = size
        self.model = model
    }
}
