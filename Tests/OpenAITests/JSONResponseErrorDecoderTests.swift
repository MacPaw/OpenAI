//
//  JSONResponseErrorDecoderTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

final class JSONResponseErrorDecoderTests: XCTestCase {
    private let decoder = JSONResponseErrorDecoder(decoder: JSONDecoder())

    // A body that decodes as an empty Gemini error array must not be treated as a
    // single Gemini error: decodeErrorResponse indexes element 0 unconditionally,
    // which traps on `[]` instead of falling through to the statusError fallback.
    func testDecodeErrorResponseDoesNotCrashOnEmptyArrayBody() {
        let emptyArrayBody = Data("[]".utf8)
        XCTAssertNil(decoder.decodeErrorResponse(data: emptyArrayBody))
    }
}
