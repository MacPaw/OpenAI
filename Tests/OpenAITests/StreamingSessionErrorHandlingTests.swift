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
    private var receivedDispositions: [URLSession.ResponseDisposition] = []
    private var middlewares: [OpenAIMiddleware] = []

    private lazy var streamingSession = StreamingSession(
        urlSessionFactory: urlSessionFactory,
        urlRequest: .init(url: URL(string: "https://api.openai.com/v1/chat/completions")!),
        interpreter: streamInterpreter,
        sslDelegate: nil,
        middlewares: middlewares,
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

        streamingSession.urlSession(
            urlSessionFactory.urlSession,
            dataTask: dataTask,
            didReceive: makeErrorResponse()
        ) { self.receivedDispositions.append($0) }

        // The connection must be kept open (not cancelled) so the error body can still be read.
        XCTAssertEqual(receivedDispositions, [.allow])

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

        let failure = try XCTUnwrap(processingErrors.first as? HTTPResponseError)
        let apiErrorResponse = try XCTUnwrap(failure.apiError as? APIErrorResponse)
        XCTAssertEqual(failure.statusCode, 400)
        XCTAssertEqual(failure.body, errorBody)
        XCTAssertFalse(failure.isBodyTruncated)
        XCTAssertEqual(apiErrorResponse.error.message, "The model `gpt-5.6-terra` does not exist")
        XCTAssertEqual(apiErrorResponse.error.code, "model_not_found")

        let completionError = try XCTUnwrap(completionErrors.first ?? nil)
        XCTAssertTrue(completionError is HTTPResponseError)
    }

    func testUnsupportedBodyIsPreservedInHTTPError() throws {
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
        let error = try XCTUnwrap(processingErrors.first as? HTTPResponseError)
        XCTAssertEqual(error.statusCode, 400)
        XCTAssertEqual(error.body, Data("not json".utf8))
        XCTAssertNil(error.apiError)
    }

    func testGatewayBodyWithoutTypeIsExposedWithoutMiddleware() throws {
        let task = DataTaskMock()
        let response = try XCTUnwrap(HTTPURLResponse(
            url: URL(string: "https://example.com/v1/responses")!,
            statusCode: 403,
            httpVersion: nil,
            headerFields: ["Retry-After": "600"]
        ))
        let body = Data(#"{"error":{"code":"quota_exceeded","message":"Quota exceeded"}}"#.utf8)
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: response) { _ in }
        for byte in body {
            streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data([byte]))
        }

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: nil)

        assertStatusError(403)
        let error = try XCTUnwrap(processingErrors.first as? HTTPResponseError)
        XCTAssertEqual(error.body, body)
        XCTAssertEqual(error.response.value(forHTTPHeaderField: "Retry-After"), "600")
        XCTAssertFalse(error.isBodyTruncated)
        XCTAssertNil(error.apiError)
        XCTAssertNil(error.underlyingError)
    }

    func testErrorBodyIsCappedAndTaskIsCancelledWhenBodyNeverEnds() throws {
        _ = streamingSession
        let dataTask = DataTaskMock()

        streamingSession.urlSession(
            urlSessionFactory.urlSession,
            dataTask: dataTask,
            didReceive: makeErrorResponse()
        ) { _ in }

        // Simulate a server that keeps sending a never-ending error body: this must not be
        // buffered without limit, and the task must be cancelled once the cap is exceeded.
        let chunk = Data(repeating: 0x61, count: 64 * 1024)
        for _ in 0..<8 {
            streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: chunk)
        }

        XCTAssertGreaterThan(dataTask.cancelCallCount, 0, "The task should be cancelled once the buffered error body exceeds the cap")

        streamingSession.urlSession(urlSessionFactory.urlSession, task: dataTask, didCompleteWithError: nil)

        XCTAssertEqual(processingErrors.count, 1)
        let error = try XCTUnwrap(processingErrors.first as? HTTPResponseError)
        XCTAssertTrue(error.isBodyTruncated)
        XCTAssertEqual(error.body.count, 256 * 1024)
    }

    func testSuccessfulResponseIsUnaffected() {
        let middleware = MockMiddleware()
        middlewares = [middleware]
        _ = streamingSession
        let dataTask = DataTaskMock()

        let successResponse = HTTPURLResponse(
            url: URL(string: "https://api.openai.com/v1/chat/completions")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!

        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: successResponse) {
            self.receivedDispositions.append($0)
        }
        XCTAssertEqual(receivedDispositions, [.allow])

        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: dataTask, didReceive: Data("chunk".utf8))
        streamingSession.urlSession(urlSessionFactory.urlSession, task: dataTask, didCompleteWithError: nil)

        XCTAssertEqual(receivedContentCount, 1)
        XCTAssertTrue(processingErrors.isEmpty)
        XCTAssertEqual(completionErrors.count, 1)
        XCTAssertNil(completionErrors.first ?? nil)
        XCTAssertEqual(middleware.interceptStreamingDataCallCount, 1)
        XCTAssertTrue(middleware.interceptedResponses.isEmpty)
    }

    func testResponseMiddlewareReceivesRawGatewayErrorWithoutType() throws {
        let streamFilter = MockMiddleware()
        streamFilter.interceptStreamingDataReturnValue = Data()
        let recorder = MockMiddleware()
        middlewares = [streamFilter, recorder]
        let response = try XCTUnwrap(HTTPURLResponse(
            url: URL(string: "https://example.com/v1/responses")!,
            statusCode: 403,
            httpVersion: nil,
            headerFields: ["Retry-After": "600"]
        ))
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: response) { _ in }
        let body = Data(#"{"error":{"code":"quota_exceeded","message":"Quota exceeded"}}"#.utf8)
        let midpoint = body.count / 2
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data(body.prefix(midpoint)))
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data(body.dropFirst(midpoint)))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: nil)

        XCTAssertEqual(streamFilter.interceptStreamingDataCallCount, 0)
        XCTAssertEqual(recorder.interceptStreamingDataCallCount, 0)
        XCTAssertEqual(recorder.interceptedResponses.count, 1)
        let captured = try XCTUnwrap(recorder.interceptedResponses.first)
        XCTAssertEqual(captured.data, body)
        XCTAssertEqual(captured.request.url?.path, "/v1/chat/completions")
        let capturedResponse = try XCTUnwrap(captured.response as? HTTPURLResponse)
        XCTAssertEqual(capturedResponse.statusCode, 403)
        XCTAssertEqual(capturedResponse.value(forHTTPHeaderField: "Retry-After"), "600")
        XCTAssertEqual(receivedContentCount, 0)
        assertStatusError(403)
    }

    func testResponseMiddlewareTransformsErrorBeforeDecoding() throws {
        let response = makeErrorResponse()
        let transformation = MockMiddleware()
        let body = Data(#"{"error":{"message":"Transformed","type":"invalid_request_error","code":"invalid"}}"#.utf8)
        transformation.interceptResponseReturnValue = (response, body)
        let recorder = MockMiddleware()
        middlewares = [transformation, recorder]
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: response) { _ in }
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data("original".utf8))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: nil)

        XCTAssertEqual(transformation.interceptedResponses.first?.data, Data("original".utf8))
        XCTAssertEqual(recorder.interceptedResponses.first?.data, body)
        let error = try XCTUnwrap(processingErrors.first as? HTTPResponseError)
        XCTAssertEqual(error.body, Data("original".utf8))
        let decoded = try XCTUnwrap(error.apiError as? APIErrorResponse)
        XCTAssertEqual(decoded.error.message, "Transformed")
        XCTAssertEqual(decoded.error.code, "invalid")
    }

    func testInterruptedErrorBodyPreservesStatusAndPartialData() {
        let recorder = MockMiddleware()
        middlewares = [recorder]
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: makeErrorResponse(statusCode: 503)) { _ in }
        let partialBody = Data(#"{"error":"#.utf8)
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: partialBody)

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: URLError(.networkConnectionLost))

        XCTAssertEqual(recorder.interceptedResponses.first?.data, partialBody)
        XCTAssertEqual((processingErrors.first as? HTTPResponseError)?.body, partialBody)
        XCTAssertEqual(((processingErrors.first as? HTTPResponseError)?.underlyingError as? URLError)?.code, .networkConnectionLost)
        assertStatusError(503)
    }

    func testUserCancellationDoesNotBecomeHTTPFailure() throws {
        let recorder = MockMiddleware()
        middlewares = [recorder]
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: makeErrorResponse(statusCode: 401)) { _ in }
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data("partial".utf8))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: URLError(.cancelled))

        XCTAssertTrue(processingErrors.isEmpty)
        XCTAssertTrue(recorder.interceptedResponses.isEmpty)
        XCTAssertEqual(completionErrors.count, 1)
        let error = try XCTUnwrap(completionErrors.first ?? nil)
        XCTAssertEqual((error as? URLError)?.code, .cancelled)
    }

    func testBodyAtLimitDoesNotCancel() {
        let recorder = MockMiddleware()
        middlewares = [recorder]
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: makeErrorResponse()) { _ in }
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data(repeating: 0x61, count: 256 * 1024))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: nil)

        XCTAssertEqual(task.cancelCallCount, 0)
        XCTAssertEqual(recorder.interceptedResponses.first?.data?.count, 256 * 1024)
        XCTAssertEqual((processingErrors.first as? HTTPResponseError)?.isBodyTruncated, false)
        assertStatusError(400)
    }

    func testCrossingBodyLimitCancelsOnceAndIgnoresQueuedChunks() {
        let recorder = MockMiddleware()
        middlewares = [recorder]
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: makeErrorResponse()) { _ in }
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data(repeating: 0x61, count: 256 * 1024 - 1))
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data([0x62, 0x63]))
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data(repeating: 0x64, count: 256 * 1024))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: URLError(.cancelled))

        XCTAssertEqual(task.cancelCallCount, 1)
        XCTAssertEqual(recorder.interceptedResponses.first?.data?.count, 256 * 1024)
        XCTAssertEqual(recorder.interceptedResponses.first?.data?.last, 0x62)
        XCTAssertEqual((processingErrors.first as? HTTPResponseError)?.isBodyTruncated, true)
        XCTAssertNil((processingErrors.first as? HTTPResponseError)?.underlyingError)
        assertStatusError(400)
    }

    func testSingleOversizedChunkIsTruncatedBeforeBuffering() {
        let recorder = MockMiddleware()
        middlewares = [recorder]
        let task = DataTaskMock()
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: makeErrorResponse()) { _ in }
        streamingSession.urlSession(urlSessionFactory.urlSession, dataTask: task, didReceive: Data(repeating: 0x61, count: 1024 * 1024))

        streamingSession.urlSession(urlSessionFactory.urlSession, task: task, didCompleteWithError: URLError(.cancelled))

        XCTAssertEqual(task.cancelCallCount, 1)
        XCTAssertEqual(recorder.interceptedResponses.first?.data?.count, 256 * 1024)
        assertStatusError(400)
    }

    private func assertStatusError(_ expected: Int, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(processingErrors.count, 1, file: file, line: line)
        XCTAssertEqual(completionErrors.count, 1, file: file, line: line)
        guard let error = processingErrors.first as? HTTPResponseError,
              let completionError = (completionErrors.first ?? nil) as? HTTPResponseError
        else {
            return XCTFail("Expected HTTP status error", file: file, line: line)
        }
        XCTAssertEqual(error.statusCode, expected, file: file, line: line)
        XCTAssertEqual(completionError.statusCode, expected, file: file, line: line)
        XCTAssertEqual(error.body, completionError.body, file: file, line: line)
        XCTAssertEqual(error.isBodyTruncated, completionError.isBodyTruncated, file: file, line: line)
    }
}
