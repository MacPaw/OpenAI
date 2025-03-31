//
//  GeminiAPIError.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.03.2025.
//

import Foundation

public struct GeminiAPIErrorResponse: ErrorResponse {
    public let error: GeminiAPIError
    
    public var errorDescription: String? {
        error.errorDescription
    }
}

public struct GeminiAPIError: Error, Decodable, Equatable, LocalizedError {
    public let code: Int
    public let message: String
    public let status: String
    
    public var errorDescription: String? {
        message
    }
}
