//
//  BatchResult.swift
//
//
//  Created by Jason Flax on 12/24/2024.
//

import Foundation

/// Result of a batch operation.
/// https://platform.openai.com/docs/api-reference/batch/object
public struct BatchResult: Codable, Equatable, Sendable {

    /// The batch ID.
    public let id: String

    /// The object type, which is always `batch`.
    public let object: String

    /// The OpenAI API endpoint used by the batch.
    public let endpoint: String

    /// The ID of the input file for the batch.
    public let inputFileId: String

    /// The time frame within which the batch should be processed.
    public let completionWindow: String

    /// The current status of the batch.
    public let status: BatchStatus

    /// The ID of the file containing the outputs of successfully executed requests.
    public let outputFileId: String?

    /// The ID of the file containing the outputs of requests with errors.
    public let errorFileId: String?

    /// The Unix timestamp (in seconds) for when the batch was created.
    public let createdAt: Int

    /// The Unix timestamp (in seconds) for when the batch started processing.
    public let inProgressAt: Int?

    /// The Unix timestamp (in seconds) for when the batch will expire.
    public let expiresAt: Int?

    /// The Unix timestamp (in seconds) for when the batch started finalizing.
    public let finalizingAt: Int?

    /// The Unix timestamp (in seconds) for when the batch was completed.
    public let completedAt: Int?

    /// The Unix timestamp (in seconds) for when the batch failed.
    public let failedAt: Int?

    /// The Unix timestamp (in seconds) for when the batch expired.
    public let expiredAt: Int?

    /// The Unix timestamp (in seconds) for when the batch started cancelling.
    public let cancellingAt: Int?

    /// The Unix timestamp (in seconds) for when the batch was cancelled.
    public let cancelledAt: Int?

    /// The request counts for different statuses within the batch.
    public let requestCounts: RequestCounts?

    /// Optional custom metadata for the batch.
    public let metadata: [String: String]?

    enum CodingKeys: String, CodingKey {
        case id
        case object
        case endpoint
        case inputFileId = "input_file_id"
        case completionWindow = "completion_window"
        case status
        case outputFileId = "output_file_id"
        case errorFileId = "error_file_id"
        case createdAt = "created_at"
        case inProgressAt = "in_progress_at"
        case expiresAt = "expires_at"
        case finalizingAt = "finalizing_at"
        case completedAt = "completed_at"
        case failedAt = "failed_at"
        case expiredAt = "expired_at"
        case cancellingAt = "cancelling_at"
        case cancelledAt = "cancelled_at"
        case requestCounts = "request_counts"
        case metadata
    }
}

extension BatchResult: Identifiable {}

/// The status of a batch.
public enum BatchStatus: String, Codable, Equatable, Sendable {
    /// The input file is being validated before the batch can begin.
    case validating
    /// The input file has failed the validation process.
    case failed
    /// The batch is currently being run.
    case inProgress = "in_progress"
    /// The batch has completed and the results are being prepared.
    case finalizing
    /// The batch has been completed and the results are ready.
    case completed
    /// The batch was not able to be completed within the 24-hour time window.
    case expired
    /// The batch is being cancelled (may take up to 10 minutes).
    case cancelling
    /// The batch was cancelled.
    case cancelled
}

/// Request counts for different statuses within a batch.
public struct RequestCounts: Codable, Equatable, Sendable {
    /// Total number of requests in the batch.
    public let total: Int
    /// Number of requests that have been completed successfully.
    public let completed: Int
    /// Number of requests that have failed.
    public let failed: Int
}
