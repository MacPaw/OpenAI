//
//  ListFilesResponse.swift
//  OpenAI
//

import Foundation

/// Hand-written replacement for `Components.Schemas.ListFilesResponse`, for two reasons:
/// - `data` holds the hand-written ``OpenAIFile``, which decodes file purposes the spec doesn't list.
/// - `firstId` and `lastId` are optional. The spec marks them as required strings, but the API returns `null` for
///   both when the page is empty, for example when filtering by a purpose with no files or paging past the last
///   file.
///
/// Replace it with the generated type once the spec fixes both.
public struct ListFilesResponse: Codable, Hashable, Sendable {
    public let object: String
    public let data: [OpenAIFile]
    public let firstId: String?
    public let lastId: String?
    public let hasMore: Bool

    public init(object: String, data: [OpenAIFile], firstId: String?, lastId: String?, hasMore: Bool) {
        self.object = object
        self.data = data
        self.firstId = firstId
        self.lastId = lastId
        self.hasMore = hasMore
    }

    enum CodingKeys: String, CodingKey {
        case object
        case data
        case firstId = "first_id"
        case lastId = "last_id"
        case hasMore = "has_more"
    }
}
