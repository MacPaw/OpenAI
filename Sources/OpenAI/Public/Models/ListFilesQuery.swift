//
//  ListFilesQuery.swift
//  OpenAI
//

import Foundation

/// Parameters for listing files. https://platform.openai.com/docs/api-reference/files/list
public struct ListFilesQuery: Hashable, Sendable {
    public enum Order: String, Hashable, Sendable {
        case ascending = "asc"
        case descending = "desc"
    }

    /// Only return files with this purpose.
    public let purpose: String?

    /// The number of files to return, from 1 to 10,000. The API defaults to 10,000.
    public let limit: Int?

    /// Sort order by the `created_at` timestamp. The API defaults to descending.
    public let order: Order?

    /// A pagination cursor: the ID of the last file on the previous page (`ListFilesResponse.lastId`).
    /// The list starts after this file.
    public let after: String?

    public init(purpose: String? = nil, limit: Int? = nil, order: Order? = nil, after: String? = nil) {
        self.purpose = purpose
        self.limit = limit
        self.order = order
        self.after = after
    }
}
