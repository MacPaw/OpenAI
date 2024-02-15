//
//  ImagesResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ImagesResult: Decodable, Equatable {

    public struct URLResult: Decodable, Equatable {
        public let url: String?
        public let b64_json: String?

        public enum CodingKeys: CodingKey {
            case url
            case b64_json
        }
    }

    public let created: TimeInterval
    public let data: [URLResult]

    public enum CodingKeys: CodingKey {
        case created
        case data
    }
}

extension ImagesResult.URLResult: Hashable { }
