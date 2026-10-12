//
//  OpenAIFile.swift
//  OpenAI
//

import Foundation

/// The `File` object represents a document that has been uploaded to OpenAI.
///
/// Hand-written replacement for `Components.Schemas.OpenAIFile`. The spec's `purpose` enum on the file object
/// omits `evals`, although `evals` is a valid purpose when uploading (`CreateFileRequest`), so the generated
/// closed enum fails to decode a file uploaded for evals. ``Purpose`` is an open type instead: it has constants
/// for the known values and decodes any other value as well. Replace this type with the generated one if the
/// spec's enum catches up and [#464](https://github.com/MacPaw/OpenAI/issues/464) settles on closed enums for
/// response values.
public struct OpenAIFile: Codable, Hashable, Sendable {
    public typealias ObjectPayload = Components.Schemas.OpenAIFile.ObjectPayload
    public typealias StatusPayload = Components.Schemas.OpenAIFile.StatusPayload

    /// The intended purpose of the file. Supported values are `assistants`, `assistants_output`, `batch`,
    /// `batch_output`, `fine-tune`, `fine-tune-results`, `vision`, and `user_data`.
    ///
    /// Also decodes values not listed here, such as `evals`, which the API accepts when uploading a file.
    public struct Purpose: RawRepresentable, Codable, Hashable, Sendable {
        /// Used in the Assistants API
        public static let assistants = Purpose(rawValue: "assistants")
        public static let assistantsOutput = Purpose(rawValue: "assistants_output")
        /// Used in the Batch API
        public static let batch = Purpose(rawValue: "batch")
        public static let batchOutput = Purpose(rawValue: "batch_output")
        /// Used for fine-tuning
        public static let fineTune = Purpose(rawValue: "fine-tune")
        public static let fineTuneResults = Purpose(rawValue: "fine-tune-results")
        /// Images used for vision fine-tuning
        public static let vision = Purpose(rawValue: "vision")
        /// Flexible file type for any purpose
        public static let userData = Purpose(rawValue: "user_data")
        /// Used for eval data sets
        public static let evals = Purpose(rawValue: "evals")

        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public init(from decoder: any Decoder) throws {
            self.rawValue = try decoder.singleValueContainer().decode(String.self)
        }

        public func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(rawValue)
        }
    }

    /// The file identifier, which can be referenced in the API endpoints.
    public let id: String
    /// The size of the file, in bytes.
    public let bytes: Int
    /// The Unix timestamp (in seconds) for when the file was created.
    public let createdAt: Int
    /// The Unix timestamp (in seconds) for when the file will expire.
    public let expiresAt: Int?
    /// The name of the file.
    public let filename: String
    /// The object type, which is always `file`.
    public let object: ObjectPayload
    /// The intended purpose of the file. Supported values are `assistants`, `assistants_output`, `batch`,
    /// `batch_output`, `fine-tune`, `fine-tune-results`, `vision`, and `user_data`.
    public let purpose: Purpose

    /// Deprecated. The current status of the file, which can be either `uploaded`, `processed`, or `error`.
    @available(*, deprecated)
    public var status: StatusPayload { _status }
    /// Deprecated. For details on why a fine-tuning training file failed validation, see the `error` field on
    /// `fine_tuning.job`.
    @available(*, deprecated)
    public var statusDetails: String? { _statusDetails }

    // Stored separately so that the type's own initializer and coding don't use the deprecated properties.
    private let _status: StatusPayload
    private let _statusDetails: String?

    public init(
        id: String,
        bytes: Int,
        createdAt: Int,
        expiresAt: Int? = nil,
        filename: String,
        object: ObjectPayload,
        purpose: Purpose,
        status: StatusPayload,
        statusDetails: String? = nil
    ) {
        self.id = id
        self.bytes = bytes
        self.createdAt = createdAt
        self.expiresAt = expiresAt
        self.filename = filename
        self.object = object
        self.purpose = purpose
        self._status = status
        self._statusDetails = statusDetails
    }

    enum CodingKeys: String, CodingKey {
        case id
        case bytes
        case createdAt = "created_at"
        case expiresAt = "expires_at"
        case filename
        case object
        case purpose
        case _status = "status"
        case _statusDetails = "status_details"
    }
}
