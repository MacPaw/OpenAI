//
//  AnyCodingKey.swift
//  OpenAI
//

import Foundation

/// A coding key for any string, used to encode and decode fields whose names aren't known in advance.
struct AnyCodingKey: CodingKey {
    let stringValue: String
    var intValue: Int? { nil }

    init(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        nil
    }
}
