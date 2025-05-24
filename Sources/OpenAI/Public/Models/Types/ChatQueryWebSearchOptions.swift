//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.05.2025.
//

import Foundation

extension ChatQuery {
    /// This tool searches the web for relevant results to use in a response.
    /// Learn more about the [web search tool](/docs/guides/tools-web-search?api-mode=chat).
    public struct WebSearchOptions: Codable, Hashable, Sendable {
        /// Approximate location parameters for the search.
        public struct UserLocation: Codable, Hashable, Sendable {
            /// The type of location approximation. Always `approximate`.
            @frozen public enum ApproximationType: String, Codable, Hashable, Sendable, CaseIterable {
                case approximate = "approximate"
            }
            /// The type of location approximation. Always `approximate`.
            public var type: UserLocation.ApproximationType
            /// Approximate location parameters for the search.
            public var approximate: Components.Schemas.WebSearchLocation
            
            public init(
                type: UserLocation.ApproximationType = .approximate,
                approximate: Components.Schemas.WebSearchLocation
            ) {
                self.type = type
                self.approximate = approximate
            }
            public enum CodingKeys: String, CodingKey {
                case type
                case approximate
            }
        }
        
        /// Approximate location parameters for the search.
        public var userLocation: UserLocation?
        /// High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
        public var searchContextSize: Components.Schemas.WebSearchContextSize?
        
        public init(
            userLocation: UserLocation? = nil,
            searchContextSize: Components.Schemas.WebSearchContextSize? = nil
        ) {
            self.userLocation = userLocation
            self.searchContextSize = searchContextSize
        }
        
        public enum CodingKeys: String, CodingKey {
            case userLocation = "user_location"
            case searchContextSize = "search_context_size"
        }
    }
}
