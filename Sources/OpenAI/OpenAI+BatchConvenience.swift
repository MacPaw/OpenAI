//
//  OpenAI+BatchConvenience.swift
//  OpenAI
//

import Foundation

// Temporary home for the Batch API convenience methods while the endpoint
// namespaces are introduced; they are redesigned as a separate step.
extension OpenAI {
    /// Submits a batch of chat requests for async processing.
    /// Handles JSONL encoding, file upload, and batch creation.
    ///
    /// - Parameters:
    ///   - requests: Array of batch request lines to process
    ///   - fileName: Name for the uploaded JSONL file
    ///   - endpoint: The API endpoint for batch requests (default: chat completions)
    ///   - metadata: Optional metadata to attach to the batch
    /// - Returns: The created batch result with ID for tracking
    public func submitBatch(
        requests: [BatchRequestLine],
        fileName: String,
        endpoint: Components.Schemas.CreateBatchRequest.EndpointPayload = ._sol_v1ChatCompletions,
        metadata: [String: String]? = nil
    ) async throws -> Components.Schemas.Batch {
        // Step 1: Encode requests to JSONL
        let encoder = JSONEncoder()
        let jsonlData = try requests.map { request -> String in
            let data = try encoder.encode(request)
            return String(data: data, encoding: .utf8)!
        }.joined(separator: "\n")

        // Step 2: Upload file
        let fileData = jsonlData.data(using: .utf8)!
        let fileQuery = FilesQuery(
            purpose: "batch",
            file: fileData,
            fileName: fileName,
            contentType: "application/jsonl"
        )
        let fileResult = try await files(query: fileQuery)

        // Step 3: Create batch
        let batchQuery = Components.Schemas.CreateBatchRequest(
            inputFileId: fileResult.id,
            endpoint: endpoint,
            completionWindow: ._24h,
            metadata: metadata.map { .init(additionalProperties: $0) }
        )
        return try await batches.create(query: batchQuery)
    }

    /// Waits for a batch to complete and returns the parsed responses.
    /// Polls the batch status until completion, then downloads and parses results.
    ///
    /// - Parameters:
    ///   - batchId: The batch ID to wait for
    ///   - pollingInterval: Time between status checks (default 5 seconds)
    ///   - timeout: Maximum time to wait (default 24 hours)
    /// - Returns: Array of parsed batch response lines
    /// - Throws: Error if batch fails, expires, or is cancelled
    public func waitForBatch(
        id batchId: String,
        pollingInterval: TimeInterval = 5.0,
        timeout: TimeInterval = 86400
    ) async throws -> [BatchResponseLine] {
        let startTime = Date()

        // Step 4: Poll for completion
        var batch = try await batches.retrieve(id: batchId)
        while batch.status != .completed &&
              batch.status != .failed &&
              batch.status != .expired &&
              batch.status != .cancelled &&
              batch.status != .cancelling {

            if Date().timeIntervalSince(startTime) > timeout {
                throw BatchError.timeout(batchId: batchId, lastStatus: batch.status)
            }

            try await Task.sleep(nanoseconds: UInt64(pollingInterval * 1_000_000_000))
            batch = try await batches.retrieve(id: batchId)
        }

        // Check for failure states
        guard batch.status == .completed else {
            throw BatchError.batchFailed(batchId: batchId, status: batch.status)
        }

        // Step 5: Download output file
        guard let outputFileId = batch.outputFileId else {
            throw BatchError.noOutputFile(batchId: batchId)
        }

        let outputData = try await files.content(id: outputFileId)
        guard let outputString = String(data: outputData, encoding: .utf8) else {
            throw BatchError.invalidOutputData(batchId: batchId)
        }

        // Step 6: Parse JSONL responses
        let decoder = JSONDecoder()
        let lines = outputString.split(separator: "\n")
        return try lines.map { line in
            let lineData = line.data(using: .utf8)!
            return try decoder.decode(BatchResponseLine.self, from: lineData)
        }
    }
}
