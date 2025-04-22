//
//  FunctionDeclaration.swift
//  
//
//  Created by Brent Whitman on 2024-01-29.
//

import Foundation

public struct FunctionDeclaration: Codable, Hashable, Sendable {
    /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
    public let name: String
    
    /// The description of what the function does.
    public let description: String?
    
    /// The parameters the functions accepts, described as a JSON Schema object.
    public let parameters: AnyJSONSchema?
  
    public init(name: String, description: String?, parameters: AnyJSONSchema?) {
      self.name = name
      self.description = description
      self.parameters = parameters
    }
}
