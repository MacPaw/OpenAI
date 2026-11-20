import Foundation
import XCTest
import OpenAI

final class JSONDocumentRegressionTests: XCTestCase {
    func testPublicNullRoundTripsAsJSONNull() throws {
        let data = try JSONEncoder().encode(AnyJSONDocument.null)
        XCTAssertEqual(String(decoding: data, as: UTF8.self), "null")
        XCTAssertEqual(try JSONDecoder().decode(AnyJSONDocument.self, from: data), .null)
    }

    func testNullRoundTripsAsNull() throws {
        XCTAssertEqual(try roundTrip(#"{"value": null}"#), #"{"value":null}"#)
    }

    func testDecimalRoundTripsAsNumber() throws {
        XCTAssertEqual(try roundTrip(#"{"value": 50.5}"#), #"{"value":50.5}"#)
    }

    /// A decoded `JSONSchema`, such as the parameters of a tool loaded from a file, is sent back as the same JSON.
    func testDecodedJSONSchemaRoundTripsNullAndDecimalValues() throws {
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
        let encoded = try jsonDictionary(JSONEncoder().encode(schema))
        let expected = try jsonDictionary(Data(json.utf8))
        XCTAssertEqual(encoded, expected)
    }

    func testNestedValuesHaveConsistentEqualityAndHashing() throws {
        let data = Data(#"{"values":[1,0.5,null,{"enabled":true}]}"#.utf8)
        let a = try JSONDecoder().decode(AnyJSONDocument.self, from: data)
        let b = try JSONDecoder().decode(AnyJSONDocument.self, from: data)
        XCTAssertEqual(a, b)
        XCTAssertEqual(Set([a, b]).count, 1)
        XCTAssertEqual(Set([AnyJSONDocument(0.05), AnyJSONDocument(0.05)]).count, 1)
        XCTAssertEqual(AnyJSONDocument(AnyJSONDocument(42)), AnyJSONDocument(42))
        XCTAssertNotEqual(AnyJSONDocument([1]), AnyJSONDocument([1, 2]))
        XCTAssertNotEqual(AnyJSONDocument([1, 2]), AnyJSONDocument([2, 1]))
    }

    func testNumbersOutsideDecimalRangeRoundTrip() throws {
        for number in ["1e200", "-1e200", "1e-200"] {
            let value = try JSONDecoder().decode(AnyJSONDocument.self, from: Data(number.utf8))
            let encoded = try JSONEncoder().encode(value)
            XCTAssertEqual(try JSONDecoder().decode(Double.self, from: encoded), Double(number))
        }
    }

    func testNumberOutsideDoubleRangeFailsToDecode() {
        XCTAssertThrowsError(try JSONDecoder().decode(AnyJSONDocument.self, from: Data("1e400".utf8))) { error in
            XCTAssertTrue(error is DecodingError, "Expected a DecodingError, got \(error)")
        }
    }

    /// The error from an array element propagates, instead of the array being decoded as an object,
    /// which would fail with a type mismatch.
    func testNestedNumberOutsideDoubleRangeFailsToDecode() {
        let data = Data(#"{"a": [1, 1e400]}"#.utf8)
        XCTAssertThrowsError(try JSONDecoder().decode(AnyJSONDocument.self, from: data)) { error in
            guard case DecodingError.dataCorrupted = error else {
                return XCTFail("Expected DecodingError.dataCorrupted, got \(error)")
            }
        }
    }

    /// A type mismatch inside an array element is reported at the element, instead of the array
    /// being decoded as an object. A property list can hold a value that isn't JSON, such as a date.
    func testNestedTypeMismatchIsReportedAtTheElement() throws {
        let data = try PropertyListEncoder().encode(["a": [Date(timeIntervalSince1970: 0)]])
        XCTAssertThrowsError(try PropertyListDecoder().decode(AnyJSONDocument.self, from: data)) { error in
            guard case DecodingError.typeMismatch(_, let context) = error else {
                return XCTFail("Expected DecodingError.typeMismatch, got \(error)")
            }
            XCTAssertEqual(context.codingPath.count, 2, "Unexpected coding path \(context.codingPath)")
        }
    }

    private func roundTrip(_ json: String) throws -> String {
        let decoded = try JSONDecoder().decode([String: AnyJSONDocument].self, from: Data(json.utf8))
        return String(decoding: try JSONEncoder().encode(decoded), as: UTF8.self)
    }

    /// Without Objective-C bridging (Linux), `JSONSerialization` returns `[String: Any]`, which isn't an `NSDictionary`.
    private func jsonDictionary(_ data: Data) throws -> NSDictionary {
        let object = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
        return NSDictionary(dictionary: object)
    }
}
