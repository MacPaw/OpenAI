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
