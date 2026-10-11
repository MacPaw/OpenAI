//
//  BatchesEndpointTests.swift
//  OpenAI
//

import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

class BatchesEndpointTests: XCTestCase {

    private var openAI: OpenAIProtocol!
    private let urlSession = URLSessionMock()

    override func setUp() async throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(configuration: configuration, session: self.urlSession, streamingSessionFactory: MockStreamingSessionFactory())
    }

    // MARK: - Create

    func testCreate() async throws {
        let query = Components.Schemas.CreateBatchRequest(
            inputFileId: "file-abc123",
            endpoint: ._sol_v1ChatCompletions,
            completionWindow: ._24h,
            metadata: .init(additionalProperties: ["description": "test batch"])
        )
        let expectedResult = Components.Schemas.Batch.mock(status: .validating)
        try stub(result: expectedResult)

        let result = try await openAI.batches.create(query: query)
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.path, "/v1/batches")
        let body = try XCTUnwrap(request.httpBody)
        let json = try XCTUnwrap(JSONSerialization.jsonObject(with: body) as? [String: Any])
        XCTAssertEqual(json["input_file_id"] as? String, "file-abc123")
        XCTAssertEqual(json["endpoint"] as? String, "/v1/chat/completions")
        XCTAssertEqual(json["completion_window"] as? String, "24h")
        XCTAssertEqual((json["metadata"] as? [String: String])?["description"], "test batch")
    }

    func testCreateError() async throws {
        let query = Components.Schemas.CreateBatchRequest(
            inputFileId: "file-abc123",
            endpoint: ._sol_v1ChatCompletions,
            completionWindow: ._24h
        )

        let inError = APIError(message: "Invalid file ID", type: "invalid_request_error", param: "input_file_id", code: "400")
        stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.batches.create(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - Retrieve

    func testRetrieve() async throws {
        let expectedResult = Components.Schemas.Batch.mock(
            status: .completed,
            outputFileId: "file-xyz789",
            requestCounts: .init(total: 100, completed: 95, failed: 5)
        )
        try stub(result: expectedResult)

        let result = try await openAI.batches.retrieve(id: "batch_abc123")
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.path, "/v1/batches/batch_abc123")
    }

    func testRetrieveError() async throws {
        let inError = APIError(message: "Batch not found", type: "invalid_request_error", param: "batch_id", code: "404")
        stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.batches.retrieve(id: "batch_nonexistent") }
        XCTAssertEqual(inError, apiError)
    }

    func testRetrieveWithCompletionHandler() throws {
        let expectedResult = Components.Schemas.Batch.mock(status: .inProgress)
        try stub(result: expectedResult)

        let expectation = expectation(description: "retrieve completes")
        let result = UncheckedBox<Result<Components.Schemas.Batch, Error>>()
        openAI.batches.retrieve(id: "batch_abc123") {
            result.value = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(try result.value?.get(), expectedResult)
        XCTAssertEqual(urlSession.dataTaskWithCompletionCalls.last?.request.url?.path, "/v1/batches/batch_abc123")
    }

    // MARK: - List

    func testList() async throws {
        let expectedResult = Components.Schemas.ListBatchesResponse(
            data: [.mock(id: "batch_abc123", status: .completed), .mock(id: "batch_def456", status: .inProgress)],
            firstId: "batch_abc123",
            lastId: "batch_def456",
            hasMore: false,
            object: .list
        )
        try stub(result: expectedResult)

        let result = try await openAI.batches.list()
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.path, "/v1/batches")
        XCTAssertNil(request.url?.query)
    }

    func testListWithPagination() async throws {
        let expectedResult = Components.Schemas.ListBatchesResponse(
            data: [.mock(id: "batch_ghi789", status: .completed)],
            firstId: "batch_ghi789",
            lastId: "batch_ghi789",
            hasMore: true,
            object: .list
        )
        try stub(result: expectedResult)

        let result = try await openAI.batches.list(query: .init(after: "batch_def456", limit: 1))
        XCTAssertEqual(result, expectedResult)

        let url = try XCTUnwrap(lastRequest?.url)
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        XCTAssertEqual(queryItems, [.init(name: "after", value: "batch_def456"), .init(name: "limit", value: "1")])
    }

    func testListError() async throws {
        let inError = APIError(message: "Unauthorized", type: "authentication_error", param: nil, code: "401")
        stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.batches.list() }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - Cancel

    func testCancel() async throws {
        let expectedResult = Components.Schemas.Batch.mock(
            status: .cancelling,
            cancellingAt: 1711475000,
            requestCounts: .init(total: 100, completed: 50, failed: 0)
        )
        try stub(result: expectedResult)

        let result = try await openAI.batches.cancel(id: "batch_abc123")
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(lastRequest)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.path, "/v1/batches/batch_abc123/cancel")
    }

    func testCancelError() async throws {
        let inError = APIError(message: "Batch already completed", type: "invalid_request_error", param: "batch_id", code: "400")
        stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.batches.cancel(id: "batch_completed") }
        XCTAssertEqual(inError, apiError)
    }

    // MARK: - Decoding

    /// The batch object example from the API reference, including the fields the generated type adds over the
    /// original hand-written one: `model`, `errors` and `usage`.
    func testBatchDecodesAPIReferenceExample() throws {
        let json = """
        {
          "id": "batch_abc123",
          "object": "batch",
          "endpoint": "/v1/chat/completions",
          "model": "gpt-4o-mini",
          "errors": {
            "object": "list",
            "data": [{ "code": "invalid_json", "message": "Invalid JSON", "param": null, "line": 3 }]
          },
          "input_file_id": "file-abc123",
          "completion_window": "24h",
          "status": "completed",
          "output_file_id": "file-cvaTdG",
          "error_file_id": "file-HOWS94",
          "created_at": 1711471533,
          "in_progress_at": 1711471538,
          "expires_at": 1711557933,
          "finalizing_at": 1711493133,
          "completed_at": 1711493163,
          "failed_at": null,
          "expired_at": null,
          "cancelling_at": null,
          "cancelled_at": null,
          "request_counts": { "total": 100, "completed": 95, "failed": 5 },
          "usage": {
            "input_tokens": 1500,
            "input_tokens_details": { "cached_tokens": 1024 },
            "output_tokens": 500,
            "output_tokens_details": { "reasoning_tokens": 300 },
            "total_tokens": 2000
          },
          "metadata": { "customer_id": "user_123456789" }
        }
        """

        let batch = try JSONDecoder().decode(Components.Schemas.Batch.self, from: Data(json.utf8))
        XCTAssertEqual(batch.status, .completed)
        XCTAssertEqual(batch.model, "gpt-4o-mini")
        XCTAssertEqual(batch.errors?.data?.first?.line, 3)
        XCTAssertEqual(batch.usage?.inputTokensDetails.cachedTokens, 1024)
        XCTAssertEqual(batch.requestCounts?.failed, 5)
        XCTAssertNil(batch.failedAt)
        XCTAssertEqual(batch.metadata?.additionalProperties["customer_id"], "user_123456789")
    }

#if canImport(Combine)
    @MainActor
    func testCreateWithCombine() throws {
        let urlSession = URLSessionMockCombine()
        let openAI = OpenAI(
            configuration: .init(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14),
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory()
        )
        let expectedResult = Components.Schemas.Batch.mock(status: .validating)
        urlSession.dataTask = try DataTaskMock.successfulJson(with: expectedResult)

        let query = Components.Schemas.CreateBatchRequest(
            inputFileId: "file-abc123",
            endpoint: ._sol_v1ChatCompletions,
            completionWindow: ._24h
        )
        let result = try awaitPublisher(openAI.batches.create(query: query))
        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(urlSession.dataTaskPublisherCalls.last?.request.url?.path, "/v1/batches")
    }
#endif
}

// MARK: - Test Helpers

extension BatchesEndpointTests {

    var lastRequest: URLRequest? {
        urlSession.dataAsyncCalls.last?.request
    }

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

final class UncheckedBox<Value>: @unchecked Sendable {
    var value: Value?
}

extension Components.Schemas.Batch {
    static func mock(
        id: String = "batch_abc123",
        status: StatusPayload,
        outputFileId: String? = nil,
        cancellingAt: Int? = nil,
        requestCounts: Components.Schemas.BatchRequestCounts? = nil
    ) -> Self {
        .init(
            id: id,
            object: .batch,
            endpoint: "/v1/chat/completions",
            inputFileId: "file-abc123",
            completionWindow: "24h",
            status: status,
            outputFileId: outputFileId,
            createdAt: 1711471533,
            expiresAt: 1711557933,
            cancellingAt: cancellingAt,
            requestCounts: requestCounts
        )
    }
}
