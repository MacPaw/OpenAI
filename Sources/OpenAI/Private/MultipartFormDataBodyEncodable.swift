//
//  MultipartFormDataBodyEncodable.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

protocol MultipartFormDataBodyEncodable: Sendable {
    
    func encode(boundary: String) -> Data
}
