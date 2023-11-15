//
//  ImagesResult.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public struct ImagesResult: Codable, Equatable {
    
    public struct URLResult: Codable, Equatable {
        public let url: String
    }
    public let created: TimeInterval
    public let data: [URLResult]
}

extension ImagesResult.URLResult: Hashable { }
