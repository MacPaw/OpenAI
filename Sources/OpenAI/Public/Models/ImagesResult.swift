//
//  ImagesResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ImagesResult: Codable, Equatable {

    public let created: TimeInterval
    public let data: [Self.Image]

    public struct Image: Codable, Equatable {

        /// The base64-encoded JSON of the generated image, if response_format is b64_json
        public let b64_json: String?
        /// The prompt that was used to generate the image, if there was any revision to the prompt.
        public let revised_prompt: String?
        /// The URL of the generated image, if response_format is url (default).
        public let url: String?
    }
}
