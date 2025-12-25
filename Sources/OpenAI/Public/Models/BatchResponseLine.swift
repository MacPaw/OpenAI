//
//  BatchResponseLine.swift
//
//
//  Created by Jason Flax on 12/24/2024.
//

import Foundation

/// A single response line from a batch output JSONL file.
public struct BatchResponseLine: Codable, Equatable, Sendable {

    /// The unique identifier for this response.
    public let id: String

    /// The custom_id from the corresponding request.
    public let customId: String

    /// The response body, if the request was successful.
    public let response: BatchResponseBody?

    /// Error information, if the request failed.
    public let error: BatchResponseError?

    enum CodingKeys: String, CodingKey {
        case id
        case customId = "custom_id"
        case response
        case error
    }
}

/// The response body from a successful batch request.
public struct BatchResponseBody: Codable, Equatable, Sendable {

    /// The HTTP status code of the response.
    public let statusCode: Int

    /// The request ID.
    public let requestId: String

    /// The response body (ChatResult for chat completions).
    public let body: ChatResult

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case requestId = "request_id"
        case body
    }
}

/// Error information from a failed batch request.
public struct BatchResponseError: Codable, Equatable, Sendable {

    /// The error code.
    public let code: String

    /// The error message.
    public let message: String
}
