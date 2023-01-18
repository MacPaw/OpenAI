//
//  File.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation

public enum Model: String, Codable {
    case textDavinci_003 = "text-davinci-003"
    case textDavinci_002 = "text-davinci-002"
    case textDavinci_001 = "text-davinci-001"
    case curie = "text-curie-001"
    case babbage = "text-babbage-001"
    case textSearchBabbadgeDoc = "text-search-babbage-doc-001"
    case textSearchBabbageQuery001 = "text-search-babbage-query-001"
    case ada = "text-ada-001"
    case textEmbeddingAda = "text-embedding-ada-002"
}
