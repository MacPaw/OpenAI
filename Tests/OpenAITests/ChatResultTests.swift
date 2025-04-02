//
//  ChatResultTests.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import XCTest
@testable import OpenAI

final class ChatResultTests: XCTestCase {
    private let jsonString = """
                {
                  "object": "chat.completion",
                  "created": 1677652288,
                  "model": "gpt-4",
                  "choices": [],
                  "system_fingerprint": null
                }
                """
    
    func testParsingWithRelaxedOptions() throws {
        let decoder = JSONDecoder()
        decoder.userInfo = [.parsingOptions: ParsingOptions.relaxed]
        let chatResult = try decoder.decode(ChatResult.self, from: jsonString.data(using: .utf8)!)
        XCTAssertEqual(chatResult.id, "")
        XCTAssertEqual(chatResult.systemFingerprint, "")
    }
    
    func testStringParsing() throws {
        let decoder = JSONDecoder()
        // no relaxing options
        XCTAssertThrowsError(try decoder.decode(ChatResult.self, from: jsonString.data(using: .utf8)!))
    }
    
    func testThrowsErrorIfOptionsNotSufficient() throws {
        let decoder = JSONDecoder()
        decoder.userInfo = [.parsingOptions: ParsingOptions.fillRequiredFieldIfKeyNotFound]
        XCTAssertThrowsError(
            try decoder.decode(ChatResult.self, from: jsonString.data(using: .utf8)!),
            "Should throw an error because system_fingerprint:null case is not handled"
        )
    }
}
