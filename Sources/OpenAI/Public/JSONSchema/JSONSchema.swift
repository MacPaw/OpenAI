//
//  JSONSchema.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

import Foundation

public protocol JSONSchema: JSONDocument {}
extension Bool: JSONSchema {}
extension Dictionary: JSONSchema where Key == String, Value: JSONDocument {}
