import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// An HTTP failure, independent of the server's error-body schema.
///
/// Returned for HTTP status codes of 400 or higher, including streaming requests.
public struct HTTPResponseError: LocalizedError {
    public let response: HTTPURLResponse
    public var statusCode: Int { response.statusCode }

    /// The original response body, retaining at most 256 KiB.
    public let body: Data
    /// True when the body exceeded the retention limit.
    public let isBodyTruncated: Bool
    /// A supported API error, when decoding succeeds. May reflect response middleware transformations.
    public let apiError: (any ErrorResponse)?
    /// A transport error encountered while reading the body, if any.
    public let underlyingError: (any Error)?

    public var errorDescription: String? {
        apiError?.errorDescription ?? "HTTP request failed with status \(statusCode)."
    }

    static let maximumBodyByteCount = 256 * 1024

    init(
        response: HTTPURLResponse,
        body: Data,
        isBodyTruncated: Bool,
        underlyingError: (any Error)?,
        decodingBody: Data?
    ) {
        self.response = response
        self.body = Data(body.prefix(Self.maximumBodyByteCount))
        self.isBodyTruncated = isBodyTruncated || body.count > Self.maximumBodyByteCount
        self.underlyingError = underlyingError
        let candidate = decodingBody ?? body
        self.apiError = !self.isBodyTruncated && candidate.count <= Self.maximumBodyByteCount
            ? JSONResponseErrorDecoder(decoder: JSONDecoder()).decodeErrorResponse(data: candidate)
            : nil
    }
}
