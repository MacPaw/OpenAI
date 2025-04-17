//
//  Components.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.03.2025.
//

@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import struct Foundation.URL
@preconcurrency import struct Foundation.Data
@preconcurrency import struct Foundation.Date
#else
import struct Foundation.URL
import struct Foundation.Data
import struct Foundation.Date
#endif

/**
 The code here is generated using OpenAPI document provided by OpenAI.
 It's partially stripped from from unusued code, because we don't want to have 39k file where most of the code is unused.
 See below for what was removed if you want to regenerate+strip again.
 
 # openapi.yaml used for generating #
 openapi: 3.0.0
 info:
 - `title`: OpenAI API
 - `description`: The OpenAI REST API. Please see https://platform.openai.com/docs/api-reference for more details.
 - `version`: 2.3.0
 - `termsOfService`: https://openai.com/policies/terms-of-use
 - `contact`:
    - name: OpenAI Support
    - url: https://help.openai.com/
 - `license`:
    - name: MIT
    - url: https://github.com/openai/openai-openapi/blob/master/LICENSE
 
 # Swift OpenAPI Generator configuration: #
 - OpenAPI document path: /Users/oleksiinezhyborets/Projects/swift-openapi-generator/openapi.yaml
 - Configuration path: <none>
 - Generator modes: types
 - Access modifier: public
 - Naming strategy: idiomatic
 - Name overrides: <none>
 - Feature flags: <none>
 - Output file names: Types.swift
 - Output directory: /Users/oleksiinezhyborets/Projects/swift-openapi-generator
 - Diagnostics output path: <none - logs to stderr>
 - Current directory: /Users/oleksiinezhyborets/Projects/swift-openapi-generator
 - Plugin source: <none>
 - Is dry run: false
 - Additional imports: <none
 
 As for the code that was removed from `Components` section of generated file.
 We didn't remove ALL the unused code, because it would take too long.
 We would also like to make the "generate+strip" repeatable, so that we could implement more features using generated code in the future.
 So I removed groups of code that are grouped by name and would be easy to remove again from the regenerated file.
 
 Removed groups of types:
 - All Assistant... types
 - All AuditLog... types
 - All ChatCompletion... types
 - All Create... types except CreateResponse and CreateModelResponseProperties
 - All Delete... types
 - All FineTun... types
 - All Invite... types
 - All List... types
 - All Message... types
 - All Modify... types
 - All Project... types
 - All Run... types
 - All Realtime... types
 Also deleted PredictionContent because it depends on ChatCompletionRequestMessageContentPartText
 */
public enum Components {
    /// Types generated from the `#/components/schemas` section of the OpenAPI document.
    public enum Schemas {
        /// - Remark: Generated from `#/components/schemas/AddUploadPartRequest`.
        @frozen public enum AddUploadPartRequest: Sendable, Hashable {
            /// - Remark: Generated from `#/components/schemas/AddUploadPartRequest/data`.
            public struct DataPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `DataPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case data(OpenAPIRuntime.MultipartPart<Components.Schemas.AddUploadPartRequest.DataPayload>)
        }
        /// - Remark: Generated from `#/components/schemas/AdminApiKey`.
        public struct AdminApiKey: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/object`.
            public var object: Swift.String?
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/id`.
            public var id: Swift.String?
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/name`.
            public var name: Swift.String?
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/redacted_value`.
            public var redactedValue: Swift.String?
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/value`.
            public var value: Swift.String?
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/created_at`.
            public var createdAt: Swift.Int64?
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner`.
            public struct OwnerPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner/type`.
                public var _type: Swift.String?
                /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner/id`.
                public var id: Swift.String?
                /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner/name`.
                public var name: Swift.String?
                /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner/created_at`.
                public var createdAt: Swift.Int64?
                /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner/role`.
                public var role: Swift.String?
                /// Creates a new `OwnerPayload`.
                ///
                /// - Parameters:
                ///   - _type:
                ///   - id:
                ///   - name:
                ///   - createdAt:
                ///   - role:
                public init(
                    _type: Swift.String? = nil,
                    id: Swift.String? = nil,
                    name: Swift.String? = nil,
                    createdAt: Swift.Int64? = nil,
                    role: Swift.String? = nil
                ) {
                    self._type = _type
                    self.id = id
                    self.name = name
                    self.createdAt = createdAt
                    self.role = role
                }
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                    case id
                    case name
                    case createdAt = "created_at"
                    case role
                }
            }
            /// - Remark: Generated from `#/components/schemas/AdminApiKey/owner`.
            public var owner: Components.Schemas.AdminApiKey.OwnerPayload?
            /// Creates a new `AdminApiKey`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - id:
            ///   - name:
            ///   - redactedValue:
            ///   - value:
            ///   - createdAt:
            ///   - owner:
            public init(
                object: Swift.String? = nil,
                id: Swift.String? = nil,
                name: Swift.String? = nil,
                redactedValue: Swift.String? = nil,
                value: Swift.String? = nil,
                createdAt: Swift.Int64? = nil,
                owner: Components.Schemas.AdminApiKey.OwnerPayload? = nil
            ) {
                self.object = object
                self.id = id
                self.name = name
                self.redactedValue = redactedValue
                self.value = value
                self.createdAt = createdAt
                self.owner = owner
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case id
                case name
                case redactedValue = "redacted_value"
                case value
                case createdAt = "created_at"
                case owner
            }
        }
        /// - Remark: Generated from `#/components/schemas/Annotation`.
        @frozen public enum Annotation: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Annotation/case1`.
            case FileCitation(Components.Schemas.FileCitation)
            /// - Remark: Generated from `#/components/schemas/Annotation/case2`.
            case UrlCitation(Components.Schemas.UrlCitation)
            /// - Remark: Generated from `#/components/schemas/Annotation/case3`.
            case FilePath(Components.Schemas.FilePath)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .FileCitation(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .UrlCitation(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .FilePath(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .FileCitation(value):
                    try value.encode(to: encoder)
                case let .UrlCitation(value):
                    try value.encode(to: encoder)
                case let .FilePath(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// The format of the output, in one of these options: `json`, `text`, `srt`, `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`, the only supported format is `json`.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/AudioResponseFormat`.
        @frozen public enum AudioResponseFormat: String, Codable, Hashable, Sendable, CaseIterable {
            case json = "json"
            case text = "text"
            case srt = "srt"
            case verboseJson = "verbose_json"
            case vtt = "vtt"
        }
        /// The default strategy. This strategy currently uses a `max_chunk_size_tokens` of `800` and `chunk_overlap_tokens` of `400`.
        ///
        /// - Remark: Generated from `#/components/schemas/AutoChunkingStrategyRequestParam`.
        public struct AutoChunkingStrategyRequestParam: Codable, Hashable, Sendable {
            /// Always `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoChunkingStrategyRequestParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
            }
            /// Always `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoChunkingStrategyRequestParam/type`.
            public var _type: Components.Schemas.AutoChunkingStrategyRequestParam._TypePayload
            /// Creates a new `AutoChunkingStrategyRequestParam`.
            ///
            /// - Parameters:
            ///   - _type: Always `auto`.
            public init(_type: Components.Schemas.AutoChunkingStrategyRequestParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.AutoChunkingStrategyRequestParam._TypePayload.self,
                    forKey: ._type
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/Batch`.
        public struct Batch: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Batch/id`.
            public var id: Swift.String
            /// The object type, which is always `batch`.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case batch = "batch"
            }
            /// The object type, which is always `batch`.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/object`.
            public var object: Components.Schemas.Batch.ObjectPayload
            /// The OpenAI API endpoint used by the batch.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/endpoint`.
            public var endpoint: Swift.String
            /// - Remark: Generated from `#/components/schemas/Batch/errors`.
            public struct ErrorsPayload: Codable, Hashable, Sendable {
                /// The object type, which is always `list`.
                ///
                /// - Remark: Generated from `#/components/schemas/Batch/errors/object`.
                public var object: Swift.String?
                /// - Remark: Generated from `#/components/schemas/Batch/errors/DataPayload`.
                public struct DataPayloadPayload: Codable, Hashable, Sendable {
                    /// An error code identifying the error type.
                    ///
                    /// - Remark: Generated from `#/components/schemas/Batch/errors/DataPayload/code`.
                    public var code: Swift.String?
                    /// A human-readable message providing more details about the error.
                    ///
                    /// - Remark: Generated from `#/components/schemas/Batch/errors/DataPayload/message`.
                    public var message: Swift.String?
                    /// The name of the parameter that caused the error, if applicable.
                    ///
                    /// - Remark: Generated from `#/components/schemas/Batch/errors/DataPayload/param`.
                    public var param: Swift.String?
                    /// The line number of the input file where the error occurred, if applicable.
                    ///
                    /// - Remark: Generated from `#/components/schemas/Batch/errors/DataPayload/line`.
                    public var line: Swift.Int?
                    /// Creates a new `DataPayloadPayload`.
                    ///
                    /// - Parameters:
                    ///   - code: An error code identifying the error type.
                    ///   - message: A human-readable message providing more details about the error.
                    ///   - param: The name of the parameter that caused the error, if applicable.
                    ///   - line: The line number of the input file where the error occurred, if applicable.
                    public init(
                        code: Swift.String? = nil,
                        message: Swift.String? = nil,
                        param: Swift.String? = nil,
                        line: Swift.Int? = nil
                    ) {
                        self.code = code
                        self.message = message
                        self.param = param
                        self.line = line
                    }
                    public enum CodingKeys: String, CodingKey {
                        case code
                        case message
                        case param
                        case line
                    }
                }
                /// - Remark: Generated from `#/components/schemas/Batch/errors/data`.
                public typealias DataPayload = [Components.Schemas.Batch.ErrorsPayload.DataPayloadPayload]
                /// - Remark: Generated from `#/components/schemas/Batch/errors/data`.
                public var data: Components.Schemas.Batch.ErrorsPayload.DataPayload?
                /// Creates a new `ErrorsPayload`.
                ///
                /// - Parameters:
                ///   - object: The object type, which is always `list`.
                ///   - data:
                public init(
                    object: Swift.String? = nil,
                    data: Components.Schemas.Batch.ErrorsPayload.DataPayload? = nil
                ) {
                    self.object = object
                    self.data = data
                }
                public enum CodingKeys: String, CodingKey {
                    case object
                    case data
                }
            }
            /// - Remark: Generated from `#/components/schemas/Batch/errors`.
            public var errors: Components.Schemas.Batch.ErrorsPayload?
            /// The ID of the input file for the batch.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/input_file_id`.
            public var inputFileId: Swift.String
            /// The time frame within which the batch should be processed.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/completion_window`.
            public var completionWindow: Swift.String
            /// The current status of the batch.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case validating = "validating"
                case failed = "failed"
                case inProgress = "in_progress"
                case finalizing = "finalizing"
                case completed = "completed"
                case expired = "expired"
                case cancelling = "cancelling"
                case cancelled = "cancelled"
            }
            /// The current status of the batch.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/status`.
            public var status: Components.Schemas.Batch.StatusPayload
            /// The ID of the file containing the outputs of successfully executed requests.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/output_file_id`.
            public var outputFileId: Swift.String?
            /// The ID of the file containing the outputs of requests with errors.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/error_file_id`.
            public var errorFileId: Swift.String?
            /// The Unix timestamp (in seconds) for when the batch was created.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/created_at`.
            public var createdAt: Swift.Int
            /// The Unix timestamp (in seconds) for when the batch started processing.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/in_progress_at`.
            public var inProgressAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch will expire.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/expires_at`.
            public var expiresAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch started finalizing.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/finalizing_at`.
            public var finalizingAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch was completed.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/completed_at`.
            public var completedAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch failed.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/failed_at`.
            public var failedAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch expired.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/expired_at`.
            public var expiredAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch started cancelling.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/cancelling_at`.
            public var cancellingAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the batch was cancelled.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/cancelled_at`.
            public var cancelledAt: Swift.Int?
            /// The request counts for different statuses within the batch.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/request_counts`.
            public struct RequestCountsPayload: Codable, Hashable, Sendable {
                /// Total number of requests in the batch.
                ///
                /// - Remark: Generated from `#/components/schemas/Batch/request_counts/total`.
                public var total: Swift.Int
                /// Number of requests that have been completed successfully.
                ///
                /// - Remark: Generated from `#/components/schemas/Batch/request_counts/completed`.
                public var completed: Swift.Int
                /// Number of requests that have failed.
                ///
                /// - Remark: Generated from `#/components/schemas/Batch/request_counts/failed`.
                public var failed: Swift.Int
                /// Creates a new `RequestCountsPayload`.
                ///
                /// - Parameters:
                ///   - total: Total number of requests in the batch.
                ///   - completed: Number of requests that have been completed successfully.
                ///   - failed: Number of requests that have failed.
                public init(
                    total: Swift.Int,
                    completed: Swift.Int,
                    failed: Swift.Int
                ) {
                    self.total = total
                    self.completed = completed
                    self.failed = failed
                }
                public enum CodingKeys: String, CodingKey {
                    case total
                    case completed
                    case failed
                }
            }
            /// The request counts for different statuses within the batch.
            ///
            /// - Remark: Generated from `#/components/schemas/Batch/request_counts`.
            public var requestCounts: Components.Schemas.Batch.RequestCountsPayload?
            /// - Remark: Generated from `#/components/schemas/Batch/metadata`.
            public var metadata: Components.Schemas.Metadata?
            /// Creates a new `Batch`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - object: The object type, which is always `batch`.
            ///   - endpoint: The OpenAI API endpoint used by the batch.
            ///   - errors:
            ///   - inputFileId: The ID of the input file for the batch.
            ///   - completionWindow: The time frame within which the batch should be processed.
            ///   - status: The current status of the batch.
            ///   - outputFileId: The ID of the file containing the outputs of successfully executed requests.
            ///   - errorFileId: The ID of the file containing the outputs of requests with errors.
            ///   - createdAt: The Unix timestamp (in seconds) for when the batch was created.
            ///   - inProgressAt: The Unix timestamp (in seconds) for when the batch started processing.
            ///   - expiresAt: The Unix timestamp (in seconds) for when the batch will expire.
            ///   - finalizingAt: The Unix timestamp (in seconds) for when the batch started finalizing.
            ///   - completedAt: The Unix timestamp (in seconds) for when the batch was completed.
            ///   - failedAt: The Unix timestamp (in seconds) for when the batch failed.
            ///   - expiredAt: The Unix timestamp (in seconds) for when the batch expired.
            ///   - cancellingAt: The Unix timestamp (in seconds) for when the batch started cancelling.
            ///   - cancelledAt: The Unix timestamp (in seconds) for when the batch was cancelled.
            ///   - requestCounts: The request counts for different statuses within the batch.
            ///   - metadata:
            public init(
                id: Swift.String,
                object: Components.Schemas.Batch.ObjectPayload,
                endpoint: Swift.String,
                errors: Components.Schemas.Batch.ErrorsPayload? = nil,
                inputFileId: Swift.String,
                completionWindow: Swift.String,
                status: Components.Schemas.Batch.StatusPayload,
                outputFileId: Swift.String? = nil,
                errorFileId: Swift.String? = nil,
                createdAt: Swift.Int,
                inProgressAt: Swift.Int? = nil,
                expiresAt: Swift.Int? = nil,
                finalizingAt: Swift.Int? = nil,
                completedAt: Swift.Int? = nil,
                failedAt: Swift.Int? = nil,
                expiredAt: Swift.Int? = nil,
                cancellingAt: Swift.Int? = nil,
                cancelledAt: Swift.Int? = nil,
                requestCounts: Components.Schemas.Batch.RequestCountsPayload? = nil,
                metadata: Components.Schemas.Metadata? = nil
            ) {
                self.id = id
                self.object = object
                self.endpoint = endpoint
                self.errors = errors
                self.inputFileId = inputFileId
                self.completionWindow = completionWindow
                self.status = status
                self.outputFileId = outputFileId
                self.errorFileId = errorFileId
                self.createdAt = createdAt
                self.inProgressAt = inProgressAt
                self.expiresAt = expiresAt
                self.finalizingAt = finalizingAt
                self.completedAt = completedAt
                self.failedAt = failedAt
                self.expiredAt = expiredAt
                self.cancellingAt = cancellingAt
                self.cancelledAt = cancelledAt
                self.requestCounts = requestCounts
                self.metadata = metadata
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case object
                case endpoint
                case errors
                case inputFileId = "input_file_id"
                case completionWindow = "completion_window"
                case status
                case outputFileId = "output_file_id"
                case errorFileId = "error_file_id"
                case createdAt = "created_at"
                case inProgressAt = "in_progress_at"
                case expiresAt = "expires_at"
                case finalizingAt = "finalizing_at"
                case completedAt = "completed_at"
                case failedAt = "failed_at"
                case expiredAt = "expired_at"
                case cancellingAt = "cancelling_at"
                case cancelledAt = "cancelled_at"
                case requestCounts = "request_counts"
                case metadata
            }
        }
        /// The per-line object of the batch input file
        ///
        /// - Remark: Generated from `#/components/schemas/BatchRequestInput`.
        public struct BatchRequestInput: Codable, Hashable, Sendable {
            /// A developer-provided per-request id that will be used to match outputs to inputs. Must be unique for each request in a batch.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestInput/custom_id`.
            public var customId: Swift.String?
            /// The HTTP method to be used for the request. Currently only `POST` is supported.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestInput/method`.
            @frozen public enum MethodPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case post = "POST"
            }
            /// The HTTP method to be used for the request. Currently only `POST` is supported.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestInput/method`.
            public var method: Components.Schemas.BatchRequestInput.MethodPayload?
            /// The OpenAI API relative URL to be used for the request. Currently `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions` are supported.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestInput/url`.
            public var url: Swift.String?
            /// Creates a new `BatchRequestInput`.
            ///
            /// - Parameters:
            ///   - customId: A developer-provided per-request id that will be used to match outputs to inputs. Must be unique for each request in a batch.
            ///   - method: The HTTP method to be used for the request. Currently only `POST` is supported.
            ///   - url: The OpenAI API relative URL to be used for the request. Currently `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions` are supported.
            public init(
                customId: Swift.String? = nil,
                method: Components.Schemas.BatchRequestInput.MethodPayload? = nil,
                url: Swift.String? = nil
            ) {
                self.customId = customId
                self.method = method
                self.url = url
            }
            public enum CodingKeys: String, CodingKey {
                case customId = "custom_id"
                case method
                case url
            }
        }
        /// The per-line object of the batch output and error files
        ///
        /// - Remark: Generated from `#/components/schemas/BatchRequestOutput`.
        public struct BatchRequestOutput: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/id`.
            public var id: Swift.String?
            /// A developer-provided per-request id that will be used to match outputs to inputs.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/custom_id`.
            public var customId: Swift.String?
            /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/response`.
            public struct ResponsePayload: Codable, Hashable, Sendable {
                /// The HTTP status code of the response
                ///
                /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/response/status_code`.
                public var statusCode: Swift.Int?
                /// An unique identifier for the OpenAI API request. Please include this request ID when contacting support.
                ///
                /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/response/request_id`.
                public var requestId: Swift.String?
                /// The JSON body of the response
                ///
                /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/response/body`.
                public var body: OpenAPIRuntime.OpenAPIObjectContainer?
                /// Creates a new `ResponsePayload`.
                ///
                /// - Parameters:
                ///   - statusCode: The HTTP status code of the response
                ///   - requestId: An unique identifier for the OpenAI API request. Please include this request ID when contacting support.
                ///   - body: The JSON body of the response
                public init(
                    statusCode: Swift.Int? = nil,
                    requestId: Swift.String? = nil,
                    body: OpenAPIRuntime.OpenAPIObjectContainer? = nil
                ) {
                    self.statusCode = statusCode
                    self.requestId = requestId
                    self.body = body
                }
                public enum CodingKeys: String, CodingKey {
                    case statusCode = "status_code"
                    case requestId = "request_id"
                    case body
                }
            }
            /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/response`.
            public var response: Components.Schemas.BatchRequestOutput.ResponsePayload?
            /// For requests that failed with a non-HTTP error, this will contain more information on the cause of the failure.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/error`.
            public struct _ErrorPayload: Codable, Hashable, Sendable {
                /// A machine-readable error code.
                ///
                /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/error/code`.
                public var code: Swift.String?
                /// A human-readable error message.
                ///
                /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/error/message`.
                public var message: Swift.String?
                /// Creates a new `_ErrorPayload`.
                ///
                /// - Parameters:
                ///   - code: A machine-readable error code.
                ///   - message: A human-readable error message.
                public init(
                    code: Swift.String? = nil,
                    message: Swift.String? = nil
                ) {
                    self.code = code
                    self.message = message
                }
                public enum CodingKeys: String, CodingKey {
                    case code
                    case message
                }
            }
            /// For requests that failed with a non-HTTP error, this will contain more information on the cause of the failure.
            ///
            /// - Remark: Generated from `#/components/schemas/BatchRequestOutput/error`.
            public var error: Components.Schemas.BatchRequestOutput._ErrorPayload?
            /// Creates a new `BatchRequestOutput`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - customId: A developer-provided per-request id that will be used to match outputs to inputs.
            ///   - response:
            ///   - error: For requests that failed with a non-HTTP error, this will contain more information on the cause of the failure.
            public init(
                id: Swift.String? = nil,
                customId: Swift.String? = nil,
                response: Components.Schemas.BatchRequestOutput.ResponsePayload? = nil,
                error: Components.Schemas.BatchRequestOutput._ErrorPayload? = nil
            ) {
                self.id = id
                self.customId = customId
                self.response = response
                self.error = error
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case customId = "custom_id"
                case response
                case error
            }
        }
        /// - Remark: Generated from `#/components/schemas/CancelUploadRequest`.
        public struct CancelUploadRequest: Codable, Hashable, Sendable {
            /// Creates a new `CancelUploadRequest`.
            public init() {}
            public init(from decoder: any Decoder) throws {
                try decoder.ensureNoAdditionalProperties(knownKeys: [])
            }
        }
        /// The chunking strategy used to chunk the file(s). If not set, will use the `auto` strategy.
        ///
        /// - Remark: Generated from `#/components/schemas/ChunkingStrategyRequestParam`.
        @frozen public enum ChunkingStrategyRequestParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ChunkingStrategyRequestParam/case1`.
            case AutoChunkingStrategyRequestParam(Components.Schemas.AutoChunkingStrategyRequestParam)
            /// - Remark: Generated from `#/components/schemas/ChunkingStrategyRequestParam/case2`.
            case StaticChunkingStrategyRequestParam(Components.Schemas.StaticChunkingStrategyRequestParam)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .AutoChunkingStrategyRequestParam(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .StaticChunkingStrategyRequestParam(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .AutoChunkingStrategyRequestParam(value):
                    try value.encode(to: encoder)
                case let .StaticChunkingStrategyRequestParam(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A click action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Click`.
        public struct Click: Codable, Hashable, Sendable {
            /// Specifies the event type. For a click action, this property is 
            /// always set to `click`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Click/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case click = "click"
            }
            /// Specifies the event type. For a click action, this property is 
            /// always set to `click`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Click/type`.
            public var _type: Components.Schemas.Click._TypePayload
            /// Indicates which mouse button was pressed during the click. One of `left`, `right`, `wheel`, `back`, or `forward`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Click/button`.
            @frozen public enum ButtonPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case left = "left"
                case right = "right"
                case wheel = "wheel"
                case back = "back"
                case forward = "forward"
            }
            /// Indicates which mouse button was pressed during the click. One of `left`, `right`, `wheel`, `back`, or `forward`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Click/button`.
            public var button: Components.Schemas.Click.ButtonPayload
            /// The x-coordinate where the click occurred.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Click/x`.
            public var x: Swift.Int
            /// The y-coordinate where the click occurred.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Click/y`.
            public var y: Swift.Int
            /// Creates a new `Click`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a click action, this property is 
            ///   - button: Indicates which mouse button was pressed during the click. One of `left`, `right`, `wheel`, `back`, or `forward`.
            ///   - x: The x-coordinate where the click occurred.
            ///   - y: The y-coordinate where the click occurred.
            public init(
                _type: Components.Schemas.Click._TypePayload,
                button: Components.Schemas.Click.ButtonPayload,
                x: Swift.Int,
                y: Swift.Int
            ) {
                self._type = _type
                self.button = button
                self.x = x
                self.y = y
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case button
                case x
                case y
            }
        }
        /// The output of a code interpreter tool call that is a file.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput`.
        public struct CodeInterpreterFileOutput: Codable, Hashable, Sendable {
            /// The type of the code interpreter file output. Always `files`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case files = "files"
            }
            /// The type of the code interpreter file output. Always `files`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/type`.
            public var _type: Components.Schemas.CodeInterpreterFileOutput._TypePayload
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/FilesPayload`.
            public struct FilesPayloadPayload: Codable, Hashable, Sendable {
                /// The MIME type of the file.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/FilesPayload/mime_type`.
                public var mimeType: Swift.String
                /// The ID of the file.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/FilesPayload/file_id`.
                public var fileId: Swift.String
                /// Creates a new `FilesPayloadPayload`.
                ///
                /// - Parameters:
                ///   - mimeType: The MIME type of the file.
                ///   - fileId: The ID of the file.
                public init(
                    mimeType: Swift.String,
                    fileId: Swift.String
                ) {
                    self.mimeType = mimeType
                    self.fileId = fileId
                }
                public enum CodingKeys: String, CodingKey {
                    case mimeType = "mime_type"
                    case fileId = "file_id"
                }
            }
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/files`.
            public typealias FilesPayload = [Components.Schemas.CodeInterpreterFileOutput.FilesPayloadPayload]
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterFileOutput/files`.
            public var files: Components.Schemas.CodeInterpreterFileOutput.FilesPayload
            /// Creates a new `CodeInterpreterFileOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the code interpreter file output. Always `files`.
            ///   - files:
            public init(
                _type: Components.Schemas.CodeInterpreterFileOutput._TypePayload,
                files: Components.Schemas.CodeInterpreterFileOutput.FilesPayload
            ) {
                self._type = _type
                self.files = files
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case files
            }
        }
        /// The output of a code interpreter tool call that is text.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterTextOutput`.
        public struct CodeInterpreterTextOutput: Codable, Hashable, Sendable {
            /// The type of the code interpreter text output. Always `logs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTextOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case logs = "logs"
            }
            /// The type of the code interpreter text output. Always `logs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTextOutput/type`.
            public var _type: Components.Schemas.CodeInterpreterTextOutput._TypePayload
            /// The logs of the code interpreter tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTextOutput/logs`.
            public var logs: Swift.String
            /// Creates a new `CodeInterpreterTextOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the code interpreter text output. Always `logs`.
            ///   - logs: The logs of the code interpreter tool call.
            public init(
                _type: Components.Schemas.CodeInterpreterTextOutput._TypePayload,
                logs: Swift.String
            ) {
                self._type = _type
                self.logs = logs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case logs
            }
        }
        /// A tool that runs code.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool`.
        public struct CodeInterpreterTool: Codable, Hashable, Sendable {
            /// The type of the code interpreter tool. Always `code_interpreter`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case codeInterpreter = "code_interpreter"
            }
            /// The type of the code interpreter tool. Always `code_interpreter`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/type`.
            public var _type: Components.Schemas.CodeInterpreterTool._TypePayload
            /// The IDs of the files to run the code on.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/file_ids`.
            public var fileIds: [Swift.String]
            /// Creates a new `CodeInterpreterTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the code interpreter tool. Always `code_interpreter`.
            ///   - fileIds: The IDs of the files to run the code on.
            public init(
                _type: Components.Schemas.CodeInterpreterTool._TypePayload,
                fileIds: [Swift.String]
            ) {
                self._type = _type
                self.fileIds = fileIds
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileIds = "file_ids"
            }
        }
        /// A tool call to run code.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall`.
        public struct CodeInterpreterToolCall: Codable, Hashable, Sendable {
            /// The unique ID of the code interpreter tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/id`.
            public var id: Swift.String
            /// The type of the code interpreter tool call. Always `code_interpreter_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case codeInterpreterCall = "code_interpreter_call"
            }
            /// The type of the code interpreter tool call. Always `code_interpreter_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/type`.
            public var _type: Components.Schemas.CodeInterpreterToolCall._TypePayload
            /// The code to run.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/code`.
            public var code: Swift.String
            /// The status of the code interpreter tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case interpreting = "interpreting"
                case completed = "completed"
            }
            /// The status of the code interpreter tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/status`.
            public var status: Components.Schemas.CodeInterpreterToolCall.StatusPayload
            /// The results of the code interpreter tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/results`.
            public var results: [Components.Schemas.CodeInterpreterToolOutput]
            /// Creates a new `CodeInterpreterToolCall`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the code interpreter tool call.
            ///   - _type: The type of the code interpreter tool call. Always `code_interpreter_call`.
            ///   - code: The code to run.
            ///   - status: The status of the code interpreter tool call.
            ///   - results: The results of the code interpreter tool call.
            public init(
                id: Swift.String,
                _type: Components.Schemas.CodeInterpreterToolCall._TypePayload,
                code: Swift.String,
                status: Components.Schemas.CodeInterpreterToolCall.StatusPayload,
                results: [Components.Schemas.CodeInterpreterToolOutput]
            ) {
                self.id = id
                self._type = _type
                self.code = code
                self.status = status
                self.results = results
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case code
                case status
                case results
            }
        }
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolOutput`.
        @frozen public enum CodeInterpreterToolOutput: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolOutput/case1`.
            case CodeInterpreterTextOutput(Components.Schemas.CodeInterpreterTextOutput)
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolOutput/case2`.
            case CodeInterpreterFileOutput(Components.Schemas.CodeInterpreterFileOutput)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .CodeInterpreterTextOutput(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .CodeInterpreterFileOutput(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .CodeInterpreterTextOutput(value):
                    try value.encode(to: encoder)
                case let .CodeInterpreterFileOutput(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComparisonFilter`.
        public struct ComparisonFilter: Codable, Hashable, Sendable {
            /// Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
            /// - `eq`: equals
            /// - `ne`: not equal
            /// - `gt`: greater than
            /// - `gte`: greater than or equal
            /// - `lt`: less than
            /// - `lte`: less than or equal
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComparisonFilter/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case eq = "eq"
                case ne = "ne"
                case gt = "gt"
                case gte = "gte"
                case lt = "lt"
                case lte = "lte"
            }
            /// Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
            /// - `eq`: equals
            /// - `ne`: not equal
            /// - `gt`: greater than
            /// - `gte`: greater than or equal
            /// - `lt`: less than
            /// - `lte`: less than or equal
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComparisonFilter/type`.
            public var _type: Components.Schemas.ComparisonFilter._TypePayload
            /// The key to compare against the value.
            ///
            /// - Remark: Generated from `#/components/schemas/ComparisonFilter/key`.
            public var key: Swift.String
            /// The value to compare against the attribute key; supports string, number, or boolean types.
            ///
            /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value`.
            @frozen public enum ValuePayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/case1`.
                case case1(Swift.String)
                /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/case2`.
                case case2(Swift.Double)
                /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/case3`.
                case case3(Swift.Bool)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .case2(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .case3(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case3(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// The value to compare against the attribute key; supports string, number, or boolean types.
            ///
            /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value`.
            public var value: Components.Schemas.ComparisonFilter.ValuePayload
            /// Creates a new `ComparisonFilter`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`.
            ///   - key: The key to compare against the value.
            ///   - value: The value to compare against the attribute key; supports string, number, or boolean types.
            public init(
                _type: Components.Schemas.ComparisonFilter._TypePayload,
                key: Swift.String,
                value: Components.Schemas.ComparisonFilter.ValuePayload
            ) {
                self._type = _type
                self.key = key
                self.value = value
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case key
                case value
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.ComparisonFilter._TypePayload.self,
                    forKey: ._type
                )
                self.key = try container.decode(
                    Swift.String.self,
                    forKey: .key
                )
                self.value = try container.decode(
                    Components.Schemas.ComparisonFilter.ValuePayload.self,
                    forKey: .value
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type",
                    "key",
                    "value"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/CompleteUploadRequest`.
        public struct CompleteUploadRequest: Codable, Hashable, Sendable {
            /// The ordered list of Part IDs.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CompleteUploadRequest/part_ids`.
            public var partIds: [Swift.String]
            /// The optional md5 checksum for the file contents to verify if the bytes uploaded matches what you expect.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CompleteUploadRequest/md5`.
            public var md5: Swift.String?
            /// Creates a new `CompleteUploadRequest`.
            ///
            /// - Parameters:
            ///   - partIds: The ordered list of Part IDs.
            ///   - md5: The optional md5 checksum for the file contents to verify if the bytes uploaded matches what you expect.
            public init(
                partIds: [Swift.String],
                md5: Swift.String? = nil
            ) {
                self.partIds = partIds
                self.md5 = md5
            }
            public enum CodingKeys: String, CodingKey {
                case partIds = "part_ids"
                case md5
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.partIds = try container.decode(
                    [Swift.String].self,
                    forKey: .partIds
                )
                self.md5 = try container.decodeIfPresent(
                    Swift.String.self,
                    forKey: .md5
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "part_ids",
                    "md5"
                ])
            }
        }
        /// Usage statistics for the completion request.
        ///
        /// - Remark: Generated from `#/components/schemas/CompletionUsage`.
        public struct CompletionUsage: Codable, Hashable, Sendable {
            /// Number of tokens in the generated completion.
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens`.
            public var completionTokens: Swift.Int
            /// Number of tokens in the prompt.
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/prompt_tokens`.
            public var promptTokens: Swift.Int
            /// Total number of tokens used in the request (prompt + completion).
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/total_tokens`.
            public var totalTokens: Swift.Int
            /// Breakdown of tokens used in a completion.
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens_details`.
            public struct CompletionTokensDetailsPayload: Codable, Hashable, Sendable {
                /// When using Predicted Outputs, the number of tokens in the
                /// prediction that appeared in the completion.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens_details/accepted_prediction_tokens`.
                public var acceptedPredictionTokens: Swift.Int?
                /// Audio input tokens generated by the model.
                ///
                /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens_details/audio_tokens`.
                public var audioTokens: Swift.Int?
                /// Tokens generated by the model for reasoning.
                ///
                /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens_details/reasoning_tokens`.
                public var reasoningTokens: Swift.Int?
                /// When using Predicted Outputs, the number of tokens in the
                /// prediction that did not appear in the completion. However, like
                /// reasoning tokens, these tokens are still counted in the total
                /// completion tokens for purposes of billing, output, and context window
                /// limits.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens_details/rejected_prediction_tokens`.
                public var rejectedPredictionTokens: Swift.Int?
                /// Creates a new `CompletionTokensDetailsPayload`.
                ///
                /// - Parameters:
                ///   - acceptedPredictionTokens: When using Predicted Outputs, the number of tokens in the
                ///   - audioTokens: Audio input tokens generated by the model.
                ///   - reasoningTokens: Tokens generated by the model for reasoning.
                ///   - rejectedPredictionTokens: When using Predicted Outputs, the number of tokens in the
                public init(
                    acceptedPredictionTokens: Swift.Int? = nil,
                    audioTokens: Swift.Int? = nil,
                    reasoningTokens: Swift.Int? = nil,
                    rejectedPredictionTokens: Swift.Int? = nil
                ) {
                    self.acceptedPredictionTokens = acceptedPredictionTokens
                    self.audioTokens = audioTokens
                    self.reasoningTokens = reasoningTokens
                    self.rejectedPredictionTokens = rejectedPredictionTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case acceptedPredictionTokens = "accepted_prediction_tokens"
                    case audioTokens = "audio_tokens"
                    case reasoningTokens = "reasoning_tokens"
                    case rejectedPredictionTokens = "rejected_prediction_tokens"
                }
            }
            /// Breakdown of tokens used in a completion.
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/completion_tokens_details`.
            public var completionTokensDetails: Components.Schemas.CompletionUsage.CompletionTokensDetailsPayload?
            /// Breakdown of tokens used in the prompt.
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/prompt_tokens_details`.
            public struct PromptTokensDetailsPayload: Codable, Hashable, Sendable {
                /// Audio input tokens present in the prompt.
                ///
                /// - Remark: Generated from `#/components/schemas/CompletionUsage/prompt_tokens_details/audio_tokens`.
                public var audioTokens: Swift.Int?
                /// Cached tokens present in the prompt.
                ///
                /// - Remark: Generated from `#/components/schemas/CompletionUsage/prompt_tokens_details/cached_tokens`.
                public var cachedTokens: Swift.Int?
                /// Creates a new `PromptTokensDetailsPayload`.
                ///
                /// - Parameters:
                ///   - audioTokens: Audio input tokens present in the prompt.
                ///   - cachedTokens: Cached tokens present in the prompt.
                public init(
                    audioTokens: Swift.Int? = nil,
                    cachedTokens: Swift.Int? = nil
                ) {
                    self.audioTokens = audioTokens
                    self.cachedTokens = cachedTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case audioTokens = "audio_tokens"
                    case cachedTokens = "cached_tokens"
                }
            }
            /// Breakdown of tokens used in the prompt.
            ///
            /// - Remark: Generated from `#/components/schemas/CompletionUsage/prompt_tokens_details`.
            public var promptTokensDetails: Components.Schemas.CompletionUsage.PromptTokensDetailsPayload?
            /// Creates a new `CompletionUsage`.
            ///
            /// - Parameters:
            ///   - completionTokens: Number of tokens in the generated completion.
            ///   - promptTokens: Number of tokens in the prompt.
            ///   - totalTokens: Total number of tokens used in the request (prompt + completion).
            ///   - completionTokensDetails: Breakdown of tokens used in a completion.
            ///   - promptTokensDetails: Breakdown of tokens used in the prompt.
            public init(
                completionTokens: Swift.Int,
                promptTokens: Swift.Int,
                totalTokens: Swift.Int,
                completionTokensDetails: Components.Schemas.CompletionUsage.CompletionTokensDetailsPayload? = nil,
                promptTokensDetails: Components.Schemas.CompletionUsage.PromptTokensDetailsPayload? = nil
            ) {
                self.completionTokens = completionTokens
                self.promptTokens = promptTokens
                self.totalTokens = totalTokens
                self.completionTokensDetails = completionTokensDetails
                self.promptTokensDetails = promptTokensDetails
            }
            public enum CodingKeys: String, CodingKey {
                case completionTokens = "completion_tokens"
                case promptTokens = "prompt_tokens"
                case totalTokens = "total_tokens"
                case completionTokensDetails = "completion_tokens_details"
                case promptTokensDetails = "prompt_tokens_details"
            }
        }
        /// Combine multiple filters using `and` or `or`.
        ///
        /// - Remark: Generated from `#/components/schemas/CompoundFilter`.
        public struct CompoundFilter: Codable, Hashable, Sendable {
            /// Type of operation: `and` or `or`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompoundFilter/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case and = "and"
                case or = "or"
            }
            /// Type of operation: `and` or `or`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompoundFilter/type`.
            public var _type: Components.Schemas.CompoundFilter._TypePayload
            /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload`.
            @frozen public enum FiltersPayloadPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/case1`.
                case ComparisonFilter(Components.Schemas.ComparisonFilter)
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/case2`.
                public struct Case2Payload: Codable, Hashable, Sendable {
                    /// A container of undocumented properties.
                    public var additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer
                    /// Creates a new `Case2Payload`.
                    ///
                    /// - Parameters:
                    ///   - additionalProperties: A container of undocumented properties.
                    public init(additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer = .init()) {
                        self.additionalProperties = additionalProperties
                    }
                    public init(from decoder: any Decoder) throws {
                        additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                    }
                    public func encode(to encoder: any Encoder) throws {
                        try encoder.encodeAdditionalProperties(additionalProperties)
                    }
                }
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/case2`.
                case case2(Components.Schemas.CompoundFilter.FiltersPayloadPayload.Case2Payload)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .ComparisonFilter(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .case2(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .ComparisonFilter(value):
                        try value.encode(to: encoder)
                    case let .case2(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompoundFilter/filters`.
            public typealias FiltersPayload = [Components.Schemas.CompoundFilter.FiltersPayloadPayload]
            /// Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompoundFilter/filters`.
            public var filters: Components.Schemas.CompoundFilter.FiltersPayload
            /// Creates a new `CompoundFilter`.
            ///
            /// - Parameters:
            ///   - _type: Type of operation: `and` or `or`.
            ///   - filters: Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
            public init(
                _type: Components.Schemas.CompoundFilter._TypePayload,
                filters: Components.Schemas.CompoundFilter.FiltersPayload
            ) {
                self._type = _type
                self.filters = filters
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case filters
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.CompoundFilter._TypePayload.self,
                    forKey: ._type
                )
                self.filters = try container.decode(
                    Components.Schemas.CompoundFilter.FiltersPayload.self,
                    forKey: .filters
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type",
                    "filters"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/ComputerAction`.
        @frozen public enum ComputerAction: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case1`.
            case Click(Components.Schemas.Click)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case2`.
            case DoubleClick(Components.Schemas.DoubleClick)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case3`.
            case Drag(Components.Schemas.Drag)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case4`.
            case KeyPress(Components.Schemas.KeyPress)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case5`.
            case Move(Components.Schemas.Move)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case6`.
            case Screenshot(Components.Schemas.Screenshot)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case7`.
            case Scroll(Components.Schemas.Scroll)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case8`.
            case _Type(Components.Schemas._Type)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/case9`.
            case Wait(Components.Schemas.Wait)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .Click(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .DoubleClick(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .Drag(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .KeyPress(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .Move(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .Screenshot(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .Scroll(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = ._Type(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .Wait(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .Click(value):
                    try value.encode(to: encoder)
                case let .DoubleClick(value):
                    try value.encode(to: encoder)
                case let .Drag(value):
                    try value.encode(to: encoder)
                case let .KeyPress(value):
                    try value.encode(to: encoder)
                case let .Move(value):
                    try value.encode(to: encoder)
                case let .Screenshot(value):
                    try value.encode(to: encoder)
                case let .Scroll(value):
                    try value.encode(to: encoder)
                case let ._Type(value):
                    try value.encode(to: encoder)
                case let .Wait(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A computer screenshot image used with the computer use tool.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerScreenshotImage`.
        public struct ComputerScreenshotImage: Codable, Hashable, Sendable {
            /// Specifies the event type. For a computer screenshot, this property is 
            /// always set to `computer_screenshot`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerScreenshotImage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computerScreenshot = "computer_screenshot"
            }
            /// Specifies the event type. For a computer screenshot, this property is 
            /// always set to `computer_screenshot`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerScreenshotImage/type`.
            public var _type: Components.Schemas.ComputerScreenshotImage._TypePayload
            /// The URL of the screenshot image.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerScreenshotImage/image_url`.
            public var imageUrl: Swift.String?
            /// The identifier of an uploaded file that contains the screenshot.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerScreenshotImage/file_id`.
            public var fileId: Swift.String?
            /// Creates a new `ComputerScreenshotImage`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a computer screenshot, this property is 
            ///   - imageUrl: The URL of the screenshot image.
            ///   - fileId: The identifier of an uploaded file that contains the screenshot.
            public init(
                _type: Components.Schemas.ComputerScreenshotImage._TypePayload,
                imageUrl: Swift.String? = nil,
                fileId: Swift.String? = nil
            ) {
                self._type = _type
                self.imageUrl = imageUrl
                self.fileId = fileId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case imageUrl = "image_url"
                case fileId = "file_id"
            }
        }
        /// A tool that controls a virtual computer. Learn more about the 
        /// [computer tool](/docs/guides/tools-computer-use).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerTool`.
        public struct ComputerTool: Codable, Hashable, Sendable {
            /// The type of the computer use tool. Always `computer_use_preview`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computerUsePreview = "computer_use_preview"
            }
            /// The type of the computer use tool. Always `computer_use_preview`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/type`.
            public var _type: Components.Schemas.ComputerTool._TypePayload
            /// The width of the computer display.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/display_width`.
            public var displayWidth: Swift.Double
            /// The height of the computer display.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/display_height`.
            public var displayHeight: Swift.Double
            /// The type of computer environment to control.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/environment`.
            @frozen public enum EnvironmentPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mac = "mac"
                case windows = "windows"
                case ubuntu = "ubuntu"
                case browser = "browser"
            }
            /// The type of computer environment to control.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/environment`.
            public var environment: Components.Schemas.ComputerTool.EnvironmentPayload
            /// Creates a new `ComputerTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the computer use tool. Always `computer_use_preview`.
            ///   - displayWidth: The width of the computer display.
            ///   - displayHeight: The height of the computer display.
            ///   - environment: The type of computer environment to control.
            public init(
                _type: Components.Schemas.ComputerTool._TypePayload,
                displayWidth: Swift.Double,
                displayHeight: Swift.Double,
                environment: Components.Schemas.ComputerTool.EnvironmentPayload
            ) {
                self._type = _type
                self.displayWidth = displayWidth
                self.displayHeight = displayHeight
                self.environment = environment
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case displayWidth = "display_width"
                case displayHeight = "display_height"
                case environment
            }
        }
        /// A tool call to a computer use tool. See the 
        /// [computer use guide](/docs/guides/tools-computer-use) for more information.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerToolCall`.
        public struct ComputerToolCall: Codable, Hashable, Sendable {
            /// The type of the computer call. Always `computer_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computerCall = "computer_call"
            }
            /// The type of the computer call. Always `computer_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/type`.
            public var _type: Components.Schemas.ComputerToolCall._TypePayload
            /// The unique ID of the computer call.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/id`.
            public var id: Swift.String
            /// An identifier used when responding to the tool call with output.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/call_id`.
            public var callId: Swift.String
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/action`.
            public var action: Components.Schemas.ComputerAction
            /// The pending safety checks for the computer call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/pending_safety_checks`.
            public var pendingSafetyChecks: [Components.Schemas.ComputerToolCallSafetyCheck]
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/status`.
            public var status: Components.Schemas.ComputerToolCall.StatusPayload
            /// Creates a new `ComputerToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the computer call. Always `computer_call`.
            ///   - id: The unique ID of the computer call.
            ///   - callId: An identifier used when responding to the tool call with output.
            ///   - action:
            ///   - pendingSafetyChecks: The pending safety checks for the computer call.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                _type: Components.Schemas.ComputerToolCall._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                action: Components.Schemas.ComputerAction,
                pendingSafetyChecks: [Components.Schemas.ComputerToolCallSafetyCheck],
                status: Components.Schemas.ComputerToolCall.StatusPayload
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.action = action
                self.pendingSafetyChecks = pendingSafetyChecks
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case action
                case pendingSafetyChecks = "pending_safety_checks"
                case status
            }
        }
        /// The output of a computer tool call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput`.
        public struct ComputerToolCallOutput: Codable, Hashable, Sendable {
            /// The type of the computer tool call output. Always `computer_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computerCallOutput = "computer_call_output"
            }
            /// The type of the computer tool call output. Always `computer_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/type`.
            public var _type: Components.Schemas.ComputerToolCallOutput._TypePayload
            /// The ID of the computer tool call output.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/id`.
            public var id: Swift.String?
            /// The ID of the computer tool call that produced the output.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/call_id`.
            public var callId: Swift.String
            /// The safety checks reported by the API that have been acknowledged by the 
            /// developer.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/acknowledged_safety_checks`.
            public var acknowledgedSafetyChecks: [Components.Schemas.ComputerToolCallSafetyCheck]?
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/output`.
            public var output: Components.Schemas.ComputerScreenshotImage
            /// The status of the message input. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when input items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the message input. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when input items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutput/status`.
            public var status: Components.Schemas.ComputerToolCallOutput.StatusPayload?
            /// Creates a new `ComputerToolCallOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the computer tool call output. Always `computer_call_output`.
            ///   - id: The ID of the computer tool call output.
            ///   - callId: The ID of the computer tool call that produced the output.
            ///   - acknowledgedSafetyChecks: The safety checks reported by the API that have been acknowledged by the 
            ///   - output:
            ///   - status: The status of the message input. One of `in_progress`, `completed`, or
            public init(
                _type: Components.Schemas.ComputerToolCallOutput._TypePayload,
                id: Swift.String? = nil,
                callId: Swift.String,
                acknowledgedSafetyChecks: [Components.Schemas.ComputerToolCallSafetyCheck]? = nil,
                output: Components.Schemas.ComputerScreenshotImage,
                status: Components.Schemas.ComputerToolCallOutput.StatusPayload? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.acknowledgedSafetyChecks = acknowledgedSafetyChecks
                self.output = output
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case acknowledgedSafetyChecks = "acknowledged_safety_checks"
                case output
                case status
            }
        }
        /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource`.
        public struct ComputerToolCallOutputResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource/value1`.
            public var value1: Components.Schemas.ComputerToolCallOutput
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// The unique ID of the computer call tool output.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource/value2/id`.
                public var id: Swift.String
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the computer call tool output.
                public init(id: Swift.String) {
                    self.id = id
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                }
            }
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource/value2`.
            public var value2: Components.Schemas.ComputerToolCallOutputResource.Value2Payload
            /// Creates a new `ComputerToolCallOutputResource`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.ComputerToolCallOutput,
                value2: Components.Schemas.ComputerToolCallOutputResource.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// A pending safety check for the computer call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerToolCallSafetyCheck`.
        public struct ComputerToolCallSafetyCheck: Codable, Hashable, Sendable {
            /// The ID of the pending safety check.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallSafetyCheck/id`.
            public var id: Swift.String
            /// The type of the pending safety check.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallSafetyCheck/code`.
            public var code: Swift.String
            /// Details about the pending safety check.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCallSafetyCheck/message`.
            public var message: Swift.String
            /// Creates a new `ComputerToolCallSafetyCheck`.
            ///
            /// - Parameters:
            ///   - id: The ID of the pending safety check.
            ///   - code: The type of the pending safety check.
            ///   - message: Details about the pending safety check.
            public init(
                id: Swift.String,
                code: Swift.String,
                message: Swift.String
            ) {
                self.id = id
                self.code = code
                self.message = message
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case code
                case message
            }
        }
        /// Multi-modal input and output contents.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Content`.
        @frozen public enum Content: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Content/case1`.
            case InputContent(Components.Schemas.InputContent)
            /// - Remark: Generated from `#/components/schemas/Content/case2`.
            case OutputContent(Components.Schemas.OutputContent)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .InputContent(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .OutputContent(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .InputContent(value):
                    try value.encode(to: encoder)
                case let .OutputContent(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Coordinate`.
        public struct Coordinate: Codable, Hashable, Sendable {
            /// The x-coordinate.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Coordinate/x`.
            public var x: Swift.Int
            /// The y-coordinate.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Coordinate/y`.
            public var y: Swift.Int
            /// Creates a new `Coordinate`.
            ///
            /// - Parameters:
            ///   - x: The x-coordinate.
            ///   - y: The y-coordinate.
            public init(
                x: Swift.Int,
                y: Swift.Int
            ) {
                self.x = x
                self.y = y
            }
            public enum CodingKeys: String, CodingKey {
                case x
                case y
            }
        }
        /// The aggregated costs details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/CostsResult`.
        public struct CostsResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CostsResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_costs_result = "organization.costs.result"
            }
            /// - Remark: Generated from `#/components/schemas/CostsResult/object`.
            public var object: Components.Schemas.CostsResult.ObjectPayload
            /// The monetary value in its associated currency.
            ///
            /// - Remark: Generated from `#/components/schemas/CostsResult/amount`.
            public struct AmountPayload: Codable, Hashable, Sendable {
                /// The numeric value of the cost.
                ///
                /// - Remark: Generated from `#/components/schemas/CostsResult/amount/value`.
                public var value: Swift.Double?
                /// Lowercase ISO-4217 currency e.g. "usd"
                ///
                /// - Remark: Generated from `#/components/schemas/CostsResult/amount/currency`.
                public var currency: Swift.String?
                /// Creates a new `AmountPayload`.
                ///
                /// - Parameters:
                ///   - value: The numeric value of the cost.
                ///   - currency: Lowercase ISO-4217 currency e.g. "usd"
                public init(
                    value: Swift.Double? = nil,
                    currency: Swift.String? = nil
                ) {
                    self.value = value
                    self.currency = currency
                }
                public enum CodingKeys: String, CodingKey {
                    case value
                    case currency
                }
            }
            /// The monetary value in its associated currency.
            ///
            /// - Remark: Generated from `#/components/schemas/CostsResult/amount`.
            public var amount: Components.Schemas.CostsResult.AmountPayload?
            /// When `group_by=line_item`, this field provides the line item of the grouped costs result.
            ///
            /// - Remark: Generated from `#/components/schemas/CostsResult/line_item`.
            public var lineItem: Swift.String?
            /// When `group_by=project_id`, this field provides the project ID of the grouped costs result.
            ///
            /// - Remark: Generated from `#/components/schemas/CostsResult/project_id`.
            public var projectId: Swift.String?
            /// Creates a new `CostsResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - amount: The monetary value in its associated currency.
            ///   - lineItem: When `group_by=line_item`, this field provides the line item of the grouped costs result.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped costs result.
            public init(
                object: Components.Schemas.CostsResult.ObjectPayload,
                amount: Components.Schemas.CostsResult.AmountPayload? = nil,
                lineItem: Swift.String? = nil,
                projectId: Swift.String? = nil
            ) {
                self.object = object
                self.amount = amount
                self.lineItem = lineItem
                self.projectId = projectId
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case amount
                case lineItem = "line_item"
                case projectId = "project_id"
            }
        }
        /// - Remark: Generated from `#/components/schemas/DefaultProjectErrorResponse`.
        public struct DefaultProjectErrorResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/DefaultProjectErrorResponse/code`.
            public var code: Swift.Int
            /// - Remark: Generated from `#/components/schemas/DefaultProjectErrorResponse/message`.
            public var message: Swift.String
            /// Creates a new `DefaultProjectErrorResponse`.
            ///
            /// - Parameters:
            ///   - code:
            ///   - message:
            public init(
                code: Swift.Int,
                message: Swift.String
            ) {
                self.code = code
                self.message = message
            }
            public enum CodingKeys: String, CodingKey {
                case code
                case message
            }
        }
        /// Occurs when a stream ends.
        ///
        /// - Remark: Generated from `#/components/schemas/DoneEvent`.
        public struct DoneEvent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/DoneEvent/event`.
            @frozen public enum EventPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case done = "done"
            }
            /// - Remark: Generated from `#/components/schemas/DoneEvent/event`.
            public var event: Components.Schemas.DoneEvent.EventPayload
            /// - Remark: Generated from `#/components/schemas/DoneEvent/data`.
            @frozen public enum DataPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case _lbrack_done_rbrack_ = "[DONE]"
            }
            /// - Remark: Generated from `#/components/schemas/DoneEvent/data`.
            public var data: Components.Schemas.DoneEvent.DataPayload
            /// Creates a new `DoneEvent`.
            ///
            /// - Parameters:
            ///   - event:
            ///   - data:
            public init(
                event: Components.Schemas.DoneEvent.EventPayload,
                data: Components.Schemas.DoneEvent.DataPayload
            ) {
                self.event = event
                self.data = data
            }
            public enum CodingKeys: String, CodingKey {
                case event
                case data
            }
        }
        /// A double click action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/DoubleClick`.
        public struct DoubleClick: Codable, Hashable, Sendable {
            /// Specifies the event type. For a double click action, this property is 
            /// always set to `double_click`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClick/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case doubleClick = "double_click"
            }
            /// Specifies the event type. For a double click action, this property is 
            /// always set to `double_click`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClick/type`.
            public var _type: Components.Schemas.DoubleClick._TypePayload
            /// The x-coordinate where the double click occurred.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClick/x`.
            public var x: Swift.Int
            /// The y-coordinate where the double click occurred.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClick/y`.
            public var y: Swift.Int
            /// Creates a new `DoubleClick`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a double click action, this property is 
            ///   - x: The x-coordinate where the double click occurred.
            ///   - y: The y-coordinate where the double click occurred.
            public init(
                _type: Components.Schemas.DoubleClick._TypePayload,
                x: Swift.Int,
                y: Swift.Int
            ) {
                self._type = _type
                self.x = x
                self.y = y
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case x
                case y
            }
        }
        /// A drag action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Drag`.
        public struct Drag: Codable, Hashable, Sendable {
            /// Specifies the event type. For a drag action, this property is 
            /// always set to `drag`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Drag/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case drag = "drag"
            }
            /// Specifies the event type. For a drag action, this property is 
            /// always set to `drag`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Drag/type`.
            public var _type: Components.Schemas.Drag._TypePayload
            /// An array of coordinates representing the path of the drag action. Coordinates will appear as an array
            /// of objects, eg
            /// ```
            /// [
            ///   { x: 100, y: 200 },
            ///   { x: 200, y: 300 }
            /// ]
            /// ```
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Drag/path`.
            public var path: [Components.Schemas.Coordinate]
            /// Creates a new `Drag`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a drag action, this property is 
            ///   - path: An array of coordinates representing the path of the drag action. Coordinates will appear as an array
            public init(
                _type: Components.Schemas.Drag._TypePayload,
                path: [Components.Schemas.Coordinate]
            ) {
                self._type = _type
                self.path = path
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
            }
        }
        /// A message input to the model with a role indicating instruction following
        /// hierarchy. Instructions given with the `developer` or `system` role take
        /// precedence over instructions given with the `user` role. Messages with the
        /// `assistant` role are presumed to have been generated by the model in previous
        /// interactions.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/EasyInputMessage`.
        public struct EasyInputMessage: Codable, Hashable, Sendable {
            /// The role of the message input. One of `user`, `assistant`, `system`, or
            /// `developer`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/role`.
            @frozen public enum RolePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case user = "user"
                case assistant = "assistant"
                case system = "system"
                case developer = "developer"
            }
            /// The role of the message input. One of `user`, `assistant`, `system`, or
            /// `developer`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/role`.
            public var role: Components.Schemas.EasyInputMessage.RolePayload
            /// Text, image, or audio input to the model, used to generate a response.
            /// Can also contain previous assistant responses.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/content`.
            @frozen public enum ContentPayload: Codable, Hashable, Sendable {
                /// A text input to the model.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/EasyInputMessage/content/case1`.
                case case1(Swift.String)
                /// - Remark: Generated from `#/components/schemas/EasyInputMessage/content/case2`.
                case InputMessageContentList(Components.Schemas.InputMessageContentList)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .InputMessageContentList(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .InputMessageContentList(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// Text, image, or audio input to the model, used to generate a response.
            /// Can also contain previous assistant responses.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/content`.
            public var content: Components.Schemas.EasyInputMessage.ContentPayload
            /// The type of the message input. Always `message`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case message = "message"
            }
            /// The type of the message input. Always `message`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/type`.
            public var _type: Components.Schemas.EasyInputMessage._TypePayload?
            /// Creates a new `EasyInputMessage`.
            ///
            /// - Parameters:
            ///   - role: The role of the message input. One of `user`, `assistant`, `system`, or
            ///   - content: Text, image, or audio input to the model, used to generate a response.
            ///   - _type: The type of the message input. Always `message`.
            public init(
                role: Components.Schemas.EasyInputMessage.RolePayload,
                content: Components.Schemas.EasyInputMessage.ContentPayload,
                _type: Components.Schemas.EasyInputMessage._TypePayload? = nil
            ) {
                self.role = role
                self.content = content
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case role
                case content
                case _type = "type"
            }
        }
        /// Represents an embedding vector returned by embedding endpoint.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Embedding`.
        public struct Embedding: Codable, Hashable, Sendable {
            /// The index of the embedding in the list of embeddings.
            ///
            /// - Remark: Generated from `#/components/schemas/Embedding/index`.
            public var index: Swift.Int
            /// The embedding vector, which is a list of floats. The length of vector depends on the model as listed in the [embedding guide](/docs/guides/embeddings).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Embedding/embedding`.
            public var embedding: [Swift.Double]
            /// The object type, which is always "embedding".
            ///
            /// - Remark: Generated from `#/components/schemas/Embedding/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case embedding = "embedding"
            }
            /// The object type, which is always "embedding".
            ///
            /// - Remark: Generated from `#/components/schemas/Embedding/object`.
            public var object: Components.Schemas.Embedding.ObjectPayload
            /// Creates a new `Embedding`.
            ///
            /// - Parameters:
            ///   - index: The index of the embedding in the list of embeddings.
            ///   - embedding: The embedding vector, which is a list of floats. The length of vector depends on the model as listed in the [embedding guide](/docs/guides/embeddings).
            ///   - object: The object type, which is always "embedding".
            public init(
                index: Swift.Int,
                embedding: [Swift.Double],
                object: Components.Schemas.Embedding.ObjectPayload
            ) {
                self.index = index
                self.embedding = embedding
                self.object = object
            }
            public enum CodingKeys: String, CodingKey {
                case index
                case embedding
                case object
            }
        }
        /// - Remark: Generated from `#/components/schemas/Error`.
        public struct _Error: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Error/code`.
            public var code: Swift.String?
            /// - Remark: Generated from `#/components/schemas/Error/message`.
            public var message: Swift.String
            /// - Remark: Generated from `#/components/schemas/Error/param`.
            public var param: Swift.String?
            /// - Remark: Generated from `#/components/schemas/Error/type`.
            public var _type: Swift.String
            /// Creates a new `_Error`.
            ///
            /// - Parameters:
            ///   - code:
            ///   - message:
            ///   - param:
            ///   - _type:
            public init(
                code: Swift.String? = nil,
                message: Swift.String,
                param: Swift.String? = nil,
                _type: Swift.String
            ) {
                self.code = code
                self.message = message
                self.param = param
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case code
                case message
                case param
                case _type = "type"
            }
        }
        /// Occurs when an [error](/docs/guides/error-codes#api-errors) occurs. This can happen due to an internal server error or a timeout.
        ///
        /// - Remark: Generated from `#/components/schemas/ErrorEvent`.
        public struct ErrorEvent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ErrorEvent/event`.
            @frozen public enum EventPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case error = "error"
            }
            /// - Remark: Generated from `#/components/schemas/ErrorEvent/event`.
            public var event: Components.Schemas.ErrorEvent.EventPayload
            /// - Remark: Generated from `#/components/schemas/ErrorEvent/data`.
            public var data: Components.Schemas._Error
            /// Creates a new `ErrorEvent`.
            ///
            /// - Parameters:
            ///   - event:
            ///   - data:
            public init(
                event: Components.Schemas.ErrorEvent.EventPayload,
                data: Components.Schemas._Error
            ) {
                self.event = event
                self.data = data
            }
            public enum CodingKeys: String, CodingKey {
                case event
                case data
            }
        }
        /// - Remark: Generated from `#/components/schemas/ErrorResponse`.
        public struct ErrorResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ErrorResponse/error`.
            public var error: Components.Schemas._Error
            /// Creates a new `ErrorResponse`.
            ///
            /// - Parameters:
            ///   - error:
            public init(error: Components.Schemas._Error) {
                self.error = error
            }
            public enum CodingKeys: String, CodingKey {
                case error
            }
        }
        /// A citation to a file.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FileCitation`.
        public struct FileCitation: Codable, Hashable, Sendable {
            /// The type of the file citation. Always `file_citation`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileCitation = "file_citation"
            }
            /// The type of the file citation. Always `file_citation`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitation/type`.
            public var _type: Components.Schemas.FileCitation._TypePayload
            /// The index of the file in the list of files.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitation/index`.
            public var index: Swift.Int
            /// The ID of the file.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitation/file_id`.
            public var fileId: Swift.String
            /// Creates a new `FileCitation`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file citation. Always `file_citation`.
            ///   - index: The index of the file in the list of files.
            ///   - fileId: The ID of the file.
            public init(
                _type: Components.Schemas.FileCitation._TypePayload,
                index: Swift.Int,
                fileId: Swift.String
            ) {
                self._type = _type
                self.index = index
                self.fileId = fileId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case index
                case fileId = "file_id"
            }
        }
        /// A path to a file.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FilePath`.
        public struct FilePath: Codable, Hashable, Sendable {
            /// The type of the file path. Always `file_path`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FilePath/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case filePath = "file_path"
            }
            /// The type of the file path. Always `file_path`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FilePath/type`.
            public var _type: Components.Schemas.FilePath._TypePayload
            /// The ID of the file.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FilePath/file_id`.
            public var fileId: Swift.String
            /// The index of the file in the list of files.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FilePath/index`.
            public var index: Swift.Int
            /// Creates a new `FilePath`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file path. Always `file_path`.
            ///   - fileId: The ID of the file.
            ///   - index: The index of the file in the list of files.
            public init(
                _type: Components.Schemas.FilePath._TypePayload,
                fileId: Swift.String,
                index: Swift.Int
            ) {
                self._type = _type
                self.fileId = fileId
                self.index = index
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileId = "file_id"
                case index
            }
        }
        /// The ranker to use for the file search. If not specified will use the `auto` ranker.
        ///
        /// - Remark: Generated from `#/components/schemas/FileSearchRanker`.
        @frozen public enum FileSearchRanker: String, Codable, Hashable, Sendable, CaseIterable {
            case auto = "auto"
            case default20240821 = "default_2024_08_21"
        }
        /// The ranking options for the file search. If not specified, the file search tool will use the `auto` ranker and a score_threshold of 0.
        ///
        /// See the [file search tool documentation](/docs/assistants/tools/file-search#customizing-file-search-settings) for more information.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FileSearchRankingOptions`.
        public struct FileSearchRankingOptions: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FileSearchRankingOptions/ranker`.
            public var ranker: Components.Schemas.FileSearchRanker?
            /// The score threshold for the file search. All values must be a floating point number between 0 and 1.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchRankingOptions/score_threshold`.
            public var scoreThreshold: Swift.Double
            /// Creates a new `FileSearchRankingOptions`.
            ///
            /// - Parameters:
            ///   - ranker:
            ///   - scoreThreshold: The score threshold for the file search. All values must be a floating point number between 0 and 1.
            public init(
                ranker: Components.Schemas.FileSearchRanker? = nil,
                scoreThreshold: Swift.Double
            ) {
                self.ranker = ranker
                self.scoreThreshold = scoreThreshold
            }
            public enum CodingKeys: String, CodingKey {
                case ranker
                case scoreThreshold = "score_threshold"
            }
        }
        /// A tool that searches for relevant content from uploaded files.
        /// Learn more about the [file search tool](/docs/guides/tools-file-search).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FileSearchTool`.
        public struct FileSearchTool: Codable, Hashable, Sendable {
            /// The type of the file search tool. Always `file_search`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileSearch = "file_search"
            }
            /// The type of the file search tool. Always `file_search`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/type`.
            public var _type: Components.Schemas.FileSearchTool._TypePayload
            /// The IDs of the vector stores to search.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/vector_store_ids`.
            public var vectorStoreIds: [Swift.String]
            /// The maximum number of results to return. This number should be between 1 
            /// and 50 inclusive.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/max_num_results`.
            public var maxNumResults: Swift.Int?
            /// A filter to apply based on file attributes.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters`.
            @frozen public enum FiltersPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters/case1`.
                case ComparisonFilter(Components.Schemas.ComparisonFilter)
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters/case2`.
                case CompoundFilter(Components.Schemas.CompoundFilter)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .ComparisonFilter(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .CompoundFilter(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .ComparisonFilter(value):
                        try value.encode(to: encoder)
                    case let .CompoundFilter(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// A filter to apply based on file attributes.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters`.
            public var filters: Components.Schemas.FileSearchTool.FiltersPayload?
            /// Ranking options for search.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options`.
            public struct RankingOptionsPayload: Codable, Hashable, Sendable {
                /// The ranker to use for the file search.
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options/ranker`.
                @frozen public enum RankerPayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case auto = "auto"
                    case default20241115 = "default-2024-11-15"
                }
                /// The ranker to use for the file search.
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options/ranker`.
                public var ranker: Components.Schemas.FileSearchTool.RankingOptionsPayload.RankerPayload?
                /// The score threshold for the file search, a number between 0 and 1.
                /// Numbers closer to 1 will attempt to return only the most relevant
                /// results, but may return fewer results.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options/score_threshold`.
                public var scoreThreshold: Swift.Double?
                /// Creates a new `RankingOptionsPayload`.
                ///
                /// - Parameters:
                ///   - ranker: The ranker to use for the file search.
                ///   - scoreThreshold: The score threshold for the file search, a number between 0 and 1.
                public init(
                    ranker: Components.Schemas.FileSearchTool.RankingOptionsPayload.RankerPayload? = nil,
                    scoreThreshold: Swift.Double? = nil
                ) {
                    self.ranker = ranker
                    self.scoreThreshold = scoreThreshold
                }
                public enum CodingKeys: String, CodingKey {
                    case ranker
                    case scoreThreshold = "score_threshold"
                }
                public init(from decoder: any Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.ranker = try container.decodeIfPresent(
                        Components.Schemas.FileSearchTool.RankingOptionsPayload.RankerPayload.self,
                        forKey: .ranker
                    )
                    self.scoreThreshold = try container.decodeIfPresent(
                        Swift.Double.self,
                        forKey: .scoreThreshold
                    )
                    try decoder.ensureNoAdditionalProperties(knownKeys: [
                        "ranker",
                        "score_threshold"
                    ])
                }
            }
            /// Ranking options for search.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options`.
            public var rankingOptions: Components.Schemas.FileSearchTool.RankingOptionsPayload?
            /// Creates a new `FileSearchTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file search tool. Always `file_search`.
            ///   - vectorStoreIds: The IDs of the vector stores to search.
            ///   - maxNumResults: The maximum number of results to return. This number should be between 1 
            ///   - filters: A filter to apply based on file attributes.
            ///   - rankingOptions: Ranking options for search.
            public init(
                _type: Components.Schemas.FileSearchTool._TypePayload,
                vectorStoreIds: [Swift.String],
                maxNumResults: Swift.Int? = nil,
                filters: Components.Schemas.FileSearchTool.FiltersPayload? = nil,
                rankingOptions: Components.Schemas.FileSearchTool.RankingOptionsPayload? = nil
            ) {
                self._type = _type
                self.vectorStoreIds = vectorStoreIds
                self.maxNumResults = maxNumResults
                self.filters = filters
                self.rankingOptions = rankingOptions
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case vectorStoreIds = "vector_store_ids"
                case maxNumResults = "max_num_results"
                case filters
                case rankingOptions = "ranking_options"
            }
        }
        /// The results of a file search tool call. See the 
        /// [file search guide](/docs/guides/tools-file-search) for more information.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FileSearchToolCall`.
        public struct FileSearchToolCall: Codable, Hashable, Sendable {
            /// The unique ID of the file search tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/id`.
            public var id: Swift.String
            /// The type of the file search tool call. Always `file_search_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileSearchCall = "file_search_call"
            }
            /// The type of the file search tool call. Always `file_search_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/type`.
            public var _type: Components.Schemas.FileSearchToolCall._TypePayload
            /// The status of the file search tool call. One of `in_progress`, 
            /// `searching`, `incomplete` or `failed`,
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case searching = "searching"
                case completed = "completed"
                case incomplete = "incomplete"
                case failed = "failed"
            }
            /// The status of the file search tool call. One of `in_progress`, 
            /// `searching`, `incomplete` or `failed`,
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/status`.
            public var status: Components.Schemas.FileSearchToolCall.StatusPayload
            /// The queries used to search for files.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/queries`.
            public var queries: [Swift.String]
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/ResultsPayload`.
            public struct ResultsPayloadPayload: Codable, Hashable, Sendable {
                /// The unique ID of the file.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/ResultsPayload/file_id`.
                public var fileId: Swift.String?
                /// The text that was retrieved from the file.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/ResultsPayload/text`.
                public var text: Swift.String?
                /// The name of the file.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/ResultsPayload/filename`.
                public var filename: Swift.String?
                /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/ResultsPayload/attributes`.
                public var attributes: Components.Schemas.VectorStoreFileAttributes?
                /// The relevance score of the file - a value between 0 and 1.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/ResultsPayload/score`.
                public var score: Swift.Float?
                /// Creates a new `ResultsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - fileId: The unique ID of the file.
                ///   - text: The text that was retrieved from the file.
                ///   - filename: The name of the file.
                ///   - attributes:
                ///   - score: The relevance score of the file - a value between 0 and 1.
                public init(
                    fileId: Swift.String? = nil,
                    text: Swift.String? = nil,
                    filename: Swift.String? = nil,
                    attributes: Components.Schemas.VectorStoreFileAttributes? = nil,
                    score: Swift.Float? = nil
                ) {
                    self.fileId = fileId
                    self.text = text
                    self.filename = filename
                    self.attributes = attributes
                    self.score = score
                }
                public enum CodingKeys: String, CodingKey {
                    case fileId = "file_id"
                    case text
                    case filename
                    case attributes
                    case score
                }
            }
            /// The results of the file search tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/results`.
            public typealias ResultsPayload = [Components.Schemas.FileSearchToolCall.ResultsPayloadPayload]
            /// The results of the file search tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/results`.
            public var results: Components.Schemas.FileSearchToolCall.ResultsPayload?
            /// Creates a new `FileSearchToolCall`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the file search tool call.
            ///   - _type: The type of the file search tool call. Always `file_search_call`.
            ///   - status: The status of the file search tool call. One of `in_progress`, 
            ///   - queries: The queries used to search for files.
            ///   - results: The results of the file search tool call.
            public init(
                id: Swift.String,
                _type: Components.Schemas.FileSearchToolCall._TypePayload,
                status: Components.Schemas.FileSearchToolCall.StatusPayload,
                queries: [Swift.String],
                results: Components.Schemas.FileSearchToolCall.ResultsPayload? = nil
            ) {
                self.id = id
                self._type = _type
                self.status = status
                self.queries = queries
                self.results = results
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case status
                case queries
                case results
            }
        }
        /// - Remark: Generated from `#/components/schemas/FunctionObject`.
        public struct FunctionObject: Codable, Hashable, Sendable {
            /// A description of what the function does, used by the model to choose when and how to call the function.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionObject/description`.
            public var description: Swift.String?
            /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionObject/name`.
            public var name: Swift.String
            /// - Remark: Generated from `#/components/schemas/FunctionObject/parameters`.
            public var parameters: Components.Schemas.FunctionParameters?
            /// Whether to enable strict schema adherence when generating the function call. If set to true, the model will follow the exact schema defined in the `parameters` field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn more about Structured Outputs in the [function calling guide](docs/guides/function-calling).
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionObject/strict`.
            public var strict: Swift.Bool?
            /// Creates a new `FunctionObject`.
            ///
            /// - Parameters:
            ///   - description: A description of what the function does, used by the model to choose when and how to call the function.
            ///   - name: The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
            ///   - parameters:
            ///   - strict: Whether to enable strict schema adherence when generating the function call. If set to true, the model will follow the exact schema defined in the `parameters` field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn more about Structured Outputs in the [function calling guide](docs/guides/function-calling).
            public init(
                description: Swift.String? = nil,
                name: Swift.String,
                parameters: Components.Schemas.FunctionParameters? = nil,
                strict: Swift.Bool? = nil
            ) {
                self.description = description
                self.name = name
                self.parameters = parameters
                self.strict = strict
            }
            public enum CodingKeys: String, CodingKey {
                case description
                case name
                case parameters
                case strict
            }
        }
        /// The parameters the functions accepts, described as a JSON Schema object. See the [guide](/docs/guides/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format. 
        ///
        /// Omitting `parameters` defines a function with an empty parameter list.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionParameters`.
        public struct FunctionParameters: Codable, Hashable, Sendable {
            /// A container of undocumented properties.
            public var additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer
            /// Creates a new `FunctionParameters`.
            ///
            /// - Parameters:
            ///   - additionalProperties: A container of undocumented properties.
            public init(additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer = .init()) {
                self.additionalProperties = additionalProperties
            }
            public init(from decoder: any Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeAdditionalProperties(additionalProperties)
            }
        }
        /// Defines a function in your own code the model can choose to call. Learn more
        /// about [function calling](/docs/guides/function-calling).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionTool`.
        public struct FunctionTool: Codable, Hashable, Sendable {
            /// The type of the function tool. Always `function`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case function = "function"
            }
            /// The type of the function tool. Always `function`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/type`.
            public var _type: Components.Schemas.FunctionTool._TypePayload
            /// The name of the function to call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/name`.
            public var name: Swift.String
            /// A description of the function. Used by the model to determine whether
            /// or not to call the function.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/description`.
            public var description: Swift.String?
            /// A JSON schema object describing the parameters of the function.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters`.
            public struct ParametersPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                public var additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer
                /// Creates a new `ParametersPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                public init(additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer = .init()) {
                    self.additionalProperties = additionalProperties
                }
                public init(from decoder: any Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                public func encode(to encoder: any Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// A JSON schema object describing the parameters of the function.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters`.
            public var parameters: Components.Schemas.FunctionTool.ParametersPayload
            /// Whether to enforce strict parameter validation. Default `true`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/strict`.
            public var strict: Swift.Bool
            /// Creates a new `FunctionTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the function tool. Always `function`.
            ///   - name: The name of the function to call.
            ///   - description: A description of the function. Used by the model to determine whether
            ///   - parameters: A JSON schema object describing the parameters of the function.
            ///   - strict: Whether to enforce strict parameter validation. Default `true`.
            public init(
                _type: Components.Schemas.FunctionTool._TypePayload,
                name: Swift.String,
                description: Swift.String? = nil,
                parameters: Components.Schemas.FunctionTool.ParametersPayload,
                strict: Swift.Bool
            ) {
                self._type = _type
                self.name = name
                self.description = description
                self.parameters = parameters
                self.strict = strict
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case name
                case description
                case parameters
                case strict
            }
        }
        /// A tool call to run a function. See the 
        /// [function calling guide](/docs/guides/function-calling) for more information.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionToolCall`.
        public struct FunctionToolCall: Codable, Hashable, Sendable {
            /// The unique ID of the function tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/id`.
            public var id: Swift.String?
            /// The type of the function tool call. Always `function_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case functionCall = "function_call"
            }
            /// The type of the function tool call. Always `function_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/type`.
            public var _type: Components.Schemas.FunctionToolCall._TypePayload
            /// The unique ID of the function tool call generated by the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/call_id`.
            public var callId: Swift.String
            /// The name of the function to run.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/name`.
            public var name: Swift.String
            /// A JSON string of the arguments to pass to the function.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/arguments`.
            public var arguments: Swift.String
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/status`.
            public var status: Components.Schemas.FunctionToolCall.StatusPayload?
            /// Creates a new `FunctionToolCall`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the function tool call.
            ///   - _type: The type of the function tool call. Always `function_call`.
            ///   - callId: The unique ID of the function tool call generated by the model.
            ///   - name: The name of the function to run.
            ///   - arguments: A JSON string of the arguments to pass to the function.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                id: Swift.String? = nil,
                _type: Components.Schemas.FunctionToolCall._TypePayload,
                callId: Swift.String,
                name: Swift.String,
                arguments: Swift.String,
                status: Components.Schemas.FunctionToolCall.StatusPayload? = nil
            ) {
                self.id = id
                self._type = _type
                self.callId = callId
                self.name = name
                self.arguments = arguments
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case callId = "call_id"
                case name
                case arguments
                case status
            }
        }
        /// The output of a function tool call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput`.
        public struct FunctionToolCallOutput: Codable, Hashable, Sendable {
            /// The unique ID of the function tool call output. Populated when this item
            /// is returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/id`.
            public var id: Swift.String?
            /// The type of the function tool call output. Always `function_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case functionCallOutput = "function_call_output"
            }
            /// The type of the function tool call output. Always `function_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/type`.
            public var _type: Components.Schemas.FunctionToolCallOutput._TypePayload
            /// The unique ID of the function tool call generated by the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/call_id`.
            public var callId: Swift.String
            /// A JSON string of the output of the function tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/output`.
            public var output: Swift.String
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/status`.
            public var status: Components.Schemas.FunctionToolCallOutput.StatusPayload?
            /// Creates a new `FunctionToolCallOutput`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the function tool call output. Populated when this item
            ///   - _type: The type of the function tool call output. Always `function_call_output`.
            ///   - callId: The unique ID of the function tool call generated by the model.
            ///   - output: A JSON string of the output of the function tool call.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                id: Swift.String? = nil,
                _type: Components.Schemas.FunctionToolCallOutput._TypePayload,
                callId: Swift.String,
                output: Swift.String,
                status: Components.Schemas.FunctionToolCallOutput.StatusPayload? = nil
            ) {
                self.id = id
                self._type = _type
                self.callId = callId
                self.output = output
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case callId = "call_id"
                case output
                case status
            }
        }
        /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource`.
        public struct FunctionToolCallOutputResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource/value1`.
            public var value1: Components.Schemas.FunctionToolCallOutput
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// The unique ID of the function call tool output.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource/value2/id`.
                public var id: Swift.String
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the function call tool output.
                public init(id: Swift.String) {
                    self.id = id
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource/value2`.
            public var value2: Components.Schemas.FunctionToolCallOutputResource.Value2Payload
            /// Creates a new `FunctionToolCallOutputResource`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.FunctionToolCallOutput,
                value2: Components.Schemas.FunctionToolCallOutputResource.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource`.
        public struct FunctionToolCallResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource/value1`.
            public var value1: Components.Schemas.FunctionToolCall
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// The unique ID of the function tool call.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource/value2/id`.
                public var id: Swift.String
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the function tool call.
                public init(id: Swift.String) {
                    self.id = id
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource/value2`.
            public var value2: Components.Schemas.FunctionToolCallResource.Value2Payload
            /// Creates a new `FunctionToolCallResource`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.FunctionToolCall,
                value2: Components.Schemas.FunctionToolCallResource.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// Represents the url or the content of an image generated by the OpenAI API.
        ///
        /// - Remark: Generated from `#/components/schemas/Image`.
        public struct Image: Codable, Hashable, Sendable {
            /// The base64-encoded JSON of the generated image, if `response_format` is `b64_json`.
            ///
            /// - Remark: Generated from `#/components/schemas/Image/b64_json`.
            public var b64Json: Swift.String?
            /// The URL of the generated image, if `response_format` is `url` (default).
            ///
            /// - Remark: Generated from `#/components/schemas/Image/url`.
            public var url: Swift.String?
            /// The prompt that was used to generate the image, if there was any revision to the prompt.
            ///
            /// - Remark: Generated from `#/components/schemas/Image/revised_prompt`.
            public var revisedPrompt: Swift.String?
            /// Creates a new `Image`.
            ///
            /// - Parameters:
            ///   - b64Json: The base64-encoded JSON of the generated image, if `response_format` is `b64_json`.
            ///   - url: The URL of the generated image, if `response_format` is `url` (default).
            ///   - revisedPrompt: The prompt that was used to generate the image, if there was any revision to the prompt.
            public init(
                b64Json: Swift.String? = nil,
                url: Swift.String? = nil,
                revisedPrompt: Swift.String? = nil
            ) {
                self.b64Json = b64Json
                self.url = url
                self.revisedPrompt = revisedPrompt
            }
            public enum CodingKeys: String, CodingKey {
                case b64Json = "b64_json"
                case url
                case revisedPrompt = "revised_prompt"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ImagesResponse`.
        public struct ImagesResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ImagesResponse/created`.
            public var created: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ImagesResponse/data`.
            public var data: [Components.Schemas.Image]
            /// Creates a new `ImagesResponse`.
            ///
            /// - Parameters:
            ///   - created:
            ///   - data:
            public init(
                created: Swift.Int,
                data: [Components.Schemas.Image]
            ) {
                self.created = created
                self.data = data
            }
            public enum CodingKeys: String, CodingKey {
                case created
                case data
            }
        }
        /// Specify additional output data to include in the model response. Currently
        /// supported values are:
        /// - `file_search_call.results`: Include the search results of
        ///   the file search tool call.
        /// - `message.input_image.image_url`: Include image urls from the input message.
        /// - `computer_call_output.output.image_url`: Include image urls from the computer call output.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Includable`.
        @frozen public enum Includable: String, Codable, Hashable, Sendable, CaseIterable {
            case fileSearchCall_results = "file_search_call.results"
            case message_inputImage_imageUrl = "message.input_image.image_url"
            case computerCallOutput_output_imageUrl = "computer_call_output.output.image_url"
        }
        /// An audio input to the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/InputAudio`.
        public struct InputAudio: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_audio`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputAudio/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputAudio = "input_audio"
            }
            /// The type of the input item. Always `input_audio`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputAudio/type`.
            public var _type: Components.Schemas.InputAudio._TypePayload
            /// Base64-encoded audio data.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputAudio/data`.
            public var data: Swift.String
            /// The format of the audio data. Currently supported formats are `mp3` and
            /// `wav`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputAudio/format`.
            @frozen public enum FormatPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mp3 = "mp3"
                case wav = "wav"
            }
            /// The format of the audio data. Currently supported formats are `mp3` and
            /// `wav`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputAudio/format`.
            public var format: Components.Schemas.InputAudio.FormatPayload
            /// Creates a new `InputAudio`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_audio`.
            ///   - data: Base64-encoded audio data.
            ///   - format: The format of the audio data. Currently supported formats are `mp3` and
            public init(
                _type: Components.Schemas.InputAudio._TypePayload,
                data: Swift.String,
                format: Components.Schemas.InputAudio.FormatPayload
            ) {
                self._type = _type
                self.data = data
                self.format = format
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case data
                case format
            }
        }
        /// - Remark: Generated from `#/components/schemas/InputContent`.
        @frozen public enum InputContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/InputContent/case1`.
            case InputText(Components.Schemas.InputText)
            /// - Remark: Generated from `#/components/schemas/InputContent/case2`.
            case InputImage(Components.Schemas.InputImage)
            /// - Remark: Generated from `#/components/schemas/InputContent/case3`.
            case InputFile(Components.Schemas.InputFile)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .InputText(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .InputImage(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .InputFile(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .InputText(value):
                    try value.encode(to: encoder)
                case let .InputImage(value):
                    try value.encode(to: encoder)
                case let .InputFile(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A file input to the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/InputFile`.
        public struct InputFile: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_file`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFile/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputFile = "input_file"
            }
            /// The type of the input item. Always `input_file`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFile/type`.
            public var _type: Components.Schemas.InputFile._TypePayload
            /// The ID of the file to be sent to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFile/file_id`.
            public var fileId: Swift.String?
            /// The name of the file to be sent to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFile/filename`.
            public var filename: Swift.String?
            /// The content of the file to be sent to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFile/file_data`.
            public var fileData: Swift.String?
            /// Creates a new `InputFile`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_file`.
            ///   - fileId: The ID of the file to be sent to the model.
            ///   - filename: The name of the file to be sent to the model.
            ///   - fileData: The content of the file to be sent to the model.
            public init(
                _type: Components.Schemas.InputFile._TypePayload,
                fileId: Swift.String? = nil,
                filename: Swift.String? = nil,
                fileData: Swift.String? = nil
            ) {
                self._type = _type
                self.fileId = fileId
                self.filename = filename
                self.fileData = fileData
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileId = "file_id"
                case filename
                case fileData = "file_data"
            }
        }
        /// An image input to the model. Learn about [image inputs](/docs/guides/vision).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/InputImage`.
        public struct InputImage: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_image`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputImage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputImage = "input_image"
            }
            /// The type of the input item. Always `input_image`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputImage/type`.
            public var _type: Components.Schemas.InputImage._TypePayload
            /// The URL of the image to be sent to the model. A fully qualified URL or
            /// base64 encoded image in a data URL.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputImage/image_url`.
            public var imageUrl: Swift.String?
            /// The ID of the file to be sent to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputImage/file_id`.
            public var fileId: Swift.String?
            /// The detail level of the image to be sent to the model. One of `high`,
            /// `low`, or `auto`. Defaults to `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputImage/detail`.
            @frozen public enum DetailPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case high = "high"
                case low = "low"
                case auto = "auto"
            }
            /// The detail level of the image to be sent to the model. One of `high`,
            /// `low`, or `auto`. Defaults to `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputImage/detail`.
            public var detail: Components.Schemas.InputImage.DetailPayload
            /// Creates a new `InputImage`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_image`.
            ///   - imageUrl: The URL of the image to be sent to the model. A fully qualified URL or
            ///   - fileId: The ID of the file to be sent to the model.
            ///   - detail: The detail level of the image to be sent to the model. One of `high`,
            public init(
                _type: Components.Schemas.InputImage._TypePayload,
                imageUrl: Swift.String? = nil,
                fileId: Swift.String? = nil,
                detail: Components.Schemas.InputImage.DetailPayload
            ) {
                self._type = _type
                self.imageUrl = imageUrl
                self.fileId = fileId
                self.detail = detail
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case imageUrl = "image_url"
                case fileId = "file_id"
                case detail
            }
        }
        /// - Remark: Generated from `#/components/schemas/InputItem`.
        @frozen public enum InputItem: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/InputItem/EasyInputMessage`.
            case easyInputMessage(Components.Schemas.EasyInputMessage)
            /// - Remark: Generated from `#/components/schemas/InputItem/Item`.
            case item(Components.Schemas.Item)
            /// - Remark: Generated from `#/components/schemas/InputItem/ItemReference`.
            case itemReference(Components.Schemas.ItemReference)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "EasyInputMessage", "#/components/schemas/EasyInputMessage":
                    self = .easyInputMessage(try .init(from: decoder))
                case "Item", "#/components/schemas/Item":
                    self = .item(try .init(from: decoder))
                case "ItemReference", "#/components/schemas/ItemReference":
                    self = .itemReference(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .easyInputMessage(value):
                    try value.encode(to: encoder)
                case let .item(value):
                    try value.encode(to: encoder)
                case let .itemReference(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A message input to the model with a role indicating instruction following
        /// hierarchy. Instructions given with the `developer` or `system` role take
        /// precedence over instructions given with the `user` role.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/InputMessage`.
        public struct InputMessage: Codable, Hashable, Sendable {
            /// The type of the message input. Always set to `message`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputMessage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case message = "message"
            }
            /// The type of the message input. Always set to `message`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputMessage/type`.
            public var _type: Components.Schemas.InputMessage._TypePayload?
            /// The role of the message input. One of `user`, `system`, or `developer`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputMessage/role`.
            @frozen public enum RolePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case user = "user"
                case system = "system"
                case developer = "developer"
            }
            /// The role of the message input. One of `user`, `system`, or `developer`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputMessage/role`.
            public var role: Components.Schemas.InputMessage.RolePayload
            /// The status of item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputMessage/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputMessage/status`.
            public var status: Components.Schemas.InputMessage.StatusPayload?
            /// - Remark: Generated from `#/components/schemas/InputMessage/content`.
            public var content: Components.Schemas.InputMessageContentList
            /// Creates a new `InputMessage`.
            ///
            /// - Parameters:
            ///   - _type: The type of the message input. Always set to `message`.
            ///   - role: The role of the message input. One of `user`, `system`, or `developer`.
            ///   - status: The status of item. One of `in_progress`, `completed`, or
            ///   - content:
            public init(
                _type: Components.Schemas.InputMessage._TypePayload? = nil,
                role: Components.Schemas.InputMessage.RolePayload,
                status: Components.Schemas.InputMessage.StatusPayload? = nil,
                content: Components.Schemas.InputMessageContentList
            ) {
                self._type = _type
                self.role = role
                self.status = status
                self.content = content
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case role
                case status
                case content
            }
        }
        /// A list of one or many input items to the model, containing different content 
        /// types.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/InputMessageContentList`.
        public typealias InputMessageContentList = [Components.Schemas.InputContent]
        /// - Remark: Generated from `#/components/schemas/InputMessageResource`.
        public struct InputMessageResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/InputMessageResource/value1`.
            public var value1: Components.Schemas.InputMessage
            /// - Remark: Generated from `#/components/schemas/InputMessageResource/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// The unique ID of the message input.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/InputMessageResource/value2/id`.
                public var id: Swift.String
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the message input.
                public init(id: Swift.String) {
                    self.id = id
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                }
            }
            /// - Remark: Generated from `#/components/schemas/InputMessageResource/value2`.
            public var value2: Components.Schemas.InputMessageResource.Value2Payload
            /// Creates a new `InputMessageResource`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.InputMessage,
                value2: Components.Schemas.InputMessageResource.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// A text input to the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/InputText`.
        public struct InputText: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_text`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputText/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputText = "input_text"
            }
            /// The type of the input item. Always `input_text`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputText/type`.
            public var _type: Components.Schemas.InputText._TypePayload
            /// The text input to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputText/text`.
            public var text: Swift.String
            /// Creates a new `InputText`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_text`.
            ///   - text: The text input to the model.
            public init(
                _type: Components.Schemas.InputText._TypePayload,
                text: Swift.String
            ) {
                self._type = _type
                self.text = text
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
            }
        }
        /// Content item used to generate a response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Item`.
        @frozen public enum Item: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Item/InputMessage`.
            case inputMessage(Components.Schemas.InputMessage)
            /// - Remark: Generated from `#/components/schemas/Item/OutputMessage`.
            case outputMessage(Components.Schemas.OutputMessage)
            /// - Remark: Generated from `#/components/schemas/Item/FileSearchToolCall`.
            case fileSearchToolCall(Components.Schemas.FileSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/ComputerToolCall`.
            case computerToolCall(Components.Schemas.ComputerToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/ComputerToolCallOutput`.
            case computerToolCallOutput(Components.Schemas.ComputerToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/Item/WebSearchToolCall`.
            case webSearchToolCall(Components.Schemas.WebSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/FunctionToolCall`.
            case functionToolCall(Components.Schemas.FunctionToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/FunctionToolCallOutput`.
            case functionToolCallOutput(Components.Schemas.FunctionToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/Item/ReasoningItem`.
            case reasoningItem(Components.Schemas.ReasoningItem)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "InputMessage", "#/components/schemas/InputMessage":
                    self = .inputMessage(try .init(from: decoder))
                case "OutputMessage", "#/components/schemas/OutputMessage":
                    self = .outputMessage(try .init(from: decoder))
                case "FileSearchToolCall", "#/components/schemas/FileSearchToolCall":
                    self = .fileSearchToolCall(try .init(from: decoder))
                case "ComputerToolCall", "#/components/schemas/ComputerToolCall":
                    self = .computerToolCall(try .init(from: decoder))
                case "ComputerToolCallOutput", "#/components/schemas/ComputerToolCallOutput":
                    self = .computerToolCallOutput(try .init(from: decoder))
                case "WebSearchToolCall", "#/components/schemas/WebSearchToolCall":
                    self = .webSearchToolCall(try .init(from: decoder))
                case "FunctionToolCall", "#/components/schemas/FunctionToolCall":
                    self = .functionToolCall(try .init(from: decoder))
                case "FunctionToolCallOutput", "#/components/schemas/FunctionToolCallOutput":
                    self = .functionToolCallOutput(try .init(from: decoder))
                case "ReasoningItem", "#/components/schemas/ReasoningItem":
                    self = .reasoningItem(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .inputMessage(value):
                    try value.encode(to: encoder)
                case let .outputMessage(value):
                    try value.encode(to: encoder)
                case let .fileSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .computerToolCall(value):
                    try value.encode(to: encoder)
                case let .computerToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .webSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .functionToolCall(value):
                    try value.encode(to: encoder)
                case let .functionToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .reasoningItem(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// An internal identifier for an item to reference.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ItemReference`.
        public struct ItemReference: Codable, Hashable, Sendable {
            /// The ID of the item to reference.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ItemReference/id`.
            public var id: Swift.String
            /// The type of item to reference. Always `item_reference`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ItemReference/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case itemReference = "item_reference"
            }
            /// The type of item to reference. Always `item_reference`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ItemReference/type`.
            public var _type: Components.Schemas.ItemReference._TypePayload
            /// Creates a new `ItemReference`.
            ///
            /// - Parameters:
            ///   - id: The ID of the item to reference.
            ///   - _type: The type of item to reference. Always `item_reference`.
            public init(
                id: Swift.String,
                _type: Components.Schemas.ItemReference._TypePayload
            ) {
                self.id = id
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
            }
        }
        /// Content item used to generate a response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ItemResource`.
        @frozen public enum ItemResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ItemResource/InputMessageResource`.
            case inputMessageResource(Components.Schemas.InputMessageResource)
            /// - Remark: Generated from `#/components/schemas/ItemResource/OutputMessage`.
            case outputMessage(Components.Schemas.OutputMessage)
            /// - Remark: Generated from `#/components/schemas/ItemResource/FileSearchToolCall`.
            case fileSearchToolCall(Components.Schemas.FileSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ComputerToolCall`.
            case computerToolCall(Components.Schemas.ComputerToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ComputerToolCallOutputResource`.
            case computerToolCallOutputResource(Components.Schemas.ComputerToolCallOutputResource)
            /// - Remark: Generated from `#/components/schemas/ItemResource/WebSearchToolCall`.
            case webSearchToolCall(Components.Schemas.WebSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/FunctionToolCallResource`.
            case functionToolCallResource(Components.Schemas.FunctionToolCallResource)
            /// - Remark: Generated from `#/components/schemas/ItemResource/FunctionToolCallOutputResource`.
            case functionToolCallOutputResource(Components.Schemas.FunctionToolCallOutputResource)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "InputMessageResource", "#/components/schemas/InputMessageResource":
                    self = .inputMessageResource(try .init(from: decoder))
                case "OutputMessage", "#/components/schemas/OutputMessage":
                    self = .outputMessage(try .init(from: decoder))
                case "FileSearchToolCall", "#/components/schemas/FileSearchToolCall":
                    self = .fileSearchToolCall(try .init(from: decoder))
                case "ComputerToolCall", "#/components/schemas/ComputerToolCall":
                    self = .computerToolCall(try .init(from: decoder))
                case "ComputerToolCallOutputResource", "#/components/schemas/ComputerToolCallOutputResource":
                    self = .computerToolCallOutputResource(try .init(from: decoder))
                case "WebSearchToolCall", "#/components/schemas/WebSearchToolCall":
                    self = .webSearchToolCall(try .init(from: decoder))
                case "FunctionToolCallResource", "#/components/schemas/FunctionToolCallResource":
                    self = .functionToolCallResource(try .init(from: decoder))
                case "FunctionToolCallOutputResource", "#/components/schemas/FunctionToolCallOutputResource":
                    self = .functionToolCallOutputResource(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .inputMessageResource(value):
                    try value.encode(to: encoder)
                case let .outputMessage(value):
                    try value.encode(to: encoder)
                case let .fileSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .computerToolCall(value):
                    try value.encode(to: encoder)
                case let .computerToolCallOutputResource(value):
                    try value.encode(to: encoder)
                case let .webSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .functionToolCallResource(value):
                    try value.encode(to: encoder)
                case let .functionToolCallOutputResource(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A collection of keypresses the model would like to perform.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/KeyPress`.
        public struct KeyPress: Codable, Hashable, Sendable {
            /// Specifies the event type. For a keypress action, this property is 
            /// always set to `keypress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/KeyPress/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case keypress = "keypress"
            }
            /// Specifies the event type. For a keypress action, this property is 
            /// always set to `keypress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/KeyPress/type`.
            public var _type: Components.Schemas.KeyPress._TypePayload
            /// The combination of keys the model is requesting to be pressed. This is an
            /// array of strings, each representing a key.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/KeyPress/keys`.
            public var keys: [Swift.String]
            /// Creates a new `KeyPress`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a keypress action, this property is 
            ///   - keys: The combination of keys the model is requesting to be pressed. This is an
            public init(
                _type: Components.Schemas.KeyPress._TypePayload,
                keys: [Swift.String]
            ) {
                self._type = _type
                self.keys = keys
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case keys
            }
        }
        /// - Remark: Generated from `#/components/schemas/LogProb`.
        public struct LogProb: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/LogProb/value1`.
            public var value1: Components.Schemas.LogProbProperties
            /// - Remark: Generated from `#/components/schemas/LogProb/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/LogProb/value2/top_logprobs`.
                public var topLogprobs: [Components.Schemas.LogProbProperties]?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - topLogprobs:
                public init(topLogprobs: [Components.Schemas.LogProbProperties]? = nil) {
                    self.topLogprobs = topLogprobs
                }
                public enum CodingKeys: String, CodingKey {
                    case topLogprobs = "top_logprobs"
                }
            }
            /// - Remark: Generated from `#/components/schemas/LogProb/value2`.
            public var value2: Components.Schemas.LogProb.Value2Payload
            /// Creates a new `LogProb`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.LogProbProperties,
                value2: Components.Schemas.LogProb.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// A log probability object.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/LogProbProperties`.
        public struct LogProbProperties: Codable, Hashable, Sendable {
            /// The token that was used to generate the log probability.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LogProbProperties/token`.
            public var token: Swift.String
            /// The log probability of the token.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LogProbProperties/logprob`.
            public var logprob: Swift.Double
            /// The bytes that were used to generate the log probability.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LogProbProperties/bytes`.
            public var bytes: [Swift.Int]
            /// Creates a new `LogProbProperties`.
            ///
            /// - Parameters:
            ///   - token: The token that was used to generate the log probability.
            ///   - logprob: The log probability of the token.
            ///   - bytes: The bytes that were used to generate the log probability.
            public init(
                token: Swift.String,
                logprob: Swift.Double,
                bytes: [Swift.Int]
            ) {
                self.token = token
                self.logprob = logprob
                self.bytes = bytes
            }
            public enum CodingKeys: String, CodingKey {
                case token
                case logprob
                case bytes
            }
        }
        /// Set of 16 key-value pairs that can be attached to an object. This can be
        /// useful for storing additional information about the object in a structured
        /// format, and querying for objects via API or the dashboard. 
        ///
        /// Keys are strings with a maximum length of 64 characters. Values are strings
        /// with a maximum length of 512 characters.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Metadata`.
        public struct Metadata: Codable, Hashable, Sendable {
            /// A container of undocumented properties.
            public var additionalProperties: [String: Swift.String]
            /// Creates a new `Metadata`.
            ///
            /// - Parameters:
            ///   - additionalProperties: A container of undocumented properties.
            public init(additionalProperties: [String: Swift.String] = .init()) {
                self.additionalProperties = additionalProperties
            }
            public init(from decoder: any Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeAdditionalProperties(additionalProperties)
            }
        }
        /// Describes an OpenAI model offering that can be used with the API.
        ///
        /// - Remark: Generated from `#/components/schemas/Model`.
        public struct Model: Codable, Hashable, Sendable {
            /// The model identifier, which can be referenced in the API endpoints.
            ///
            /// - Remark: Generated from `#/components/schemas/Model/id`.
            public var id: Swift.String
            /// The Unix timestamp (in seconds) when the model was created.
            ///
            /// - Remark: Generated from `#/components/schemas/Model/created`.
            public var created: Swift.Int
            /// The object type, which is always "model".
            ///
            /// - Remark: Generated from `#/components/schemas/Model/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case model = "model"
            }
            /// The object type, which is always "model".
            ///
            /// - Remark: Generated from `#/components/schemas/Model/object`.
            public var object: Components.Schemas.Model.ObjectPayload
            /// The organization that owns the model.
            ///
            /// - Remark: Generated from `#/components/schemas/Model/owned_by`.
            public var ownedBy: Swift.String
            /// Creates a new `Model`.
            ///
            /// - Parameters:
            ///   - id: The model identifier, which can be referenced in the API endpoints.
            ///   - created: The Unix timestamp (in seconds) when the model was created.
            ///   - object: The object type, which is always "model".
            ///   - ownedBy: The organization that owns the model.
            public init(
                id: Swift.String,
                created: Swift.Int,
                object: Components.Schemas.Model.ObjectPayload,
                ownedBy: Swift.String
            ) {
                self.id = id
                self.created = created
                self.object = object
                self.ownedBy = ownedBy
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case created
                case object
                case ownedBy = "owned_by"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ModelIds`.
        public struct ModelIds: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ModelIds/value1`.
            public var value1: Components.Schemas.ModelIdsShared?
            /// - Remark: Generated from `#/components/schemas/ModelIds/value2`.
            public var value2: Components.Schemas.ModelIdsResponses?
            /// Creates a new `ModelIds`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.ModelIdsShared? = nil,
                value2: Components.Schemas.ModelIdsResponses? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self.value1 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                do {
                    self.value2 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                try Swift.DecodingError.verifyAtLeastOneSchemaIsNotNil(
                    [
                        self.value1,
                        self.value2
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeFirstNonNilValueToSingleValueContainer([
                    self.value1,
                    self.value2
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/ModelIdsResponses`.
        public struct ModelIdsResponses: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ModelIdsResponses/value1`.
            public var value1: Components.Schemas.ModelIdsShared?
            /// - Remark: Generated from `#/components/schemas/ModelIdsResponses/value2`.
            @frozen public enum Value2Payload: String, Codable, Hashable, Sendable, CaseIterable {
                case o1Pro = "o1-pro"
                case o1Pro20250319 = "o1-pro-2025-03-19"
                case computerUsePreview = "computer-use-preview"
                case computerUsePreview20250311 = "computer-use-preview-2025-03-11"
            }
            /// - Remark: Generated from `#/components/schemas/ModelIdsResponses/value2`.
            public var value2: Components.Schemas.ModelIdsResponses.Value2Payload?
            /// Creates a new `ModelIdsResponses`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.ModelIdsShared? = nil,
                value2: Components.Schemas.ModelIdsResponses.Value2Payload? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self.value1 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                do {
                    self.value2 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                try Swift.DecodingError.verifyAtLeastOneSchemaIsNotNil(
                    [
                        self.value1,
                        self.value2
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeFirstNonNilValueToSingleValueContainer([
                    self.value1,
                    self.value2
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/ModelIdsShared`.
        public struct ModelIdsShared: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ModelIdsShared/value1`.
            public var value1: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ModelIdsShared/value2`.
            @frozen public enum Value2Payload: String, Codable, Hashable, Sendable, CaseIterable {
                case o3Mini = "o3-mini"
                case o3Mini20250131 = "o3-mini-2025-01-31"
                case o1 = "o1"
                case o120241217 = "o1-2024-12-17"
                case o1Preview = "o1-preview"
                case o1Preview20240912 = "o1-preview-2024-09-12"
                case o1Mini = "o1-mini"
                case o1Mini20240912 = "o1-mini-2024-09-12"
                case gpt4o = "gpt-4o"
                case gpt4o20241120 = "gpt-4o-2024-11-20"
                case gpt4o20240806 = "gpt-4o-2024-08-06"
                case gpt4o20240513 = "gpt-4o-2024-05-13"
                case gpt4oAudioPreview = "gpt-4o-audio-preview"
                case gpt4oAudioPreview20241001 = "gpt-4o-audio-preview-2024-10-01"
                case gpt4oAudioPreview20241217 = "gpt-4o-audio-preview-2024-12-17"
                case gpt4oMiniAudioPreview = "gpt-4o-mini-audio-preview"
                case gpt4oMiniAudioPreview20241217 = "gpt-4o-mini-audio-preview-2024-12-17"
                case gpt4oSearchPreview = "gpt-4o-search-preview"
                case gpt4oMiniSearchPreview = "gpt-4o-mini-search-preview"
                case gpt4oSearchPreview20250311 = "gpt-4o-search-preview-2025-03-11"
                case gpt4oMiniSearchPreview20250311 = "gpt-4o-mini-search-preview-2025-03-11"
                case chatgpt4oLatest = "chatgpt-4o-latest"
                case gpt4oMini = "gpt-4o-mini"
                case gpt4oMini20240718 = "gpt-4o-mini-2024-07-18"
                case gpt4Turbo = "gpt-4-turbo"
                case gpt4Turbo20240409 = "gpt-4-turbo-2024-04-09"
                case gpt40125Preview = "gpt-4-0125-preview"
                case gpt4TurboPreview = "gpt-4-turbo-preview"
                case gpt41106Preview = "gpt-4-1106-preview"
                case gpt4VisionPreview = "gpt-4-vision-preview"
                case gpt4 = "gpt-4"
                case gpt40314 = "gpt-4-0314"
                case gpt40613 = "gpt-4-0613"
                case gpt432k = "gpt-4-32k"
                case gpt432k0314 = "gpt-4-32k-0314"
                case gpt432k0613 = "gpt-4-32k-0613"
                case gpt3_5Turbo = "gpt-3.5-turbo"
                case gpt3_5Turbo16k = "gpt-3.5-turbo-16k"
                case gpt3_5Turbo0301 = "gpt-3.5-turbo-0301"
                case gpt3_5Turbo0613 = "gpt-3.5-turbo-0613"
                case gpt3_5Turbo1106 = "gpt-3.5-turbo-1106"
                case gpt3_5Turbo0125 = "gpt-3.5-turbo-0125"
                case gpt3_5Turbo16k0613 = "gpt-3.5-turbo-16k-0613"
            }
            /// - Remark: Generated from `#/components/schemas/ModelIdsShared/value2`.
            public var value2: Components.Schemas.ModelIdsShared.Value2Payload?
            /// Creates a new `ModelIdsShared`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Swift.String? = nil,
                value2: Components.Schemas.ModelIdsShared.Value2Payload? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self.value1 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                do {
                    self.value2 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                try Swift.DecodingError.verifyAtLeastOneSchemaIsNotNil(
                    [
                        self.value1,
                        self.value2
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeFirstNonNilValueToSingleValueContainer([
                    self.value1,
                    self.value2
                ])
            }
        }
        /// A mouse move action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Move`.
        public struct Move: Codable, Hashable, Sendable {
            /// Specifies the event type. For a move action, this property is 
            /// always set to `move`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Move/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case move = "move"
            }
            /// Specifies the event type. For a move action, this property is 
            /// always set to `move`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Move/type`.
            public var _type: Components.Schemas.Move._TypePayload
            /// The x-coordinate to move to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Move/x`.
            public var x: Swift.Int
            /// The y-coordinate to move to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Move/y`.
            public var y: Swift.Int
            /// Creates a new `Move`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a move action, this property is 
            ///   - x: The x-coordinate to move to.
            ///   - y: The y-coordinate to move to.
            public init(
                _type: Components.Schemas.Move._TypePayload,
                x: Swift.Int,
                y: Swift.Int
            ) {
                self._type = _type
                self.x = x
                self.y = y
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case x
                case y
            }
        }
        /// This is returned when the chunking strategy is unknown. Typically, this is because the file was indexed before the `chunking_strategy` concept was introduced in the API.
        ///
        /// - Remark: Generated from `#/components/schemas/OtherChunkingStrategyResponseParam`.
        public struct OtherChunkingStrategyResponseParam: Codable, Hashable, Sendable {
            /// Always `other`.
            ///
            /// - Remark: Generated from `#/components/schemas/OtherChunkingStrategyResponseParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case other = "other"
            }
            /// Always `other`.
            ///
            /// - Remark: Generated from `#/components/schemas/OtherChunkingStrategyResponseParam/type`.
            public var _type: Components.Schemas.OtherChunkingStrategyResponseParam._TypePayload
            /// Creates a new `OtherChunkingStrategyResponseParam`.
            ///
            /// - Parameters:
            ///   - _type: Always `other`.
            public init(_type: Components.Schemas.OtherChunkingStrategyResponseParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.OtherChunkingStrategyResponseParam._TypePayload.self,
                    forKey: ._type
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type"
                ])
            }
        }
        /// An audio output from the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/OutputAudio`.
        public struct OutputAudio: Codable, Hashable, Sendable {
            /// The type of the output audio. Always `output_audio`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputAudio/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case outputAudio = "output_audio"
            }
            /// The type of the output audio. Always `output_audio`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputAudio/type`.
            public var _type: Components.Schemas.OutputAudio._TypePayload
            /// Base64-encoded audio data from the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputAudio/data`.
            public var data: Swift.String
            /// The transcript of the audio data from the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputAudio/transcript`.
            public var transcript: Swift.String
            /// Creates a new `OutputAudio`.
            ///
            /// - Parameters:
            ///   - _type: The type of the output audio. Always `output_audio`.
            ///   - data: Base64-encoded audio data from the model.
            ///   - transcript: The transcript of the audio data from the model.
            public init(
                _type: Components.Schemas.OutputAudio._TypePayload,
                data: Swift.String,
                transcript: Swift.String
            ) {
                self._type = _type
                self.data = data
                self.transcript = transcript
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case data
                case transcript
            }
        }
        /// - Remark: Generated from `#/components/schemas/OutputContent`.
        @frozen public enum OutputContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/OutputContent/case1`.
            case OutputText(Components.Schemas.OutputText)
            /// - Remark: Generated from `#/components/schemas/OutputContent/case2`.
            case Refusal(Components.Schemas.Refusal)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .OutputText(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .Refusal(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .OutputText(value):
                    try value.encode(to: encoder)
                case let .Refusal(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// - Remark: Generated from `#/components/schemas/OutputItem`.
        public struct OutputItem: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/OutputItem/value1`.
            public var value1: Components.Schemas.OutputMessage?
            /// - Remark: Generated from `#/components/schemas/OutputItem/value2`.
            public var value2: Components.Schemas.FileSearchToolCall?
            /// - Remark: Generated from `#/components/schemas/OutputItem/value3`.
            public var value3: Components.Schemas.FunctionToolCall?
            /// - Remark: Generated from `#/components/schemas/OutputItem/value4`.
            public var value4: Components.Schemas.WebSearchToolCall?
            /// - Remark: Generated from `#/components/schemas/OutputItem/value5`.
            public var value5: Components.Schemas.ComputerToolCall?
            /// - Remark: Generated from `#/components/schemas/OutputItem/value6`.
            public var value6: Components.Schemas.ReasoningItem?
            /// Creates a new `OutputItem`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            ///   - value3:
            ///   - value4:
            ///   - value5:
            ///   - value6:
            public init(
                value1: Components.Schemas.OutputMessage? = nil,
                value2: Components.Schemas.FileSearchToolCall? = nil,
                value3: Components.Schemas.FunctionToolCall? = nil,
                value4: Components.Schemas.WebSearchToolCall? = nil,
                value5: Components.Schemas.ComputerToolCall? = nil,
                value6: Components.Schemas.ReasoningItem? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
                self.value3 = value3
                self.value4 = value4
                self.value5 = value5
                self.value6 = value6
            }
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self.value1 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value2 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value3 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value4 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value5 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value6 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                try Swift.DecodingError.verifyAtLeastOneSchemaIsNotNil(
                    [
                        self.value1,
                        self.value2,
                        self.value3,
                        self.value4,
                        self.value5,
                        self.value6
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1?.encode(to: encoder)
                try self.value2?.encode(to: encoder)
                try self.value3?.encode(to: encoder)
                try self.value4?.encode(to: encoder)
                try self.value5?.encode(to: encoder)
                try self.value6?.encode(to: encoder)
            }
        }
        /// An output message from the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/OutputMessage`.
        public struct OutputMessage: Codable, Hashable, Sendable {
            /// The unique ID of the output message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/id`.
            public var id: Swift.String
            /// The type of the output message. Always `message`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case message = "message"
            }
            /// The type of the output message. Always `message`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/type`.
            public var _type: Components.Schemas.OutputMessage._TypePayload
            /// The role of the output message. Always `assistant`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/role`.
            @frozen public enum RolePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case assistant = "assistant"
            }
            /// The role of the output message. Always `assistant`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/role`.
            public var role: Components.Schemas.OutputMessage.RolePayload
            /// The content of the output message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/content`.
            public var content: [Components.Schemas.OutputContent]
            /// The status of the message input. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when input items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the message input. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when input items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputMessage/status`.
            public var status: Components.Schemas.OutputMessage.StatusPayload
            /// Creates a new `OutputMessage`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the output message.
            ///   - _type: The type of the output message. Always `message`.
            ///   - role: The role of the output message. Always `assistant`.
            ///   - content: The content of the output message.
            ///   - status: The status of the message input. One of `in_progress`, `completed`, or
            public init(
                id: Swift.String,
                _type: Components.Schemas.OutputMessage._TypePayload,
                role: Components.Schemas.OutputMessage.RolePayload,
                content: [Components.Schemas.OutputContent],
                status: Components.Schemas.OutputMessage.StatusPayload
            ) {
                self.id = id
                self._type = _type
                self.role = role
                self.content = content
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case role
                case content
                case status
            }
        }
        /// A text output from the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/OutputText`.
        public struct OutputText: Codable, Hashable, Sendable {
            /// The type of the output text. Always `output_text`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputText/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case outputText = "output_text"
            }
            /// The type of the output text. Always `output_text`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputText/type`.
            public var _type: Components.Schemas.OutputText._TypePayload
            /// The text output from the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputText/text`.
            public var text: Swift.String
            /// The annotations of the text output.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/OutputText/annotations`.
            public var annotations: [Components.Schemas.Annotation]
            /// Creates a new `OutputText`.
            ///
            /// - Parameters:
            ///   - _type: The type of the output text. Always `output_text`.
            ///   - text: The text output from the model.
            ///   - annotations: The annotations of the text output.
            public init(
                _type: Components.Schemas.OutputText._TypePayload,
                text: Swift.String,
                annotations: [Components.Schemas.Annotation]
            ) {
                self._type = _type
                self.text = text
                self.annotations = annotations
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
                case annotations
            }
        }
        /// Whether to enable [parallel function calling](/docs/guides/function-calling#configuring-parallel-function-calling) during tool use.
        ///
        /// - Remark: Generated from `#/components/schemas/ParallelToolCalls`.
        public typealias ParallelToolCalls = Swift.Bool
        /// **o-series models only**
        ///
        /// Configuration options for 
        /// [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Reasoning`.
        public struct Reasoning: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Reasoning/effort`.
            public var effort: Components.Schemas.ReasoningEffort?
            /// **computer_use_preview only**
            ///
            /// A summary of the reasoning performed by the model. This can be
            /// useful for debugging and understanding the model's reasoning process.
            /// One of `concise` or `detailed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/generate_summary`.
            @frozen public enum GenerateSummaryPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case concise = "concise"
                case detailed = "detailed"
            }
            /// **computer_use_preview only**
            ///
            /// A summary of the reasoning performed by the model. This can be
            /// useful for debugging and understanding the model's reasoning process.
            /// One of `concise` or `detailed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/generate_summary`.
            public var generateSummary: Components.Schemas.Reasoning.GenerateSummaryPayload?
            /// Creates a new `Reasoning`.
            ///
            /// - Parameters:
            ///   - effort:
            ///   - generateSummary: **computer_use_preview only**
            public init(
                effort: Components.Schemas.ReasoningEffort? = nil,
                generateSummary: Components.Schemas.Reasoning.GenerateSummaryPayload? = nil
            ) {
                self.effort = effort
                self.generateSummary = generateSummary
            }
            public enum CodingKeys: String, CodingKey {
                case effort
                case generateSummary = "generate_summary"
            }
        }
        /// **o-series models only** 
        ///
        /// Constrains effort on reasoning for 
        /// [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        /// Currently supported values are `low`, `medium`, and `high`. Reducing
        /// reasoning effort can result in faster responses and fewer tokens used
        /// on reasoning in a response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ReasoningEffort`.
        @frozen public enum ReasoningEffort: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case medium = "medium"
            case high = "high"
        }
        /// A description of the chain of thought used by a reasoning model while generating
        /// a response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ReasoningItem`.
        public struct ReasoningItem: Codable, Hashable, Sendable {
            /// The type of the object. Always `reasoning`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case reasoning = "reasoning"
            }
            /// The type of the object. Always `reasoning`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/type`.
            public var _type: Components.Schemas.ReasoningItem._TypePayload
            /// The unique identifier of the reasoning content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/id`.
            public var id: Swift.String
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/SummaryPayload`.
            public struct SummaryPayloadPayload: Codable, Hashable, Sendable {
                /// The type of the object. Always `summary_text`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ReasoningItem/SummaryPayload/type`.
                @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case summaryText = "summary_text"
                }
                /// The type of the object. Always `summary_text`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ReasoningItem/SummaryPayload/type`.
                public var _type: Components.Schemas.ReasoningItem.SummaryPayloadPayload._TypePayload
                /// A short summary of the reasoning used by the model when generating
                /// the response.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ReasoningItem/SummaryPayload/text`.
                public var text: Swift.String
                /// Creates a new `SummaryPayloadPayload`.
                ///
                /// - Parameters:
                ///   - _type: The type of the object. Always `summary_text`.
                ///   - text: A short summary of the reasoning used by the model when generating
                public init(
                    _type: Components.Schemas.ReasoningItem.SummaryPayloadPayload._TypePayload,
                    text: Swift.String
                ) {
                    self._type = _type
                    self.text = text
                }
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                    case text
                }
            }
            /// Reasoning text contents.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/summary`.
            public typealias SummaryPayload = [Components.Schemas.ReasoningItem.SummaryPayloadPayload]
            /// Reasoning text contents.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/summary`.
            public var summary: Components.Schemas.ReasoningItem.SummaryPayload
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the item. One of `in_progress`, `completed`, or
            /// `incomplete`. Populated when items are returned via API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/status`.
            public var status: Components.Schemas.ReasoningItem.StatusPayload?
            /// Creates a new `ReasoningItem`.
            ///
            /// - Parameters:
            ///   - _type: The type of the object. Always `reasoning`.
            ///   - id: The unique identifier of the reasoning content.
            ///   - summary: Reasoning text contents.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                _type: Components.Schemas.ReasoningItem._TypePayload,
                id: Swift.String,
                summary: Components.Schemas.ReasoningItem.SummaryPayload,
                status: Components.Schemas.ReasoningItem.StatusPayload? = nil
            ) {
                self._type = _type
                self.id = id
                self.summary = summary
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case summary
                case status
            }
        }
        /// A refusal from the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Refusal`.
        public struct Refusal: Codable, Hashable, Sendable {
            /// The type of the refusal. Always `refusal`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Refusal/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case refusal = "refusal"
            }
            /// The type of the refusal. Always `refusal`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Refusal/type`.
            public var _type: Components.Schemas.Refusal._TypePayload
            /// The refusal explanationfrom the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Refusal/refusal`.
            public var refusal: Swift.String
            /// Creates a new `Refusal`.
            ///
            /// - Parameters:
            ///   - _type: The type of the refusal. Always `refusal`.
            ///   - refusal: The refusal explanationfrom the model.
            public init(
                _type: Components.Schemas.Refusal._TypePayload,
                refusal: Swift.String
            ) {
                self._type = _type
                self.refusal = refusal
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case refusal
            }
        }
        /// A screenshot action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Screenshot`.
        public struct Screenshot: Codable, Hashable, Sendable {
            /// Specifies the event type. For a screenshot action, this property is 
            /// always set to `screenshot`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Screenshot/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case screenshot = "screenshot"
            }
            /// Specifies the event type. For a screenshot action, this property is 
            /// always set to `screenshot`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Screenshot/type`.
            public var _type: Components.Schemas.Screenshot._TypePayload
            /// Creates a new `Screenshot`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a screenshot action, this property is 
            public init(_type: Components.Schemas.Screenshot._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// A scroll action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Scroll`.
        public struct Scroll: Codable, Hashable, Sendable {
            /// Specifies the event type. For a scroll action, this property is 
            /// always set to `scroll`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Scroll/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case scroll = "scroll"
            }
            /// Specifies the event type. For a scroll action, this property is 
            /// always set to `scroll`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Scroll/type`.
            public var _type: Components.Schemas.Scroll._TypePayload
            /// The x-coordinate where the scroll occurred.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Scroll/x`.
            public var x: Swift.Int
            /// The y-coordinate where the scroll occurred.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Scroll/y`.
            public var y: Swift.Int
            /// The horizontal scroll distance.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Scroll/scroll_x`.
            public var scrollX: Swift.Int
            /// The vertical scroll distance.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Scroll/scroll_y`.
            public var scrollY: Swift.Int
            /// Creates a new `Scroll`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a scroll action, this property is 
            ///   - x: The x-coordinate where the scroll occurred.
            ///   - y: The y-coordinate where the scroll occurred.
            ///   - scrollX: The horizontal scroll distance.
            ///   - scrollY: The vertical scroll distance.
            public init(
                _type: Components.Schemas.Scroll._TypePayload,
                x: Swift.Int,
                y: Swift.Int,
                scrollX: Swift.Int,
                scrollY: Swift.Int
            ) {
                self._type = _type
                self.x = x
                self.y = y
                self.scrollX = scrollX
                self.scrollY = scrollY
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case x
                case y
                case scrollX = "scroll_x"
                case scrollY = "scroll_y"
            }
        }
        /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategy`.
        public struct StaticChunkingStrategy: Codable, Hashable, Sendable {
            /// The maximum number of tokens in each chunk. The default value is `800`. The minimum value is `100` and the maximum value is `4096`.
            ///
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategy/max_chunk_size_tokens`.
            public var maxChunkSizeTokens: Swift.Int
            /// The number of tokens that overlap between chunks. The default value is `400`.
            ///
            /// Note that the overlap must not exceed half of `max_chunk_size_tokens`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategy/chunk_overlap_tokens`.
            public var chunkOverlapTokens: Swift.Int
            /// Creates a new `StaticChunkingStrategy`.
            ///
            /// - Parameters:
            ///   - maxChunkSizeTokens: The maximum number of tokens in each chunk. The default value is `800`. The minimum value is `100` and the maximum value is `4096`.
            ///   - chunkOverlapTokens: The number of tokens that overlap between chunks. The default value is `400`.
            public init(
                maxChunkSizeTokens: Swift.Int,
                chunkOverlapTokens: Swift.Int
            ) {
                self.maxChunkSizeTokens = maxChunkSizeTokens
                self.chunkOverlapTokens = chunkOverlapTokens
            }
            public enum CodingKeys: String, CodingKey {
                case maxChunkSizeTokens = "max_chunk_size_tokens"
                case chunkOverlapTokens = "chunk_overlap_tokens"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.maxChunkSizeTokens = try container.decode(
                    Swift.Int.self,
                    forKey: .maxChunkSizeTokens
                )
                self.chunkOverlapTokens = try container.decode(
                    Swift.Int.self,
                    forKey: .chunkOverlapTokens
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "max_chunk_size_tokens",
                    "chunk_overlap_tokens"
                ])
            }
        }
        /// Customize your own chunking strategy by setting chunk size and chunk overlap.
        ///
        /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyRequestParam`.
        public struct StaticChunkingStrategyRequestParam: Codable, Hashable, Sendable {
            /// Always `static`.
            ///
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyRequestParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case _static = "static"
            }
            /// Always `static`.
            ///
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyRequestParam/type`.
            public var _type: Components.Schemas.StaticChunkingStrategyRequestParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyRequestParam/static`.
            public var _static: Components.Schemas.StaticChunkingStrategy
            /// Creates a new `StaticChunkingStrategyRequestParam`.
            ///
            /// - Parameters:
            ///   - _type: Always `static`.
            ///   - _static:
            public init(
                _type: Components.Schemas.StaticChunkingStrategyRequestParam._TypePayload,
                _static: Components.Schemas.StaticChunkingStrategy
            ) {
                self._type = _type
                self._static = _static
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case _static = "static"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.StaticChunkingStrategyRequestParam._TypePayload.self,
                    forKey: ._type
                )
                self._static = try container.decode(
                    Components.Schemas.StaticChunkingStrategy.self,
                    forKey: ._static
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type",
                    "static"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyResponseParam`.
        public struct StaticChunkingStrategyResponseParam: Codable, Hashable, Sendable {
            /// Always `static`.
            ///
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyResponseParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case _static = "static"
            }
            /// Always `static`.
            ///
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyResponseParam/type`.
            public var _type: Components.Schemas.StaticChunkingStrategyResponseParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/StaticChunkingStrategyResponseParam/static`.
            public var _static: Components.Schemas.StaticChunkingStrategy
            /// Creates a new `StaticChunkingStrategyResponseParam`.
            ///
            /// - Parameters:
            ///   - _type: Always `static`.
            ///   - _static:
            public init(
                _type: Components.Schemas.StaticChunkingStrategyResponseParam._TypePayload,
                _static: Components.Schemas.StaticChunkingStrategy
            ) {
                self._type = _type
                self._static = _static
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case _static = "static"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.StaticChunkingStrategyResponseParam._TypePayload.self,
                    forKey: ._type
                )
                self._static = try container.decode(
                    Components.Schemas.StaticChunkingStrategy.self,
                    forKey: ._static
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type",
                    "static"
                ])
            }
        }
        /// Up to 4 sequences where the API will stop generating further tokens. The
        /// returned text will not contain the stop sequence.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/StopConfiguration`.
        @frozen public enum StopConfiguration: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/StopConfiguration/case1`.
            case case1(Swift.String?)
            /// - Remark: Generated from `#/components/schemas/StopConfiguration/case2`.
            case case2([Swift.String])
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .case1(try decoder.decodeFromSingleValueContainer())
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .case2(try decoder.decodeFromSingleValueContainer())
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .case1(value):
                    try encoder.encodeToSingleValueContainer(value)
                case let .case2(value):
                    try encoder.encodeToSingleValueContainer(value)
                }
            }
        }
        /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest`.
        public struct SubmitToolOutputsRunRequest: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest/ToolOutputsPayload`.
            public struct ToolOutputsPayloadPayload: Codable, Hashable, Sendable {
                /// The ID of the tool call in the `required_action` object within the run object the output is being submitted for.
                ///
                /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest/ToolOutputsPayload/tool_call_id`.
                public var toolCallId: Swift.String?
                /// The output of the tool call to be submitted to continue the run.
                ///
                /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest/ToolOutputsPayload/output`.
                public var output: Swift.String?
                /// Creates a new `ToolOutputsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - toolCallId: The ID of the tool call in the `required_action` object within the run object the output is being submitted for.
                ///   - output: The output of the tool call to be submitted to continue the run.
                public init(
                    toolCallId: Swift.String? = nil,
                    output: Swift.String? = nil
                ) {
                    self.toolCallId = toolCallId
                    self.output = output
                }
                public enum CodingKeys: String, CodingKey {
                    case toolCallId = "tool_call_id"
                    case output
                }
            }
            /// A list of tools for which the outputs are being submitted.
            ///
            /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest/tool_outputs`.
            public typealias ToolOutputsPayload = [Components.Schemas.SubmitToolOutputsRunRequest.ToolOutputsPayloadPayload]
            /// A list of tools for which the outputs are being submitted.
            ///
            /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest/tool_outputs`.
            public var toolOutputs: Components.Schemas.SubmitToolOutputsRunRequest.ToolOutputsPayload
            /// If `true`, returns a stream of events that happen during the Run as server-sent events, terminating when the Run enters a terminal state with a `data: [DONE]` message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/SubmitToolOutputsRunRequest/stream`.
            public var stream: Swift.Bool?
            /// Creates a new `SubmitToolOutputsRunRequest`.
            ///
            /// - Parameters:
            ///   - toolOutputs: A list of tools for which the outputs are being submitted.
            ///   - stream: If `true`, returns a stream of events that happen during the Run as server-sent events, terminating when the Run enters a terminal state with a `data: [DONE]` message.
            public init(
                toolOutputs: Components.Schemas.SubmitToolOutputsRunRequest.ToolOutputsPayload,
                stream: Swift.Bool? = nil
            ) {
                self.toolOutputs = toolOutputs
                self.stream = stream
            }
            public enum CodingKeys: String, CodingKey {
                case toolOutputs = "tool_outputs"
                case stream
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.toolOutputs = try container.decode(
                    Components.Schemas.SubmitToolOutputsRunRequest.ToolOutputsPayload.self,
                    forKey: .toolOutputs
                )
                self.stream = try container.decodeIfPresent(
                    Swift.Bool.self,
                    forKey: .stream
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "tool_outputs",
                    "stream"
                ])
            }
        }
        /// An object specifying the format that the model must output.
        ///
        /// Configuring `{ "type": "json_schema" }` enables Structured Outputs, 
        /// which ensures the model will match your supplied JSON schema. Learn more in the 
        /// [Structured Outputs guide](/docs/guides/structured-outputs).
        ///
        /// The default format is `{ "type": "text" }` with no additional options.
        ///
        /// **Not recommended for gpt-4o and newer models:**
        ///
        /// Setting to `{ "type": "json_object" }` enables the older JSON mode, which
        /// ensures the message the model generates is valid JSON. Using `json_schema`
        /// is preferred for models that support it.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/TextResponseFormatConfiguration`.
        @frozen public enum TextResponseFormatConfiguration: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatConfiguration/case1`.
            case ResponseFormatText(Components.Schemas.ResponseFormatText)
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatConfiguration/case2`.
            case TextResponseFormatJsonSchema(Components.Schemas.TextResponseFormatJsonSchema)
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatConfiguration/case3`.
            case ResponseFormatJsonObject(Components.Schemas.ResponseFormatJsonObject)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .ResponseFormatText(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .TextResponseFormatJsonSchema(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .ResponseFormatJsonObject(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .ResponseFormatText(value):
                    try value.encode(to: encoder)
                case let .TextResponseFormatJsonSchema(value):
                    try value.encode(to: encoder)
                case let .ResponseFormatJsonObject(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// JSON Schema response format. Used to generate structured JSON responses.
        /// Learn more about [Structured Outputs](/docs/guides/structured-outputs).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema`.
        public struct TextResponseFormatJsonSchema: Codable, Hashable, Sendable {
            /// The type of response format being defined. Always `json_schema`.
            ///
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case jsonSchema = "json_schema"
            }
            /// The type of response format being defined. Always `json_schema`.
            ///
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/type`.
            public var _type: Components.Schemas.TextResponseFormatJsonSchema._TypePayload
            /// A description of what the response format is for, used by the model to
            /// determine how to respond in the format.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/description`.
            public var description: Swift.String?
            /// The name of the response format. Must be a-z, A-Z, 0-9, or contain
            /// underscores and dashes, with a maximum length of 64.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/name`.
            public var name: Swift.String?
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/schema`.
            public var schema: Components.Schemas.ResponseFormatJsonSchemaSchema
            /// Whether to enable strict schema adherence when generating the output.
            /// If set to true, the model will always follow the exact schema defined
            /// in the `schema` field. Only a subset of JSON Schema is supported when
            /// `strict` is `true`. To learn more, read the [Structured Outputs
            /// guide](/docs/guides/structured-outputs).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/strict`.
            public var strict: Swift.Bool?
            /// Creates a new `TextResponseFormatJsonSchema`.
            ///
            /// - Parameters:
            ///   - _type: The type of response format being defined. Always `json_schema`.
            ///   - description: A description of what the response format is for, used by the model to
            ///   - name: The name of the response format. Must be a-z, A-Z, 0-9, or contain
            ///   - schema:
            ///   - strict: Whether to enable strict schema adherence when generating the output.
            public init(
                _type: Components.Schemas.TextResponseFormatJsonSchema._TypePayload,
                description: Swift.String? = nil,
                name: Swift.String? = nil,
                schema: Components.Schemas.ResponseFormatJsonSchemaSchema,
                strict: Swift.Bool? = nil
            ) {
                self._type = _type
                self.description = description
                self.name = name
                self.schema = schema
                self.strict = strict
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case description
                case name
                case schema
                case strict
            }
        }
        /// Represents a thread that contains [messages](/docs/api-reference/messages).
        ///
        /// - Remark: Generated from `#/components/schemas/ThreadObject`.
        public struct ThreadObject: Codable, Hashable, Sendable {
            /// The identifier, which can be referenced in API endpoints.
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadObject/id`.
            public var id: Swift.String
            /// The object type, which is always `thread`.
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadObject/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case thread = "thread"
            }
            /// The object type, which is always `thread`.
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadObject/object`.
            public var object: Components.Schemas.ThreadObject.ObjectPayload
            /// The Unix timestamp (in seconds) for when the thread was created.
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadObject/created_at`.
            public var createdAt: Swift.Int
            /// A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources`.
            public struct ToolResourcesPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources/code_interpreter`.
                public struct CodeInterpreterPayload: Codable, Hashable, Sendable {
                    /// A list of [file](/docs/api-reference/files) IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files associated with the tool.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources/code_interpreter/file_ids`.
                    public var fileIds: [Swift.String]?
                    /// Creates a new `CodeInterpreterPayload`.
                    ///
                    /// - Parameters:
                    ///   - fileIds: A list of [file](/docs/api-reference/files) IDs made available to the `code_interpreter` tool. There can be a maximum of 20 files associated with the tool.
                    public init(fileIds: [Swift.String]? = nil) {
                        self.fileIds = fileIds
                    }
                    public enum CodingKeys: String, CodingKey {
                        case fileIds = "file_ids"
                    }
                }
                /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources/code_interpreter`.
                public var codeInterpreter: Components.Schemas.ThreadObject.ToolResourcesPayload.CodeInterpreterPayload?
                /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources/file_search`.
                public struct FileSearchPayload: Codable, Hashable, Sendable {
                    /// The [vector store](/docs/api-reference/vector-stores/object) attached to this thread. There can be a maximum of 1 vector store attached to the thread.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources/file_search/vector_store_ids`.
                    public var vectorStoreIds: [Swift.String]?
                    /// Creates a new `FileSearchPayload`.
                    ///
                    /// - Parameters:
                    ///   - vectorStoreIds: The [vector store](/docs/api-reference/vector-stores/object) attached to this thread. There can be a maximum of 1 vector store attached to the thread.
                    public init(vectorStoreIds: [Swift.String]? = nil) {
                        self.vectorStoreIds = vectorStoreIds
                    }
                    public enum CodingKeys: String, CodingKey {
                        case vectorStoreIds = "vector_store_ids"
                    }
                }
                /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources/file_search`.
                public var fileSearch: Components.Schemas.ThreadObject.ToolResourcesPayload.FileSearchPayload?
                /// Creates a new `ToolResourcesPayload`.
                ///
                /// - Parameters:
                ///   - codeInterpreter:
                ///   - fileSearch:
                public init(
                    codeInterpreter: Components.Schemas.ThreadObject.ToolResourcesPayload.CodeInterpreterPayload? = nil,
                    fileSearch: Components.Schemas.ThreadObject.ToolResourcesPayload.FileSearchPayload? = nil
                ) {
                    self.codeInterpreter = codeInterpreter
                    self.fileSearch = fileSearch
                }
                public enum CodingKeys: String, CodingKey {
                    case codeInterpreter = "code_interpreter"
                    case fileSearch = "file_search"
                }
            }
            /// A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadObject/tool_resources`.
            public var toolResources: Components.Schemas.ThreadObject.ToolResourcesPayload?
            /// - Remark: Generated from `#/components/schemas/ThreadObject/metadata`.
            public var metadata: Components.Schemas.Metadata?
            /// Creates a new `ThreadObject`.
            ///
            /// - Parameters:
            ///   - id: The identifier, which can be referenced in API endpoints.
            ///   - object: The object type, which is always `thread`.
            ///   - createdAt: The Unix timestamp (in seconds) for when the thread was created.
            ///   - toolResources: A set of resources that are made available to the assistant's tools in this thread. The resources are specific to the type of tool. For example, the `code_interpreter` tool requires a list of file IDs, while the `file_search` tool requires a list of vector store IDs.
            ///   - metadata:
            public init(
                id: Swift.String,
                object: Components.Schemas.ThreadObject.ObjectPayload,
                createdAt: Swift.Int,
                toolResources: Components.Schemas.ThreadObject.ToolResourcesPayload? = nil,
                metadata: Components.Schemas.Metadata? = nil
            ) {
                self.id = id
                self.object = object
                self.createdAt = createdAt
                self.toolResources = toolResources
                self.metadata = metadata
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case object
                case createdAt = "created_at"
                case toolResources = "tool_resources"
                case metadata
            }
        }
        /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent`.
        @frozen public enum ThreadStreamEvent: Codable, Hashable, Sendable {
            /// Occurs when a new [thread](/docs/api-reference/threads/object) is created.
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent/case1`.
            public struct Case1Payload: Codable, Hashable, Sendable {
                /// Whether to enable input audio transcription.
                ///
                /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent/case1/enabled`.
                public var enabled: Swift.Bool?
                /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent/case1/event`.
                @frozen public enum EventPayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case thread_created = "thread.created"
                }
                /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent/case1/event`.
                public var event: Components.Schemas.ThreadStreamEvent.Case1Payload.EventPayload
                /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent/case1/data`.
                public var data: Components.Schemas.ThreadObject
                /// Creates a new `Case1Payload`.
                ///
                /// - Parameters:
                ///   - enabled: Whether to enable input audio transcription.
                ///   - event:
                ///   - data:
                public init(
                    enabled: Swift.Bool? = nil,
                    event: Components.Schemas.ThreadStreamEvent.Case1Payload.EventPayload,
                    data: Components.Schemas.ThreadObject
                ) {
                    self.enabled = enabled
                    self.event = event
                    self.data = data
                }
                public enum CodingKeys: String, CodingKey {
                    case enabled
                    case event
                    case data
                }
            }
            /// Occurs when a new [thread](/docs/api-reference/threads/object) is created.
            ///
            /// - Remark: Generated from `#/components/schemas/ThreadStreamEvent/case1`.
            case case1(Components.Schemas.ThreadStreamEvent.Case1Payload)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .case1(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .case1(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// - Remark: Generated from `#/components/schemas/Tool`.
        @frozen public enum Tool: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Tool/case1`.
            case FileSearchTool(Components.Schemas.FileSearchTool)
            /// - Remark: Generated from `#/components/schemas/Tool/case2`.
            case FunctionTool(Components.Schemas.FunctionTool)
            /// - Remark: Generated from `#/components/schemas/Tool/case3`.
            case ComputerTool(Components.Schemas.ComputerTool)
            /// - Remark: Generated from `#/components/schemas/Tool/case4`.
            case WebSearchTool(Components.Schemas.WebSearchTool)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .FileSearchTool(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .FunctionTool(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .ComputerTool(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .WebSearchTool(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                throw Swift.DecodingError.failedToDecodeOneOfSchema(
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                switch self {
                case let .FileSearchTool(value):
                    try value.encode(to: encoder)
                case let .FunctionTool(value):
                    try value.encode(to: encoder)
                case let .ComputerTool(value):
                    try value.encode(to: encoder)
                case let .WebSearchTool(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// Use this option to force the model to call a specific function.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceFunction`.
        public struct ToolChoiceFunction: Codable, Hashable, Sendable {
            /// For function calling, the type is always `function`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceFunction/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case function = "function"
            }
            /// For function calling, the type is always `function`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceFunction/type`.
            public var _type: Components.Schemas.ToolChoiceFunction._TypePayload
            /// The name of the function to call.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceFunction/name`.
            public var name: Swift.String
            /// Creates a new `ToolChoiceFunction`.
            ///
            /// - Parameters:
            ///   - _type: For function calling, the type is always `function`.
            ///   - name: The name of the function to call.
            public init(
                _type: Components.Schemas.ToolChoiceFunction._TypePayload,
                name: Swift.String
            ) {
                self._type = _type
                self.name = name
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case name
            }
        }
        /// Controls which (if any) tool is called by the model.
        ///
        /// `none` means the model will not call any tool and instead generates a message.
        ///
        /// `auto` means the model can pick between generating a message or calling one or
        /// more tools.
        ///
        /// `required` means the model must call one or more tools.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceOptions`.
        @frozen public enum ToolChoiceOptions: String, Codable, Hashable, Sendable, CaseIterable {
            case none = "none"
            case auto = "auto"
            case required = "required"
        }
        /// Indicates that the model should use a built-in tool to generate a response.
        /// [Learn more about built-in tools](/docs/guides/tools).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceTypes`.
        public struct ToolChoiceTypes: Codable, Hashable, Sendable {
            /// The type of hosted tool the model should to use. Learn more about
            /// [built-in tools](/docs/guides/tools).
            ///
            /// Allowed values are:
            /// - `file_search`
            /// - `web_search_preview`
            /// - `computer_use_preview`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceTypes/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileSearch = "file_search"
                case webSearchPreview = "web_search_preview"
                case computerUsePreview = "computer_use_preview"
                case webSearchPreview20250311 = "web_search_preview_2025_03_11"
            }
            /// The type of hosted tool the model should to use. Learn more about
            /// [built-in tools](/docs/guides/tools).
            ///
            /// Allowed values are:
            /// - `file_search`
            /// - `web_search_preview`
            /// - `computer_use_preview`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceTypes/type`.
            public var _type: Components.Schemas.ToolChoiceTypes._TypePayload
            /// Creates a new `ToolChoiceTypes`.
            ///
            /// - Parameters:
            ///   - _type: The type of hosted tool the model should to use. Learn more about
            public init(_type: Components.Schemas.ToolChoiceTypes._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Emitted when there is an additional text delta. This is also the first event emitted when the transcription starts. Only emitted when you [create a transcription](/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        ///
        /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent`.
        public struct TranscriptTextDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `transcript.text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case transcript_text_delta = "transcript.text.delta"
            }
            /// The type of the event. Always `transcript.text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/type`.
            public var _type: Components.Schemas.TranscriptTextDeltaEvent._TypePayload
            /// The text delta that was additionally transcribed.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/delta`.
            public var delta: Swift.String
            /// The log probabilities of the delta. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/logprobs`.
            public var logprobs: [Components.Schemas.LogProbProperties]?
            /// Creates a new `TranscriptTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `transcript.text.delta`.
            ///   - delta: The text delta that was additionally transcribed.
            ///   - logprobs: The log probabilities of the delta. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            public init(
                _type: Components.Schemas.TranscriptTextDeltaEvent._TypePayload,
                delta: Swift.String,
                logprobs: [Components.Schemas.LogProbProperties]? = nil
            ) {
                self._type = _type
                self.delta = delta
                self.logprobs = logprobs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case delta
                case logprobs
            }
        }
        /// Emitted when the transcription is complete. Contains the complete transcription text. Only emitted when you [create a transcription](/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`.
        ///
        /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent`.
        public struct TranscriptTextDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `transcript.text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case transcript_text_done = "transcript.text.done"
            }
            /// The type of the event. Always `transcript.text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/type`.
            public var _type: Components.Schemas.TranscriptTextDoneEvent._TypePayload
            /// The text that was transcribed.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/text`.
            public var text: Swift.String
            /// The log probabilities of the individual tokens in the transcription. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/logprobs`.
            public var logprobs: [Components.Schemas.LogProbProperties]?
            /// Creates a new `TranscriptTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `transcript.text.done`.
            ///   - text: The text that was transcribed.
            ///   - logprobs: The log probabilities of the individual tokens in the transcription. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            public init(
                _type: Components.Schemas.TranscriptTextDoneEvent._TypePayload,
                text: Swift.String,
                logprobs: [Components.Schemas.LogProbProperties]? = nil
            ) {
                self._type = _type
                self.text = text
                self.logprobs = logprobs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
                case logprobs
            }
        }
        /// - Remark: Generated from `#/components/schemas/TranscriptionInclude`.
        @frozen public enum TranscriptionInclude: String, Codable, Hashable, Sendable, CaseIterable {
            case logprobs = "logprobs"
        }
        /// - Remark: Generated from `#/components/schemas/TranscriptionSegment`.
        public struct TranscriptionSegment: Codable, Hashable, Sendable {
            /// Unique identifier of the segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/id`.
            public var id: Swift.Int
            /// Seek offset of the segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/seek`.
            public var seek: Swift.Int
            /// Start time of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/start`.
            public var start: Swift.Float
            /// End time of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/end`.
            public var end: Swift.Float
            /// Text content of the segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/text`.
            public var text: Swift.String
            /// Array of token IDs for the text content.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/tokens`.
            public var tokens: [Swift.Int]
            /// Temperature parameter used for generating the segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/temperature`.
            public var temperature: Swift.Float
            /// Average logprob of the segment. If the value is lower than -1, consider the logprobs failed.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/avg_logprob`.
            public var avgLogprob: Swift.Float
            /// Compression ratio of the segment. If the value is greater than 2.4, consider the compression failed.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/compression_ratio`.
            public var compressionRatio: Swift.Float
            /// Probability of no speech in the segment. If the value is higher than 1.0 and the `avg_logprob` is below -1, consider this segment silent.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/no_speech_prob`.
            public var noSpeechProb: Swift.Float
            /// Creates a new `TranscriptionSegment`.
            ///
            /// - Parameters:
            ///   - id: Unique identifier of the segment.
            ///   - seek: Seek offset of the segment.
            ///   - start: Start time of the segment in seconds.
            ///   - end: End time of the segment in seconds.
            ///   - text: Text content of the segment.
            ///   - tokens: Array of token IDs for the text content.
            ///   - temperature: Temperature parameter used for generating the segment.
            ///   - avgLogprob: Average logprob of the segment. If the value is lower than -1, consider the logprobs failed.
            ///   - compressionRatio: Compression ratio of the segment. If the value is greater than 2.4, consider the compression failed.
            ///   - noSpeechProb: Probability of no speech in the segment. If the value is higher than 1.0 and the `avg_logprob` is below -1, consider this segment silent.
            public init(
                id: Swift.Int,
                seek: Swift.Int,
                start: Swift.Float,
                end: Swift.Float,
                text: Swift.String,
                tokens: [Swift.Int],
                temperature: Swift.Float,
                avgLogprob: Swift.Float,
                compressionRatio: Swift.Float,
                noSpeechProb: Swift.Float
            ) {
                self.id = id
                self.seek = seek
                self.start = start
                self.end = end
                self.text = text
                self.tokens = tokens
                self.temperature = temperature
                self.avgLogprob = avgLogprob
                self.compressionRatio = compressionRatio
                self.noSpeechProb = noSpeechProb
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case seek
                case start
                case end
                case text
                case tokens
                case temperature
                case avgLogprob = "avg_logprob"
                case compressionRatio = "compression_ratio"
                case noSpeechProb = "no_speech_prob"
            }
        }
        /// - Remark: Generated from `#/components/schemas/TranscriptionWord`.
        public struct TranscriptionWord: Codable, Hashable, Sendable {
            /// The text content of the word.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionWord/word`.
            public var word: Swift.String
            /// Start time of the word in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionWord/start`.
            public var start: Swift.Float
            /// End time of the word in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionWord/end`.
            public var end: Swift.Float
            /// Creates a new `TranscriptionWord`.
            ///
            /// - Parameters:
            ///   - word: The text content of the word.
            ///   - start: Start time of the word in seconds.
            ///   - end: End time of the word in seconds.
            public init(
                word: Swift.String,
                start: Swift.Float,
                end: Swift.Float
            ) {
                self.word = word
                self.start = start
                self.end = end
            }
            public enum CodingKeys: String, CodingKey {
                case word
                case start
                case end
            }
        }
        /// Controls for how a thread will be truncated prior to the run. Use this to control the intial context window of the run.
        ///
        /// - Remark: Generated from `#/components/schemas/TruncationObject`.
        public struct TruncationObject: Codable, Hashable, Sendable {
            /// The truncation strategy to use for the thread. The default is `auto`. If set to `last_messages`, the thread will be truncated to the n most recent messages in the thread. When set to `auto`, messages in the middle of the thread will be dropped to fit the context length of the model, `max_prompt_tokens`.
            ///
            /// - Remark: Generated from `#/components/schemas/TruncationObject/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case lastMessages = "last_messages"
            }
            /// The truncation strategy to use for the thread. The default is `auto`. If set to `last_messages`, the thread will be truncated to the n most recent messages in the thread. When set to `auto`, messages in the middle of the thread will be dropped to fit the context length of the model, `max_prompt_tokens`.
            ///
            /// - Remark: Generated from `#/components/schemas/TruncationObject/type`.
            public var _type: Components.Schemas.TruncationObject._TypePayload
            /// The number of most recent messages from the thread when constructing the context for the run.
            ///
            /// - Remark: Generated from `#/components/schemas/TruncationObject/last_messages`.
            public var lastMessages: Swift.Int?
            /// Creates a new `TruncationObject`.
            ///
            /// - Parameters:
            ///   - _type: The truncation strategy to use for the thread. The default is `auto`. If set to `last_messages`, the thread will be truncated to the n most recent messages in the thread. When set to `auto`, messages in the middle of the thread will be dropped to fit the context length of the model, `max_prompt_tokens`.
            ///   - lastMessages: The number of most recent messages from the thread when constructing the context for the run.
            public init(
                _type: Components.Schemas.TruncationObject._TypePayload,
                lastMessages: Swift.Int? = nil
            ) {
                self._type = _type
                self.lastMessages = lastMessages
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case lastMessages = "last_messages"
            }
        }
        /// An action to type in text.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Type`.
        public struct _Type: Codable, Hashable, Sendable {
            /// Specifies the event type. For a type action, this property is 
            /// always set to `type`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Type/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case _type = "type"
            }
            /// Specifies the event type. For a type action, this property is 
            /// always set to `type`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Type/type`.
            public var _type: Components.Schemas._Type._TypePayload
            /// The text to type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Type/text`.
            public var text: Swift.String
            /// Creates a new `_Type`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a type action, this property is 
            ///   - text: The text to type.
            public init(
                _type: Components.Schemas._Type._TypePayload,
                text: Swift.String
            ) {
                self._type = _type
                self.text = text
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
            }
        }
        /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreFileAttributesRequest`.
        public struct UpdateVectorStoreFileAttributesRequest: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreFileAttributesRequest/attributes`.
            public var attributes: Components.Schemas.VectorStoreFileAttributes?
            /// Creates a new `UpdateVectorStoreFileAttributesRequest`.
            ///
            /// - Parameters:
            ///   - attributes:
            public init(attributes: Components.Schemas.VectorStoreFileAttributes? = nil) {
                self.attributes = attributes
            }
            public enum CodingKeys: String, CodingKey {
                case attributes
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.attributes = try container.decodeIfPresent(
                    Components.Schemas.VectorStoreFileAttributes.self,
                    forKey: .attributes
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "attributes"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest`.
        public struct UpdateVectorStoreRequest: Codable, Hashable, Sendable {
            /// The name of the vector store.
            ///
            /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest/name`.
            public var name: Swift.String?
            /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest/expires_after`.
            public struct ExpiresAfterPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest/expires_after/value1`.
                public var value1: Components.Schemas.VectorStoreExpirationAfter
                /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest/expires_after/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer
                /// Creates a new `ExpiresAfterPayload`.
                ///
                /// - Parameters:
                ///   - value1:
                ///   - value2:
                public init(
                    value1: Components.Schemas.VectorStoreExpirationAfter,
                    value2: OpenAPIRuntime.OpenAPIValueContainer
                ) {
                    self.value1 = value1
                    self.value2 = value2
                }
                public init(from decoder: any Decoder) throws {
                    self.value1 = try .init(from: decoder)
                    self.value2 = try .init(from: decoder)
                }
                public func encode(to encoder: any Encoder) throws {
                    try self.value1.encode(to: encoder)
                    try self.value2.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest/expires_after`.
            public var expiresAfter: Components.Schemas.UpdateVectorStoreRequest.ExpiresAfterPayload?
            /// - Remark: Generated from `#/components/schemas/UpdateVectorStoreRequest/metadata`.
            public var metadata: Components.Schemas.Metadata?
            /// Creates a new `UpdateVectorStoreRequest`.
            ///
            /// - Parameters:
            ///   - name: The name of the vector store.
            ///   - expiresAfter:
            ///   - metadata:
            public init(
                name: Swift.String? = nil,
                expiresAfter: Components.Schemas.UpdateVectorStoreRequest.ExpiresAfterPayload? = nil,
                metadata: Components.Schemas.Metadata? = nil
            ) {
                self.name = name
                self.expiresAfter = expiresAfter
                self.metadata = metadata
            }
            public enum CodingKeys: String, CodingKey {
                case name
                case expiresAfter = "expires_after"
                case metadata
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.name = try container.decodeIfPresent(
                    Swift.String.self,
                    forKey: .name
                )
                self.expiresAfter = try container.decodeIfPresent(
                    Components.Schemas.UpdateVectorStoreRequest.ExpiresAfterPayload.self,
                    forKey: .expiresAfter
                )
                self.metadata = try container.decodeIfPresent(
                    Components.Schemas.Metadata.self,
                    forKey: .metadata
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "name",
                    "expires_after",
                    "metadata"
                ])
            }
        }
        /// The upload Part represents a chunk of bytes we can add to an Upload object.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/UploadPart`.
        public struct UploadPart: Codable, Hashable, Sendable {
            /// The upload Part unique identifier, which can be referenced in API endpoints.
            ///
            /// - Remark: Generated from `#/components/schemas/UploadPart/id`.
            public var id: Swift.String
            /// The Unix timestamp (in seconds) for when the Part was created.
            ///
            /// - Remark: Generated from `#/components/schemas/UploadPart/created_at`.
            public var createdAt: Swift.Int
            /// The ID of the Upload object that this Part was added to.
            ///
            /// - Remark: Generated from `#/components/schemas/UploadPart/upload_id`.
            public var uploadId: Swift.String
            /// The object type, which is always `upload.part`.
            ///
            /// - Remark: Generated from `#/components/schemas/UploadPart/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case upload_part = "upload.part"
            }
            /// The object type, which is always `upload.part`.
            ///
            /// - Remark: Generated from `#/components/schemas/UploadPart/object`.
            public var object: Components.Schemas.UploadPart.ObjectPayload
            /// Creates a new `UploadPart`.
            ///
            /// - Parameters:
            ///   - id: The upload Part unique identifier, which can be referenced in API endpoints.
            ///   - createdAt: The Unix timestamp (in seconds) for when the Part was created.
            ///   - uploadId: The ID of the Upload object that this Part was added to.
            ///   - object: The object type, which is always `upload.part`.
            public init(
                id: Swift.String,
                createdAt: Swift.Int,
                uploadId: Swift.String,
                object: Components.Schemas.UploadPart.ObjectPayload
            ) {
                self.id = id
                self.createdAt = createdAt
                self.uploadId = uploadId
                self.object = object
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case createdAt = "created_at"
                case uploadId = "upload_id"
                case object
            }
        }
        /// A citation for a web resource used to generate a model response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/UrlCitation`.
        public struct UrlCitation: Codable, Hashable, Sendable {
            /// The URL of the web resource.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitation/url`.
            public var url: Swift.String
            /// The title of the web resource.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitation/title`.
            public var title: Swift.String
            /// The type of the URL citation. Always `url_citation`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case urlCitation = "url_citation"
            }
            /// The type of the URL citation. Always `url_citation`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitation/type`.
            public var _type: Components.Schemas.UrlCitation._TypePayload
            /// The index of the first character of the URL citation in the message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitation/start_index`.
            public var startIndex: Swift.Int
            /// The index of the last character of the URL citation in the message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitation/end_index`.
            public var endIndex: Swift.Int
            /// Creates a new `UrlCitation`.
            ///
            /// - Parameters:
            ///   - url: The URL of the web resource.
            ///   - title: The title of the web resource.
            ///   - _type: The type of the URL citation. Always `url_citation`.
            ///   - startIndex: The index of the first character of the URL citation in the message.
            ///   - endIndex: The index of the last character of the URL citation in the message.
            public init(
                url: Swift.String,
                title: Swift.String,
                _type: Components.Schemas.UrlCitation._TypePayload,
                startIndex: Swift.Int,
                endIndex: Swift.Int
            ) {
                self.url = url
                self.title = title
                self._type = _type
                self.startIndex = startIndex
                self.endIndex = endIndex
            }
            public enum CodingKeys: String, CodingKey {
                case url
                case title
                case _type = "type"
                case startIndex = "start_index"
                case endIndex = "end_index"
            }
        }
        /// The aggregated audio speeches usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult`.
        public struct UsageAudioSpeechesResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_audioSpeeches_result = "organization.usage.audio_speeches.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/object`.
            public var object: Components.Schemas.UsageAudioSpeechesResult.ObjectPayload
            /// The number of characters processed.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/characters`.
            public var characters: Swift.Int
            /// The count of requests made to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/num_model_requests`.
            public var numModelRequests: Swift.Int
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/project_id`.
            public var projectId: Swift.String?
            /// When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/user_id`.
            public var userId: Swift.String?
            /// When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/api_key_id`.
            public var apiKeyId: Swift.String?
            /// When `group_by=model`, this field provides the model name of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioSpeechesResult/model`.
            public var model: Swift.String?
            /// Creates a new `UsageAudioSpeechesResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - characters: The number of characters processed.
            ///   - numModelRequests: The count of requests made to the model.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///   - userId: When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///   - apiKeyId: When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///   - model: When `group_by=model`, this field provides the model name of the grouped usage result.
            public init(
                object: Components.Schemas.UsageAudioSpeechesResult.ObjectPayload,
                characters: Swift.Int,
                numModelRequests: Swift.Int,
                projectId: Swift.String? = nil,
                userId: Swift.String? = nil,
                apiKeyId: Swift.String? = nil,
                model: Swift.String? = nil
            ) {
                self.object = object
                self.characters = characters
                self.numModelRequests = numModelRequests
                self.projectId = projectId
                self.userId = userId
                self.apiKeyId = apiKeyId
                self.model = model
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case characters
                case numModelRequests = "num_model_requests"
                case projectId = "project_id"
                case userId = "user_id"
                case apiKeyId = "api_key_id"
                case model
            }
        }
        /// The aggregated audio transcriptions usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult`.
        public struct UsageAudioTranscriptionsResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_audioTranscriptions_result = "organization.usage.audio_transcriptions.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/object`.
            public var object: Components.Schemas.UsageAudioTranscriptionsResult.ObjectPayload
            /// The number of seconds processed.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/seconds`.
            public var seconds: Swift.Int
            /// The count of requests made to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/num_model_requests`.
            public var numModelRequests: Swift.Int
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/project_id`.
            public var projectId: Swift.String?
            /// When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/user_id`.
            public var userId: Swift.String?
            /// When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/api_key_id`.
            public var apiKeyId: Swift.String?
            /// When `group_by=model`, this field provides the model name of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageAudioTranscriptionsResult/model`.
            public var model: Swift.String?
            /// Creates a new `UsageAudioTranscriptionsResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - seconds: The number of seconds processed.
            ///   - numModelRequests: The count of requests made to the model.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///   - userId: When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///   - apiKeyId: When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///   - model: When `group_by=model`, this field provides the model name of the grouped usage result.
            public init(
                object: Components.Schemas.UsageAudioTranscriptionsResult.ObjectPayload,
                seconds: Swift.Int,
                numModelRequests: Swift.Int,
                projectId: Swift.String? = nil,
                userId: Swift.String? = nil,
                apiKeyId: Swift.String? = nil,
                model: Swift.String? = nil
            ) {
                self.object = object
                self.seconds = seconds
                self.numModelRequests = numModelRequests
                self.projectId = projectId
                self.userId = userId
                self.apiKeyId = apiKeyId
                self.model = model
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case seconds
                case numModelRequests = "num_model_requests"
                case projectId = "project_id"
                case userId = "user_id"
                case apiKeyId = "api_key_id"
                case model
            }
        }
        /// The aggregated code interpreter sessions usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageCodeInterpreterSessionsResult`.
        public struct UsageCodeInterpreterSessionsResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageCodeInterpreterSessionsResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_codeInterpreterSessions_result = "organization.usage.code_interpreter_sessions.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageCodeInterpreterSessionsResult/object`.
            public var object: Components.Schemas.UsageCodeInterpreterSessionsResult.ObjectPayload
            /// The number of code interpreter sessions.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCodeInterpreterSessionsResult/num_sessions`.
            public var numSessions: Swift.Int?
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCodeInterpreterSessionsResult/project_id`.
            public var projectId: Swift.String?
            /// Creates a new `UsageCodeInterpreterSessionsResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - numSessions: The number of code interpreter sessions.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            public init(
                object: Components.Schemas.UsageCodeInterpreterSessionsResult.ObjectPayload,
                numSessions: Swift.Int? = nil,
                projectId: Swift.String? = nil
            ) {
                self.object = object
                self.numSessions = numSessions
                self.projectId = projectId
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case numSessions = "num_sessions"
                case projectId = "project_id"
            }
        }
        /// The aggregated completions usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult`.
        public struct UsageCompletionsResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_completions_result = "organization.usage.completions.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/object`.
            public var object: Components.Schemas.UsageCompletionsResult.ObjectPayload
            /// The aggregated number of text input tokens used, including cached tokens. For customers subscribe to scale tier, this includes scale tier tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/input_tokens`.
            public var inputTokens: Swift.Int
            /// The aggregated number of text input tokens that has been cached from previous requests. For customers subscribe to scale tier, this includes scale tier tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/input_cached_tokens`.
            public var inputCachedTokens: Swift.Int?
            /// The aggregated number of text output tokens used. For customers subscribe to scale tier, this includes scale tier tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/output_tokens`.
            public var outputTokens: Swift.Int
            /// The aggregated number of audio input tokens used, including cached tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/input_audio_tokens`.
            public var inputAudioTokens: Swift.Int?
            /// The aggregated number of audio output tokens used.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/output_audio_tokens`.
            public var outputAudioTokens: Swift.Int?
            /// The count of requests made to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/num_model_requests`.
            public var numModelRequests: Swift.Int
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/project_id`.
            public var projectId: Swift.String?
            /// When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/user_id`.
            public var userId: Swift.String?
            /// When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/api_key_id`.
            public var apiKeyId: Swift.String?
            /// When `group_by=model`, this field provides the model name of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/model`.
            public var model: Swift.String?
            /// When `group_by=batch`, this field tells whether the grouped usage result is batch or not.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageCompletionsResult/batch`.
            public var batch: Swift.Bool?
            /// Creates a new `UsageCompletionsResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - inputTokens: The aggregated number of text input tokens used, including cached tokens. For customers subscribe to scale tier, this includes scale tier tokens.
            ///   - inputCachedTokens: The aggregated number of text input tokens that has been cached from previous requests. For customers subscribe to scale tier, this includes scale tier tokens.
            ///   - outputTokens: The aggregated number of text output tokens used. For customers subscribe to scale tier, this includes scale tier tokens.
            ///   - inputAudioTokens: The aggregated number of audio input tokens used, including cached tokens.
            ///   - outputAudioTokens: The aggregated number of audio output tokens used.
            ///   - numModelRequests: The count of requests made to the model.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///   - userId: When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///   - apiKeyId: When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///   - model: When `group_by=model`, this field provides the model name of the grouped usage result.
            ///   - batch: When `group_by=batch`, this field tells whether the grouped usage result is batch or not.
            public init(
                object: Components.Schemas.UsageCompletionsResult.ObjectPayload,
                inputTokens: Swift.Int,
                inputCachedTokens: Swift.Int? = nil,
                outputTokens: Swift.Int,
                inputAudioTokens: Swift.Int? = nil,
                outputAudioTokens: Swift.Int? = nil,
                numModelRequests: Swift.Int,
                projectId: Swift.String? = nil,
                userId: Swift.String? = nil,
                apiKeyId: Swift.String? = nil,
                model: Swift.String? = nil,
                batch: Swift.Bool? = nil
            ) {
                self.object = object
                self.inputTokens = inputTokens
                self.inputCachedTokens = inputCachedTokens
                self.outputTokens = outputTokens
                self.inputAudioTokens = inputAudioTokens
                self.outputAudioTokens = outputAudioTokens
                self.numModelRequests = numModelRequests
                self.projectId = projectId
                self.userId = userId
                self.apiKeyId = apiKeyId
                self.model = model
                self.batch = batch
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case inputTokens = "input_tokens"
                case inputCachedTokens = "input_cached_tokens"
                case outputTokens = "output_tokens"
                case inputAudioTokens = "input_audio_tokens"
                case outputAudioTokens = "output_audio_tokens"
                case numModelRequests = "num_model_requests"
                case projectId = "project_id"
                case userId = "user_id"
                case apiKeyId = "api_key_id"
                case model
                case batch
            }
        }
        /// The aggregated embeddings usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult`.
        public struct UsageEmbeddingsResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_embeddings_result = "organization.usage.embeddings.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/object`.
            public var object: Components.Schemas.UsageEmbeddingsResult.ObjectPayload
            /// The aggregated number of input tokens used.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/input_tokens`.
            public var inputTokens: Swift.Int
            /// The count of requests made to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/num_model_requests`.
            public var numModelRequests: Swift.Int
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/project_id`.
            public var projectId: Swift.String?
            /// When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/user_id`.
            public var userId: Swift.String?
            /// When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/api_key_id`.
            public var apiKeyId: Swift.String?
            /// When `group_by=model`, this field provides the model name of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageEmbeddingsResult/model`.
            public var model: Swift.String?
            /// Creates a new `UsageEmbeddingsResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - inputTokens: The aggregated number of input tokens used.
            ///   - numModelRequests: The count of requests made to the model.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///   - userId: When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///   - apiKeyId: When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///   - model: When `group_by=model`, this field provides the model name of the grouped usage result.
            public init(
                object: Components.Schemas.UsageEmbeddingsResult.ObjectPayload,
                inputTokens: Swift.Int,
                numModelRequests: Swift.Int,
                projectId: Swift.String? = nil,
                userId: Swift.String? = nil,
                apiKeyId: Swift.String? = nil,
                model: Swift.String? = nil
            ) {
                self.object = object
                self.inputTokens = inputTokens
                self.numModelRequests = numModelRequests
                self.projectId = projectId
                self.userId = userId
                self.apiKeyId = apiKeyId
                self.model = model
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case inputTokens = "input_tokens"
                case numModelRequests = "num_model_requests"
                case projectId = "project_id"
                case userId = "user_id"
                case apiKeyId = "api_key_id"
                case model
            }
        }
        /// The aggregated images usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageImagesResult`.
        public struct UsageImagesResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_images_result = "organization.usage.images.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/object`.
            public var object: Components.Schemas.UsageImagesResult.ObjectPayload
            /// The number of images processed.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/images`.
            public var images: Swift.Int
            /// The count of requests made to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/num_model_requests`.
            public var numModelRequests: Swift.Int
            /// When `group_by=source`, this field provides the source of the grouped usage result, possible values are `image.generation`, `image.edit`, `image.variation`.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/source`.
            public var source: Swift.String?
            /// When `group_by=size`, this field provides the image size of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/size`.
            public var size: Swift.String?
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/project_id`.
            public var projectId: Swift.String?
            /// When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/user_id`.
            public var userId: Swift.String?
            /// When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/api_key_id`.
            public var apiKeyId: Swift.String?
            /// When `group_by=model`, this field provides the model name of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageImagesResult/model`.
            public var model: Swift.String?
            /// Creates a new `UsageImagesResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - images: The number of images processed.
            ///   - numModelRequests: The count of requests made to the model.
            ///   - source: When `group_by=source`, this field provides the source of the grouped usage result, possible values are `image.generation`, `image.edit`, `image.variation`.
            ///   - size: When `group_by=size`, this field provides the image size of the grouped usage result.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///   - userId: When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///   - apiKeyId: When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///   - model: When `group_by=model`, this field provides the model name of the grouped usage result.
            public init(
                object: Components.Schemas.UsageImagesResult.ObjectPayload,
                images: Swift.Int,
                numModelRequests: Swift.Int,
                source: Swift.String? = nil,
                size: Swift.String? = nil,
                projectId: Swift.String? = nil,
                userId: Swift.String? = nil,
                apiKeyId: Swift.String? = nil,
                model: Swift.String? = nil
            ) {
                self.object = object
                self.images = images
                self.numModelRequests = numModelRequests
                self.source = source
                self.size = size
                self.projectId = projectId
                self.userId = userId
                self.apiKeyId = apiKeyId
                self.model = model
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case images
                case numModelRequests = "num_model_requests"
                case source
                case size
                case projectId = "project_id"
                case userId = "user_id"
                case apiKeyId = "api_key_id"
                case model
            }
        }
        /// The aggregated moderations usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageModerationsResult`.
        public struct UsageModerationsResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_moderations_result = "organization.usage.moderations.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/object`.
            public var object: Components.Schemas.UsageModerationsResult.ObjectPayload
            /// The aggregated number of input tokens used.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/input_tokens`.
            public var inputTokens: Swift.Int
            /// The count of requests made to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/num_model_requests`.
            public var numModelRequests: Swift.Int
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/project_id`.
            public var projectId: Swift.String?
            /// When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/user_id`.
            public var userId: Swift.String?
            /// When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/api_key_id`.
            public var apiKeyId: Swift.String?
            /// When `group_by=model`, this field provides the model name of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageModerationsResult/model`.
            public var model: Swift.String?
            /// Creates a new `UsageModerationsResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - inputTokens: The aggregated number of input tokens used.
            ///   - numModelRequests: The count of requests made to the model.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///   - userId: When `group_by=user_id`, this field provides the user ID of the grouped usage result.
            ///   - apiKeyId: When `group_by=api_key_id`, this field provides the API key ID of the grouped usage result.
            ///   - model: When `group_by=model`, this field provides the model name of the grouped usage result.
            public init(
                object: Components.Schemas.UsageModerationsResult.ObjectPayload,
                inputTokens: Swift.Int,
                numModelRequests: Swift.Int,
                projectId: Swift.String? = nil,
                userId: Swift.String? = nil,
                apiKeyId: Swift.String? = nil,
                model: Swift.String? = nil
            ) {
                self.object = object
                self.inputTokens = inputTokens
                self.numModelRequests = numModelRequests
                self.projectId = projectId
                self.userId = userId
                self.apiKeyId = apiKeyId
                self.model = model
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case inputTokens = "input_tokens"
                case numModelRequests = "num_model_requests"
                case projectId = "project_id"
                case userId = "user_id"
                case apiKeyId = "api_key_id"
                case model
            }
        }
        /// - Remark: Generated from `#/components/schemas/UsageResponse`.
        public struct UsageResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageResponse/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case page = "page"
            }
            /// - Remark: Generated from `#/components/schemas/UsageResponse/object`.
            public var object: Components.Schemas.UsageResponse.ObjectPayload
            /// - Remark: Generated from `#/components/schemas/UsageResponse/data`.
            public var data: [Components.Schemas.UsageTimeBucket]
            /// - Remark: Generated from `#/components/schemas/UsageResponse/has_more`.
            public var hasMore: Swift.Bool
            /// - Remark: Generated from `#/components/schemas/UsageResponse/next_page`.
            public var nextPage: Swift.String
            /// Creates a new `UsageResponse`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - data:
            ///   - hasMore:
            ///   - nextPage:
            public init(
                object: Components.Schemas.UsageResponse.ObjectPayload,
                data: [Components.Schemas.UsageTimeBucket],
                hasMore: Swift.Bool,
                nextPage: Swift.String
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.nextPage = nextPage
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case data
                case hasMore = "has_more"
                case nextPage = "next_page"
            }
        }
        /// - Remark: Generated from `#/components/schemas/UsageTimeBucket`.
        public struct UsageTimeBucket: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case bucket = "bucket"
            }
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/object`.
            public var object: Components.Schemas.UsageTimeBucket.ObjectPayload
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/start_time`.
            public var startTime: Swift.Int
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/end_time`.
            public var endTime: Swift.Int
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload`.
            @frozen public enum ResultPayloadPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case1`.
                case UsageCompletionsResult(Components.Schemas.UsageCompletionsResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case2`.
                case UsageEmbeddingsResult(Components.Schemas.UsageEmbeddingsResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case3`.
                case UsageModerationsResult(Components.Schemas.UsageModerationsResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case4`.
                case UsageImagesResult(Components.Schemas.UsageImagesResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case5`.
                case UsageAudioSpeechesResult(Components.Schemas.UsageAudioSpeechesResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case6`.
                case UsageAudioTranscriptionsResult(Components.Schemas.UsageAudioTranscriptionsResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case7`.
                case UsageVectorStoresResult(Components.Schemas.UsageVectorStoresResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case8`.
                case UsageCodeInterpreterSessionsResult(Components.Schemas.UsageCodeInterpreterSessionsResult)
                /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/ResultPayload/case9`.
                case CostsResult(Components.Schemas.CostsResult)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .UsageCompletionsResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageEmbeddingsResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageModerationsResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageImagesResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageAudioSpeechesResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageAudioTranscriptionsResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageVectorStoresResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .UsageCodeInterpreterSessionsResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .CostsResult(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .UsageCompletionsResult(value):
                        try value.encode(to: encoder)
                    case let .UsageEmbeddingsResult(value):
                        try value.encode(to: encoder)
                    case let .UsageModerationsResult(value):
                        try value.encode(to: encoder)
                    case let .UsageImagesResult(value):
                        try value.encode(to: encoder)
                    case let .UsageAudioSpeechesResult(value):
                        try value.encode(to: encoder)
                    case let .UsageAudioTranscriptionsResult(value):
                        try value.encode(to: encoder)
                    case let .UsageVectorStoresResult(value):
                        try value.encode(to: encoder)
                    case let .UsageCodeInterpreterSessionsResult(value):
                        try value.encode(to: encoder)
                    case let .CostsResult(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/result`.
            public typealias ResultPayload = [Components.Schemas.UsageTimeBucket.ResultPayloadPayload]
            /// - Remark: Generated from `#/components/schemas/UsageTimeBucket/result`.
            public var result: Components.Schemas.UsageTimeBucket.ResultPayload
            /// Creates a new `UsageTimeBucket`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - startTime:
            ///   - endTime:
            ///   - result:
            public init(
                object: Components.Schemas.UsageTimeBucket.ObjectPayload,
                startTime: Swift.Int,
                endTime: Swift.Int,
                result: Components.Schemas.UsageTimeBucket.ResultPayload
            ) {
                self.object = object
                self.startTime = startTime
                self.endTime = endTime
                self.result = result
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case startTime = "start_time"
                case endTime = "end_time"
                case result
            }
        }
        /// The aggregated vector stores usage details of the specific time bucket.
        ///
        /// - Remark: Generated from `#/components/schemas/UsageVectorStoresResult`.
        public struct UsageVectorStoresResult: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UsageVectorStoresResult/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_usage_vectorStores_result = "organization.usage.vector_stores.result"
            }
            /// - Remark: Generated from `#/components/schemas/UsageVectorStoresResult/object`.
            public var object: Components.Schemas.UsageVectorStoresResult.ObjectPayload
            /// The vector stores usage in bytes.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageVectorStoresResult/usage_bytes`.
            public var usageBytes: Swift.Int
            /// When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            ///
            /// - Remark: Generated from `#/components/schemas/UsageVectorStoresResult/project_id`.
            public var projectId: Swift.String?
            /// Creates a new `UsageVectorStoresResult`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - usageBytes: The vector stores usage in bytes.
            ///   - projectId: When `group_by=project_id`, this field provides the project ID of the grouped usage result.
            public init(
                object: Components.Schemas.UsageVectorStoresResult.ObjectPayload,
                usageBytes: Swift.Int,
                projectId: Swift.String? = nil
            ) {
                self.object = object
                self.usageBytes = usageBytes
                self.projectId = projectId
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case usageBytes = "usage_bytes"
                case projectId = "project_id"
            }
        }
        /// Represents an individual `user` within an organization.
        ///
        /// - Remark: Generated from `#/components/schemas/User`.
        public struct User: Codable, Hashable, Sendable {
            /// The object type, which is always `organization.user`
            ///
            /// - Remark: Generated from `#/components/schemas/User/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_user = "organization.user"
            }
            /// The object type, which is always `organization.user`
            ///
            /// - Remark: Generated from `#/components/schemas/User/object`.
            public var object: Components.Schemas.User.ObjectPayload
            /// The identifier, which can be referenced in API endpoints
            ///
            /// - Remark: Generated from `#/components/schemas/User/id`.
            public var id: Swift.String
            /// The name of the user
            ///
            /// - Remark: Generated from `#/components/schemas/User/name`.
            public var name: Swift.String
            /// The email address of the user
            ///
            /// - Remark: Generated from `#/components/schemas/User/email`.
            public var email: Swift.String
            /// `owner` or `reader`
            ///
            /// - Remark: Generated from `#/components/schemas/User/role`.
            @frozen public enum RolePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case owner = "owner"
                case reader = "reader"
            }
            /// `owner` or `reader`
            ///
            /// - Remark: Generated from `#/components/schemas/User/role`.
            public var role: Components.Schemas.User.RolePayload
            /// The Unix timestamp (in seconds) of when the user was added.
            ///
            /// - Remark: Generated from `#/components/schemas/User/added_at`.
            public var addedAt: Swift.Int
            /// Creates a new `User`.
            ///
            /// - Parameters:
            ///   - object: The object type, which is always `organization.user`
            ///   - id: The identifier, which can be referenced in API endpoints
            ///   - name: The name of the user
            ///   - email: The email address of the user
            ///   - role: `owner` or `reader`
            ///   - addedAt: The Unix timestamp (in seconds) of when the user was added.
            public init(
                object: Components.Schemas.User.ObjectPayload,
                id: Swift.String,
                name: Swift.String,
                email: Swift.String,
                role: Components.Schemas.User.RolePayload,
                addedAt: Swift.Int
            ) {
                self.object = object
                self.id = id
                self.name = name
                self.email = email
                self.role = role
                self.addedAt = addedAt
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case id
                case name
                case email
                case role
                case addedAt = "added_at"
            }
        }
        /// - Remark: Generated from `#/components/schemas/UserDeleteResponse`.
        public struct UserDeleteResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UserDeleteResponse/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case organization_user_deleted = "organization.user.deleted"
            }
            /// - Remark: Generated from `#/components/schemas/UserDeleteResponse/object`.
            public var object: Components.Schemas.UserDeleteResponse.ObjectPayload
            /// - Remark: Generated from `#/components/schemas/UserDeleteResponse/id`.
            public var id: Swift.String
            /// - Remark: Generated from `#/components/schemas/UserDeleteResponse/deleted`.
            public var deleted: Swift.Bool
            /// Creates a new `UserDeleteResponse`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - id:
            ///   - deleted:
            public init(
                object: Components.Schemas.UserDeleteResponse.ObjectPayload,
                id: Swift.String,
                deleted: Swift.Bool
            ) {
                self.object = object
                self.id = id
                self.deleted = deleted
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case id
                case deleted
            }
        }
        /// - Remark: Generated from `#/components/schemas/UserListResponse`.
        public struct UserListResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/UserListResponse/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case list = "list"
            }
            /// - Remark: Generated from `#/components/schemas/UserListResponse/object`.
            public var object: Components.Schemas.UserListResponse.ObjectPayload
            /// - Remark: Generated from `#/components/schemas/UserListResponse/data`.
            public var data: [Components.Schemas.User]
            /// - Remark: Generated from `#/components/schemas/UserListResponse/first_id`.
            public var firstId: Swift.String
            /// - Remark: Generated from `#/components/schemas/UserListResponse/last_id`.
            public var lastId: Swift.String
            /// - Remark: Generated from `#/components/schemas/UserListResponse/has_more`.
            public var hasMore: Swift.Bool
            /// Creates a new `UserListResponse`.
            ///
            /// - Parameters:
            ///   - object:
            ///   - data:
            ///   - firstId:
            ///   - lastId:
            ///   - hasMore:
            public init(
                object: Components.Schemas.UserListResponse.ObjectPayload,
                data: [Components.Schemas.User],
                firstId: Swift.String,
                lastId: Swift.String,
                hasMore: Swift.Bool
            ) {
                self.object = object
                self.data = data
                self.firstId = firstId
                self.lastId = lastId
                self.hasMore = hasMore
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case data
                case firstId = "first_id"
                case lastId = "last_id"
                case hasMore = "has_more"
            }
        }
        /// - Remark: Generated from `#/components/schemas/UserRoleUpdateRequest`.
        public struct UserRoleUpdateRequest: Codable, Hashable, Sendable {
            /// `owner` or `reader`
            ///
            /// - Remark: Generated from `#/components/schemas/UserRoleUpdateRequest/role`.
            @frozen public enum RolePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case owner = "owner"
                case reader = "reader"
            }
            /// `owner` or `reader`
            ///
            /// - Remark: Generated from `#/components/schemas/UserRoleUpdateRequest/role`.
            public var role: Components.Schemas.UserRoleUpdateRequest.RolePayload
            /// Creates a new `UserRoleUpdateRequest`.
            ///
            /// - Parameters:
            ///   - role: `owner` or `reader`
            public init(role: Components.Schemas.UserRoleUpdateRequest.RolePayload) {
                self.role = role
            }
            public enum CodingKeys: String, CodingKey {
                case role
            }
        }
        /// The expiration policy for a vector store.
        ///
        /// - Remark: Generated from `#/components/schemas/VectorStoreExpirationAfter`.
        public struct VectorStoreExpirationAfter: Codable, Hashable, Sendable {
            /// Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreExpirationAfter/anchor`.
            @frozen public enum AnchorPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case lastActiveAt = "last_active_at"
            }
            /// Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreExpirationAfter/anchor`.
            public var anchor: Components.Schemas.VectorStoreExpirationAfter.AnchorPayload
            /// The number of days after the anchor time that the vector store will expire.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreExpirationAfter/days`.
            public var days: Swift.Int
            /// Creates a new `VectorStoreExpirationAfter`.
            ///
            /// - Parameters:
            ///   - anchor: Anchor timestamp after which the expiration policy applies. Supported anchors: `last_active_at`.
            ///   - days: The number of days after the anchor time that the vector store will expire.
            public init(
                anchor: Components.Schemas.VectorStoreExpirationAfter.AnchorPayload,
                days: Swift.Int
            ) {
                self.anchor = anchor
                self.days = days
            }
            public enum CodingKeys: String, CodingKey {
                case anchor
                case days
            }
        }
        /// Set of 16 key-value pairs that can be attached to an object. This can be 
        /// useful for storing additional information about the object in a structured 
        /// format, and querying for objects via API or the dashboard. Keys are strings 
        /// with a maximum length of 64 characters. Values are strings with a maximum 
        /// length of 512 characters, booleans, or numbers.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/VectorStoreFileAttributes`.
        public struct VectorStoreFileAttributes: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileAttributes/additionalProperties`.
            @frozen public enum AdditionalPropertiesPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileAttributes/additionalProperties/case1`.
                case case1(Swift.String)
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileAttributes/additionalProperties/case2`.
                case case2(Swift.Double)
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileAttributes/additionalProperties/case3`.
                case case3(Swift.Bool)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .case2(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .case3(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case3(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// A container of undocumented properties.
            public var additionalProperties: [String: Components.Schemas.VectorStoreFileAttributes.AdditionalPropertiesPayload]
            /// Creates a new `VectorStoreFileAttributes`.
            ///
            /// - Parameters:
            ///   - additionalProperties: A container of undocumented properties.
            public init(additionalProperties: [String: Components.Schemas.VectorStoreFileAttributes.AdditionalPropertiesPayload] = .init()) {
                self.additionalProperties = additionalProperties
            }
            public init(from decoder: any Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeAdditionalProperties(additionalProperties)
            }
        }
        /// A batch of files attached to a vector store.
        ///
        /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject`.
        public struct VectorStoreFileBatchObject: Codable, Hashable, Sendable {
            /// The identifier, which can be referenced in API endpoints.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/id`.
            public var id: Swift.String
            /// The object type, which is always `vector_store.file_batch`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case vectorStore_filesBatch = "vector_store.files_batch"
            }
            /// The object type, which is always `vector_store.file_batch`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/object`.
            public var object: Components.Schemas.VectorStoreFileBatchObject.ObjectPayload
            /// The Unix timestamp (in seconds) for when the vector store files batch was created.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/created_at`.
            public var createdAt: Swift.Int
            /// The ID of the [vector store](/docs/api-reference/vector-stores/object) that the [File](/docs/api-reference/files) is attached to.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/vector_store_id`.
            public var vectorStoreId: Swift.String
            /// The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case cancelled = "cancelled"
                case failed = "failed"
            }
            /// The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/status`.
            public var status: Components.Schemas.VectorStoreFileBatchObject.StatusPayload
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts`.
            public struct FileCountsPayload: Codable, Hashable, Sendable {
                /// The number of files that are currently being processed.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts/in_progress`.
                public var inProgress: Swift.Int
                /// The number of files that have been processed.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts/completed`.
                public var completed: Swift.Int
                /// The number of files that have failed to process.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts/failed`.
                public var failed: Swift.Int
                /// The number of files that where cancelled.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts/cancelled`.
                public var cancelled: Swift.Int
                /// The total number of files.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts/total`.
                public var total: Swift.Int
                /// Creates a new `FileCountsPayload`.
                ///
                /// - Parameters:
                ///   - inProgress: The number of files that are currently being processed.
                ///   - completed: The number of files that have been processed.
                ///   - failed: The number of files that have failed to process.
                ///   - cancelled: The number of files that where cancelled.
                ///   - total: The total number of files.
                public init(
                    inProgress: Swift.Int,
                    completed: Swift.Int,
                    failed: Swift.Int,
                    cancelled: Swift.Int,
                    total: Swift.Int
                ) {
                    self.inProgress = inProgress
                    self.completed = completed
                    self.failed = failed
                    self.cancelled = cancelled
                    self.total = total
                }
                public enum CodingKeys: String, CodingKey {
                    case inProgress = "in_progress"
                    case completed
                    case failed
                    case cancelled
                    case total
                }
            }
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileBatchObject/file_counts`.
            public var fileCounts: Components.Schemas.VectorStoreFileBatchObject.FileCountsPayload
            /// Creates a new `VectorStoreFileBatchObject`.
            ///
            /// - Parameters:
            ///   - id: The identifier, which can be referenced in API endpoints.
            ///   - object: The object type, which is always `vector_store.file_batch`.
            ///   - createdAt: The Unix timestamp (in seconds) for when the vector store files batch was created.
            ///   - vectorStoreId: The ID of the [vector store](/docs/api-reference/vector-stores/object) that the [File](/docs/api-reference/files) is attached to.
            ///   - status: The status of the vector store files batch, which can be either `in_progress`, `completed`, `cancelled` or `failed`.
            ///   - fileCounts:
            public init(
                id: Swift.String,
                object: Components.Schemas.VectorStoreFileBatchObject.ObjectPayload,
                createdAt: Swift.Int,
                vectorStoreId: Swift.String,
                status: Components.Schemas.VectorStoreFileBatchObject.StatusPayload,
                fileCounts: Components.Schemas.VectorStoreFileBatchObject.FileCountsPayload
            ) {
                self.id = id
                self.object = object
                self.createdAt = createdAt
                self.vectorStoreId = vectorStoreId
                self.status = status
                self.fileCounts = fileCounts
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case object
                case createdAt = "created_at"
                case vectorStoreId = "vector_store_id"
                case status
                case fileCounts = "file_counts"
            }
        }
        /// Represents the parsed content of a vector store file.
        ///
        /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse`.
        public struct VectorStoreFileContentResponse: Codable, Hashable, Sendable {
            /// The object type, which is always `vector_store.file_content.page`
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case vectorStore_fileContent_page = "vector_store.file_content.page"
            }
            /// The object type, which is always `vector_store.file_content.page`
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/object`.
            public var object: Components.Schemas.VectorStoreFileContentResponse.ObjectPayload
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/DataPayload`.
            public struct DataPayloadPayload: Codable, Hashable, Sendable {
                /// The content type (currently only `"text"`)
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/DataPayload/type`.
                public var _type: Swift.String?
                /// The text content
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/DataPayload/text`.
                public var text: Swift.String?
                /// Creates a new `DataPayloadPayload`.
                ///
                /// - Parameters:
                ///   - _type: The content type (currently only `"text"`)
                ///   - text: The text content
                public init(
                    _type: Swift.String? = nil,
                    text: Swift.String? = nil
                ) {
                    self._type = _type
                    self.text = text
                }
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                    case text
                }
            }
            /// Parsed content of the file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/data`.
            public typealias DataPayload = [Components.Schemas.VectorStoreFileContentResponse.DataPayloadPayload]
            /// Parsed content of the file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/data`.
            public var data: Components.Schemas.VectorStoreFileContentResponse.DataPayload
            /// Indicates if there are more content pages to fetch.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/has_more`.
            public var hasMore: Swift.Bool
            /// The token for the next page, if any.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileContentResponse/next_page`.
            public var nextPage: Swift.String?
            /// Creates a new `VectorStoreFileContentResponse`.
            ///
            /// - Parameters:
            ///   - object: The object type, which is always `vector_store.file_content.page`
            ///   - data: Parsed content of the file.
            ///   - hasMore: Indicates if there are more content pages to fetch.
            ///   - nextPage: The token for the next page, if any.
            public init(
                object: Components.Schemas.VectorStoreFileContentResponse.ObjectPayload,
                data: Components.Schemas.VectorStoreFileContentResponse.DataPayload,
                hasMore: Swift.Bool,
                nextPage: Swift.String? = nil
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.nextPage = nextPage
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case data
                case hasMore = "has_more"
                case nextPage = "next_page"
            }
        }
        /// A list of files attached to a vector store.
        ///
        /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject`.
        public struct VectorStoreFileObject: Codable, Hashable, Sendable {
            /// The identifier, which can be referenced in API endpoints.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/id`.
            public var id: Swift.String
            /// The object type, which is always `vector_store.file`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case vectorStore_file = "vector_store.file"
            }
            /// The object type, which is always `vector_store.file`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/object`.
            public var object: Components.Schemas.VectorStoreFileObject.ObjectPayload
            /// The total vector store usage in bytes. Note that this may be different from the original file size.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/usage_bytes`.
            public var usageBytes: Swift.Int
            /// The Unix timestamp (in seconds) for when the vector store file was created.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/created_at`.
            public var createdAt: Swift.Int
            /// The ID of the [vector store](/docs/api-reference/vector-stores/object) that the [File](/docs/api-reference/files) is attached to.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/vector_store_id`.
            public var vectorStoreId: Swift.String
            /// The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case cancelled = "cancelled"
                case failed = "failed"
            }
            /// The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/status`.
            public var status: Components.Schemas.VectorStoreFileObject.StatusPayload
            /// The last error associated with this vector store file. Will be `null` if there are no errors.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/last_error`.
            public struct LastErrorPayload: Codable, Hashable, Sendable {
                /// One of `server_error` or `rate_limit_exceeded`.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/last_error/code`.
                @frozen public enum CodePayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case serverError = "server_error"
                    case unsupportedFile = "unsupported_file"
                    case invalidFile = "invalid_file"
                }
                /// One of `server_error` or `rate_limit_exceeded`.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/last_error/code`.
                public var code: Components.Schemas.VectorStoreFileObject.LastErrorPayload.CodePayload
                /// A human-readable description of the error.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/last_error/message`.
                public var message: Swift.String
                /// Creates a new `LastErrorPayload`.
                ///
                /// - Parameters:
                ///   - code: One of `server_error` or `rate_limit_exceeded`.
                ///   - message: A human-readable description of the error.
                public init(
                    code: Components.Schemas.VectorStoreFileObject.LastErrorPayload.CodePayload,
                    message: Swift.String
                ) {
                    self.code = code
                    self.message = message
                }
                public enum CodingKeys: String, CodingKey {
                    case code
                    case message
                }
            }
            /// The last error associated with this vector store file. Will be `null` if there are no errors.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/last_error`.
            public var lastError: Components.Schemas.VectorStoreFileObject.LastErrorPayload?
            /// The strategy used to chunk the file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/chunking_strategy`.
            @frozen public enum ChunkingStrategyPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/chunking_strategy/case1`.
                case StaticChunkingStrategyResponseParam(Components.Schemas.StaticChunkingStrategyResponseParam)
                /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/chunking_strategy/case2`.
                case OtherChunkingStrategyResponseParam(Components.Schemas.OtherChunkingStrategyResponseParam)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .StaticChunkingStrategyResponseParam(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .OtherChunkingStrategyResponseParam(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .StaticChunkingStrategyResponseParam(value):
                        try value.encode(to: encoder)
                    case let .OtherChunkingStrategyResponseParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// The strategy used to chunk the file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/chunking_strategy`.
            public var chunkingStrategy: Components.Schemas.VectorStoreFileObject.ChunkingStrategyPayload?
            /// - Remark: Generated from `#/components/schemas/VectorStoreFileObject/attributes`.
            public var attributes: Components.Schemas.VectorStoreFileAttributes?
            /// Creates a new `VectorStoreFileObject`.
            ///
            /// - Parameters:
            ///   - id: The identifier, which can be referenced in API endpoints.
            ///   - object: The object type, which is always `vector_store.file`.
            ///   - usageBytes: The total vector store usage in bytes. Note that this may be different from the original file size.
            ///   - createdAt: The Unix timestamp (in seconds) for when the vector store file was created.
            ///   - vectorStoreId: The ID of the [vector store](/docs/api-reference/vector-stores/object) that the [File](/docs/api-reference/files) is attached to.
            ///   - status: The status of the vector store file, which can be either `in_progress`, `completed`, `cancelled`, or `failed`. The status `completed` indicates that the vector store file is ready for use.
            ///   - lastError: The last error associated with this vector store file. Will be `null` if there are no errors.
            ///   - chunkingStrategy: The strategy used to chunk the file.
            ///   - attributes:
            public init(
                id: Swift.String,
                object: Components.Schemas.VectorStoreFileObject.ObjectPayload,
                usageBytes: Swift.Int,
                createdAt: Swift.Int,
                vectorStoreId: Swift.String,
                status: Components.Schemas.VectorStoreFileObject.StatusPayload,
                lastError: Components.Schemas.VectorStoreFileObject.LastErrorPayload? = nil,
                chunkingStrategy: Components.Schemas.VectorStoreFileObject.ChunkingStrategyPayload? = nil,
                attributes: Components.Schemas.VectorStoreFileAttributes? = nil
            ) {
                self.id = id
                self.object = object
                self.usageBytes = usageBytes
                self.createdAt = createdAt
                self.vectorStoreId = vectorStoreId
                self.status = status
                self.lastError = lastError
                self.chunkingStrategy = chunkingStrategy
                self.attributes = attributes
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case object
                case usageBytes = "usage_bytes"
                case createdAt = "created_at"
                case vectorStoreId = "vector_store_id"
                case status
                case lastError = "last_error"
                case chunkingStrategy = "chunking_strategy"
                case attributes
            }
        }
        /// A vector store is a collection of processed files can be used by the `file_search` tool.
        ///
        /// - Remark: Generated from `#/components/schemas/VectorStoreObject`.
        public struct VectorStoreObject: Codable, Hashable, Sendable {
            /// The identifier, which can be referenced in API endpoints.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/id`.
            public var id: Swift.String
            /// The object type, which is always `vector_store`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case vectorStore = "vector_store"
            }
            /// The object type, which is always `vector_store`.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/object`.
            public var object: Components.Schemas.VectorStoreObject.ObjectPayload
            /// The Unix timestamp (in seconds) for when the vector store was created.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/created_at`.
            public var createdAt: Swift.Int
            /// The name of the vector store.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/name`.
            public var name: Swift.String
            /// The total number of bytes used by the files in the vector store.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/usage_bytes`.
            public var usageBytes: Swift.Int
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts`.
            public struct FileCountsPayload: Codable, Hashable, Sendable {
                /// The number of files that are currently being processed.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts/in_progress`.
                public var inProgress: Swift.Int
                /// The number of files that have been successfully processed.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts/completed`.
                public var completed: Swift.Int
                /// The number of files that have failed to process.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts/failed`.
                public var failed: Swift.Int
                /// The number of files that were cancelled.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts/cancelled`.
                public var cancelled: Swift.Int
                /// The total number of files.
                ///
                /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts/total`.
                public var total: Swift.Int
                /// Creates a new `FileCountsPayload`.
                ///
                /// - Parameters:
                ///   - inProgress: The number of files that are currently being processed.
                ///   - completed: The number of files that have been successfully processed.
                ///   - failed: The number of files that have failed to process.
                ///   - cancelled: The number of files that were cancelled.
                ///   - total: The total number of files.
                public init(
                    inProgress: Swift.Int,
                    completed: Swift.Int,
                    failed: Swift.Int,
                    cancelled: Swift.Int,
                    total: Swift.Int
                ) {
                    self.inProgress = inProgress
                    self.completed = completed
                    self.failed = failed
                    self.cancelled = cancelled
                    self.total = total
                }
                public enum CodingKeys: String, CodingKey {
                    case inProgress = "in_progress"
                    case completed
                    case failed
                    case cancelled
                    case total
                }
            }
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/file_counts`.
            public var fileCounts: Components.Schemas.VectorStoreObject.FileCountsPayload
            /// The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case expired = "expired"
                case inProgress = "in_progress"
                case completed = "completed"
            }
            /// The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/status`.
            public var status: Components.Schemas.VectorStoreObject.StatusPayload
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/expires_after`.
            public var expiresAfter: Components.Schemas.VectorStoreExpirationAfter?
            /// The Unix timestamp (in seconds) for when the vector store will expire.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/expires_at`.
            public var expiresAt: Swift.Int?
            /// The Unix timestamp (in seconds) for when the vector store was last active.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/last_active_at`.
            public var lastActiveAt: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/VectorStoreObject/metadata`.
            public var metadata: Components.Schemas.Metadata?
            /// Creates a new `VectorStoreObject`.
            ///
            /// - Parameters:
            ///   - id: The identifier, which can be referenced in API endpoints.
            ///   - object: The object type, which is always `vector_store`.
            ///   - createdAt: The Unix timestamp (in seconds) for when the vector store was created.
            ///   - name: The name of the vector store.
            ///   - usageBytes: The total number of bytes used by the files in the vector store.
            ///   - fileCounts:
            ///   - status: The status of the vector store, which can be either `expired`, `in_progress`, or `completed`. A status of `completed` indicates that the vector store is ready for use.
            ///   - expiresAfter:
            ///   - expiresAt: The Unix timestamp (in seconds) for when the vector store will expire.
            ///   - lastActiveAt: The Unix timestamp (in seconds) for when the vector store was last active.
            ///   - metadata:
            public init(
                id: Swift.String,
                object: Components.Schemas.VectorStoreObject.ObjectPayload,
                createdAt: Swift.Int,
                name: Swift.String,
                usageBytes: Swift.Int,
                fileCounts: Components.Schemas.VectorStoreObject.FileCountsPayload,
                status: Components.Schemas.VectorStoreObject.StatusPayload,
                expiresAfter: Components.Schemas.VectorStoreExpirationAfter? = nil,
                expiresAt: Swift.Int? = nil,
                lastActiveAt: Swift.Int? = nil,
                metadata: Components.Schemas.Metadata? = nil
            ) {
                self.id = id
                self.object = object
                self.createdAt = createdAt
                self.name = name
                self.usageBytes = usageBytes
                self.fileCounts = fileCounts
                self.status = status
                self.expiresAfter = expiresAfter
                self.expiresAt = expiresAt
                self.lastActiveAt = lastActiveAt
                self.metadata = metadata
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case object
                case createdAt = "created_at"
                case name
                case usageBytes = "usage_bytes"
                case fileCounts = "file_counts"
                case status
                case expiresAfter = "expires_after"
                case expiresAt = "expires_at"
                case lastActiveAt = "last_active_at"
                case metadata
            }
        }
        /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest`.
        public struct VectorStoreSearchRequest: Codable, Hashable, Sendable {
            /// A query string for a search
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/query`.
            @frozen public enum QueryPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/query/case1`.
                case case1(Swift.String)
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/query/case2`.
                case case2([Swift.String])
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .case2(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// A query string for a search
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/query`.
            public var query: Components.Schemas.VectorStoreSearchRequest.QueryPayload
            /// Whether to rewrite the natural language query for vector search.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/rewrite_query`.
            public var rewriteQuery: Swift.Bool?
            /// The maximum number of results to return. This number should be between 1 and 50 inclusive.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/max_num_results`.
            public var maxNumResults: Swift.Int?
            /// A filter to apply based on file attributes.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/filters`.
            @frozen public enum FiltersPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/filters/case1`.
                case ComparisonFilter(Components.Schemas.ComparisonFilter)
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/filters/case2`.
                case CompoundFilter(Components.Schemas.CompoundFilter)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .ComparisonFilter(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .CompoundFilter(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    throw Swift.DecodingError.failedToDecodeOneOfSchema(
                        type: Self.self,
                        codingPath: decoder.codingPath,
                        errors: errors
                    )
                }
                public func encode(to encoder: any Encoder) throws {
                    switch self {
                    case let .ComparisonFilter(value):
                        try value.encode(to: encoder)
                    case let .CompoundFilter(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// A filter to apply based on file attributes.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/filters`.
            public var filters: Components.Schemas.VectorStoreSearchRequest.FiltersPayload?
            /// Ranking options for search.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/ranking_options`.
            public struct RankingOptionsPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/ranking_options/ranker`.
                @frozen public enum RankerPayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case auto = "auto"
                    case default20241115 = "default-2024-11-15"
                }
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/ranking_options/ranker`.
                public var ranker: Components.Schemas.VectorStoreSearchRequest.RankingOptionsPayload.RankerPayload?
                /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/ranking_options/score_threshold`.
                public var scoreThreshold: Swift.Double?
                /// Creates a new `RankingOptionsPayload`.
                ///
                /// - Parameters:
                ///   - ranker:
                ///   - scoreThreshold:
                public init(
                    ranker: Components.Schemas.VectorStoreSearchRequest.RankingOptionsPayload.RankerPayload? = nil,
                    scoreThreshold: Swift.Double? = nil
                ) {
                    self.ranker = ranker
                    self.scoreThreshold = scoreThreshold
                }
                public enum CodingKeys: String, CodingKey {
                    case ranker
                    case scoreThreshold = "score_threshold"
                }
                public init(from decoder: any Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.ranker = try container.decodeIfPresent(
                        Components.Schemas.VectorStoreSearchRequest.RankingOptionsPayload.RankerPayload.self,
                        forKey: .ranker
                    )
                    self.scoreThreshold = try container.decodeIfPresent(
                        Swift.Double.self,
                        forKey: .scoreThreshold
                    )
                    try decoder.ensureNoAdditionalProperties(knownKeys: [
                        "ranker",
                        "score_threshold"
                    ])
                }
            }
            /// Ranking options for search.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchRequest/ranking_options`.
            public var rankingOptions: Components.Schemas.VectorStoreSearchRequest.RankingOptionsPayload?
            /// Creates a new `VectorStoreSearchRequest`.
            ///
            /// - Parameters:
            ///   - query: A query string for a search
            ///   - rewriteQuery: Whether to rewrite the natural language query for vector search.
            ///   - maxNumResults: The maximum number of results to return. This number should be between 1 and 50 inclusive.
            ///   - filters: A filter to apply based on file attributes.
            ///   - rankingOptions: Ranking options for search.
            public init(
                query: Components.Schemas.VectorStoreSearchRequest.QueryPayload,
                rewriteQuery: Swift.Bool? = nil,
                maxNumResults: Swift.Int? = nil,
                filters: Components.Schemas.VectorStoreSearchRequest.FiltersPayload? = nil,
                rankingOptions: Components.Schemas.VectorStoreSearchRequest.RankingOptionsPayload? = nil
            ) {
                self.query = query
                self.rewriteQuery = rewriteQuery
                self.maxNumResults = maxNumResults
                self.filters = filters
                self.rankingOptions = rankingOptions
            }
            public enum CodingKeys: String, CodingKey {
                case query
                case rewriteQuery = "rewrite_query"
                case maxNumResults = "max_num_results"
                case filters
                case rankingOptions = "ranking_options"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.query = try container.decode(
                    Components.Schemas.VectorStoreSearchRequest.QueryPayload.self,
                    forKey: .query
                )
                self.rewriteQuery = try container.decodeIfPresent(
                    Swift.Bool.self,
                    forKey: .rewriteQuery
                )
                self.maxNumResults = try container.decodeIfPresent(
                    Swift.Int.self,
                    forKey: .maxNumResults
                )
                self.filters = try container.decodeIfPresent(
                    Components.Schemas.VectorStoreSearchRequest.FiltersPayload.self,
                    forKey: .filters
                )
                self.rankingOptions = try container.decodeIfPresent(
                    Components.Schemas.VectorStoreSearchRequest.RankingOptionsPayload.self,
                    forKey: .rankingOptions
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "query",
                    "rewrite_query",
                    "max_num_results",
                    "filters",
                    "ranking_options"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultContentObject`.
        public struct VectorStoreSearchResultContentObject: Codable, Hashable, Sendable {
            /// The type of content.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultContentObject/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case text = "text"
            }
            /// The type of content.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultContentObject/type`.
            public var _type: Components.Schemas.VectorStoreSearchResultContentObject._TypePayload
            /// The text content returned from search.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultContentObject/text`.
            public var text: Swift.String
            /// Creates a new `VectorStoreSearchResultContentObject`.
            ///
            /// - Parameters:
            ///   - _type: The type of content.
            ///   - text: The text content returned from search.
            public init(
                _type: Components.Schemas.VectorStoreSearchResultContentObject._TypePayload,
                text: Swift.String
            ) {
                self._type = _type
                self.text = text
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.VectorStoreSearchResultContentObject._TypePayload.self,
                    forKey: ._type
                )
                self.text = try container.decode(
                    Swift.String.self,
                    forKey: .text
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type",
                    "text"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultItem`.
        public struct VectorStoreSearchResultItem: Codable, Hashable, Sendable {
            /// The ID of the vector store file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultItem/file_id`.
            public var fileId: Swift.String
            /// The name of the vector store file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultItem/filename`.
            public var filename: Swift.String
            /// The similarity score for the result.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultItem/score`.
            public var score: Swift.Double
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultItem/attributes`.
            public var attributes: Components.Schemas.VectorStoreFileAttributes?
            /// Content chunks from the file.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultItem/content`.
            public var content: [Components.Schemas.VectorStoreSearchResultContentObject]
            /// Creates a new `VectorStoreSearchResultItem`.
            ///
            /// - Parameters:
            ///   - fileId: The ID of the vector store file.
            ///   - filename: The name of the vector store file.
            ///   - score: The similarity score for the result.
            ///   - attributes:
            ///   - content: Content chunks from the file.
            public init(
                fileId: Swift.String,
                filename: Swift.String,
                score: Swift.Double,
                attributes: Components.Schemas.VectorStoreFileAttributes? = nil,
                content: [Components.Schemas.VectorStoreSearchResultContentObject]
            ) {
                self.fileId = fileId
                self.filename = filename
                self.score = score
                self.attributes = attributes
                self.content = content
            }
            public enum CodingKeys: String, CodingKey {
                case fileId = "file_id"
                case filename
                case score
                case attributes
                case content
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.fileId = try container.decode(
                    Swift.String.self,
                    forKey: .fileId
                )
                self.filename = try container.decode(
                    Swift.String.self,
                    forKey: .filename
                )
                self.score = try container.decode(
                    Swift.Double.self,
                    forKey: .score
                )
                self.attributes = try container.decodeIfPresent(
                    Components.Schemas.VectorStoreFileAttributes.self,
                    forKey: .attributes
                )
                self.content = try container.decode(
                    [Components.Schemas.VectorStoreSearchResultContentObject].self,
                    forKey: .content
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "file_id",
                    "filename",
                    "score",
                    "attributes",
                    "content"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage`.
        public struct VectorStoreSearchResultsPage: Codable, Hashable, Sendable {
            /// The object type, which is always `vector_store.search_results.page`
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case vectorStore_searchResults_page = "vector_store.search_results.page"
            }
            /// The object type, which is always `vector_store.search_results.page`
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage/object`.
            public var object: Components.Schemas.VectorStoreSearchResultsPage.ObjectPayload
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage/search_query`.
            public var searchQuery: [Swift.String]
            /// The list of search result items.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage/data`.
            public var data: [Components.Schemas.VectorStoreSearchResultItem]
            /// Indicates if there are more results to fetch.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage/has_more`.
            public var hasMore: Swift.Bool
            /// The token for the next page, if any.
            ///
            /// - Remark: Generated from `#/components/schemas/VectorStoreSearchResultsPage/next_page`.
            public var nextPage: Swift.String?
            /// Creates a new `VectorStoreSearchResultsPage`.
            ///
            /// - Parameters:
            ///   - object: The object type, which is always `vector_store.search_results.page`
            ///   - searchQuery:
            ///   - data: The list of search result items.
            ///   - hasMore: Indicates if there are more results to fetch.
            ///   - nextPage: The token for the next page, if any.
            public init(
                object: Components.Schemas.VectorStoreSearchResultsPage.ObjectPayload,
                searchQuery: [Swift.String],
                data: [Components.Schemas.VectorStoreSearchResultItem],
                hasMore: Swift.Bool,
                nextPage: Swift.String? = nil
            ) {
                self.object = object
                self.searchQuery = searchQuery
                self.data = data
                self.hasMore = hasMore
                self.nextPage = nextPage
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case searchQuery = "search_query"
                case data
                case hasMore = "has_more"
                case nextPage = "next_page"
            }
            public init(from decoder: any Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.object = try container.decode(
                    Components.Schemas.VectorStoreSearchResultsPage.ObjectPayload.self,
                    forKey: .object
                )
                self.searchQuery = try container.decode(
                    [Swift.String].self,
                    forKey: .searchQuery
                )
                self.data = try container.decode(
                    [Components.Schemas.VectorStoreSearchResultItem].self,
                    forKey: .data
                )
                self.hasMore = try container.decode(
                    Swift.Bool.self,
                    forKey: .hasMore
                )
                self.nextPage = try container.decodeIfPresent(
                    Swift.String.self,
                    forKey: .nextPage
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "object",
                    "search_query",
                    "data",
                    "has_more",
                    "next_page"
                ])
            }
        }
        /// - Remark: Generated from `#/components/schemas/VoiceIdsShared`.
        public struct VoiceIdsShared: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/VoiceIdsShared/value1`.
            public var value1: Swift.String?
            /// - Remark: Generated from `#/components/schemas/VoiceIdsShared/value2`.
            @frozen public enum Value2Payload: String, Codable, Hashable, Sendable, CaseIterable {
                case alloy = "alloy"
                case ash = "ash"
                case ballad = "ballad"
                case coral = "coral"
                case echo = "echo"
                case fable = "fable"
                case onyx = "onyx"
                case nova = "nova"
                case sage = "sage"
                case shimmer = "shimmer"
                case verse = "verse"
            }
            /// - Remark: Generated from `#/components/schemas/VoiceIdsShared/value2`.
            public var value2: Components.Schemas.VoiceIdsShared.Value2Payload?
            /// Creates a new `VoiceIdsShared`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Swift.String? = nil,
                value2: Components.Schemas.VoiceIdsShared.Value2Payload? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self.value1 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                do {
                    self.value2 = try decoder.decodeFromSingleValueContainer()
                } catch {
                    errors.append(error)
                }
                try Swift.DecodingError.verifyAtLeastOneSchemaIsNotNil(
                    [
                        self.value1,
                        self.value2
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Encoder) throws {
                try encoder.encodeFirstNonNilValueToSingleValueContainer([
                    self.value1,
                    self.value2
                ])
            }
        }
        /// A wait action.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Wait`.
        public struct Wait: Codable, Hashable, Sendable {
            /// Specifies the event type. For a wait action, this property is 
            /// always set to `wait`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Wait/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case wait = "wait"
            }
            /// Specifies the event type. For a wait action, this property is 
            /// always set to `wait`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Wait/type`.
            public var _type: Components.Schemas.Wait._TypePayload
            /// Creates a new `Wait`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a wait action, this property is 
            public init(_type: Components.Schemas.Wait._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// High level guidance for the amount of context window space to use for the 
        /// search. One of `low`, `medium`, or `high`. `medium` is the default.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchContextSize`.
        @frozen public enum WebSearchContextSize: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case medium = "medium"
            case high = "high"
        }
        /// Approximate location parameters for the search.
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchLocation`.
        public struct WebSearchLocation: Codable, Hashable, Sendable {
            /// The two-letter 
            /// [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of the user,
            /// e.g. `US`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchLocation/country`.
            public var country: Swift.String?
            /// Free text input for the region of the user, e.g. `California`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchLocation/region`.
            public var region: Swift.String?
            /// Free text input for the city of the user, e.g. `San Francisco`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchLocation/city`.
            public var city: Swift.String?
            /// The [IANA timezone](https://timeapi.io/documentation/iana-timezones) 
            /// of the user, e.g. `America/Los_Angeles`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchLocation/timezone`.
            public var timezone: Swift.String?
            /// Creates a new `WebSearchLocation`.
            ///
            /// - Parameters:
            ///   - country: The two-letter 
            ///   - region: Free text input for the region of the user, e.g. `California`.
            ///   - city: Free text input for the city of the user, e.g. `San Francisco`.
            ///   - timezone: The [IANA timezone](https://timeapi.io/documentation/iana-timezones) 
            public init(
                country: Swift.String? = nil,
                region: Swift.String? = nil,
                city: Swift.String? = nil,
                timezone: Swift.String? = nil
            ) {
                self.country = country
                self.region = region
                self.city = city
                self.timezone = timezone
            }
            public enum CodingKeys: String, CodingKey {
                case country
                case region
                case city
                case timezone
            }
        }
        /// This tool searches the web for relevant results to use in a response.
        /// Learn more about the [web search tool](/docs/guides/tools-web-search).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchTool`.
        public struct WebSearchTool: Codable, Hashable, Sendable {
            /// The type of the web search tool. One of:
            /// - `web_search_preview`
            /// - `web_search_preview_2025_03_11`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case webSearchPreview = "web_search_preview"
                case webSearchPreview20250311 = "web_search_preview_2025_03_11"
            }
            /// The type of the web search tool. One of:
            /// - `web_search_preview`
            /// - `web_search_preview_2025_03_11`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/type`.
            public var _type: Components.Schemas.WebSearchTool._TypePayload
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location`.
            public struct UserLocationPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location/value1`.
                public var value1: Components.Schemas.WebSearchLocation
                /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location/value2`.
                public struct Value2Payload: Codable, Hashable, Sendable {
                    /// The type of location approximation. Always `approximate`.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location/value2/type`.
                    @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                        case approximate = "approximate"
                    }
                    /// The type of location approximation. Always `approximate`.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location/value2/type`.
                    public var _type: Components.Schemas.WebSearchTool.UserLocationPayload.Value2Payload._TypePayload
                    /// Creates a new `Value2Payload`.
                    ///
                    /// - Parameters:
                    ///   - _type: The type of location approximation. Always `approximate`.
                    public init(_type: Components.Schemas.WebSearchTool.UserLocationPayload.Value2Payload._TypePayload) {
                        self._type = _type
                    }
                    public enum CodingKeys: String, CodingKey {
                        case _type = "type"
                    }
                }
                /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location/value2`.
                public var value2: Components.Schemas.WebSearchTool.UserLocationPayload.Value2Payload
                /// Creates a new `UserLocationPayload`.
                ///
                /// - Parameters:
                ///   - value1:
                ///   - value2:
                public init(
                    value1: Components.Schemas.WebSearchLocation,
                    value2: Components.Schemas.WebSearchTool.UserLocationPayload.Value2Payload
                ) {
                    self.value1 = value1
                    self.value2 = value2
                }
                public init(from decoder: any Decoder) throws {
                    self.value1 = try .init(from: decoder)
                    self.value2 = try .init(from: decoder)
                }
                public func encode(to encoder: any Encoder) throws {
                    try self.value1.encode(to: encoder)
                    try self.value2.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location`.
            public var userLocation: Components.Schemas.WebSearchTool.UserLocationPayload?
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/search_context_size`.
            public var searchContextSize: Components.Schemas.WebSearchContextSize?
            /// Creates a new `WebSearchTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the web search tool. One of:
            ///   - userLocation:
            ///   - searchContextSize:
            public init(
                _type: Components.Schemas.WebSearchTool._TypePayload,
                userLocation: Components.Schemas.WebSearchTool.UserLocationPayload? = nil,
                searchContextSize: Components.Schemas.WebSearchContextSize? = nil
            ) {
                self._type = _type
                self.userLocation = userLocation
                self.searchContextSize = searchContextSize
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case userLocation = "user_location"
                case searchContextSize = "search_context_size"
            }
        }
        /// The results of a web search tool call. See the 
        /// [web search guide](/docs/guides/tools-web-search) for more information.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchToolCall`.
        public struct WebSearchToolCall: Codable, Hashable, Sendable {
            /// The unique ID of the web search tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/id`.
            public var id: Swift.String
            /// The type of the web search tool call. Always `web_search_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case webSearchCall = "web_search_call"
            }
            /// The type of the web search tool call. Always `web_search_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/type`.
            public var _type: Components.Schemas.WebSearchToolCall._TypePayload
            /// The status of the web search tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case searching = "searching"
                case completed = "completed"
                case failed = "failed"
            }
            /// The status of the web search tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/status`.
            public var status: Components.Schemas.WebSearchToolCall.StatusPayload
            /// Creates a new `WebSearchToolCall`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the web search tool call.
            ///   - _type: The type of the web search tool call. Always `web_search_call`.
            ///   - status: The status of the web search tool call.
            public init(
                id: Swift.String,
                _type: Components.Schemas.WebSearchToolCall._TypePayload,
                status: Components.Schemas.WebSearchToolCall.StatusPayload
            ) {
                self.id = id
                self._type = _type
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case status
            }
        }
    }
    /// Types generated from the `#/components/parameters` section of the OpenAPI document.
    public enum Parameters {}
    /// Types generated from the `#/components/requestBodies` section of the OpenAPI document.
    public enum RequestBodies {}
    /// Types generated from the `#/components/responses` section of the OpenAPI document.
    public enum Responses {}
    /// Types generated from the `#/components/headers` section of the OpenAPI document.
    public enum Headers {}
}
