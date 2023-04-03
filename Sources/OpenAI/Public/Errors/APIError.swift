//
//  APIError.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public enum OpenAIError: Error {
    case emptyData
}

public struct APIError: Error, Decodable, Equatable {
    public let message: String
    public let type: String
    public let param: String?
    public let code: String?
}

extension APIError: LocalizedError {
    
    public var errorDescription: String? {
        return message
    }
}

public struct APIErrorResponse: Error, Decodable, Equatable {
    public let error: APIError
}

extension APIErrorResponse: LocalizedError {
    
    public var errorDescription: String? {
        return error.errorDescription
    }
}
