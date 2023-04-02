//
//  ImagesQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ImagesQuery: Codable {
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?

    public init(prompt: String, n: Int?, size: String?) {
        self.prompt = prompt
        self.n = n
        self.size = size
    }
}
