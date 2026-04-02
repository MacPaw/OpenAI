//
//  ChatVendorRequestBody.swift
//
//
//  Created by limchihi on 11/22/25.
//

import Foundation

struct ChatVendorRequestBody: Codable {
    private let query: ChatQuery
    private let vendorParameters: [String: JSONValue]

    init(query: ChatQuery, vendorParameters: [String: JSONValue]) {
        self.query = query
        self.vendorParameters = vendorParameters
    }

    func encode(to encoder: Encoder) throws {
        try query.encode(to: encoder)
        guard !vendorParameters.isEmpty else { return }

        var container = encoder.container(keyedBy: DynamicCodingKey.self)
        for (key, value) in vendorParameters {
            // Skip keys that are already part of the official Chat API payload.
            if ChatQuery.CodingKeys(stringValue: key) != nil {
                continue
            }
            guard let codingKey = DynamicCodingKey(stringValue: key) else { continue }
            try container.encode(value, forKey: codingKey)
        }
    }

    init(from decoder: Decoder) throws {
        self.query = try ChatQuery(from: decoder)
        self.vendorParameters = [:]
    }
}

private struct DynamicCodingKey: CodingKey {
    let stringValue: String
    var intValue: Int? { nil }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}
