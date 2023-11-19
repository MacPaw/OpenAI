//
//  CodableUtilities.swift
//
//
//  Created by Federico Vitale on 09/11/23.
//

import Foundation


/// Allows having dynamic keys in codables. 
struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = "\(intValue)"
    }
}


///  Allows to encode/decode ``Chat`` or ``Codable`` (T)
///     ```swift
///     struct Person: Codable, Equatable {
///         let name: StringOrCodable<FullName>
///
///         struct FullName {
///             firstName: String
///             lastName: String
///         }
///     }
///
///     let person = Person(name: .string("John Doe"))
///     let fullNamePerson = Person(name: .object(.init(firstName: "John", lastName: "Doe")))
///     ```
public enum StringOrCodable<T: Codable>: Equatable, Codable where T: Equatable {
    case string(String)
    case object(T)
    
    enum CodingKeys: CodingKey {
        case string
        case object
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let string):
            try container.encode(string)
        case .object(let object):
            try container.encode(object)
        }
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let object = try? container.decode(T.self) {
            self = .object(object)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Invalid data encountered when decoding StringOrCodable<T>"
                )
            )
        }
    }
}


public enum EnumOrCodable<E: Codable, C: Codable>: Equatable, Codable where E: Equatable, C: Equatable {
    case `enum`(E)
    case codable(C)
    
    enum CodingKeys: CodingKey {
        case objectA
        case objectB
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .codable(let value):
            try container.encode(value)
        case .enum(let value):
            try container.encode(value)
        }
    }
    
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let value = try? container.decode(E.self) {
            self = .enum(value)
        } else if let value = try? container.decode(C.self) {
            self = .codable(value)
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Invalid data encountered when decoding EnumOrCodable<E, C>"
                )
            )
        }
    }
}
