//
//  BatchError.swift
//  OpenAI
//
//  Errors for batch API convenience methods.
//

import Foundation

/// Errors that can occur during batch processing.
public enum BatchError: LocalizedError, Sendable {
    /// Batch polling timed out before completion.
    case timeout(batchId: String, lastStatus: BatchStatus)
    /// Batch ended in a non-completed state.
    case batchFailed(batchId: String, status: BatchStatus)
    /// Batch completed but no output file was returned.
    case noOutputFile(batchId: String)
    /// Output file data could not be decoded.
    case invalidOutputData(batchId: String)

    public var errorDescription: String? {
        switch self {
        case .timeout(let batchId, let lastStatus):
            return "Batch \(batchId) timed out with status: \(lastStatus)"
        case .batchFailed(let batchId, let status):
            return "Batch \(batchId) failed with status: \(status)"
        case .noOutputFile(let batchId):
            return "Batch \(batchId) completed but no output file was returned"
        case .invalidOutputData(let batchId):
            return "Batch \(batchId) output file could not be decoded"
        }
    }
}
