//
//  JSONResponseErrorDecoder.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.03.2025.
//

import Foundation

struct JSONResponseErrorDecoder {
    let decoder: JSONDecoder
    
    func decodeErrorResponse(data: Data) -> (any ErrorResponse)? {
        if let decoded = try? decoder.decode(APIErrorResponse.self, from: data) {
            return decoded
        } else if let decoded = try? decoder.decode([GeminiAPIErrorResponse].self, from: data) {
            return decoded[0]
        } else {
            return nil
        }
    }
}
