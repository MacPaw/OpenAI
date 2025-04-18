//
//  InputImage.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.04.2025.
//

import Foundation

/// An image input to the model. Learn about [image inputs](/docs/guides/vision).
public struct InputImage: Codable, Hashable, Sendable {
    /// The type of the input item. Always `input_image`.
    @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
        case inputImage = "input_image"
    }
    /// The type of the input item. Always `input_image`.
    public var _type: InputImage._TypePayload
    /// The URL of the image to be sent to the model. A fully qualified URL or
    /// base64 encoded image in a data URL.
    public var imageUrl: Swift.String?
    /// The ID of the file to be sent to the model.
    public var fileId: Swift.String?
    /// The detail level of the image to be sent to the model. One of `high`,
    /// `low`, or `auto`. Defaults to `auto`.
    @frozen public enum DetailPayload: String, Codable, Hashable, Sendable, CaseIterable {
        case high = "high"
        case low = "low"
        case auto = "auto"
    }
    /// The detail level of the image to be sent to the model. One of `high`,
    /// `low`, or `auto`. Defaults to `auto`.
    public var detail: InputImage.DetailPayload
    /// Creates a new `InputImage`.
    ///
    /// - Parameters:
    ///   - _type: The type of the input item. Always `input_image`.
    ///   - imageUrl: The URL of the image to be sent to the model. A fully qualified URL or
    ///   - fileId: The ID of the file to be sent to the model.
    ///   - detail: The detail level of the image to be sent to the model. One of `high`,
    public init(
        _type: InputImage._TypePayload,
        imageUrl: Swift.String? = nil,
        fileId: Swift.String? = nil,
        detail: InputImage.DetailPayload
    ) {
        self._type = _type
        self.imageUrl = imageUrl
        self.fileId = fileId
        self.detail = detail
    }
    
    public init(imageData: Data, detail: DetailPayload) {
        self.init(
            _type: .inputImage,
            imageUrl: "data:image/jpeg;base64,\(imageData.base64EncodedString())",
            detail: detail
        )
    }
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
        case imageUrl = "image_url"
        case fileId = "file_id"
        case detail
    }
}
