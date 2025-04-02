//
//  KeyedDecodingContainer+ParsingOptions.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.03.2025.
//

import Foundation

extension KeyedDecodingContainer {
    func decodeString(forKey key: KeyedDecodingContainer<K>.Key, parsingOptions: ParsingOptions) throws -> String {
        try self.decode(String.self, forKey: key, parsingOptions: parsingOptions, defaultValue: "")
    }
    
    func decodeTimeInterval(forKey key: KeyedDecodingContainer<K>.Key, parsingOptions: ParsingOptions) throws -> TimeInterval {
        try self.decode(TimeInterval.self, forKey: key, parsingOptions: parsingOptions, defaultValue: 0)
    }
    
    func decode<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key, parsingOptions: ParsingOptions, defaultValue: T) throws -> T {
        do {
            return try decode(T.self, forKey: key)
        } catch {
            switch error {
            case DecodingError.keyNotFound:
                if parsingOptions.contains(.fillRequiredFieldIfKeyNotFound) {
                    return defaultValue
                } else {
                    throw error
                }
            case DecodingError.valueNotFound:
                if parsingOptions.contains(.fillRequiredFieldIfValueNotFound) {
                    return defaultValue
                } else {
                    throw error
                }
            default:
                throw error
            }
        }
    }
}
