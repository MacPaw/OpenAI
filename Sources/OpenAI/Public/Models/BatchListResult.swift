//
//  BatchListResult.swift
//
//
//  Created by Jason Flax on 12/24/2024.
//

import Foundation

/// Result of listing batches.
/// https://platform.openai.com/docs/api-reference/batch/list
public struct BatchListResult: Codable, Equatable, Sendable {

    /// The object type, which is always `list`.
    public let object: String

    /// The list of batches.
    public let data: [BatchResult]

    /// The ID of the first batch in the list.
    public let firstId: String?

    /// The ID of the last batch in the list.
    public let lastId: String?

    /// Whether there are more batches to retrieve.
    public let hasMore: Bool

    enum CodingKeys: String, CodingKey {
        case object
        case data
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }
}
