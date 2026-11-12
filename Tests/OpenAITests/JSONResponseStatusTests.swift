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
        } catch let error as HTTPResponseError {
            XCTAssertEqual(error.statusCode, 400)
            let apiError = try XCTUnwrap(error.apiError as? APIErrorResponse)
            XCTAssertEqual(apiError.error.message, "Invalid request")
            XCTAssertEqual(apiError.error.type, "invalid_request_error")
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
            guard let httpError = error as? HTTPResponseError, let apiError = httpError.apiError as? APIErrorResponse else {
                return XCTFail("Expected HTTPResponseError with an APIErrorResponse, got \(error)")
            }
            XCTAssertEqual(httpError.statusCode, 400)
            XCTAssertEqual(apiError.error.message, "Invalid request")
            XCTAssertEqual(apiError.error.type, "invalid_request_error")
        }
    }

    func testAsyncChatsThrowsHTTPResponseErrorForHTMLBody() async throws {
        urlSession.dataTask = .errorResponse(statusCode: 502, data: Data("<html>Bad Gateway</html>".utf8))

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as HTTPResponseError {
            XCTAssertEqual(error.statusCode, 502)
            XCTAssertNil(error.apiError)
            XCTAssertEqual(error.body, Data("<html>Bad Gateway</html>".utf8))
        }
    }

    func testCompletionChatsThrowsHTTPResponseErrorForHTMLBody() throws {
        urlSession.dataTask = .errorResponse(statusCode: 502, data: Data("<html>Bad Gateway</html>".utf8))

        let expectation = expectation(description: "chats completes")
        let result = UncheckedBox<Result<ChatResult, Error>>()
        openAI.chats(query: chatQuery()) {
            result.value = $0
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

        XCTAssertThrowsError(try result.value?.get()) { error in
            guard let httpError = error as? HTTPResponseError else {
                return XCTFail("Expected HTTPResponseError, got \(error)")
            }
            XCTAssertEqual(httpError.statusCode, 502)
            XCTAssertNil(httpError.apiError)
            XCTAssertEqual(httpError.body, Data("<html>Bad Gateway</html>".utf8))
        }
    }

    /// `.relaxed` fills the missing `id`, `object`, and `model` strings, so this body decodes as `ChatResult`.
    /// A status of 400 must still be an error. `created` and `choices` are not filled by `.relaxed`.
    func testRelaxedAsyncChatsThrowsHTTPResponseErrorForPartialBody() async throws {
        let openAI = makeOpenAI(parsingOptions: .relaxed)
        urlSession.dataTask = .errorResponse(statusCode: 400, data: Data(#"{"created":1,"choices":[]}"#.utf8))

        do {
            let result = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error, got \(result)")
        } catch let error as HTTPResponseError {
            XCTAssertEqual(error.statusCode, 400)
            XCTAssertNil(error.apiError)
        }
    }

    /// A status below 400 still decodes. `ModelResult` fills missing `created`, `object`, and `owned_by` only under `.relaxed`.
    func testRelaxedAsyncModelDecodesPartialBodyOnSuccessStatus() async throws {
        let openAI = makeOpenAI(parsingOptions: .relaxed)
        urlSession.dataTask = .successful(with: Data(#"{"id":"gemini-2.0-flash"}"#.utf8))

        let result = try await openAI.model(query: ModelQuery(model: .gpt3_5Turbo))
        XCTAssertEqual(result, ModelResult(id: "gemini-2.0-flash", created: 0, object: "model", ownedBy: ""))
    }

    /// The status guard applies only at 400 and above. A 200 error document still throws through `JSONResponseDecoder`.
    func testAsyncChatsThrowsAPIErrorForErrorDocumentOnSuccessStatus() async throws {
        urlSession.dataTask = .successful(with: Self.apiErrorBody)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as APIErrorResponse {
            XCTAssertEqual(error.error.message, "Invalid request")
            XCTAssertEqual(error.error.type, "invalid_request_error")
        }
    }

    /// `DataTaskMock.failed` sets a transport error and status 503 with nil data. The 503 is an HTTP failure,
    /// and the transport error is kept as its `underlyingError`.
    func testCompletionChatsKeepsTransportErrorOfErrorStatus() throws {
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
            guard let httpError = error as? HTTPResponseError else {
                return XCTFail("Expected HTTPResponseError, got \(error)")
            }
            XCTAssertEqual(httpError.statusCode, 503)
            XCTAssertEqual(httpError.underlyingError as? URLError, transportError)
            XCTAssertEqual(httpError.body, Data())
        }
    }

    func testAsyncChatsThrowsGeminiAPIErrorForErrorStatus() async throws {
        let body = Data(#"[{"error":{"code":400,"message":"Request contains an invalid argument.","status":"INVALID_ARGUMENT"}}]"#.utf8)
        urlSession.dataTask = .errorResponse(statusCode: 400, data: body)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as HTTPResponseError {
            XCTAssertEqual(error.statusCode, 400)
            let geminiError = try XCTUnwrap(error.apiError as? GeminiAPIErrorResponse)
            XCTAssertEqual(geminiError.error.code, 400)
            XCTAssertEqual(geminiError.error.message, "Request contains an invalid argument.")
            XCTAssertEqual(geminiError.error.status, "INVALID_ARGUMENT")
        }
    }

    /// A single Gemini error object is not the array `JSONResponseErrorDecoder` accepts, and it is not an
    /// `APIErrorResponse` (`type` is required), so a 400 has no decoded `apiError`.
    func testAsyncChatsThrowsHTTPResponseErrorForSingleGeminiErrorObject() async throws {
        let body = Data(#"{"error":{"code":400,"message":"Request contains an invalid argument.","status":"INVALID_ARGUMENT"}}"#.utf8)
        urlSession.dataTask = .errorResponse(statusCode: 400, data: body)

        do {
            _ = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error")
        } catch let error as HTTPResponseError {
            XCTAssertEqual(error.statusCode, 400)
            XCTAssertNil(error.apiError)
            XCTAssertEqual(error.body, body)
        }
    }

    /// The status check reads the response a middleware returns, not the original one.
    func testAsyncChatsThrowsHTTPResponseErrorForMiddlewareErrorStatus() async throws {
        let openAI = makeOpenAI(middlewares: [StatusOverrideMiddleware(statusCode: 503)])
        urlSession.dataTask = .successful(with: Data("<html>Unavailable</html>".utf8))

        do {
            let result = try await openAI.chats(query: chatQuery())
            XCTFail("Expected an error, got \(result)")
        } catch let error as HTTPResponseError {
            XCTAssertEqual(error.statusCode, 503)
        }
    }

    /// A middleware that turns an error status into a success lets the body decode.
    func testAsyncModelDecodesWhenMiddlewareReturnsSuccessStatus() async throws {
        let openAI = makeOpenAI(middlewares: [StatusOverrideMiddleware(statusCode: 200)])
        let body = Data(#"{"id":"gpt-3.5-turbo","created":1,"object":"model","owned_by":"openai"}"#.utf8)
        urlSession.dataTask = .errorResponse(statusCode: 500, data: body)

        let result = try await openAI.model(query: ModelQuery(model: .gpt3_5Turbo))
        XCTAssertEqual(result, ModelResult(id: "gpt-3.5-turbo", created: 1, object: "model", ownedBy: "openai"))
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
            guard let httpError = error as? HTTPResponseError, let apiError = httpError.apiError as? APIErrorResponse else {
                return XCTFail("Expected HTTPResponseError with an APIErrorResponse, got \(error)")
            }
            XCTAssertEqual(httpError.statusCode, 400)
            XCTAssertEqual(apiError.error.message, "Invalid request")
            XCTAssertEqual(apiError.error.type, "invalid_request_error")
        }
    }

    @MainActor
    func testCombineChatsThrowsHTTPResponseErrorForHTMLBody() throws {
        let urlSession = URLSessionMockCombine()
        let openAI = OpenAI(
            configuration: .init(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14),
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory()
        )
        urlSession.dataTask = .errorResponse(statusCode: 502, data: Data("<html>Bad Gateway</html>".utf8))

        XCTAssertThrowsError(try awaitPublisher(openAI.chats(query: chatQuery()))) { error in
            guard let httpError = error as? HTTPResponseError else {
                return XCTFail("Expected HTTPResponseError, got \(error)")
            }
            XCTAssertEqual(httpError.statusCode, 502)
            XCTAssertNil(httpError.apiError)
            XCTAssertEqual(httpError.body, Data("<html>Bad Gateway</html>".utf8))
        }
    }
#endif

    private func makeOpenAI(parsingOptions: ParsingOptions = [], middlewares: [OpenAIMiddleware] = []) -> OpenAI {
        let configuration = OpenAI.Configuration(
            token: "foo",
            organizationIdentifier: "bar",
            timeoutInterval: 14,
            parsingOptions: parsingOptions
        )
        return OpenAI(
            configuration: configuration,
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory(),
            middlewares: middlewares
        )
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

/// Replaces the HTTP status of every response it sees.
private struct StatusOverrideMiddleware: OpenAIMiddleware {
    let statusCode: Int

    func intercept(response: URLResponse?, request: URLRequest, data: Data?) -> (response: URLResponse?, data: Data?) {
        let url = response?.url ?? URL(fileURLWithPath: "")
        return (HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil), data)
    }
}
