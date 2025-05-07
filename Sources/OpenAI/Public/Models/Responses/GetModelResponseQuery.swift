//
//  GetModelResponseQuery.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.03.2025.
//

import Foundation

public struct GetModelResponseQuery: Codable, Equatable, Sendable {
    /// The ID of the response to retrieve.
    public let responseId: String
    
    /// Specify additional output data to include in the model response. Currently supported values are:
    /// * `file_search_call.results`: Include the search results of the file search tool call.
    /// * `message.input_image.image_url`: Include image urls from the input message.
    /// * `computer_call_output.output.image_url`: Include image urls from the computer call output.
    public let include: [Components.Schemas.Includable]?
    
    private enum CodingKeys: String, CodingKey {
        case responseId = "response_id"
        case include
    }
}
