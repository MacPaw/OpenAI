//
//  StreamingSessionErrorHandlingTests.swift
//  OpenAI
//

import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

final class StreamingSessionErrorHandlingTests: XCTestCase {
    private let urlSessionFactory = MockURLSessionFactory()
    private let streamInterpreter = MockDataStreamInterpreter()
    private let executionSerializer: ExecutionSerializer = NoDispatchExecutionSerializer()

    private var receivedContentCount = 0
    private var processingErrors: [Error] = []
    private var completionErrors: [Error?] = []

    private lazy var streamingSession = StreamingSession(
        urlSessionFactory: urlSessionFactory,
        urlRequest: .init(url: URL(string: "https://api.openai.com/v1/chat/completions")!),
        interpreter: streamInterpreter,
        sslDelegate: nil,
        middlewares: [],
        executionSerializer: executionSerializer,
        onReceiveContent: { _, _ in
            self.receivedContentCount += 1
        },
        onProcessingError: { _, error in
            self.processingErrors.append(error)
        },
        onComplete: { _, error in
            self.completionErrors.append(error)
        }
    )

    private func makeErrorResponse(statusCode: Int = 400) -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://api.openai.com/v1/chat/completions")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!
    }

    func testErrorBodyIsDecodedInsteadOfBeingDiscarded() throws {
        _ = streamingSession
        let dataTask = DataTaskMock()

        var disposition: URLSession.ResponseDisposition?
        streamingSession.urlSession(
            urlSessionFactory.urlSession,
            dataTask: dataTask,
            didReceive: makeErrorResponse()
        ) { disposition = $0 }

        // The connection must be kept open (not cancelled) so the error body can still be read.
        XCTAssertEqual(disposition, .allow)

        let errorBody = """
        {"error": {"message": "The model `gpt-5.6-terra` does not exist", "type": "invalid_request_error", "param": null, "code": "model_not_found"}}
        """.data(using: .utf8)!

        // Body can arrive in multiple chunks; make sure they're accumulated correctly.
        let midpoint = errorBody.index(errorBody.startIndex, offsetBy: errorBody.count / 2)
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: Data(errorBody[..<midpoint]))
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: Data(errorBody[midpoint...]))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: dataTask, didCompleteWithError: nil)

        XCTAssertEqual(receivedContentCount, 0, "Error body must not be fed to the SSE interpreter")
        XCTAssertEqual(processingErrors.count, 1)

        let apiErrorResponse = try XCTUnwrap(processingErrors.first as? APIErrorResponse)
        XCTAssertEqual(apiErrorResponse.error.message, "The model `gpt-5.6-terra` does not exist")
        XCTAssertEqual(apiErrorResponse.error.code, "model_not_found")

        let completionError = try XCTUnwrap(completionErrors.first ?? nil)
        XCTAssertTrue(completionError is APIErrorResponse)
    }

    func testFallsBackToStatusErrorWhenBodyIsNotDecodable() throws {
        _ = streamingSession
        let dataTask = DataTaskMock()

        streamingSession.urlSession(
            urlSessionFactory.urlSession,
            dataTask: dataTask,
            didReceive: makeErrorResponse()
        ) { _ in }

        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: Data("not json".utf8))
        streamingSession.urlSession(urlSessionFactory.urlSession, task: dataTask, didCompleteWithError: nil)

        XCTAssertEqual(processingErrors.count, 1)
        guard case let .statusError(_, statusCode)? = processingErrors.first as? OpenAIError else {
            return XCTFail("Expected OpenAIError.statusError, got \(String(describing: processingErrors.first))")
        }
        XCTAssertEqual(statusCode, 400)
    }

    func testSuccessfulResponseIsUnaffected() {
        _ = streamingSession
        let dataTask = DataTaskMock()

        let successResponse = HTTPURLResponse(
            url: URL(string: "https://api.openai.com/v1/chat/completions")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        var disposition: URLSession.ResponseDisposition?
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: successResponse) {
            disposition = $0
        }
        XCTAssertEqual(disposition, .allow)

        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: Data("chunk".utf8))
        streamingSession.urlSession(urlSessionFactory.urlSession, task: dataTask, didCompleteWithError: nil)

        XCTAssertEqual(receivedContentCount, 1)
        XCTAssertTrue(processingErrors.isEmpty)
        XCTAssertEqual(completionErrors.count, 1)
        XCTAssertNil(completionErrors.first ?? nil)
    }
}
