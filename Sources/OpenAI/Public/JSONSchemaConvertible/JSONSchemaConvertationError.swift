//
//  JSONSchemaConvertationError.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 01.07.2025.
//

import Foundation

public enum JSONSchemaConvertationError: LocalizedError {
    case enumsConformance
    case typeUnsupported
    case nilFoundInExample
    
    public var errorDescription: String? {
        switch self {
        case .enumsConformance:
            return "Conform the enum types to JSONSchemaEnumConvertible and provide the `caseNames` property with a list of available cases."
        case .typeUnsupported:
            return "Unsupported type. Supported types: String, Bool, Int, Double, Array, and Codable struct/class instances."
        case .nilFoundInExample:
            return "Found nils when serializing the JSONSchemaConvertible example. Provide values for all optional properties in the example."
        }
    }
}
