//
//  JSONResponseStatusTests.swift
//  OpenAI
//

import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

final class JSONResponseStatusTests: XCTestCase {

    private var openAI: OpenAIProtocol!
    private let urlSession = URLSessionMock()

    override func setUp() async throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(configuration: configuration, session: self.urlSession, streamingSessionFactory: MockStreamingSessionFactory())
    }

    func testAsyncChatsThrowsAPIErrorForErrorStatus() async throws {
        urlSession.dataTask = .errorResponse(statusCode: 400, data: Self.apiErrorBody)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as APIErrorResponse {
            XCTAssertEqual(error.error.message, "Invalid request")
            XCTAssertEqual(error.error.type, "invalid_request_error")
        }
    }

    func testCompletionChatsThrowsAPIErrorForErrorStatus() throws {
        urlSession.dataTask = .errorResponse(statusCode: 400, data: Self.apiErrorBody)

        let expectation = expectation(description: "chats completes")
        let result = UncheckedBox<Result<ChatResult, Error>>()
        openAI.chats(query: chatQuery()) {
            result.value = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertThrowsError(try result.value?.get()) { error in
            guard let apiError = error as? APIErrorResponse else {
                return XCTFail("Expected APIErrorResponse, got \(error)")
            }
            XCTAssertEqual(apiError.error.message, "Invalid request")
            XCTAssertEqual(apiError.error.type, "invalid_request_error")
        }
    }

    func testAsyncChatsThrowsStatusErrorForHTMLBody() async throws {
        urlSession.dataTask = .errorResponse(statusCode: 502, data: Data("<html>Bad Gateway</html>".utf8))

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch OpenAIError.statusError(_, let statusCode) {
            XCTAssertEqual(statusCode, 502)
        }
    }

    func testCompletionChatsThrowsStatusErrorForHTMLBody() throws {
        urlSession.dataTask = .errorResponse(statusCode: 502, data: Data("<html>Bad Gateway</html>".utf8))

        let expectation = expectation(description: "chats completes")
        let result = UncheckedBox<Result<ChatResult, Error>>()
        openAI.chats(query: chatQuery()) {
            result.value = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertThrowsError(try result.value?.get()) { error in
            guard case let .statusError(_, statusCode)? = error as? OpenAIError else {
                return XCTFail("Expected OpenAIError.statusError, got \(error)")
            }
            XCTAssertEqual(statusCode, 502)
        }
    }

    /// `.relaxed` fills the missing `id`, `object`, and `model` strings, so this body decodes as `ChatResult`.
    /// A status of 400 must still be an error. `created` and `choices` are not filled by `.relaxed`.
    func testRelaxedAsyncChatsThrowsStatusErrorForPartialBody() async throws {
        let openAI = makeOpenAI(parsingOptions: .relaxed)
        urlSession.dataTask = .errorResponse(statusCode: 400, data: Data(#"{"created":1,"choices":[]}"#.utf8))

        do {
            let result = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error, got \(result)")
        } catch OpenAIError.statusError(_, let statusCode) {
            XCTAssertEqual(statusCode, 400)
        }
    }

    /// A status below 400 still decodes. `ModelResult` fills missing `created`, `object`, and `owned_by` only under `.relaxed`.
    func testRelaxedAsyncModelDecodesPartialBodyOnSuccessStatus() async throws {
        let openAI = makeOpenAI(parsingOptions: .relaxed)
        urlSession.dataTask = .errorResponse(statusCode: 200, data: Data(#"{"id":"gemini-2.0-flash"}"#.utf8))

        let result = try await openAI.model(query: ModelQuery(model: .gpt3_5Turbo))
        XCTAssertEqual(result, ModelResult(id: "gemini-2.0-flash", created: 0, object: "model", ownedBy: ""))
    }

    /// The status guard applies only at 400 and above. A 200 error document still throws through `JSONResponseDecoder`.
    func testAsyncChatsThrowsAPIErrorForErrorDocumentOnSuccessStatus() async throws {
        urlSession.dataTask = .errorResponse(statusCode: 200, data: Self.apiErrorBody)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as APIErrorResponse {
            XCTAssertEqual(error.error.message, "Invalid request")
            XCTAssertEqual(error.error.type, "invalid_request_error")
        }
    }

    /// `DataTaskMock.failed` sets a transport error and status 503 with nil data. The transport error is thrown.
    func testCompletionChatsThrowsTransportError() throws {
        let transportError = URLError(.cannotConnectToHost)
        urlSession.dataTask = .failed(with: transportError)

        let expectation = expectation(description: "chats completes")
        let result = UncheckedBox<Result<ChatResult, Error>>()
        openAI.chats(query: chatQuery()) {
            result.value = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertThrowsError(try result.value?.get()) { error in
            XCTAssertEqual(error as? URLError, transportError)
        }
    }

    func testAsyncChatsThrowsGeminiAPIErrorForErrorStatus() async throws {
        let body = Data(#"[{"error":{"code":400,"message":"Request contains an invalid argument.","status":"INVALID_ARGUMENT"}}]"#.utf8)
        urlSession.dataTask = .errorResponse(statusCode: 400, data: body)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as GeminiAPIErrorResponse {
            XCTAssertEqual(error.error.code, 400)
            XCTAssertEqual(error.error.message, "Request contains an invalid argument.")
            XCTAssertEqual(error.error.status, "INVALID_ARGUMENT")
        }
    }

    /// A single Gemini error object is not the array `JSONResponseErrorDecoder` accepts, and it is not an
    /// `APIErrorResponse` (`type` is required), so a 400 falls through to `OpenAIError.statusError`.
    func testAsyncChatsThrowsStatusErrorForSingleGeminiErrorObject() async throws {
        let body = Data(#"{"error":{"code":400,"message":"Request contains an invalid argument.","status":"INVALID_ARGUMENT"}}"#.utf8)
        urlSession.dataTask = .errorResponse(statusCode: 400, data: body)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch OpenAIError.statusError(_, let statusCode) {
            XCTAssertEqual(statusCode, 400)
        }
    }

#if canImport(Combine)
    @MainActor
    func testCombineChatsThrowsAPIErrorForErrorStatus() throws {
        let urlSession = URLSessionMockCombine()
        let openAI = OpenAI(
            configuration: .init(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14),
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory()
        )
        urlSession.dataTask = .errorResponse(statusCode: 400, data: Self.apiErrorBody)

        XCTAssertThrowsError(try awaitPublisher(openAI.chats(query: chatQuery()))) { error in
            guard let apiError = error as? APIErrorResponse else {
                return XCTFail("Expected APIErrorResponse, got \(error)")
            }
            XCTAssertEqual(apiError.error.message, "Invalid request")
            XCTAssertEqual(apiError.error.type, "invalid_request_error")
        }
    }

    @MainActor
    func testCombineChatsThrowsStatusErrorForHTMLBody() throws {
        let urlSession = URLSessionMockCombine()
        let openAI = OpenAI(
            configuration: .init(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14),
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory()
        )
        urlSession.dataTask = .errorResponse(statusCode: 502, data: Data("<html>Bad Gateway</html>".utf8))

        XCTAssertThrowsError(try awaitPublisher(openAI.chats(query: chatQuery()))) { error in
            guard case let .statusError(_, statusCode)? = error as? OpenAIError else {
                return XCTFail("Expected OpenAIError.statusError, got \(error)")
            }
            XCTAssertEqual(statusCode, 502)
        }
    }
#endif

    private func makeOpenAI(parsingOptions: ParsingOptions) -> OpenAI {
        let configuration = OpenAI.Configuration(
            token: "foo",
            organizationIdentifier: "bar",
            timeoutInterval: 14,
            parsingOptions: parsingOptions
        )
        return OpenAI(configuration: configuration, session: urlSession, streamingSessionFactory: MockStreamingSessionFactory())
    }

    private func chatQuery() -> ChatQuery {
        ChatQuery(messages: [.user(.init(content: .string("Hi")))], model: .gpt3_5Turbo)
    }

    /// An OpenAI error document: `error.message` and `error.type`.
    private static let apiErrorBody = Data("""
    {
      "error": {
        "message": "Invalid request",
        "type": "invalid_request_error",
        "param": null,
        "code": null
      }
    }
    """.utf8)
}

private final class UncheckedBox<Value>: @unchecked Sendable {
    var value: Value?
}
