//
//  BatchAPITests.swift
//  OpenAI
//
//  Created for Batch API implementation.
//

import XCTest
@testable import OpenAI

class BatchAPITests: XCTestCase {

    private var openAI: OpenAIProtocol!
    private let urlSession = URLSessionMock()

    override func setUp() async throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(configuration: configuration, session: self.urlSession, streamingSessionFactory: MockStreamingSessionFactory())
    }

    // MARK: - Create Batch Tests

    func testCreateBatch() async throws {
        let query = BatchQuery(
            inputFileId: "file-abc123",
            endpoint: .chatCompletions,
            completionWindow: .twentyFourHours,
            metadata: ["description": "test batch"]
        )

        let expectedResult = BatchResult(
            id: "batch_abc123",
            object: "batch",
            endpoint: "/v1/chat/completions",
            inputFileId: "file-abc123",
            completionWindow: "24h",
            status: .validating,
            outputFileId: nil,
            errorFileId: nil,
            createdAt: 1711471533,
            inProgressAt: nil,
            expiresAt: 1711557933,
            finalizingAt: nil,
            completedAt: nil,
            failedAt: nil,
            expiredAt: nil,
            cancellingAt: nil,
            cancelledAt: nil,
            requestCounts: nil,
            metadata: ["description": "test batch"]
        )

        try self.stub(result: expectedResult)

        let result = try await openAI.createBatch(query: query)
        XCTAssertEqual(result.id, expectedResult.id)
        XCTAssertEqual(result.status, BatchStatus.validating)
        XCTAssertEqual(result.inputFileId, "file-abc123")
    }

    func testCreateBatchError() async throws {
        let query = BatchQuery(
            inputFileId: "file-abc123",
            endpoint: .chatCompletions,
            completionWindow: .twentyFourHours
        )

        let inError = APIError(message: "Invalid file ID", type: "invalid_request_error", param: "input_file_id", code: "400")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.createBatch(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - Retrieve Batch Tests

    func testRetrieveBatch() async throws {
        let expectedResult = BatchResult(
            id: "batch_abc123",
            object: "batch",
            endpoint: "/v1/chat/completions",
            inputFileId: "file-abc123",
            completionWindow: "24h",
            status: .completed,
            outputFileId: "file-xyz789",
            errorFileId: nil,
            createdAt: 1711471533,
            inProgressAt: 1711471534,
            expiresAt: 1711557933,
            finalizingAt: 1711493133,
            completedAt: 1711493134,
            failedAt: nil,
            expiredAt: nil,
            cancellingAt: nil,
            cancelledAt: nil,
            requestCounts: RequestCounts(total: 100, completed: 95, failed: 5),
            metadata: nil
        )

        try self.stub(result: expectedResult)

        let result = try await openAI.retrieveBatch(id: "batch_abc123")
        XCTAssertEqual(result.id, "batch_abc123")
        XCTAssertEqual(result.status, .completed)
        XCTAssertEqual(result.outputFileId, "file-xyz789")
        XCTAssertEqual(result.requestCounts?.total, 100)
        XCTAssertEqual(result.requestCounts?.completed, 95)
        XCTAssertEqual(result.requestCounts?.failed, 5)
    }

    func testRetrieveBatchError() async throws {
        let inError = APIError(message: "Batch not found", type: "invalid_request_error", param: "batch_id", code: "404")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.retrieveBatch(id: "batch_nonexistent") }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - List Batches Tests

    func testListBatches() async throws {
        let batch1 = BatchResult(
            id: "batch_abc123",
            object: "batch",
            endpoint: "/v1/chat/completions",
            inputFileId: "file-abc123",
            completionWindow: "24h",
            status: .completed,
            outputFileId: "file-xyz789",
            errorFileId: nil,
            createdAt: 1711471533,
            inProgressAt: nil,
            expiresAt: 1711557933,
            finalizingAt: nil,
            completedAt: 1711493134,
            failedAt: nil,
            expiredAt: nil,
            cancellingAt: nil,
            cancelledAt: nil,
            requestCounts: nil,
            metadata: nil
        )

        let batch2 = BatchResult(
            id: "batch_def456",
            object: "batch",
            endpoint: "/v1/chat/completions",
            inputFileId: "file-def456",
            completionWindow: "24h",
            status: .inProgress,
            outputFileId: nil,
            errorFileId: nil,
            createdAt: 1711471600,
            inProgressAt: 1711471601,
            expiresAt: 1711558000,
            finalizingAt: nil,
            completedAt: nil,
            failedAt: nil,
            expiredAt: nil,
            cancellingAt: nil,
            cancelledAt: nil,
            requestCounts: nil,
            metadata: nil
        )

        let expectedResult = BatchListResult(
            object: "list",
            data: [batch1, batch2],
            firstId: "batch_abc123",
            lastId: "batch_def456",
            hasMore: false
        )

        try self.stub(result: expectedResult)

        let result = try await openAI.listBatches(after: nil, limit: 20)
        XCTAssertEqual(result.data.count, 2)
        XCTAssertEqual(result.data[0].id, "batch_abc123")
        XCTAssertEqual(result.data[1].id, "batch_def456")
        XCTAssertFalse(result.hasMore)
    }

    func testListBatchesWithPagination() async throws {
        let batch = BatchResult(
            id: "batch_ghi789",
            object: "batch",
            endpoint: "/v1/chat/completions",
            inputFileId: "file-ghi789",
            completionWindow: "24h",
            status: .completed,
            outputFileId: nil,
            errorFileId: nil,
            createdAt: 1711471700,
            inProgressAt: nil,
            expiresAt: 1711558100,
            finalizingAt: nil,
            completedAt: nil,
            failedAt: nil,
            expiredAt: nil,
            cancellingAt: nil,
            cancelledAt: nil,
            requestCounts: nil,
            metadata: nil
        )

        let expectedResult = BatchListResult(
            object: "list",
            data: [batch],
            firstId: "batch_ghi789",
            lastId: "batch_ghi789",
            hasMore: true
        )

        try self.stub(result: expectedResult)

        let result = try await openAI.listBatches(after: "batch_def456", limit: 1)
        XCTAssertEqual(result.data.count, 1)
        XCTAssertTrue(result.hasMore)
    }

    func testListBatchesError() async throws {
        let inError = APIError(message: "Unauthorized", type: "authentication_error", param: nil, code: "401")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.listBatches(after: nil, limit: 20) }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - Cancel Batch Tests

    func testCancelBatch() async throws {
        let expectedResult = BatchResult(
            id: "batch_abc123",
            object: "batch",
            endpoint: "/v1/chat/completions",
            inputFileId: "file-abc123",
            completionWindow: "24h",
            status: .cancelling,
            outputFileId: nil,
            errorFileId: nil,
            createdAt: 1711471533,
            inProgressAt: 1711471534,
            expiresAt: 1711557933,
            finalizingAt: nil,
            completedAt: nil,
            failedAt: nil,
            expiredAt: nil,
            cancellingAt: 1711475000,
            cancelledAt: nil,
            requestCounts: RequestCounts(total: 100, completed: 50, failed: 0),
            metadata: nil
        )

        try self.stub(result: expectedResult)

        let result = try await openAI.cancelBatch(id: "batch_abc123")
        XCTAssertEqual(result.id, "batch_abc123")
        XCTAssertEqual(result.status, .cancelling)
        XCTAssertNotNil(result.cancellingAt)
    }

    func testCancelBatchError() async throws {
        let inError = APIError(message: "Batch already completed", type: "invalid_request_error", param: "batch_id", code: "400")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.cancelBatch(id: "batch_completed") }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - Batch Status Tests

    func testBatchStatusValues() {
        XCTAssertEqual(BatchStatus.validating.rawValue, "validating")
        XCTAssertEqual(BatchStatus.failed.rawValue, "failed")
        XCTAssertEqual(BatchStatus.inProgress.rawValue, "in_progress")
        XCTAssertEqual(BatchStatus.finalizing.rawValue, "finalizing")
        XCTAssertEqual(BatchStatus.completed.rawValue, "completed")
        XCTAssertEqual(BatchStatus.expired.rawValue, "expired")
        XCTAssertEqual(BatchStatus.cancelling.rawValue, "cancelling")
        XCTAssertEqual(BatchStatus.cancelled.rawValue, "cancelled")
    }

    // MARK: - BatchQuery Encoding Tests

    func testBatchQueryEncoding() throws {
        let query = BatchQuery(
            inputFileId: "file-abc123",
            endpoint: .chatCompletions,
            completionWindow: .twentyFourHours,
            metadata: ["key": "value"]
        )

        let encoder = JSONEncoder()
        let data = try encoder.encode(query)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]

        XCTAssertEqual(json["input_file_id"] as? String, "file-abc123")
        XCTAssertEqual(json["endpoint"] as? String, "/v1/chat/completions")
        XCTAssertEqual(json["completion_window"] as? String, "24h")
        XCTAssertEqual((json["metadata"] as? [String: String])?["key"], "value")
    }

    // MARK: - BatchResponseLine Tests

    func testBatchResponseLineDecoding() throws {
        let jsonString = """
        {
            "id": "response_abc123",
            "custom_id": "request-1",
            "response": {
                "status_code": 200,
                "request_id": "req_abc123",
                "body": {
                    "id": "chatcmpl-abc123",
                    "object": "chat.completion",
                    "created": 1711471533,
                    "model": "gpt-4o-mini",
                    "choices": [
                        {
                            "index": 0,
                            "message": {
                                "role": "assistant",
                                "content": "Hello! How can I help you?"
                            },
                            "finish_reason": "stop"
                        }
                    ],
                    "usage": {
                        "prompt_tokens": 10,
                        "completion_tokens": 8,
                        "total_tokens": 18
                    }
                }
            },
            "error": null
        }
        """

        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)!
        let responseLine = try decoder.decode(BatchResponseLine.self, from: data)

        XCTAssertEqual(responseLine.id, "response_abc123")
        XCTAssertEqual(responseLine.customId, "request-1")
        XCTAssertNotNil(responseLine.response)
        XCTAssertEqual(responseLine.response?.statusCode, 200)
        XCTAssertEqual(responseLine.response?.requestId, "req_abc123")
        XCTAssertNil(responseLine.error)
    }

    func testBatchResponseLineWithError() throws {
        let jsonString = """
        {
            "id": "response_def456",
            "custom_id": "request-2",
            "response": null,
            "error": {
                "code": "rate_limit_exceeded",
                "message": "Rate limit exceeded"
            }
        }
        """

        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)!
        let responseLine = try decoder.decode(BatchResponseLine.self, from: data)

        XCTAssertEqual(responseLine.id, "response_def456")
        XCTAssertEqual(responseLine.customId, "request-2")
        XCTAssertNil(responseLine.response)
        XCTAssertNotNil(responseLine.error)
        XCTAssertEqual(responseLine.error?.code, "rate_limit_exceeded")
        XCTAssertEqual(responseLine.error?.message, "Rate limit exceeded")
    }

    // MARK: - URL Building Tests

    func testBatchURLBuilding() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession, streamingSessionFactory: MockStreamingSessionFactory())

        let batchesURL = openAI.buildURL(path: .batches)
        XCTAssertEqual(batchesURL, URL(string: "https://api.openai.com:443/v1/batches"))

        let batchURL = openAI.buildURL(path: .batch("batch_abc123"))
        XCTAssertEqual(batchURL, URL(string: "https://api.openai.com:443/v1/batches/batch_abc123"))

        let cancelURL = openAI.buildURL(path: .batchCancel("batch_abc123"))
        XCTAssertEqual(cancelURL, URL(string: "https://api.openai.com:443/v1/batches/batch_abc123/cancel"))
    }
}

// MARK: - Test Helpers

extension BatchAPITests {

    func stub(error: APIError) {
        let task = DataTaskMock.failed(with: error)
        self.urlSession.dataTask = task
    }

    func stub(result: Codable) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(result)
        let task = DataTaskMock.successful(with: data)
        self.urlSession.dataTask = task
    }

    enum TypeError: Error {
        case unexpectedResult(String)
        case typeMismatch(String)
    }

    func XCTExpectError<ErrorType: Error>(execute: () async throws -> Sendable) async throws -> ErrorType {
        do {
            let result = try await execute()
            throw TypeError.unexpectedResult("Error expected, but result is returned \(result)")
        } catch {
            guard let apiError = error as? ErrorType else {
                throw TypeError.typeMismatch("Expected APIError, got instead: \(error)")
            }
            return apiError
        }
    }
}
