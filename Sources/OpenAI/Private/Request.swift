//
//  Request.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation

class Request<ResultType> {
    
    let body: Codable
    let url: URL
    let timeoutInterval: TimeInterval
    
    init(body: Codable, url: URL, timeoutInterval: TimeInterval) {
        self.body = body
        self.url = url
        self.timeoutInterval = timeoutInterval
    }
}
