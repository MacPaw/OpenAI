//
//  File.swift
//  
//
//  Created by Federico Vitale on 09/11/23.
//

import XCTest
@testable import OpenAI

fileprivate class TestUtils {
    static func decode<T: Decodable & Equatable>(
        _ jsonString: String,
        _ expectedValue: T
    ) throws {
        let data = jsonString.data(using: .utf8)!
        let decoded = try JSONDecoder().decode(T.self, from: data)
        
        XCTAssertEqual(decoded, expectedValue)
    }
    
    static func encode<T: Encodable & Equatable>(
        _ value: T,
        _ expectedJson: String
    ) throws {
        let source = try jsonDataAsNSDictionary(JSONEncoder().encode(value))
        let expected = try jsonDataAsNSDictionary(expectedJson.data(using: .utf8)!)
        
        XCTAssertEqual(source, expected)
    }
    
    static func jsonDataAsNSDictionary(_ data: Data) throws -> NSDictionary {
        return NSDictionary(dictionary: try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any])
    }
}


class CodableUtilsTests: XCTestCase {
    func testStringOrCodable_String() throws {
        struct Person: Codable, Equatable {
            let name: StringOrCodable<FullName>
            
            struct FullName: Codable, Equatable {
                let firstName: String
                let lastName: String
            }
        }
        
        let jsonString = """
        {
            "name": "test"
        }
        """
        
        let value = Person(name: .string("test"))
        
        try TestUtils.encode(value, jsonString)
        try TestUtils.decode(jsonString, value)
    }
    
    func testStringOrCodable_Object() throws {
        struct Person: Codable, Equatable {
            let name: StringOrCodable<FullName>
            
            struct FullName: Codable, Equatable {
                let firstName: String
                let lastName: String
            }
        }
        
        let jsonString = """
        {
            "name": { "firstName": "first", "lastName": "last" }
        }
        """
        
        let value = Person(name: .object(.init(firstName: "first", lastName: "last")))
        
        try TestUtils.encode(value, jsonString)
        try TestUtils.decode(jsonString, value)
    }
}


