//
//  ResponseFunctionCallArgumentsDoneEventTests.swift
//  OpenAI
//

import XCTest
@testable import OpenAI

final class ResponseFunctionCallArgumentsDoneEventTests: XCTestCase {
    func testDecodesNameField() throws {
        let json = """
        {
          "type": "response.function_call_arguments.done",
          "item_id": "item-abc",
          "name": "get_weather",
          "output_index": 1,
          "arguments": "{ \\"arg\\": 123 }",
          "sequence_number": 1
        }
        """.data(using: .utf8)!

        let event = try JSONDecoder().decode(ResponseFunctionCallArgumentsDoneEvent.self, from: json)
        XCTAssertEqual(event._type, .response_functionCallArguments_done)
        XCTAssertEqual(event.itemId, "item-abc")
        XCTAssertEqual(event.outputIndex, 1)
        XCTAssertEqual(event.sequenceNumber, 1)
        XCTAssertEqual(event.arguments, "{ \"arg\": 123 }")
        XCTAssertEqual(event.name, "get_weather")
    }

    func testDecodesWithoutNameField() throws {
        let json = """
        {
          "type": "response.function_call_arguments.done",
          "item_id": "item-abc",
          "output_index": 1,
          "arguments": "{}",
          "sequence_number": 1
        }
        """.data(using: .utf8)!

        let event = try JSONDecoder().decode(ResponseFunctionCallArgumentsDoneEvent.self, from: json)
        XCTAssertNil(event.name)
    }

    func testRoundTripPreservesName() throws {
        let original = ResponseFunctionCallArgumentsDoneEvent(
            _type: .response_functionCallArguments_done,
            itemId: "item-abc",
            outputIndex: 2,
            sequenceNumber: 5,
            arguments: "{\"a\":1}",
            name: "lookup_user"
        )

        let encoded = try JSONEncoder().encode(original)
        let decoded = try JSONDecoder().decode(ResponseFunctionCallArgumentsDoneEvent.self, from: encoded)
        XCTAssertEqual(decoded, original)

        let dict = try XCTUnwrap(JSONSerialization.jsonObject(with: encoded) as? [String: Any])
        XCTAssertEqual(try XCTUnwrap(dict["name"] as? String), "lookup_user")
        XCTAssertEqual(try XCTUnwrap(dict["type"] as? String), "response.function_call_arguments.done")
    }

    func testResponseStreamEventFacadeExposesName() throws {
        let json = """
        {
          "type": "response.function_call_arguments.done",
          "item_id": "item-abc",
          "name": "get_weather",
          "output_index": 1,
          "arguments": "{}",
          "sequence_number": 7
        }
        """.data(using: .utf8)!

        let event = try JSONDecoder().decode(ResponseStreamEvent.self, from: json)
        switch event {
        case .functionCallArguments(.done(let doneEvent)):
            XCTAssertEqual(doneEvent.name, "get_weather")
            XCTAssertEqual(doneEvent.itemId, "item-abc")
            XCTAssertEqual(doneEvent.sequenceNumber, 7)
        default:
            XCTFail("Expected .functionCallArguments(.done), got \(event)")
        }
    }
}
