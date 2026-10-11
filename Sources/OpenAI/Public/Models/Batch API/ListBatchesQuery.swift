//
//  ListBatchesQuery.swift
//  OpenAI
//

import Foundation

/// Parameters for listing batches.
/// https://platform.openai.com/docs/api-reference/batch/list
public struct ListBatchesQuery: Hashable, Sendable {
    /// A pagination cursor: the ID of the last batch on the previous page
    /// (`ListBatchesResponse.lastId`). The list starts after this batch.
    public let after: String?

    /// The number of batches to return, from 1 to 100. The API defaults to 20.
    public let limit: Int?

    public init(after: String? = nil, limit: Int? = nil) {
        self.after = after
        self.limit = limit
    }
}
