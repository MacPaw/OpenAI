//
//  StructuredOutput.swift
//  
//
//  Created by Andriy Gordiyenko on 8/28/24.
//

import Foundation

public protocol StructuredOutput: Codable {
    static var example: Self { get }
}
