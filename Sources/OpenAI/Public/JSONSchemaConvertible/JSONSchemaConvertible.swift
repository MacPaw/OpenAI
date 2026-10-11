//
//  JSONSchemaConvertible.swift
//  
//
//  Created by Andriy Gordiyenko on 8/28/24.
//

import Foundation

public protocol JSONSchemaConvertible: Codable, Sendable {
    static var example: Self { get }
}
