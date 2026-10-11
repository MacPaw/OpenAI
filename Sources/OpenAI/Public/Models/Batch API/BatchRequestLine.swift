//
//  BatchRequestLine.swift
//
//
//  Created by Jason Flax on 12/24/2024.
//

import Foundation

/// A single request line for batch JSONL input file.
public struct BatchRequestLine: Codable, Sendable {

    /// A developer-provided per-request id that will be used to match outputs to inputs.
    public let customId: String

    /// The HTTP method to be used for the request. Always POST.
    let method: String

    /// The OpenAI API relative URL to be used for the request.
    let url: Components.Schemas.CreateBatchRequest.EndpointPayload

    /// The body of the request.
    public let body: ChatQuery

    enum CodingKeys: String, CodingKey {
        case customId = "custom_id"
        case method
        case url
        case body
    }

    public init(
        customId: String,
        body: ChatQuery,
        endpoint: Components.Schemas.CreateBatchRequest.EndpointPayload = ._sol_v1ChatCompletions
    ) {
        self.customId = customId
        self.method = "POST"
        self.url = endpoint
        self.body = body
    }
}
