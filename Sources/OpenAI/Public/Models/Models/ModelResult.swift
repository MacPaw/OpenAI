//
//  ModelResult.swift
//  
//
//  Created by Aled Samuel on 08/04/2023.
//

import Foundation

public struct ModelResult: Codable, Equatable {

    public let id: Model
    public let object: String
    public let ownedBy: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case ownedBy = "owned_by"
    }
}
