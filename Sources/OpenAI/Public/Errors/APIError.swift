//
//  APIError.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public enum OpenAIError: Error {
    case invalidURL
    case emptyData
}

public struct APIError: Error, Decodable, Equatable {
    public let message: String
    public let type: String
    public let param: String?
    public let code: String?
}

public struct APIErrorResponse: Error, Decodable {
    public let error: APIError
}
