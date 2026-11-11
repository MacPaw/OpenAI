import XCTest
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
@testable import OpenAI

final class URLResponseHandlerTests: XCTestCase {
    private let request = URLRequest(url: URL(string: "https://example.com/v1/responses")!)
    private let handler = URLResponseHandler(middlewares: [], configuration: .init(token: nil))

    func testEveryResponsePathPreservesUnsupportedBodyWithoutMiddleware() throws {
        let body = Data(#"{"error":{"code":"quota_exceeded","message":"Quota exceeded"}}"#.utf8)
        let response = makeResponse(403)
        let calls: [() throws -> Void] = [
            { let _: String = try self.handler.interceptAndDecode(response: response, urlRequest: self.request, responseData: body) },
            { let _: String = try self.handler.interceptAndDecode(response: response, urlRequest: self.request, error: nil, responseData: body) },
            { _ = try self.handler.interceptAndDecodeRaw(response: response, urlRequest: self.request, responseData: body) },
            { _ = try self.handler.interceptAndDecodeRaw(response: response, urlRequest: self.request, error: nil, responseData: body) }
        ]
        for call in calls {
            XCTAssertThrowsError(try call()) { error in
                guard let error = error as? HTTPResponseError else { return XCTFail("Expected HTTPResponseError") }
                XCTAssertEqual(error.statusCode, 403)
                XCTAssertEqual(error.response.value(forHTTPHeaderField: "Retry-After"), "600")
                XCTAssertEqual(error.body, body)
                XCTAssertNil(error.apiError)
                XCTAssertFalse(error.isBodyTruncated)
            }
        }
    }

    func testSupportedBodyPreservesResponseAndDecodedError() throws {
        let body = Data(#"{"error":{"type":"invalid_request_error","code":"invalid","message":"Invalid request"}}"#.utf8)
        XCTAssertThrowsError(try handler.interceptAndDecodeRaw(response: makeResponse(400), urlRequest: request, responseData: body)) {
            guard let error = $0 as? HTTPResponseError else { return XCTFail("Expected HTTPResponseError") }
            XCTAssertEqual(error.statusCode, 400)
            XCTAssertEqual(error.body, body)
            XCTAssertEqual((error.apiError as? APIErrorResponse)?.error.code, "invalid")
            XCTAssertEqual(error.localizedDescription, "Invalid request")
        }
    }

    func testEmptyHTMLAndMalformedBodiesStillThrowHTTPFailure() {
        for body in [Data(), Data("<html>Unavailable</html>".utf8), Data(#"{"error":"#.utf8)] {
            XCTAssertThrowsError(try handler.interceptAndDecodeRaw(response: makeResponse(503), urlRequest: request, responseData: body)) {
                guard let error = $0 as? HTTPResponseError else { return XCTFail("Expected HTTPResponseError") }
                XCTAssertEqual(error.statusCode, 503)
                XCTAssertEqual(error.body, body)
                XCTAssertNil(error.apiError)
            }
        }
    }

    func testMissingBodyAndInterruptedReadPreserveHTTPFailure() {
        XCTAssertThrowsError(try handler.interceptAndDecodeRaw(
            response: makeResponse(503), urlRequest: request,
            error: URLError(.networkConnectionLost), responseData: nil
        )) {
            guard let error = $0 as? HTTPResponseError else { return XCTFail("Expected HTTPResponseError") }
            XCTAssertEqual(error.statusCode, 503)
            XCTAssertEqual(error.body, Data())
            XCTAssertEqual((error.underlyingError as? URLError)?.code, .networkConnectionLost)
        }
    }

    func testRetainedBodyIsBounded() {
        for size in [256 * 1024 - 1, 256 * 1024, 256 * 1024 + 1] {
            XCTAssertThrowsError(try handler.interceptAndDecodeRaw(
                response: makeResponse(500), urlRequest: request,
                responseData: Data(repeating: 0x61, count: size)
            )) {
                guard let error = $0 as? HTTPResponseError else { return XCTFail("Expected HTTPResponseError") }
                XCTAssertEqual(error.body.count, min(size, 256 * 1024))
                XCTAssertEqual(error.isBodyTruncated, size > 256 * 1024)
            }
        }
    }

    func testUserCancellationTakesPrecedenceOverHTTPFailure() {
        XCTAssertThrowsError(try handler.interceptAndDecodeRaw(
            response: makeResponse(401), urlRequest: request,
            error: URLError(.cancelled), responseData: Data()
        )) {
            XCTAssertEqual(($0 as? URLError)?.code, .cancelled)
        }
    }

    func testSuccessfulJSONAndRawResponsesRemainUnchanged() throws {
        let body = Data(#""Success""#.utf8)
        let response = makeResponse(200)
        let value: String = try handler.interceptAndDecode(response: response, urlRequest: request, responseData: body)
        XCTAssertEqual(value, "Success")
        XCTAssertEqual(try handler.interceptAndDecodeRaw(response: response, urlRequest: request, responseData: body), body)
    }

    private func makeResponse(_ status: Int) -> HTTPURLResponse {
        HTTPURLResponse(
            url: request.url!, statusCode: status, httpVersion: nil, headerFields: ["Retry-After": "600"]
        )!
    }
}
