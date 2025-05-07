//
//  ServerSentEventsParserTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 04.04.2025.
//

import XCTest
@testable import OpenAI

final class ServerSentEventsParserTests: XCTestCase {
    private let parser = ServerSentEventsStreamParser()
    
    func testSingleDataLine() {
        let input = "data: Hello\n\n"
        let events = parse(input)
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events[0].decodedData, "Hello")
        XCTAssertEqual(events[0].eventType, "message")
        XCTAssertNil(events[0].id)
    }
    
    func testMultilineData() {
        let input = "data: Hello\ndata: World\n\n"
        let events = parse(input)
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events[0].decodedData, "Hello\nWorld")
    }
    
    func testEventType() {
        let input = "event: update\ndata: something\n\n"
        let events = parse(input)
        XCTAssertEqual(events[0].eventType, "update")
        XCTAssertEqual(events[0].decodedData, "something")
    }
    
    func testIdAndRetry() {
        let input = "id: 123\nretry: 5000\ndata: hi\n\n"
        let events = parse(input)
        XCTAssertEqual(events[0].id, "123")
        XCTAssertEqual(events[0].retry, 5000)
    }
    
    func testCommentLineIsIgnored() {
        let input = ": this is a comment\ndata: test\n\n"
        let events = parse(input)
        XCTAssertEqual(events.count, 1)
        XCTAssertEqual(events[0].decodedData, "test")
    }
    
    func testEmptyFieldValue() {
        let input = "data\n\n"
        let events = parse(input)
        XCTAssertEqual(events[0].decodedData, "")
    }
    
    func testFieldWithColonButNoValue() {
        let input = "data:\n\n"
        let events = parse(input)
        XCTAssertEqual(events[0].decodedData, "")
    }
    
    func testUnicodeData() {
        let input = "data: Привіт світ\n\n"
        let events = parse(input)
        XCTAssertEqual(events[0].decodedData, "Привіт світ")
    }
    
    func testMultipleEvents() {
        let input = "data: one\n\n" +
        "data: two\n\n"
        let events = parse(input)
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events[0].decodedData, "one")
        XCTAssertEqual(events[1].decodedData, "two")
    }
    
    func testEmptyEventShouldNotEmit() {
        let input = "\n"
        let events = parse(input)
        XCTAssertTrue(events.isEmpty)
    }
    
    func testIgnoreUnknownField() {
        let input = "foo: bar\ndata: real\n\n"
        let events = parse(input)
        XCTAssertEqual(events[0].decodedData, "real")
    }
    
    // Helper
    func parse(_ raw: String) -> [ServerSentEventsStreamParser.Event] {
        let parser = ServerSentEventsStreamParser()
        let resultsHolder = ResultsHolder()
        parser.setCallbackClosures(onEventDispatched: { event in
            dispatchPrecondition(condition: .onQueue(.main))
            resultsHolder.results.append(event)
        }, onError: { error in
        })
        parser.processData(data: raw.data(using: .utf8)!)
        return resultsHolder.results
    }
    
    private class ResultsHolder: @unchecked Sendable {
        var results: [ServerSentEventsStreamParser.Event] = []
    }
}
