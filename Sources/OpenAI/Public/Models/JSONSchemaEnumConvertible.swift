//
//  JSONSchemaEnumConvertible.swift
//
//
//  Created by Andriy Gordiyenko on 8/29/24.
//

import Foundation

public protocol JSONSchemaEnumConvertible: CaseIterable {
    var caseNames: [String] { get }
}
