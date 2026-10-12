//
//  ListFilesQuery.swift
//  OpenAI
//

import Foundation

/// Parameters for ``FilesEndpointProtocol/list(query:completion:)``.
/// https://platform.openai.com/docs/api-reference/files/list
public struct ListFilesQuery: Hashable, Sendable {
    /// Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending
    /// order.
    public struct Order: RawRepresentable, Hashable, Sendable {
        public static let ascending = Order(rawValue: "asc")
        public static let descending = Order(rawValue: "desc")
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }

    /// Only return files with the given purpose.
    public let purpose: String?

    /// A limit on the number of objects to be returned. Limit can range between 1 and 10,000, and the default is
    /// 10,000.
    public let limit: Int?

    /// Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending
    /// order.
    public let order: Order?

    /// A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if
    /// you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include
    /// after=obj_foo in order to fetch the next page of the list.
    public let after: String?

    public init(purpose: String? = nil, limit: Int? = nil, order: Order? = nil, after: String? = nil) {
        self.purpose = purpose
        self.limit = limit
        self.order = order
        self.after = after
    }
}
