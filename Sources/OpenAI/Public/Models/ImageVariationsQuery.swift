//
//  ImageVariationsQuery.swift
//  
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageVariationsQuery: Codable {
    /// The image to edit. Must be a valid PNG file, less than 4MB, and square.
    public let image: Data
    public let fileName: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?

    public init(image: Data, fileName: String, n: Int? = nil, size: String? = nil) {
        self.image = image
        self.fileName = fileName
        self.n = n
        self.size = size
    }
}

extension ImageVariationsQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "image", fileName: fileName, fileData: image, contentType: "image/png"),
            .string(paramName: "n", value: n),
            .string(paramName: "size", value: size)
        ])
        return bodyBuilder.build()
    }
}
