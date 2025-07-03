//
//  PropertyValue.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 01.07.2025.
//


import Foundation

indirect enum PropertyValue: Codable, Hashable, Sendable {
    enum SimpleType: String, Codable {
        case string, integer, number, boolean
    }
    
    enum ComplexType: String, Codable {
        case object, array, date
    }
    
    enum SpecialType: String, Codable {
        case null
    }
    
    case simple(SimpleType, isOptional: Bool)
    case date(isOptional: Bool)
    case `enum`(cases: [String], isOptional: Bool)
    case object([String: PropertyValue], isOptional: Bool)
    case array(PropertyValue, isOptional: Bool)
    
    enum CodingKeys: String, CodingKey {
        case type
        case description
        case properties
        case items
        case additionalProperties
        case required
        case `enum`
    }
    
    enum ValueType: String, Codable {
        case string
        case date
        case integer
        case number
        case boolean
        case object
        case array
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .simple(let type, let isOptional):
            if isOptional {
                try container.encode([type.rawValue, SpecialType.null.rawValue], forKey: .type)
            } else {
                try container.encode(type.rawValue, forKey: .type)
            }
        case .date(let isOptional):
            if isOptional {
                try container.encode([SimpleType.string.rawValue, SpecialType.null.rawValue], forKey: .type)
            } else {
                try container.encode(SimpleType.string.rawValue, forKey: .type)
            }
            try container.encode("String that represents a date formatted in iso8601", forKey: .description)
        case .enum(let cases, let isOptional):
            if isOptional {
                try container.encode([SimpleType.string.rawValue, SpecialType.null.rawValue], forKey: .type)
            } else {
                try container.encode(SimpleType.string.rawValue, forKey: .type)
            }
            try container.encode(cases, forKey: .enum)
        case .object(let object, let isOptional):
            if isOptional {
                try container.encode([ComplexType.object.rawValue, SpecialType.null.rawValue], forKey: .type)
            } else {
                try container.encode(ComplexType.object.rawValue, forKey: .type)
            }
            try container.encode(false, forKey: .additionalProperties)
            try container.encode(object, forKey: .properties)
            let fields = object.map { key, value in key }
            try container.encode(fields, forKey: .required)
        case .array(let items, let isOptional):
            if isOptional {
                try container.encode([ComplexType.array.rawValue, SpecialType.null.rawValue], forKey: .type)
            } else {
                try container.encode(ComplexType.array.rawValue, forKey: .type)
            }
            try container.encode(items, forKey: .items)
        }
    }
    
    init(from value: Any) throws {
        let mirror = Mirror(reflecting: value)
        let isOptional = mirror.displayStyle == .optional
        
        switch value {
        case _ as String:
            self = .simple(.string, isOptional: isOptional)
            return
        case _ as Bool:
            self = .simple(.boolean, isOptional: isOptional)
            return
        case _ as Int, _ as Int8, _ as Int16, _ as Int32, _ as Int64, _ as UInt, _ as UInt8, _ as UInt16, _ as UInt32, _ as UInt64:
            self = .simple(.integer, isOptional: isOptional)
            return
        case _ as Double, _ as Float, _ as CGFloat:
            self = .simple(.number, isOptional: isOptional)
            return
        case _ as Date:
            self = .date(isOptional: isOptional)
            return
        default:
            
            var unwrappedMirror: Mirror!
            if isOptional {
                guard let child = mirror.children.first else {
                    throw JSONSchemaConvertationError.nilFoundInExample
                }
                unwrappedMirror = Mirror(reflecting: child.value)
            } else {
                unwrappedMirror = mirror
            }
            
            if let displayStyle = unwrappedMirror.displayStyle {
                
                switch displayStyle {
                    
                case .struct, .class:
                    var dict = [String: PropertyValue]()
                    for child in unwrappedMirror.children {
                        dict[child.label!] = try Self(from: child.value)
                    }
                    self = .object(dict, isOptional: isOptional)
                    return
                    
                case .collection:
                    if let child = unwrappedMirror.children.first {
                        self = .array(try Self(from: child.value), isOptional: isOptional)
                        return
                    } else {
                        throw JSONSchemaConvertationError.typeUnsupported
                    }
                    
                case .enum:
                    if let structuredEnum = value as? any JSONSchemaEnumConvertible {
                        self = .enum(cases: structuredEnum.caseNames, isOptional: isOptional)
                        return
                    } else {
                        throw JSONSchemaConvertationError.enumsConformance
                    }
                    
                default:
                    throw JSONSchemaConvertationError.typeUnsupported
                }
            }
            throw JSONSchemaConvertationError.typeUnsupported
        }
    }
    
    
    /// A formal initializer reqluired for the inherited Decodable conformance.
    /// This type is never returned from the server and is never decoded into.
    init(from decoder: Decoder) throws {
        self = .simple(.boolean, isOptional: false)
    }
}
