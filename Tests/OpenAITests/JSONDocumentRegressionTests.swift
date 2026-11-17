import Foundation
import XCTest
import OpenAI

final class JSONDocumentRegressionTests: XCTestCase {
    func testPublicNullRoundTripsAsJSONNull() throws {
        let data = try JSONEncoder().encode(AnyJSONDocument.null)
        XCTAssertEqual(String(decoding: data, as: UTF8.self), "null")
        XCTAssertEqual(try JSONDecoder().decode(AnyJSONDocument.self, from: data), .null)
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
}
