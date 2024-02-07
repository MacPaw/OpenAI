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
    }
    
    public let created: TimeInterval
    public let data: [URLResult]
}

extension ImagesResult.URLResult: Hashable { }
