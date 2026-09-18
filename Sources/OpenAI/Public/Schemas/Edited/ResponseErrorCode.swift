//
//  ResponseErrorCode.swift
//  OpenAI
//

/// Well-known values of `Components.Schemas.ResponseErrorCode`.
///
/// `ResponseErrorCode` is an open `String` rather than a closed enum: OpenAI
/// adds codes without a spec bump, and OpenAI-compatible servers emit their
/// own. A `response.failed` event must decode whatever code it carries so the
/// human-readable `message` reaches the caller. Compare against these constants
/// instead of switching exhaustively.
extension Components.Schemas {
    public enum ResponseErrorCodes {
        public static let serverError: ResponseErrorCode = "server_error"
        public static let rateLimitExceeded: ResponseErrorCode = "rate_limit_exceeded"
        public static let invalidPrompt: ResponseErrorCode = "invalid_prompt"
        public static let vectorStoreTimeout: ResponseErrorCode = "vector_store_timeout"
        public static let invalidImage: ResponseErrorCode = "invalid_image"
        public static let invalidImageFormat: ResponseErrorCode = "invalid_image_format"
        public static let invalidBase64Image: ResponseErrorCode = "invalid_base64_image"
        public static let invalidImageUrl: ResponseErrorCode = "invalid_image_url"
        public static let imageTooLarge: ResponseErrorCode = "image_too_large"
        public static let imageTooSmall: ResponseErrorCode = "image_too_small"
        public static let imageParseError: ResponseErrorCode = "image_parse_error"
        public static let imageContentPolicyViolation: ResponseErrorCode = "image_content_policy_violation"
        public static let invalidImageMode: ResponseErrorCode = "invalid_image_mode"
        public static let imageFileTooLarge: ResponseErrorCode = "image_file_too_large"
        public static let unsupportedImageMediaType: ResponseErrorCode = "unsupported_image_media_type"
        public static let emptyImageFile: ResponseErrorCode = "empty_image_file"
        public static let failedToDownloadImage: ResponseErrorCode = "failed_to_download_image"
        public static let imageFileNotFound: ResponseErrorCode = "image_file_not_found"
    }
}
