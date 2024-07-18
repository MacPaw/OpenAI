//
//  APIError.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public enum OpenAIError: Error {
    case emptyData
}

public struct APIError: Error, Decodable, Equatable {
    public let message: String
    public let type: String
    public let param: String?
    public let code: String?
  
  public init(message: String, type: String, param: String?, code: String?) {
    self.message = message
    self.type = type
    self.param = param
    self.code = code
  }
  
  enum CodingKeys: CodingKey {
    case message
    case type
    case param
    case code
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    //
    // message can be String or [String].
    //
    if let string = try? container.decode(String.self, forKey: .message) {
      self.message = string
    } else if let array = try? container.decode([String].self, forKey: .message) {
      self.message = array.joined(separator: "\n")
    } else {
      throw DecodingError.typeMismatch(String.self, .init(codingPath: [CodingKeys.message], debugDescription: "message: expected String or [String]"))
    }
    
    self.type = try container.decode(String.self, forKey: .type)
    self.param = try container.decodeIfPresent(String.self, forKey: .param)
    self.code = try container.decodeIfPresent(String.self, forKey: .code)
  }
}

extension APIError: LocalizedError {
    
    public var errorDescription: String? {
        return message
    }
}

public struct APIErrorResponse: Error, Decodable, Equatable {
    public let error: APIError
}

extension APIErrorResponse: LocalizedError {
    
    public var errorDescription: String? {
        return error.errorDescription
    }
}
