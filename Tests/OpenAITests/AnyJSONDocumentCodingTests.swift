//
//  AnyJSONDocumentCodingTests.swift
//  OpenAI
//

// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
import Testing
@testable import OpenAI
import Foundation

struct AnyJSONDocumentCodingTests {
    @Test func nullRoundTripsAsNull() throws {
        let decoded = try JSONDecoder().decode(JSONObject.self, from: Data(#"{"value": null}"#.utf8))
        let encoded = String(decoding: try JSONEncoder().encode(decoded), as: UTF8.self)
        #expect(encoded == #"{"value":null}"#)
    }

    @Test func decimalRoundTripsAsNumber() throws {
        let decoded = try JSONDecoder().decode(JSONObject.self, from: Data(#"{"value": 50.5}"#.utf8))
        let encoded = String(decoding: try JSONEncoder().encode(decoded), as: UTF8.self)
        #expect(encoded == #"{"value":50.5}"#)
    }

    /// A decoded `JSONSchema`, such as the parameters of a tool loaded from a file, is sent back as the same JSON.
    @Test func decodedJSONSchemaRoundTripsNullAndDecimalValues() throws {
        let json = """
        {
            "type": "object",
            "properties": {
                "temperature": {"type": "number", "minimum": 0.5, "maximum": 1.5},
                "unit": {"type": ["string", "null"], "default": null}
            }
        }
        """
        let schema = try JSONDecoder().decode(JSONSchema.self, from: Data(json.utf8))
        let encoded = try JSONSerialization.jsonObject(with: JSONEncoder().encode(schema)) as? NSDictionary
        let expected = try JSONSerialization.jsonObject(with: Data(json.utf8)) as? NSDictionary
        #expect(encoded == expected)
    }
}
#endif
