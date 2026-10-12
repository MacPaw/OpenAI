//
//  FilesEndpointTests.swift
//  OpenAI
//

import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

class FilesEndpointTests: XCTestCase {

    private var openAI: OpenAIProtocol!
    private let urlSession = URLSessionMock()

    override func setUp() async throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(configuration: configuration, session: self.urlSession, streamingSessionFactory: MockStreamingSessionFactory())
    }

    // MARK: - Create

    func testCreate() async throws {
        let expectedResult = OpenAIFile.mock()
        urlSession.dataTask = try DataTaskMock.successfulJson(with: expectedResult)

        let query = CreateFileQuery(
            purpose: "batch",
            file: Data("{\"custom_id\":\"request-1\"}".utf8),
            fileName: "requests.jsonl",
            contentType: "application/jsonl"
        )
        let result = try await openAI.files.create(query: query)
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(urlSession.dataAsyncCalls.last?.request)
        XCTAssertEqual(request.httpMethod, "POST")
        XCTAssertEqual(request.url?.path, "/v1/files")
        XCTAssertTrue(request.value(forHTTPHeaderField: "Content-Type")?.hasPrefix("multipart/form-data; boundary=") == true)
        XCTAssertNil(request.value(forHTTPHeaderField: "OpenAI-Beta"))
        let body = String(decoding: try XCTUnwrap(request.httpBody), as: UTF8.self)
        XCTAssertTrue(body.contains("name=\"purpose\"\r\n\r\nbatch\r\n"))
        XCTAssertTrue(body.contains("name=\"file\"; filename=\"requests.jsonl\"\r\nContent-Type: application/jsonl\r\n\r\n{\"custom_id\":\"request-1\"}\r\n"))
        XCTAssertFalse(body.contains("expires_after"))
    }

    func testCreateWithExpiration() async throws {
        urlSession.dataTask = try DataTaskMock.successfulJson(with: OpenAIFile.mock())

        let query = CreateFileQuery(
            purpose: "batch",
            file: Data("{}".utf8),
            fileName: "requests.jsonl",
            contentType: "application/jsonl",
            expiresAfter: .init(anchor: .createdAt, seconds: 3600)
        )
        _ = try await openAI.files.create(query: query)

        let body = String(decoding: try XCTUnwrap(urlSession.dataAsyncCalls.last?.request.httpBody), as: UTF8.self)
        XCTAssertTrue(body.contains("name=\"expires_after[anchor]\"\r\n\r\ncreated_at\r\n"))
        XCTAssertTrue(body.contains("name=\"expires_after[seconds]\"\r\n\r\n3600\r\n"))
    }

    // MARK: - Retrieve

    func testRetrieve() async throws {
        let expectedResult = OpenAIFile.mock()
        urlSession.dataTask = try DataTaskMock.successfulJson(with: expectedResult)

        let result = try await openAI.files.retrieve(id: "file-abc123")
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(urlSession.dataAsyncCalls.last?.request)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.path, "/v1/files/file-abc123")
    }

    // MARK: - List

    func testList() async throws {
        let expectedResult = ListFilesResponse(
            object: "list",
            data: [.mock(id: "file-abc123"), .mock(id: "file-def456")],
            firstId: "file-abc123",
            lastId: "file-def456",
            hasMore: false
        )
        urlSession.dataTask = try DataTaskMock.successfulJson(with: expectedResult)

        let result = try await openAI.files.list()
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(urlSession.dataAsyncCalls.last?.request)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.path, "/v1/files")
        XCTAssertNil(request.url?.query)
    }

    func testListWithQuery() async throws {
        urlSession.dataTask = try DataTaskMock.successfulJson(with: ListFilesResponse(
            object: "list",
            data: [.mock(id: "file-ghi789")],
            firstId: "file-ghi789",
            lastId: "file-ghi789",
            hasMore: true
        ))

        _ = try await openAI.files.list(query: .init(purpose: "batch", limit: 1, order: .ascending, after: "file-def456"))

        let url = try XCTUnwrap(urlSession.dataAsyncCalls.last?.request.url)
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        XCTAssertEqual(queryItems, [
            .init(name: "purpose", value: "batch"),
            .init(name: "limit", value: "1"),
            .init(name: "order", value: "asc"),
            .init(name: "after", value: "file-def456"),
        ])
    }

    // MARK: - Decoding

    /// `evals` is a valid upload purpose but missing from the spec's file object enum; see `OpenAIFile`.
    func testFileDecodesPurposeMissingFromSpec() throws {
        let json = """
        {
          "id": "file-abc123",
          "object": "file",
          "bytes": 120000,
          "created_at": 1677610602,
          "expires_at": null,
          "filename": "eval_data.jsonl",
          "purpose": "evals",
          "status": "processed"
        }
        """

        let file = try JSONDecoder().decode(OpenAIFile.self, from: Data(json.utf8))
        XCTAssertEqual(file.purpose, .evals)
        XCTAssertEqual(file.filename, "eval_data.jsonl")
        XCTAssertNil(file.expiresAt)
    }

    // MARK: - Content

    func testContent() async throws {
        let jsonl = Data("{\"custom_id\":\"request-1\"}\n{\"custom_id\":\"request-2\"}\n".utf8)
        urlSession.dataTask = DataTaskMock.successful(with: jsonl)

        let result = try await openAI.files.content(id: "file-abc123")
        XCTAssertEqual(result, jsonl)

        let request = try XCTUnwrap(urlSession.dataAsyncCalls.last?.request)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.url?.path, "/v1/files/file-abc123/content")
    }

    func testContentError() async throws {
        let inError = APIError(message: "No such File object: file-abc123", type: "invalid_request_error", param: "id", code: "404")
        urlSession.dataTask = DataTaskMock.failed(with: inError)

        do {
            _ = try await openAI.files.content(id: "file-abc123")
            XCTFail("Expected an error")
        } catch let error as APIError {
            XCTAssertEqual(error, inError)
        }
    }

    func testContentWithCompletionHandler() throws {
        let data = Data("content".utf8)
        urlSession.dataTask = DataTaskMock.successful(with: data)

        let expectation = expectation(description: "content completes")
        let result = UncheckedBox<Result<Data, Error>>()
        openAI.files.content(id: "file-abc123") {
            result.value = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(try result.value?.get(), data)
        XCTAssertEqual(urlSession.dataTaskWithCompletionCalls.last?.request.url?.path, "/v1/files/file-abc123/content")
    }

    // MARK: - Delete

    func testDelete() async throws {
        let expectedResult = Components.Schemas.DeleteFileResponse(id: "file-abc123", object: .file, deleted: true)
        urlSession.dataTask = try DataTaskMock.successfulJson(with: expectedResult)

        let result = try await openAI.files.delete(id: "file-abc123")
        XCTAssertEqual(result, expectedResult)

        let request = try XCTUnwrap(urlSession.dataAsyncCalls.last?.request)
        XCTAssertEqual(request.httpMethod, "DELETE")
        XCTAssertEqual(request.url?.path, "/v1/files/file-abc123")
    }

#if canImport(Combine)
    @MainActor
    func testContentWithCombine() throws {
        let urlSession = URLSessionMockCombine()
        let openAI = OpenAI(
            configuration: .init(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14),
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory()
        )
        let data = Data("content".utf8)
        urlSession.dataTask = DataTaskMock.successful(with: data)

        let result = try awaitPublisher(openAI.files.content(id: "file-abc123"))
        XCTAssertEqual(result, data)
        XCTAssertEqual(urlSession.dataTaskPublisherCalls.last?.request.url?.path, "/v1/files/file-abc123/content")
    }
#endif
}

private final class UncheckedBox<Value>: @unchecked Sendable {
    var value: Value?
}

extension OpenAIFile {
    static func mock(id: String = "file-abc123") -> Self {
        .init(
            id: id,
            bytes: 120000,
            createdAt: 1677610602,
            filename: "requests.jsonl",
            object: .file,
            purpose: .batch,
            status: .processed
        )
    }
}
