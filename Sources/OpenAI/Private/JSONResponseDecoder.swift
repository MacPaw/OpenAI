//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 09.06.2025.
//

import Foundation

struct JSONResponseDecoder {
    let parsingOptions: ParsingOptions
    
    func decodeResponseData<ResultType: Codable>(_ data: Data) throws -> ResultType {
        let responseDecoder = JSONDecoder()
        responseDecoder.userInfo[.parsingOptions] = parsingOptions
        
        do {
            return try responseDecoder.decode(ResultType.self, from: data)
        } catch {
            let errorDecoder = JSONResponseErrorDecoder(decoder: JSONDecoder())
            
            if let decodedError = errorDecoder.decodeErrorResponse(data: data) {
                throw decodedError
            } else {
                throw error
            }
        }
    }
}
