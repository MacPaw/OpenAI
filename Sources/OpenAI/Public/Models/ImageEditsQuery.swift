//
//  ImageEditsQuery.swift
//  
//
//  Created by Aled Samuel on 24/04/2023.
//

import Foundation

public struct ImageEditsQuery: Codable {
    /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
    public let image: Data
    public let fileName: String
    /// An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
    public let mask: Data?
    public let maskFileName: String?
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?

    public init(image: Data, fileName: String, mask: Data? = nil, maskFileName: String? = nil, prompt: String, n: Int? = nil, size: String? = nil) {
        self.image = image
        self.fileName = fileName
        self.mask = mask
        self.maskFileName = maskFileName
        self.prompt = prompt
        self.n = n
        self.size = size
    }
}

extension ImageEditsQuery: MultipartFormDataBodyEncodable {
    func encode(boundary: String) -> Data {
        let bodyBuilder = MultipartFormDataBodyBuilder(boundary: boundary, entries: [
            .file(paramName: "image", fileName: fileName, fileData: image, contentType: "image/png"),
            .file(paramName: "mask", fileName: maskFileName, fileData: mask, contentType: "image/png"),
            .string(paramName: "prompt", value: prompt),
            .string(paramName: "n", value: n),
            .string(paramName: "size", value: size)
        ])
        return bodyBuilder.build()
    }
}
