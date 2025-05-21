//
//  Test.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 20.05.2025.
//

import Testing
@testable import OpenAI
import Foundation

struct ChatQueryCodingTests {
    @Test func encodesPredictionWithTextContent() async throws {
        let query = ChatQuery(
            messages: [],
            model: .gpt4_o,
            prediction: .staticContent(.init(content: .textContent("text_content")))
        )
        
        let expected = """
        {
            "model": "gpt-4o",
            "messages": [],
            "prediction": {
                "type": "content",
                "content": "text_content"
            },
            "stream": false
        }
        """
        
        let encodedQuery = try encodedAndComparable(query)
        let decodedExpectation = try decodedAndComparable(expected)
        #expect(encodedQuery == decodedExpectation)
    }

    @Test func decodesPredictionWithTextContent() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    private func encodedAndComparable(_ candidate: Codable) throws -> NSDictionary {
        try jsonDataAsNSDictionary(try JSONEncoder().encode(candidate))
    }
    
    private func decodedAndComparable(_ candidate: String) throws -> NSDictionary {
        try jsonDataAsNSDictionary(candidate.data(using: .utf8)!)
    }

    private func jsonDataAsNSDictionary(_ data: Data) throws -> NSDictionary {
        NSDictionary(dictionary: try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any])
    }
}
