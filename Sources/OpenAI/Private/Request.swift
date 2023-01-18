//
//  File.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation

class Request<ResultType> {
    
    let body: Codable
    let url: URL
    
    init(body: Codable, url: URL) {
        self.body = body
        self.url = url
    }
}
