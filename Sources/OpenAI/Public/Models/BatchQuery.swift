//
//  BatchQuery.swift
//
//
//  Created by Jason Flax on 12/24/2024.
//

import Foundation

/// The endpoint to be used for batch requests.
public enum BatchEndpoint: String, Codable, Sendable {
    /// Chat completions endpoint.
    case chatCompletions = "/v1/chat/completions"
    /// Embeddings endpoint.
    case embeddings = "/v1/embeddings"
    /// Legacy completions endpoint.
    case completions = "/v1/completions"
}

/// The time frame within which the batch should be processed.
public enum BatchCompletionWindow: String, Codable, Sendable {
    /// 24 hour completion window (50% cost discount).
    case twentyFourHours = "24h"
}

/// Query for creating a batch job.
/// https://platform.openai.com/docs/api-reference/batch/create
public struct BatchQuery: Codable, Sendable {

    /// The ID of an uploaded file that contains requests for the new batch.
    /// Your input file must be formatted as a JSONL file, and must be uploaded with the purpose `batch`.
    public let inputFileId: String

    /// The endpoint to be used for all requests in the batch.
    public let endpoint: BatchEndpoint

    /// The time frame within which the batch should be processed.
    public let completionWindow: BatchCompletionWindow

    /// Optional custom metadata for the batch.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case inputFileId = "input_file_id"
        case endpoint
        case completionWindow = "completion_window"
        case metadata
    }

    public init(
        inputFileId: String,
        endpoint: BatchEndpoint = .chatCompletions,
        completionWindow: BatchCompletionWindow = .twentyFourHours,
        metadata: [String: String]? = nil
    ) {
        self.inputFileId = inputFileId
        self.endpoint = endpoint
        self.completionWindow = completionWindow
        self.metadata = metadata
    }
}

/// A single request line for batch JSONL input file.
public struct BatchRequestLine: Codable, Sendable {

    /// A developer-provided per-request id that will be used to match outputs to inputs.
    public let customId: String

    /// The HTTP method to be used for the request. Always POST.
    let method: String

    /// The OpenAI API relative URL to be used for the request.
    let url: BatchEndpoint

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
        endpoint: BatchEndpoint = .chatCompletions
    ) {
        self.customId = customId
        self.method = "POST"
        self.url = endpoint
        self.body = body
    }
}
