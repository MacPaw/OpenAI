import Foundation

public struct Annotation: Codable, Equatable, Sendable {
    /// The type of the URL citation. Always `url_citation`.
    public let type: String
    /// A URL citation when using web search.
    public let urlCitation: URLCitation

    public enum CodingKeys: String, CodingKey {
        case type, urlCitation = "url_citation"
    }

    public struct URLCitation: Codable, Equatable, Sendable {
        /// The index of the last character of the URL citation in the message.
        public let endIndex: Int
        /// The index of the first character of the URL citation in the message.
        public let startIndex: Int
        /// The title of the web resource.
        public let title: String
        /// The URL of the web resource.
        public let url: String

        public enum CodingKeys: String, CodingKey {
            case endIndex = "end_index"
            case startIndex = "start_index"
            case title, url
        }
    }
}
