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
 
 # OpenAI OpenAPI commit: #
 498c71dd Update openapi.yaml
 https://github.com/openai/openai-openapi/commit/498c71ddf6f1c45b983f972ccabca795da211a3e
 
 # Command that was used to generate the code #
 `swift run swift-openapi-generator generate --config openapi-generator-config.yaml openapi.yaml`
 
 # Contents of config that was used to generate the code #
 generate:
   - types
 namingStrategy: idiomatic
 accessModifier: public
 filter:
   paths:
   - /responses
   - /responses/{response_id}
   - /responses/{response_id}/input_items
   schemas:
   - WebSearchLocation
   - WebSearchContextSize
 
 # openapi.yaml used for generating #
 openapi: 3.0.0
 info:
   title: OpenAI API
   description: The OpenAI REST API. Please see
     https://platform.openai.com/docs/api-reference for more details.
   version: 2.3.0
   termsOfService: https://openai.com/policies/terms-of-use
   contact:
     name: OpenAI Support
     url: https://help.openai.com/
   license:
     name: MIT
     url: https://github.com/openai/openai-openapi/blob/master/LICENSE
 
 # Console output describing how generator was configured for that run #
 Swift OpenAPI Generator is running with the following configuration:
 - OpenAPI document path: /Users/oleksiinezhyborets/Projects/swift-openapi-generator/openapi.yaml
 - Configuration path: /Users/oleksiinezhyborets/Projects/swift-openapi-generator/openapi-generator-config.yaml
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
 - Additional imports: <none>
 
 # Manual operations after Types.swift file was generated #
 - Extract Components enum from Types.swift into it's own file, as we don't need other top level files
 - Delete `generateSummary` from Reasoning.init to silence deprecation warnings
 */

/// Types generated from the components section of the OpenAPI document.
public enum Components {
    /// Types generated from the `#/components/schemas` section of the OpenAPI document.
    public enum Schemas {
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
                case case2(OpenAPIRuntime.OpenAPIValueContainer)
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
        /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties`.
        public struct CreateModelResponseProperties: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties/value1`.
            public var value1: Components.Schemas.ModelResponseProperties
            /// Creates a new `CreateModelResponseProperties`.
            ///
            /// - Parameters:
            ///   - value1:
            public init(value1: Components.Schemas.ModelResponseProperties) {
                self.value1 = value1
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
            }
        }
        /// - Remark: Generated from `#/components/schemas/CreateResponse`.
        public struct CreateResponse: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CreateResponse/value1`.
            public var value1: Components.Schemas.CreateModelResponseProperties
            /// - Remark: Generated from `#/components/schemas/CreateResponse/value2`.
            public var value2: Components.Schemas.ResponseProperties
            /// - Remark: Generated from `#/components/schemas/CreateResponse/value3`.
            public struct Value3Payload: Codable, Hashable, Sendable {
                /// Text, image, or file inputs to the model, used to generate a response.
                ///
                /// Learn more:
                /// - [Text inputs and outputs](/docs/guides/text)
                /// - [Image inputs](/docs/guides/images)
                /// - [File inputs](/docs/guides/pdf-files)
                /// - [Conversation state](/docs/guides/conversation-state)
                /// - [Function calling](/docs/guides/function-calling)
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/input`.
                @frozen public enum InputPayload: Codable, Hashable, Sendable {
                    /// A text input to the model, equivalent to a text input with the
                    /// `user` role.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/input/case1`.
                    case case1(Swift.String)
                    /// A list of one or many input items to the model, containing
                    /// different content types.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/input/case2`.
                    case case2([Components.Schemas.InputItem])
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
                /// Text, image, or file inputs to the model, used to generate a response.
                ///
                /// Learn more:
                /// - [Text inputs and outputs](/docs/guides/text)
                /// - [Image inputs](/docs/guides/images)
                /// - [File inputs](/docs/guides/pdf-files)
                /// - [Conversation state](/docs/guides/conversation-state)
                /// - [Function calling](/docs/guides/function-calling)
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/input`.
                public var input: Components.Schemas.CreateResponse.Value3Payload.InputPayload
                /// Specify additional output data to include in the model response. Currently
                /// supported values are:
                /// - `file_search_call.results`: Include the search results of
                ///   the file search tool call.
                /// - `message.input_image.image_url`: Include image urls from the input message.
                /// - `computer_call_output.output.image_url`: Include image urls from the computer call output.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/include`.
                public var include: [Components.Schemas.Includable]?
                /// Whether to allow the model to run tool calls in parallel.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/parallel_tool_calls`.
                public var parallelToolCalls: Swift.Bool?
                /// Whether to store the generated model response for later retrieval via
                /// API.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/store`.
                public var store: Swift.Bool?
                /// If set to true, the model response data will be streamed to the client
                /// as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
                /// See the [Streaming section below](/docs/api-reference/responses-streaming)
                /// for more information.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/stream`.
                public var stream: Swift.Bool?
                /// Creates a new `Value3Payload`.
                ///
                /// - Parameters:
                ///   - input: Text, image, or file inputs to the model, used to generate a response.
                ///   - include: Specify additional output data to include in the model response. Currently
                ///   - parallelToolCalls: Whether to allow the model to run tool calls in parallel.
                ///   - store: Whether to store the generated model response for later retrieval via
                ///   - stream: If set to true, the model response data will be streamed to the client
                public init(
                    input: Components.Schemas.CreateResponse.Value3Payload.InputPayload,
                    include: [Components.Schemas.Includable]? = nil,
                    parallelToolCalls: Swift.Bool? = nil,
                    store: Swift.Bool? = nil,
                    stream: Swift.Bool? = nil
                ) {
                    self.input = input
                    self.include = include
                    self.parallelToolCalls = parallelToolCalls
                    self.store = store
                    self.stream = stream
                }
                public enum CodingKeys: String, CodingKey {
                    case input
                    case include
                    case parallelToolCalls = "parallel_tool_calls"
                    case store
                    case stream
                }
            }
            /// - Remark: Generated from `#/components/schemas/CreateResponse/value3`.
            public var value3: Components.Schemas.CreateResponse.Value3Payload
            /// Creates a new `CreateResponse`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            ///   - value3:
            public init(
                value1: Components.Schemas.CreateModelResponseProperties,
                value2: Components.Schemas.ResponseProperties,
                value3: Components.Schemas.CreateResponse.Value3Payload
            ) {
                self.value1 = value1
                self.value2 = value2
                self.value3 = value3
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
                self.value3 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
                try self.value3.encode(to: encoder)
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
        /// - Remark: Generated from `#/components/schemas/InputContent`.
        @frozen public enum InputContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/InputContent/case1`.
            case InputTextContent(Components.Schemas.InputTextContent)
            /// - Remark: Generated from `#/components/schemas/InputContent/case2`.
            case InputImageContent(Components.Schemas.InputImageContent)
            /// - Remark: Generated from `#/components/schemas/InputContent/case3`.
            case InputFileContent(Components.Schemas.InputFileContent)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .InputTextContent(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .InputImageContent(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .InputFileContent(try .init(from: decoder))
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
                case let .InputTextContent(value):
                    try value.encode(to: encoder)
                case let .InputImageContent(value):
                    try value.encode(to: encoder)
                case let .InputFileContent(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// - Remark: Generated from `#/components/schemas/InputItem`.
        @frozen public enum InputItem: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/InputItem/EasyInputMessage`.
            case easyInputMessage(Components.Schemas.EasyInputMessage)
            /// - Remark: Generated from `#/components/schemas/InputItem/Item`.
            case item(Components.Schemas.Item)
            /// - Remark: Generated from `#/components/schemas/InputItem/ItemReferenceParam`.
            case itemReferenceParam(Components.Schemas.ItemReferenceParam)
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
                case "ItemReferenceParam", "#/components/schemas/ItemReferenceParam":
                    self = .itemReferenceParam(try .init(from: decoder))
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
                case let .itemReferenceParam(value):
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
            /// - Remark: Generated from `#/components/schemas/Item/ComputerCallOutputItemParam`.
            case computerCallOutputItemParam(Components.Schemas.ComputerCallOutputItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/WebSearchToolCall`.
            case webSearchToolCall(Components.Schemas.WebSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/FunctionToolCall`.
            case functionToolCall(Components.Schemas.FunctionToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/FunctionCallOutputItemParam`.
            case functionCallOutputItemParam(Components.Schemas.FunctionCallOutputItemParam)
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
                case "ComputerCallOutputItemParam", "#/components/schemas/ComputerCallOutputItemParam":
                    self = .computerCallOutputItemParam(try .init(from: decoder))
                case "WebSearchToolCall", "#/components/schemas/WebSearchToolCall":
                    self = .webSearchToolCall(try .init(from: decoder))
                case "FunctionToolCall", "#/components/schemas/FunctionToolCall":
                    self = .functionToolCall(try .init(from: decoder))
                case "FunctionCallOutputItemParam", "#/components/schemas/FunctionCallOutputItemParam":
                    self = .functionCallOutputItemParam(try .init(from: decoder))
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
                case let .computerCallOutputItemParam(value):
                    try value.encode(to: encoder)
                case let .webSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .functionToolCall(value):
                    try value.encode(to: encoder)
                case let .functionCallOutputItemParam(value):
                    try value.encode(to: encoder)
                case let .reasoningItem(value):
                    try value.encode(to: encoder)
                }
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
                case gpt4_1 = "gpt-4.1"
                case gpt4_1Mini = "gpt-4.1-mini"
                case gpt4_1Nano = "gpt-4.1-nano"
                case gpt4_120250414 = "gpt-4.1-2025-04-14"
                case gpt4_1Mini20250414 = "gpt-4.1-mini-2025-04-14"
                case gpt4_1Nano20250414 = "gpt-4.1-nano-2025-04-14"
                case o4Mini = "o4-mini"
                case o4Mini20250416 = "o4-mini-2025-04-16"
                case o3 = "o3"
                case o320250416 = "o3-2025-04-16"
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
        /// - Remark: Generated from `#/components/schemas/ModelResponseProperties`.
        public struct ModelResponseProperties: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/metadata`.
            public var metadata: Components.Schemas.Metadata?
            /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
            /// We generally recommend altering this or `top_p` but not both.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/temperature`.
            public var temperature: Swift.Double?
            /// An alternative to sampling with temperature, called nucleus sampling,
            /// where the model considers the results of the tokens with top_p probability
            /// mass. So 0.1 means only the tokens comprising the top 10% probability mass
            /// are considered.
            ///
            /// We generally recommend altering this or `temperature` but not both.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/top_p`.
            public var topP: Swift.Double?
            /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](/docs/guides/safety-best-practices#end-user-ids).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/user`.
            public var user: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/service_tier`.
            public var serviceTier: Components.Schemas.ServiceTier?
            /// Creates a new `ModelResponseProperties`.
            ///
            /// - Parameters:
            ///   - metadata:
            ///   - temperature: What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
            ///   - topP: An alternative to sampling with temperature, called nucleus sampling,
            ///   - user: A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](/docs/guides/safety-best-practices#end-user-ids).
            ///   - serviceTier:
            public init(
                metadata: Components.Schemas.Metadata? = nil,
                temperature: Swift.Double? = nil,
                topP: Swift.Double? = nil,
                user: Swift.String? = nil,
                serviceTier: Components.Schemas.ServiceTier? = nil
            ) {
                self.metadata = metadata
                self.temperature = temperature
                self.topP = topP
                self.user = user
                self.serviceTier = serviceTier
            }
            public enum CodingKeys: String, CodingKey {
                case metadata
                case temperature
                case topP = "top_p"
                case user
                case serviceTier = "service_tier"
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
        /// - Remark: Generated from `#/components/schemas/OutputContent`.
        @frozen public enum OutputContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/OutputContent/case1`.
            case OutputTextContent(Components.Schemas.OutputTextContent)
            /// - Remark: Generated from `#/components/schemas/OutputContent/case2`.
            case RefusalContent(Components.Schemas.RefusalContent)
            public init(from decoder: any Decoder) throws {
                var errors: [any Error] = []
                do {
                    self = .OutputTextContent(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .RefusalContent(try .init(from: decoder))
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
                case let .OutputTextContent(value):
                    try value.encode(to: encoder)
                case let .RefusalContent(value):
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
            /// A summary of the reasoning performed by the model. This can be
            /// useful for debugging and understanding the model's reasoning process.
            /// One of `auto`, `concise`, or `detailed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/summary`.
            @frozen public enum SummaryPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case concise = "concise"
                case detailed = "detailed"
            }
            /// A summary of the reasoning performed by the model. This can be
            /// useful for debugging and understanding the model's reasoning process.
            /// One of `auto`, `concise`, or `detailed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/summary`.
            public var summary: Components.Schemas.Reasoning.SummaryPayload?
            /// **Deprecated:** use `summary` instead.
            ///
            /// A summary of the reasoning performed by the model. This can be
            /// useful for debugging and understanding the model's reasoning process.
            /// One of `auto`, `concise`, or `detailed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/generate_summary`.
            @frozen public enum GenerateSummaryPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case concise = "concise"
                case detailed = "detailed"
            }
            /// **Deprecated:** use `summary` instead.
            ///
            /// A summary of the reasoning performed by the model. This can be
            /// useful for debugging and understanding the model's reasoning process.
            /// One of `auto`, `concise`, or `detailed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/generate_summary`.
            @available(*, deprecated)
            public var generateSummary: Components.Schemas.Reasoning.GenerateSummaryPayload?
            /// Creates a new `Reasoning`.
            ///
            /// - Parameters:
            ///   - effort:
            ///   - summary: A summary of the reasoning performed by the model. This can be
            public init(
                effort: Components.Schemas.ReasoningEffort? = nil,
                summary: Components.Schemas.Reasoning.SummaryPayload? = nil
            ) {
                self.effort = effort
                self.summary = summary
            }
            public enum CodingKeys: String, CodingKey {
                case effort
                case summary
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
        /// - Remark: Generated from `#/components/schemas/Response`.
        public struct Response: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Response/value1`.
            public var value1: Components.Schemas.ModelResponseProperties
            /// - Remark: Generated from `#/components/schemas/Response/value2`.
            public var value2: Components.Schemas.ResponseProperties
            /// - Remark: Generated from `#/components/schemas/Response/value3`.
            public struct Value3Payload: Codable, Hashable, Sendable {
                /// Unique identifier for this Response.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/id`.
                public var id: Swift.String
                /// The object type of this resource - always set to `response`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/object`.
                @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case response = "response"
                }
                /// The object type of this resource - always set to `response`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/object`.
                public var object: Components.Schemas.Response.Value3Payload.ObjectPayload
                /// The status of the response generation. One of `completed`, `failed`,
                /// `in_progress`, or `incomplete`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/status`.
                @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case completed = "completed"
                    case failed = "failed"
                    case inProgress = "in_progress"
                    case incomplete = "incomplete"
                }
                /// The status of the response generation. One of `completed`, `failed`,
                /// `in_progress`, or `incomplete`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/status`.
                public var status: Components.Schemas.Response.Value3Payload.StatusPayload?
                /// Unix timestamp (in seconds) of when this Response was created.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/created_at`.
                public var createdAt: Swift.Double
                /// - Remark: Generated from `#/components/schemas/Response/value3/error`.
                public var error: Components.Schemas.ResponseError?
                /// Details about why the response is incomplete.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/incomplete_details`.
                public struct IncompleteDetailsPayload: Codable, Hashable, Sendable {
                    /// The reason why the response is incomplete.
                    ///
                    /// - Remark: Generated from `#/components/schemas/Response/value3/incomplete_details/reason`.
                    @frozen public enum ReasonPayload: String, Codable, Hashable, Sendable, CaseIterable {
                        case maxOutputTokens = "max_output_tokens"
                        case contentFilter = "content_filter"
                    }
                    /// The reason why the response is incomplete.
                    ///
                    /// - Remark: Generated from `#/components/schemas/Response/value3/incomplete_details/reason`.
                    public var reason: Components.Schemas.Response.Value3Payload.IncompleteDetailsPayload.ReasonPayload?
                    /// Creates a new `IncompleteDetailsPayload`.
                    ///
                    /// - Parameters:
                    ///   - reason: The reason why the response is incomplete.
                    public init(reason: Components.Schemas.Response.Value3Payload.IncompleteDetailsPayload.ReasonPayload? = nil) {
                        self.reason = reason
                    }
                    public enum CodingKeys: String, CodingKey {
                        case reason
                    }
                }
                /// Details about why the response is incomplete.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/incomplete_details`.
                public var incompleteDetails: Components.Schemas.Response.Value3Payload.IncompleteDetailsPayload?
                /// An array of content items generated by the model.
                ///
                /// - The length and order of items in the `output` array is dependent
                ///   on the model's response.
                /// - Rather than accessing the first item in the `output` array and
                ///   assuming it's an `assistant` message with the content generated by
                ///   the model, you might consider using the `output_text` property where
                ///   supported in SDKs.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/output`.
                public var output: [Components.Schemas.OutputItem]
                /// SDK-only convenience property that contains the aggregated text output
                /// from all `output_text` items in the `output` array, if any are present.
                /// Supported in the Python and JavaScript SDKs.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/output_text`.
                public var outputText: Swift.String?
                /// - Remark: Generated from `#/components/schemas/Response/value3/usage`.
                public var usage: Components.Schemas.ResponseUsage?
                /// Whether to allow the model to run tool calls in parallel.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/parallel_tool_calls`.
                public var parallelToolCalls: Swift.Bool
                /// Creates a new `Value3Payload`.
                ///
                /// - Parameters:
                ///   - id: Unique identifier for this Response.
                ///   - object: The object type of this resource - always set to `response`.
                ///   - status: The status of the response generation. One of `completed`, `failed`,
                ///   - createdAt: Unix timestamp (in seconds) of when this Response was created.
                ///   - error:
                ///   - incompleteDetails: Details about why the response is incomplete.
                ///   - output: An array of content items generated by the model.
                ///   - outputText: SDK-only convenience property that contains the aggregated text output
                ///   - usage:
                ///   - parallelToolCalls: Whether to allow the model to run tool calls in parallel.
                public init(
                    id: Swift.String,
                    object: Components.Schemas.Response.Value3Payload.ObjectPayload,
                    status: Components.Schemas.Response.Value3Payload.StatusPayload? = nil,
                    createdAt: Swift.Double,
                    error: Components.Schemas.ResponseError? = nil,
                    incompleteDetails: Components.Schemas.Response.Value3Payload.IncompleteDetailsPayload? = nil,
                    output: [Components.Schemas.OutputItem],
                    outputText: Swift.String? = nil,
                    usage: Components.Schemas.ResponseUsage? = nil,
                    parallelToolCalls: Swift.Bool
                ) {
                    self.id = id
                    self.object = object
                    self.status = status
                    self.createdAt = createdAt
                    self.error = error
                    self.incompleteDetails = incompleteDetails
                    self.output = output
                    self.outputText = outputText
                    self.usage = usage
                    self.parallelToolCalls = parallelToolCalls
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case object
                    case status
                    case createdAt = "created_at"
                    case error
                    case incompleteDetails = "incomplete_details"
                    case output
                    case outputText = "output_text"
                    case usage
                    case parallelToolCalls = "parallel_tool_calls"
                }
            }
            /// - Remark: Generated from `#/components/schemas/Response/value3`.
            public var value3: Components.Schemas.Response.Value3Payload
            /// Creates a new `Response`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            ///   - value3:
            public init(
                value1: Components.Schemas.ModelResponseProperties,
                value2: Components.Schemas.ResponseProperties,
                value3: Components.Schemas.Response.Value3Payload
            ) {
                self.value1 = value1
                self.value2 = value2
                self.value3 = value3
            }
            public init(from decoder: any Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
                self.value3 = try .init(from: decoder)
            }
            public func encode(to encoder: any Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
                try self.value3.encode(to: encoder)
            }
        }
        /// Emitted when there is a partial audio response.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseAudioDeltaEvent`.
        public struct ResponseAudioDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.audio.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_audio_delta = "response.audio.delta"
            }
            /// The type of the event. Always `response.audio.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseAudioDeltaEvent._TypePayload
            /// A chunk of Base64 encoded response audio bytes.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseAudioDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.delta`.
            ///   - delta: A chunk of Base64 encoded response audio bytes.
            public init(
                _type: Components.Schemas.ResponseAudioDeltaEvent._TypePayload,
                delta: Swift.String
            ) {
                self._type = _type
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case delta
            }
        }
        /// Emitted when the audio response is complete.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseAudioDoneEvent`.
        public struct ResponseAudioDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.audio.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_audio_done = "response.audio.done"
            }
            /// The type of the event. Always `response.audio.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDoneEvent/type`.
            public var _type: Components.Schemas.ResponseAudioDoneEvent._TypePayload
            /// Creates a new `ResponseAudioDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.done`.
            public init(_type: Components.Schemas.ResponseAudioDoneEvent._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Emitted when there is a partial transcript of audio.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDeltaEvent`.
        public struct ResponseAudioTranscriptDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.audio.transcript.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_audio_transcript_delta = "response.audio.transcript.delta"
            }
            /// The type of the event. Always `response.audio.transcript.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseAudioTranscriptDeltaEvent._TypePayload
            /// The partial transcript of the audio response.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseAudioTranscriptDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.transcript.delta`.
            ///   - delta: The partial transcript of the audio response.
            public init(
                _type: Components.Schemas.ResponseAudioTranscriptDeltaEvent._TypePayload,
                delta: Swift.String
            ) {
                self._type = _type
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case delta
            }
        }
        /// Emitted when the full audio transcript is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDoneEvent`.
        public struct ResponseAudioTranscriptDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.audio.transcript.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_audio_transcript_done = "response.audio.transcript.done"
            }
            /// The type of the event. Always `response.audio.transcript.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDoneEvent/type`.
            public var _type: Components.Schemas.ResponseAudioTranscriptDoneEvent._TypePayload
            /// Creates a new `ResponseAudioTranscriptDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.transcript.done`.
            public init(_type: Components.Schemas.ResponseAudioTranscriptDoneEvent._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Emitted when a partial code snippet is added by the code interpreter.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent`.
        public struct ResponseCodeInterpreterCallCodeDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.code.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_code_delta = "response.code_interpreter_call.code.delta"
            }
            /// The type of the event. Always `response.code_interpreter_call.code.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallCodeDeltaEvent._TypePayload
            /// The index of the output item that the code interpreter call is in progress.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The partial code snippet added by the code interpreter.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseCodeInterpreterCallCodeDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.code.delta`.
            ///   - outputIndex: The index of the output item that the code interpreter call is in progress.
            ///   - delta: The partial code snippet added by the code interpreter.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallCodeDeltaEvent._TypePayload,
                outputIndex: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case delta
            }
        }
        /// Emitted when code snippet output is finalized by the code interpreter.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent`.
        public struct ResponseCodeInterpreterCallCodeDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.code.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_code_done = "response.code_interpreter_call.code.done"
            }
            /// The type of the event. Always `response.code_interpreter_call.code.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallCodeDoneEvent._TypePayload
            /// The index of the output item that the code interpreter call is in progress.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The final code snippet output by the code interpreter.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/code`.
            public var code: Swift.String
            /// Creates a new `ResponseCodeInterpreterCallCodeDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.code.done`.
            ///   - outputIndex: The index of the output item that the code interpreter call is in progress.
            ///   - code: The final code snippet output by the code interpreter.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallCodeDoneEvent._TypePayload,
                outputIndex: Swift.Int,
                code: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.code = code
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case code
            }
        }
        /// Emitted when the code interpreter call is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent`.
        public struct ResponseCodeInterpreterCallCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_completed = "response.code_interpreter_call.completed"
            }
            /// The type of the event. Always `response.code_interpreter_call.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallCompletedEvent._TypePayload
            /// The index of the output item that the code interpreter call is in progress.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/code_interpreter_call`.
            public var codeInterpreterCall: Components.Schemas.CodeInterpreterToolCall
            /// Creates a new `ResponseCodeInterpreterCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.completed`.
            ///   - outputIndex: The index of the output item that the code interpreter call is in progress.
            ///   - codeInterpreterCall:
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                codeInterpreterCall: Components.Schemas.CodeInterpreterToolCall
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.codeInterpreterCall = codeInterpreterCall
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case codeInterpreterCall = "code_interpreter_call"
            }
        }
        /// Emitted when a code interpreter call is in progress.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent`.
        public struct ResponseCodeInterpreterCallInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_inProgress = "response.code_interpreter_call.in_progress"
            }
            /// The type of the event. Always `response.code_interpreter_call.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallInProgressEvent._TypePayload
            /// The index of the output item that the code interpreter call is in progress.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/code_interpreter_call`.
            public var codeInterpreterCall: Components.Schemas.CodeInterpreterToolCall
            /// Creates a new `ResponseCodeInterpreterCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.in_progress`.
            ///   - outputIndex: The index of the output item that the code interpreter call is in progress.
            ///   - codeInterpreterCall:
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                codeInterpreterCall: Components.Schemas.CodeInterpreterToolCall
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.codeInterpreterCall = codeInterpreterCall
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case codeInterpreterCall = "code_interpreter_call"
            }
        }
        /// Emitted when the code interpreter is actively interpreting the code snippet.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent`.
        public struct ResponseCodeInterpreterCallInterpretingEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.interpreting`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_interpreting = "response.code_interpreter_call.interpreting"
            }
            /// The type of the event. Always `response.code_interpreter_call.interpreting`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallInterpretingEvent._TypePayload
            /// The index of the output item that the code interpreter call is in progress.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/output_index`.
            public var outputIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/code_interpreter_call`.
            public var codeInterpreterCall: Components.Schemas.CodeInterpreterToolCall
            /// Creates a new `ResponseCodeInterpreterCallInterpretingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.interpreting`.
            ///   - outputIndex: The index of the output item that the code interpreter call is in progress.
            ///   - codeInterpreterCall:
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallInterpretingEvent._TypePayload,
                outputIndex: Swift.Int,
                codeInterpreterCall: Components.Schemas.CodeInterpreterToolCall
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.codeInterpreterCall = codeInterpreterCall
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case codeInterpreterCall = "code_interpreter_call"
            }
        }
        /// Emitted when the model response is complete.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCompletedEvent`.
        public struct ResponseCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_completed = "response.completed"
            }
            /// The type of the event. Always `response.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseCompletedEvent._TypePayload
            /// - Remark: Generated from `#/components/schemas/ResponseCompletedEvent/response`.
            public var response: Components.Schemas.Response
            /// Creates a new `ResponseCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.completed`.
            ///   - response:
            public init(
                _type: Components.Schemas.ResponseCompletedEvent._TypePayload,
                response: Components.Schemas.Response
            ) {
                self._type = _type
                self.response = response
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
            }
        }
        /// Emitted when a new content part is added.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent`.
        public struct ResponseContentPartAddedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.content_part.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_contentPart_added = "response.content_part.added"
            }
            /// The type of the event. Always `response.content_part.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/type`.
            public var _type: Components.Schemas.ResponseContentPartAddedEvent._TypePayload
            /// The ID of the output item that the content part was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the content part was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/content_index`.
            public var contentIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/part`.
            public var part: Components.Schemas.OutputContent
            /// Creates a new `ResponseContentPartAddedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.content_part.added`.
            ///   - itemId: The ID of the output item that the content part was added to.
            ///   - outputIndex: The index of the output item that the content part was added to.
            ///   - contentIndex: The index of the content part that was added.
            ///   - part:
            public init(
                _type: Components.Schemas.ResponseContentPartAddedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                part: Components.Schemas.OutputContent
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case part
            }
        }
        /// Emitted when a content part is done.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent`.
        public struct ResponseContentPartDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.content_part.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_contentPart_done = "response.content_part.done"
            }
            /// The type of the event. Always `response.content_part.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/type`.
            public var _type: Components.Schemas.ResponseContentPartDoneEvent._TypePayload
            /// The ID of the output item that the content part was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the content part was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that is done.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/content_index`.
            public var contentIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/part`.
            public var part: Components.Schemas.OutputContent
            /// Creates a new `ResponseContentPartDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.content_part.done`.
            ///   - itemId: The ID of the output item that the content part was added to.
            ///   - outputIndex: The index of the output item that the content part was added to.
            ///   - contentIndex: The index of the content part that is done.
            ///   - part:
            public init(
                _type: Components.Schemas.ResponseContentPartDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                part: Components.Schemas.OutputContent
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case part
            }
        }
        /// An event that is emitted when a response is created.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCreatedEvent`.
        public struct ResponseCreatedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.created`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCreatedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_created = "response.created"
            }
            /// The type of the event. Always `response.created`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCreatedEvent/type`.
            public var _type: Components.Schemas.ResponseCreatedEvent._TypePayload
            /// - Remark: Generated from `#/components/schemas/ResponseCreatedEvent/response`.
            public var response: Components.Schemas.Response
            /// Creates a new `ResponseCreatedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.created`.
            ///   - response:
            public init(
                _type: Components.Schemas.ResponseCreatedEvent._TypePayload,
                response: Components.Schemas.Response
            ) {
                self._type = _type
                self.response = response
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
            }
        }
        /// An error object returned when the model fails to generate a Response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseError`.
        public struct ResponseError: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ResponseError/code`.
            public var code: Components.Schemas.ResponseErrorCode
            /// A human-readable description of the error.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseError/message`.
            public var message: Swift.String
            /// Creates a new `ResponseError`.
            ///
            /// - Parameters:
            ///   - code:
            ///   - message: A human-readable description of the error.
            public init(
                code: Components.Schemas.ResponseErrorCode,
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
        /// The error code for the response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseErrorCode`.
        @frozen public enum ResponseErrorCode: String, Codable, Hashable, Sendable, CaseIterable {
            case serverError = "server_error"
            case rateLimitExceeded = "rate_limit_exceeded"
            case invalidPrompt = "invalid_prompt"
            case vectorStoreTimeout = "vector_store_timeout"
            case invalidImage = "invalid_image"
            case invalidImageFormat = "invalid_image_format"
            case invalidBase64Image = "invalid_base64_image"
            case invalidImageUrl = "invalid_image_url"
            case imageTooLarge = "image_too_large"
            case imageTooSmall = "image_too_small"
            case imageParseError = "image_parse_error"
            case imageContentPolicyViolation = "image_content_policy_violation"
            case invalidImageMode = "invalid_image_mode"
            case imageFileTooLarge = "image_file_too_large"
            case unsupportedImageMediaType = "unsupported_image_media_type"
            case emptyImageFile = "empty_image_file"
            case failedToDownloadImage = "failed_to_download_image"
            case imageFileNotFound = "image_file_not_found"
        }
        /// Emitted when an error occurs.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent`.
        public struct ResponseErrorEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `error`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case error = "error"
            }
            /// The type of the event. Always `error`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/type`.
            public var _type: Components.Schemas.ResponseErrorEvent._TypePayload
            /// The error code.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/code`.
            public var code: Swift.String?
            /// The error message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/message`.
            public var message: Swift.String
            /// The error parameter.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/param`.
            public var param: Swift.String?
            /// Creates a new `ResponseErrorEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `error`.
            ///   - code: The error code.
            ///   - message: The error message.
            ///   - param: The error parameter.
            public init(
                _type: Components.Schemas.ResponseErrorEvent._TypePayload,
                code: Swift.String? = nil,
                message: Swift.String,
                param: Swift.String? = nil
            ) {
                self._type = _type
                self.code = code
                self.message = message
                self.param = param
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case code
                case message
                case param
            }
        }
        /// An event that is emitted when a response fails.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFailedEvent`.
        public struct ResponseFailedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.failed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFailedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_failed = "response.failed"
            }
            /// The type of the event. Always `response.failed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFailedEvent/type`.
            public var _type: Components.Schemas.ResponseFailedEvent._TypePayload
            /// - Remark: Generated from `#/components/schemas/ResponseFailedEvent/response`.
            public var response: Components.Schemas.Response
            /// Creates a new `ResponseFailedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.failed`.
            ///   - response:
            public init(
                _type: Components.Schemas.ResponseFailedEvent._TypePayload,
                response: Components.Schemas.Response
            ) {
                self._type = _type
                self.response = response
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
            }
        }
        /// Emitted when a file search call is completed (results found).
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallCompletedEvent`.
        public struct ResponseFileSearchCallCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.file_search_call.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_fileSearchCall_completed = "response.file_search_call.completed"
            }
            /// The type of the event. Always `response.file_search_call.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseFileSearchCallCompletedEvent._TypePayload
            /// The index of the output item that the file search call is initiated.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The ID of the output item that the file search call is initiated.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallCompletedEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseFileSearchCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.file_search_call.completed`.
            ///   - outputIndex: The index of the output item that the file search call is initiated.
            ///   - itemId: The ID of the output item that the file search call is initiated.
            public init(
                _type: Components.Schemas.ResponseFileSearchCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
            }
        }
        /// Emitted when a file search call is initiated.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallInProgressEvent`.
        public struct ResponseFileSearchCallInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.file_search_call.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_fileSearchCall_inProgress = "response.file_search_call.in_progress"
            }
            /// The type of the event. Always `response.file_search_call.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseFileSearchCallInProgressEvent._TypePayload
            /// The index of the output item that the file search call is initiated.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The ID of the output item that the file search call is initiated.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallInProgressEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseFileSearchCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.file_search_call.in_progress`.
            ///   - outputIndex: The index of the output item that the file search call is initiated.
            ///   - itemId: The ID of the output item that the file search call is initiated.
            public init(
                _type: Components.Schemas.ResponseFileSearchCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
            }
        }
        /// Emitted when a file search is currently searching.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallSearchingEvent`.
        public struct ResponseFileSearchCallSearchingEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.file_search_call.searching`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallSearchingEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_fileSearchCall_searching = "response.file_search_call.searching"
            }
            /// The type of the event. Always `response.file_search_call.searching`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallSearchingEvent/type`.
            public var _type: Components.Schemas.ResponseFileSearchCallSearchingEvent._TypePayload
            /// The index of the output item that the file search call is searching.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallSearchingEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The ID of the output item that the file search call is initiated.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallSearchingEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseFileSearchCallSearchingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.file_search_call.searching`.
            ///   - outputIndex: The index of the output item that the file search call is searching.
            ///   - itemId: The ID of the output item that the file search call is initiated.
            public init(
                _type: Components.Schemas.ResponseFileSearchCallSearchingEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
            }
        }
        /// JSON object response format. An older method of generating JSON responses.
        /// Using `json_schema` is recommended for models that support it. Note that the
        /// model will not generate JSON without a system or user message instructing it
        /// to do so.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonObject`.
        public struct ResponseFormatJsonObject: Codable, Hashable, Sendable {
            /// The type of response format being defined. Always `json_object`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonObject/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case jsonObject = "json_object"
            }
            /// The type of response format being defined. Always `json_object`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonObject/type`.
            public var _type: Components.Schemas.ResponseFormatJsonObject._TypePayload
            /// Creates a new `ResponseFormatJsonObject`.
            ///
            /// - Parameters:
            ///   - _type: The type of response format being defined. Always `json_object`.
            public init(_type: Components.Schemas.ResponseFormatJsonObject._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// The schema for the response format, described as a JSON Schema object.
        /// Learn how to build JSON schemas [here](https://json-schema.org/).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchemaSchema`.
        public struct ResponseFormatJsonSchemaSchema: Codable, Hashable, Sendable {
            /// A container of undocumented properties.
            public var additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer
            /// Creates a new `ResponseFormatJsonSchemaSchema`.
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
        /// Default response format. Used to generate text responses.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatText`.
        public struct ResponseFormatText: Codable, Hashable, Sendable {
            /// The type of response format being defined. Always `text`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatText/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case text = "text"
            }
            /// The type of response format being defined. Always `text`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatText/type`.
            public var _type: Components.Schemas.ResponseFormatText._TypePayload
            /// Creates a new `ResponseFormatText`.
            ///
            /// - Parameters:
            ///   - _type: The type of response format being defined. Always `text`.
            public init(_type: Components.Schemas.ResponseFormatText._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Emitted when there is a partial function-call arguments delta.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent`.
        public struct ResponseFunctionCallArgumentsDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.function_call_arguments.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_functionCallArguments_delta = "response.function_call_arguments.delta"
            }
            /// The type of the event. Always `response.function_call_arguments.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseFunctionCallArgumentsDeltaEvent._TypePayload
            /// The ID of the output item that the function-call arguments delta is added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the function-call arguments delta is added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The function-call arguments delta that is added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseFunctionCallArgumentsDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.function_call_arguments.delta`.
            ///   - itemId: The ID of the output item that the function-call arguments delta is added to.
            ///   - outputIndex: The index of the output item that the function-call arguments delta is added to.
            ///   - delta: The function-call arguments delta that is added.
            public init(
                _type: Components.Schemas.ResponseFunctionCallArgumentsDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case delta
            }
        }
        /// Emitted when function-call arguments are finalized.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent`.
        public struct ResponseFunctionCallArgumentsDoneEvent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_functionCallArguments_done = "response.function_call_arguments.done"
            }
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/type`.
            public var _type: Components.Schemas.ResponseFunctionCallArgumentsDoneEvent._TypePayload
            /// The ID of the item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The function-call arguments.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/arguments`.
            public var arguments: Swift.String
            /// Creates a new `ResponseFunctionCallArgumentsDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type:
            ///   - itemId: The ID of the item.
            ///   - outputIndex: The index of the output item.
            ///   - arguments: The function-call arguments.
            public init(
                _type: Components.Schemas.ResponseFunctionCallArgumentsDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                arguments: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.arguments = arguments
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case arguments
            }
        }
        /// Emitted when the response is in progress.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseInProgressEvent`.
        public struct ResponseInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_inProgress = "response.in_progress"
            }
            /// The type of the event. Always `response.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseInProgressEvent._TypePayload
            /// - Remark: Generated from `#/components/schemas/ResponseInProgressEvent/response`.
            public var response: Components.Schemas.Response
            /// Creates a new `ResponseInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.in_progress`.
            ///   - response:
            public init(
                _type: Components.Schemas.ResponseInProgressEvent._TypePayload,
                response: Components.Schemas.Response
            ) {
                self._type = _type
                self.response = response
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
            }
        }
        /// An event that is emitted when a response finishes as incomplete.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseIncompleteEvent`.
        public struct ResponseIncompleteEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.incomplete`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseIncompleteEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_incomplete = "response.incomplete"
            }
            /// The type of the event. Always `response.incomplete`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseIncompleteEvent/type`.
            public var _type: Components.Schemas.ResponseIncompleteEvent._TypePayload
            /// - Remark: Generated from `#/components/schemas/ResponseIncompleteEvent/response`.
            public var response: Components.Schemas.Response
            /// Creates a new `ResponseIncompleteEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.incomplete`.
            ///   - response:
            public init(
                _type: Components.Schemas.ResponseIncompleteEvent._TypePayload,
                response: Components.Schemas.Response
            ) {
                self._type = _type
                self.response = response
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
            }
        }
        /// A list of Response items.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseItemList`.
        public struct ResponseItemList: Codable, Hashable, Sendable {
            /// The type of object returned, must be `list`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseItemList/object`.
            @frozen public enum ObjectPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case list = "list"
            }
            /// The type of object returned, must be `list`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseItemList/object`.
            public var object: Components.Schemas.ResponseItemList.ObjectPayload
            /// A list of items used to generate this response.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseItemList/data`.
            public var data: [Components.Schemas.ItemResource]
            /// Whether there are more items available.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseItemList/has_more`.
            public var hasMore: Swift.Bool
            /// The ID of the first item in the list.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseItemList/first_id`.
            public var firstId: Swift.String
            /// The ID of the last item in the list.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseItemList/last_id`.
            public var lastId: Swift.String
            /// Creates a new `ResponseItemList`.
            ///
            /// - Parameters:
            ///   - object: The type of object returned, must be `list`.
            ///   - data: A list of items used to generate this response.
            ///   - hasMore: Whether there are more items available.
            ///   - firstId: The ID of the first item in the list.
            ///   - lastId: The ID of the last item in the list.
            public init(
                object: Components.Schemas.ResponseItemList.ObjectPayload,
                data: [Components.Schemas.ItemResource],
                hasMore: Swift.Bool,
                firstId: Swift.String,
                lastId: Swift.String
            ) {
                self.object = object
                self.data = data
                self.hasMore = hasMore
                self.firstId = firstId
                self.lastId = lastId
            }
            public enum CodingKeys: String, CodingKey {
                case object
                case data
                case hasMore = "has_more"
                case firstId = "first_id"
                case lastId = "last_id"
            }
        }
        /// Emitted when a new output item is added.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent`.
        public struct ResponseOutputItemAddedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.output_item.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_outputItem_added = "response.output_item.added"
            }
            /// The type of the event. Always `response.output_item.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent/type`.
            public var _type: Components.Schemas.ResponseOutputItemAddedEvent._TypePayload
            /// The index of the output item that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent/item`.
            public var item: Components.Schemas.OutputItem
            /// Creates a new `ResponseOutputItemAddedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_item.added`.
            ///   - outputIndex: The index of the output item that was added.
            ///   - item:
            public init(
                _type: Components.Schemas.ResponseOutputItemAddedEvent._TypePayload,
                outputIndex: Swift.Int,
                item: Components.Schemas.OutputItem
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.item = item
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case item
            }
        }
        /// Emitted when an output item is marked done.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent`.
        public struct ResponseOutputItemDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.output_item.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_outputItem_done = "response.output_item.done"
            }
            /// The type of the event. Always `response.output_item.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent/type`.
            public var _type: Components.Schemas.ResponseOutputItemDoneEvent._TypePayload
            /// The index of the output item that was marked done.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent/item`.
            public var item: Components.Schemas.OutputItem
            /// Creates a new `ResponseOutputItemDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_item.done`.
            ///   - outputIndex: The index of the output item that was marked done.
            ///   - item:
            public init(
                _type: Components.Schemas.ResponseOutputItemDoneEvent._TypePayload,
                outputIndex: Swift.Int,
                item: Components.Schemas.OutputItem
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.item = item
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case item
            }
        }
        /// - Remark: Generated from `#/components/schemas/ResponseProperties`.
        public struct ResponseProperties: Codable, Hashable, Sendable {
            /// The unique ID of the previous response to the model. Use this to
            /// create multi-turn conversations. Learn more about
            /// [conversation state](/docs/guides/conversation-state).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/previous_response_id`.
            public var previousResponseId: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/model`.
            public var model: Components.Schemas.ModelIdsResponses?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/reasoning`.
            public var reasoning: Components.Schemas.Reasoning?
            /// An upper bound for the number of tokens that can be generated for a response, including visible output tokens and [reasoning tokens](/docs/guides/reasoning).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/max_output_tokens`.
            public var maxOutputTokens: Swift.Int?
            /// Inserts a system (or developer) message as the first item in the model's context.
            ///
            /// When using along with `previous_response_id`, the instructions from a previous
            /// response will not be carried over to the next response. This makes it simple
            /// to swap out system (or developer) messages in new responses.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/instructions`.
            public var instructions: Swift.String?
            /// Configuration options for a text response from the model. Can be plain
            /// text or structured JSON data. Learn more:
            /// - [Text inputs and outputs](/docs/guides/text)
            /// - [Structured Outputs](/docs/guides/structured-outputs)
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/text`.
            public struct TextPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ResponseProperties/text/format`.
                public var format: Components.Schemas.TextResponseFormatConfiguration?
                /// Creates a new `TextPayload`.
                ///
                /// - Parameters:
                ///   - format:
                public init(format: Components.Schemas.TextResponseFormatConfiguration? = nil) {
                    self.format = format
                }
                public enum CodingKeys: String, CodingKey {
                    case format
                }
            }
            /// Configuration options for a text response from the model. Can be plain
            /// text or structured JSON data. Learn more:
            /// - [Text inputs and outputs](/docs/guides/text)
            /// - [Structured Outputs](/docs/guides/structured-outputs)
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/text`.
            public var text: Components.Schemas.ResponseProperties.TextPayload?
            /// An array of tools the model may call while generating a response. You
            /// can specify which tool to use by setting the `tool_choice` parameter.
            ///
            /// The two categories of tools you can provide the model are:
            ///
            /// - **Built-in tools**: Tools that are provided by OpenAI that extend the
            ///   model's capabilities, like [web search](/docs/guides/tools-web-search)
            ///   or [file search](/docs/guides/tools-file-search). Learn more about
            ///   [built-in tools](/docs/guides/tools).
            /// - **Function calls (custom tools)**: Functions that are defined by you,
            ///   enabling the model to call your own code. Learn more about
            ///   [function calling](/docs/guides/function-calling).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/tools`.
            public var tools: [Components.Schemas.Tool]?
            /// How the model should select which tool (or tools) to use when generating
            /// a response. See the `tools` parameter to see how to specify which tools
            /// the model can call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/tool_choice`.
            @frozen public enum ToolChoicePayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ResponseProperties/tool_choice/case1`.
                case ToolChoiceOptions(Components.Schemas.ToolChoiceOptions)
                /// - Remark: Generated from `#/components/schemas/ResponseProperties/tool_choice/case2`.
                case ToolChoiceTypes(Components.Schemas.ToolChoiceTypes)
                /// - Remark: Generated from `#/components/schemas/ResponseProperties/tool_choice/case3`.
                case ToolChoiceFunction(Components.Schemas.ToolChoiceFunction)
                public init(from decoder: any Decoder) throws {
                    var errors: [any Error] = []
                    do {
                        self = .ToolChoiceOptions(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .ToolChoiceTypes(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .ToolChoiceFunction(try .init(from: decoder))
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
                    case let .ToolChoiceOptions(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .ToolChoiceTypes(value):
                        try value.encode(to: encoder)
                    case let .ToolChoiceFunction(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// How the model should select which tool (or tools) to use when generating
            /// a response. See the `tools` parameter to see how to specify which tools
            /// the model can call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/tool_choice`.
            public var toolChoice: Components.Schemas.ResponseProperties.ToolChoicePayload?
            /// The truncation strategy to use for the model response.
            /// - `auto`: If the context of this response and previous ones exceeds
            ///   the model's context window size, the model will truncate the
            ///   response to fit the context window by dropping input items in the
            ///   middle of the conversation.
            /// - `disabled` (default): If a model response will exceed the context window
            ///   size for a model, the request will fail with a 400 error.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/truncation`.
            @frozen public enum TruncationPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case disabled = "disabled"
            }
            /// The truncation strategy to use for the model response.
            /// - `auto`: If the context of this response and previous ones exceeds
            ///   the model's context window size, the model will truncate the
            ///   response to fit the context window by dropping input items in the
            ///   middle of the conversation.
            /// - `disabled` (default): If a model response will exceed the context window
            ///   size for a model, the request will fail with a 400 error.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/truncation`.
            public var truncation: Components.Schemas.ResponseProperties.TruncationPayload?
            /// Creates a new `ResponseProperties`.
            ///
            /// - Parameters:
            ///   - previousResponseId: The unique ID of the previous response to the model. Use this to
            ///   - model:
            ///   - reasoning:
            ///   - maxOutputTokens: An upper bound for the number of tokens that can be generated for a response, including visible output tokens and [reasoning tokens](/docs/guides/reasoning).
            ///   - instructions: Inserts a system (or developer) message as the first item in the model's context.
            ///   - text: Configuration options for a text response from the model. Can be plain
            ///   - tools: An array of tools the model may call while generating a response. You
            ///   - toolChoice: How the model should select which tool (or tools) to use when generating
            ///   - truncation: The truncation strategy to use for the model response.
            public init(
                previousResponseId: Swift.String? = nil,
                model: Components.Schemas.ModelIdsResponses? = nil,
                reasoning: Components.Schemas.Reasoning? = nil,
                maxOutputTokens: Swift.Int? = nil,
                instructions: Swift.String? = nil,
                text: Components.Schemas.ResponseProperties.TextPayload? = nil,
                tools: [Components.Schemas.Tool]? = nil,
                toolChoice: Components.Schemas.ResponseProperties.ToolChoicePayload? = nil,
                truncation: Components.Schemas.ResponseProperties.TruncationPayload? = nil
            ) {
                self.previousResponseId = previousResponseId
                self.model = model
                self.reasoning = reasoning
                self.maxOutputTokens = maxOutputTokens
                self.instructions = instructions
                self.text = text
                self.tools = tools
                self.toolChoice = toolChoice
                self.truncation = truncation
            }
            public enum CodingKeys: String, CodingKey {
                case previousResponseId = "previous_response_id"
                case model
                case reasoning
                case maxOutputTokens = "max_output_tokens"
                case instructions
                case text
                case tools
                case toolChoice = "tool_choice"
                case truncation
            }
        }
        /// Emitted when a new reasoning summary part is added.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent`.
        public struct ResponseReasoningSummaryPartAddedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.reasoning_summary_part.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_reasoningSummaryPart_added = "response.reasoning_summary_part.added"
            }
            /// The type of the event. Always `response.reasoning_summary_part.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/type`.
            public var _type: Components.Schemas.ResponseReasoningSummaryPartAddedEvent._TypePayload
            /// The ID of the item this summary part is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item this summary part is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the summary part within the reasoning summary.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/summary_index`.
            public var summaryIndex: Swift.Int
            /// The summary part that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/part`.
            public struct PartPayload: Codable, Hashable, Sendable {
                /// The type of the summary part. Always `summary_text`.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/part/type`.
                @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case summaryText = "summary_text"
                }
                /// The type of the summary part. Always `summary_text`.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/part/type`.
                public var _type: Components.Schemas.ResponseReasoningSummaryPartAddedEvent.PartPayload._TypePayload
                /// The text of the summary part.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/part/text`.
                public var text: Swift.String
                /// Creates a new `PartPayload`.
                ///
                /// - Parameters:
                ///   - _type: The type of the summary part. Always `summary_text`.
                ///   - text: The text of the summary part.
                public init(
                    _type: Components.Schemas.ResponseReasoningSummaryPartAddedEvent.PartPayload._TypePayload,
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
            /// The summary part that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/part`.
            public var part: Components.Schemas.ResponseReasoningSummaryPartAddedEvent.PartPayload
            /// Creates a new `ResponseReasoningSummaryPartAddedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_summary_part.added`.
            ///   - itemId: The ID of the item this summary part is associated with.
            ///   - outputIndex: The index of the output item this summary part is associated with.
            ///   - summaryIndex: The index of the summary part within the reasoning summary.
            ///   - part: The summary part that was added.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryPartAddedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                part: Components.Schemas.ResponseReasoningSummaryPartAddedEvent.PartPayload
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case part
            }
        }
        /// Emitted when a reasoning summary part is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent`.
        public struct ResponseReasoningSummaryPartDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.reasoning_summary_part.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_reasoningSummaryPart_done = "response.reasoning_summary_part.done"
            }
            /// The type of the event. Always `response.reasoning_summary_part.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/type`.
            public var _type: Components.Schemas.ResponseReasoningSummaryPartDoneEvent._TypePayload
            /// The ID of the item this summary part is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item this summary part is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the summary part within the reasoning summary.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/summary_index`.
            public var summaryIndex: Swift.Int
            /// The completed summary part.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/part`.
            public struct PartPayload: Codable, Hashable, Sendable {
                /// The type of the summary part. Always `summary_text`.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/part/type`.
                @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case summaryText = "summary_text"
                }
                /// The type of the summary part. Always `summary_text`.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/part/type`.
                public var _type: Components.Schemas.ResponseReasoningSummaryPartDoneEvent.PartPayload._TypePayload
                /// The text of the summary part.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/part/text`.
                public var text: Swift.String
                /// Creates a new `PartPayload`.
                ///
                /// - Parameters:
                ///   - _type: The type of the summary part. Always `summary_text`.
                ///   - text: The text of the summary part.
                public init(
                    _type: Components.Schemas.ResponseReasoningSummaryPartDoneEvent.PartPayload._TypePayload,
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
            /// The completed summary part.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/part`.
            public var part: Components.Schemas.ResponseReasoningSummaryPartDoneEvent.PartPayload
            /// Creates a new `ResponseReasoningSummaryPartDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_summary_part.done`.
            ///   - itemId: The ID of the item this summary part is associated with.
            ///   - outputIndex: The index of the output item this summary part is associated with.
            ///   - summaryIndex: The index of the summary part within the reasoning summary.
            ///   - part: The completed summary part.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryPartDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                part: Components.Schemas.ResponseReasoningSummaryPartDoneEvent.PartPayload
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case part
            }
        }
        /// Emitted when a delta is added to a reasoning summary text.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent`.
        public struct ResponseReasoningSummaryTextDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.reasoning_summary_text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_reasoningSummaryText_delta = "response.reasoning_summary_text.delta"
            }
            /// The type of the event. Always `response.reasoning_summary_text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseReasoningSummaryTextDeltaEvent._TypePayload
            /// The ID of the item this summary text delta is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item this summary text delta is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the summary part within the reasoning summary.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/summary_index`.
            public var summaryIndex: Swift.Int
            /// The text delta that was added to the summary.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseReasoningSummaryTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_summary_text.delta`.
            ///   - itemId: The ID of the item this summary text delta is associated with.
            ///   - outputIndex: The index of the output item this summary text delta is associated with.
            ///   - summaryIndex: The index of the summary part within the reasoning summary.
            ///   - delta: The text delta that was added to the summary.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryTextDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case delta
            }
        }
        /// Emitted when a reasoning summary text is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent`.
        public struct ResponseReasoningSummaryTextDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.reasoning_summary_text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_reasoningSummaryText_done = "response.reasoning_summary_text.done"
            }
            /// The type of the event. Always `response.reasoning_summary_text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/type`.
            public var _type: Components.Schemas.ResponseReasoningSummaryTextDoneEvent._TypePayload
            /// The ID of the item this summary text is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item this summary text is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the summary part within the reasoning summary.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/summary_index`.
            public var summaryIndex: Swift.Int
            /// The full text of the completed reasoning summary.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/text`.
            public var text: Swift.String
            /// Creates a new `ResponseReasoningSummaryTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_summary_text.done`.
            ///   - itemId: The ID of the item this summary text is associated with.
            ///   - outputIndex: The index of the output item this summary text is associated with.
            ///   - summaryIndex: The index of the summary part within the reasoning summary.
            ///   - text: The full text of the completed reasoning summary.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryTextDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                text: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.text = text
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case text
            }
        }
        /// Emitted when there is a partial refusal text.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent`.
        public struct ResponseRefusalDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.refusal.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_refusal_delta = "response.refusal.delta"
            }
            /// The type of the event. Always `response.refusal.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseRefusalDeltaEvent._TypePayload
            /// The ID of the output item that the refusal text is added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the refusal text is added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that the refusal text is added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The refusal text that is added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseRefusalDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.refusal.delta`.
            ///   - itemId: The ID of the output item that the refusal text is added to.
            ///   - outputIndex: The index of the output item that the refusal text is added to.
            ///   - contentIndex: The index of the content part that the refusal text is added to.
            ///   - delta: The refusal text that is added.
            public init(
                _type: Components.Schemas.ResponseRefusalDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case delta
            }
        }
        /// Emitted when refusal text is finalized.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent`.
        public struct ResponseRefusalDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.refusal.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_refusal_done = "response.refusal.done"
            }
            /// The type of the event. Always `response.refusal.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/type`.
            public var _type: Components.Schemas.ResponseRefusalDoneEvent._TypePayload
            /// The ID of the output item that the refusal text is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the refusal text is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that the refusal text is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The refusal text that is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/refusal`.
            public var refusal: Swift.String
            /// Creates a new `ResponseRefusalDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.refusal.done`.
            ///   - itemId: The ID of the output item that the refusal text is finalized.
            ///   - outputIndex: The index of the output item that the refusal text is finalized.
            ///   - contentIndex: The index of the content part that the refusal text is finalized.
            ///   - refusal: The refusal text that is finalized.
            public init(
                _type: Components.Schemas.ResponseRefusalDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                refusal: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.refusal = refusal
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case refusal
            }
        }
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent`.
        public struct ResponseStreamEvent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value1`.
            public var value1: Components.Schemas.ResponseAudioDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value2`.
            public var value2: Components.Schemas.ResponseAudioDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value3`.
            public var value3: Components.Schemas.ResponseAudioTranscriptDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value4`.
            public var value4: Components.Schemas.ResponseAudioTranscriptDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value5`.
            public var value5: Components.Schemas.ResponseCodeInterpreterCallCodeDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value6`.
            public var value6: Components.Schemas.ResponseCodeInterpreterCallCodeDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value7`.
            public var value7: Components.Schemas.ResponseCodeInterpreterCallCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value8`.
            public var value8: Components.Schemas.ResponseCodeInterpreterCallInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value9`.
            public var value9: Components.Schemas.ResponseCodeInterpreterCallInterpretingEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value10`.
            public var value10: Components.Schemas.ResponseCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value11`.
            public var value11: Components.Schemas.ResponseContentPartAddedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value12`.
            public var value12: Components.Schemas.ResponseContentPartDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value13`.
            public var value13: Components.Schemas.ResponseCreatedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value14`.
            public var value14: Components.Schemas.ResponseErrorEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value15`.
            public var value15: Components.Schemas.ResponseFileSearchCallCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value16`.
            public var value16: Components.Schemas.ResponseFileSearchCallInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value17`.
            public var value17: Components.Schemas.ResponseFileSearchCallSearchingEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value18`.
            public var value18: Components.Schemas.ResponseFunctionCallArgumentsDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value19`.
            public var value19: Components.Schemas.ResponseFunctionCallArgumentsDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value20`.
            public var value20: Components.Schemas.ResponseInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value21`.
            public var value21: Components.Schemas.ResponseFailedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value22`.
            public var value22: Components.Schemas.ResponseIncompleteEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value23`.
            public var value23: Components.Schemas.ResponseOutputItemAddedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value24`.
            public var value24: Components.Schemas.ResponseOutputItemDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value25`.
            public var value25: Components.Schemas.ResponseReasoningSummaryPartAddedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value26`.
            public var value26: Components.Schemas.ResponseReasoningSummaryPartDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value27`.
            public var value27: Components.Schemas.ResponseReasoningSummaryTextDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value28`.
            public var value28: Components.Schemas.ResponseReasoningSummaryTextDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value29`.
            public var value29: Components.Schemas.ResponseRefusalDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value30`.
            public var value30: Components.Schemas.ResponseRefusalDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value31`.
            public var value31: Components.Schemas.ResponseTextAnnotationDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value32`.
            public var value32: Components.Schemas.ResponseTextDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value33`.
            public var value33: Components.Schemas.ResponseTextDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value34`.
            public var value34: Components.Schemas.ResponseWebSearchCallCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value35`.
            public var value35: Components.Schemas.ResponseWebSearchCallInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value36`.
            public var value36: Components.Schemas.ResponseWebSearchCallSearchingEvent?
            /// Creates a new `ResponseStreamEvent`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            ///   - value3:
            ///   - value4:
            ///   - value5:
            ///   - value6:
            ///   - value7:
            ///   - value8:
            ///   - value9:
            ///   - value10:
            ///   - value11:
            ///   - value12:
            ///   - value13:
            ///   - value14:
            ///   - value15:
            ///   - value16:
            ///   - value17:
            ///   - value18:
            ///   - value19:
            ///   - value20:
            ///   - value21:
            ///   - value22:
            ///   - value23:
            ///   - value24:
            ///   - value25:
            ///   - value26:
            ///   - value27:
            ///   - value28:
            ///   - value29:
            ///   - value30:
            ///   - value31:
            ///   - value32:
            ///   - value33:
            ///   - value34:
            ///   - value35:
            ///   - value36:
            public init(
                value1: Components.Schemas.ResponseAudioDeltaEvent? = nil,
                value2: Components.Schemas.ResponseAudioDoneEvent? = nil,
                value3: Components.Schemas.ResponseAudioTranscriptDeltaEvent? = nil,
                value4: Components.Schemas.ResponseAudioTranscriptDoneEvent? = nil,
                value5: Components.Schemas.ResponseCodeInterpreterCallCodeDeltaEvent? = nil,
                value6: Components.Schemas.ResponseCodeInterpreterCallCodeDoneEvent? = nil,
                value7: Components.Schemas.ResponseCodeInterpreterCallCompletedEvent? = nil,
                value8: Components.Schemas.ResponseCodeInterpreterCallInProgressEvent? = nil,
                value9: Components.Schemas.ResponseCodeInterpreterCallInterpretingEvent? = nil,
                value10: Components.Schemas.ResponseCompletedEvent? = nil,
                value11: Components.Schemas.ResponseContentPartAddedEvent? = nil,
                value12: Components.Schemas.ResponseContentPartDoneEvent? = nil,
                value13: Components.Schemas.ResponseCreatedEvent? = nil,
                value14: Components.Schemas.ResponseErrorEvent? = nil,
                value15: Components.Schemas.ResponseFileSearchCallCompletedEvent? = nil,
                value16: Components.Schemas.ResponseFileSearchCallInProgressEvent? = nil,
                value17: Components.Schemas.ResponseFileSearchCallSearchingEvent? = nil,
                value18: Components.Schemas.ResponseFunctionCallArgumentsDeltaEvent? = nil,
                value19: Components.Schemas.ResponseFunctionCallArgumentsDoneEvent? = nil,
                value20: Components.Schemas.ResponseInProgressEvent? = nil,
                value21: Components.Schemas.ResponseFailedEvent? = nil,
                value22: Components.Schemas.ResponseIncompleteEvent? = nil,
                value23: Components.Schemas.ResponseOutputItemAddedEvent? = nil,
                value24: Components.Schemas.ResponseOutputItemDoneEvent? = nil,
                value25: Components.Schemas.ResponseReasoningSummaryPartAddedEvent? = nil,
                value26: Components.Schemas.ResponseReasoningSummaryPartDoneEvent? = nil,
                value27: Components.Schemas.ResponseReasoningSummaryTextDeltaEvent? = nil,
                value28: Components.Schemas.ResponseReasoningSummaryTextDoneEvent? = nil,
                value29: Components.Schemas.ResponseRefusalDeltaEvent? = nil,
                value30: Components.Schemas.ResponseRefusalDoneEvent? = nil,
                value31: Components.Schemas.ResponseTextAnnotationDeltaEvent? = nil,
                value32: Components.Schemas.ResponseTextDeltaEvent? = nil,
                value33: Components.Schemas.ResponseTextDoneEvent? = nil,
                value34: Components.Schemas.ResponseWebSearchCallCompletedEvent? = nil,
                value35: Components.Schemas.ResponseWebSearchCallInProgressEvent? = nil,
                value36: Components.Schemas.ResponseWebSearchCallSearchingEvent? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
                self.value3 = value3
                self.value4 = value4
                self.value5 = value5
                self.value6 = value6
                self.value7 = value7
                self.value8 = value8
                self.value9 = value9
                self.value10 = value10
                self.value11 = value11
                self.value12 = value12
                self.value13 = value13
                self.value14 = value14
                self.value15 = value15
                self.value16 = value16
                self.value17 = value17
                self.value18 = value18
                self.value19 = value19
                self.value20 = value20
                self.value21 = value21
                self.value22 = value22
                self.value23 = value23
                self.value24 = value24
                self.value25 = value25
                self.value26 = value26
                self.value27 = value27
                self.value28 = value28
                self.value29 = value29
                self.value30 = value30
                self.value31 = value31
                self.value32 = value32
                self.value33 = value33
                self.value34 = value34
                self.value35 = value35
                self.value36 = value36
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
                do {
                    self.value7 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value8 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value9 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value10 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value11 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value12 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value13 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value14 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value15 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value16 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value17 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value18 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value19 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value20 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value21 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value22 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value23 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value24 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value25 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value26 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value27 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value28 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value29 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value30 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value31 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value32 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value33 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value34 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value35 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value36 = try .init(from: decoder)
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
                        self.value6,
                        self.value7,
                        self.value8,
                        self.value9,
                        self.value10,
                        self.value11,
                        self.value12,
                        self.value13,
                        self.value14,
                        self.value15,
                        self.value16,
                        self.value17,
                        self.value18,
                        self.value19,
                        self.value20,
                        self.value21,
                        self.value22,
                        self.value23,
                        self.value24,
                        self.value25,
                        self.value26,
                        self.value27,
                        self.value28,
                        self.value29,
                        self.value30,
                        self.value31,
                        self.value32,
                        self.value33,
                        self.value34,
                        self.value35,
                        self.value36
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
                try self.value7?.encode(to: encoder)
                try self.value8?.encode(to: encoder)
                try self.value9?.encode(to: encoder)
                try self.value10?.encode(to: encoder)
                try self.value11?.encode(to: encoder)
                try self.value12?.encode(to: encoder)
                try self.value13?.encode(to: encoder)
                try self.value14?.encode(to: encoder)
                try self.value15?.encode(to: encoder)
                try self.value16?.encode(to: encoder)
                try self.value17?.encode(to: encoder)
                try self.value18?.encode(to: encoder)
                try self.value19?.encode(to: encoder)
                try self.value20?.encode(to: encoder)
                try self.value21?.encode(to: encoder)
                try self.value22?.encode(to: encoder)
                try self.value23?.encode(to: encoder)
                try self.value24?.encode(to: encoder)
                try self.value25?.encode(to: encoder)
                try self.value26?.encode(to: encoder)
                try self.value27?.encode(to: encoder)
                try self.value28?.encode(to: encoder)
                try self.value29?.encode(to: encoder)
                try self.value30?.encode(to: encoder)
                try self.value31?.encode(to: encoder)
                try self.value32?.encode(to: encoder)
                try self.value33?.encode(to: encoder)
                try self.value34?.encode(to: encoder)
                try self.value35?.encode(to: encoder)
                try self.value36?.encode(to: encoder)
            }
        }
        /// Emitted when a text annotation is added.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent`.
        public struct ResponseTextAnnotationDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.output_text.annotation.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_outputText_annotation_added = "response.output_text.annotation.added"
            }
            /// The type of the event. Always `response.output_text.annotation.added`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseTextAnnotationDeltaEvent._TypePayload
            /// The ID of the output item that the text annotation was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the text annotation was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that the text annotation was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The index of the annotation that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/annotation_index`.
            public var annotationIndex: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ResponseTextAnnotationDeltaEvent/annotation`.
            public var annotation: Components.Schemas.Annotation
            /// Creates a new `ResponseTextAnnotationDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_text.annotation.added`.
            ///   - itemId: The ID of the output item that the text annotation was added to.
            ///   - outputIndex: The index of the output item that the text annotation was added to.
            ///   - contentIndex: The index of the content part that the text annotation was added to.
            ///   - annotationIndex: The index of the annotation that was added.
            ///   - annotation:
            public init(
                _type: Components.Schemas.ResponseTextAnnotationDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                annotationIndex: Swift.Int,
                annotation: Components.Schemas.Annotation
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.annotationIndex = annotationIndex
                self.annotation = annotation
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case annotationIndex = "annotation_index"
                case annotation
            }
        }
        /// Emitted when there is an additional text delta.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent`.
        public struct ResponseTextDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.output_text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_outputText_delta = "response.output_text.delta"
            }
            /// The type of the event. Always `response.output_text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseTextDeltaEvent._TypePayload
            /// The ID of the output item that the text delta was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the text delta was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that the text delta was added to.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The text delta that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_text.delta`.
            ///   - itemId: The ID of the output item that the text delta was added to.
            ///   - outputIndex: The index of the output item that the text delta was added to.
            ///   - contentIndex: The index of the content part that the text delta was added to.
            ///   - delta: The text delta that was added.
            public init(
                _type: Components.Schemas.ResponseTextDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case delta
            }
        }
        /// Emitted when text content is finalized.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent`.
        public struct ResponseTextDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.output_text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_outputText_done = "response.output_text.done"
            }
            /// The type of the event. Always `response.output_text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/type`.
            public var _type: Components.Schemas.ResponseTextDoneEvent._TypePayload
            /// The ID of the output item that the text content is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that the text content is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part that the text content is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The text content that is finalized.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/text`.
            public var text: Swift.String
            /// Creates a new `ResponseTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_text.done`.
            ///   - itemId: The ID of the output item that the text content is finalized.
            ///   - outputIndex: The index of the output item that the text content is finalized.
            ///   - contentIndex: The index of the content part that the text content is finalized.
            ///   - text: The text content that is finalized.
            public init(
                _type: Components.Schemas.ResponseTextDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                text: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.text = text
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case text
            }
        }
        /// Represents token usage details including input tokens, output tokens,
        /// a breakdown of output tokens, and the total tokens used.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseUsage`.
        public struct ResponseUsage: Codable, Hashable, Sendable {
            /// The number of input tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/input_tokens`.
            public var inputTokens: Swift.Int
            /// A detailed breakdown of the input tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/input_tokens_details`.
            public struct InputTokensDetailsPayload: Codable, Hashable, Sendable {
                /// The number of tokens that were retrieved from the cache.
                /// [More on prompt caching](/docs/guides/prompt-caching).
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseUsage/input_tokens_details/cached_tokens`.
                public var cachedTokens: Swift.Int
                /// Creates a new `InputTokensDetailsPayload`.
                ///
                /// - Parameters:
                ///   - cachedTokens: The number of tokens that were retrieved from the cache.
                public init(cachedTokens: Swift.Int) {
                    self.cachedTokens = cachedTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case cachedTokens = "cached_tokens"
                }
            }
            /// A detailed breakdown of the input tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/input_tokens_details`.
            public var inputTokensDetails: Components.Schemas.ResponseUsage.InputTokensDetailsPayload
            /// The number of output tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/output_tokens`.
            public var outputTokens: Swift.Int
            /// A detailed breakdown of the output tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/output_tokens_details`.
            public struct OutputTokensDetailsPayload: Codable, Hashable, Sendable {
                /// The number of reasoning tokens.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseUsage/output_tokens_details/reasoning_tokens`.
                public var reasoningTokens: Swift.Int
                /// Creates a new `OutputTokensDetailsPayload`.
                ///
                /// - Parameters:
                ///   - reasoningTokens: The number of reasoning tokens.
                public init(reasoningTokens: Swift.Int) {
                    self.reasoningTokens = reasoningTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case reasoningTokens = "reasoning_tokens"
                }
            }
            /// A detailed breakdown of the output tokens.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/output_tokens_details`.
            public var outputTokensDetails: Components.Schemas.ResponseUsage.OutputTokensDetailsPayload
            /// The total number of tokens used.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseUsage/total_tokens`.
            public var totalTokens: Swift.Int
            /// Creates a new `ResponseUsage`.
            ///
            /// - Parameters:
            ///   - inputTokens: The number of input tokens.
            ///   - inputTokensDetails: A detailed breakdown of the input tokens.
            ///   - outputTokens: The number of output tokens.
            ///   - outputTokensDetails: A detailed breakdown of the output tokens.
            ///   - totalTokens: The total number of tokens used.
            public init(
                inputTokens: Swift.Int,
                inputTokensDetails: Components.Schemas.ResponseUsage.InputTokensDetailsPayload,
                outputTokens: Swift.Int,
                outputTokensDetails: Components.Schemas.ResponseUsage.OutputTokensDetailsPayload,
                totalTokens: Swift.Int
            ) {
                self.inputTokens = inputTokens
                self.inputTokensDetails = inputTokensDetails
                self.outputTokens = outputTokens
                self.outputTokensDetails = outputTokensDetails
                self.totalTokens = totalTokens
            }
            public enum CodingKeys: String, CodingKey {
                case inputTokens = "input_tokens"
                case inputTokensDetails = "input_tokens_details"
                case outputTokens = "output_tokens"
                case outputTokensDetails = "output_tokens_details"
                case totalTokens = "total_tokens"
            }
        }
        /// Emitted when a web search call is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallCompletedEvent`.
        public struct ResponseWebSearchCallCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.web_search_call.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_webSearchCall_completed = "response.web_search_call.completed"
            }
            /// The type of the event. Always `response.web_search_call.completed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseWebSearchCallCompletedEvent._TypePayload
            /// The index of the output item that the web search call is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// Unique ID for the output item associated with the web search call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallCompletedEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseWebSearchCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.web_search_call.completed`.
            ///   - outputIndex: The index of the output item that the web search call is associated with.
            ///   - itemId: Unique ID for the output item associated with the web search call.
            public init(
                _type: Components.Schemas.ResponseWebSearchCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
            }
        }
        /// Emitted when a web search call is initiated.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallInProgressEvent`.
        public struct ResponseWebSearchCallInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.web_search_call.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_webSearchCall_inProgress = "response.web_search_call.in_progress"
            }
            /// The type of the event. Always `response.web_search_call.in_progress`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseWebSearchCallInProgressEvent._TypePayload
            /// The index of the output item that the web search call is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// Unique ID for the output item associated with the web search call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallInProgressEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseWebSearchCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.web_search_call.in_progress`.
            ///   - outputIndex: The index of the output item that the web search call is associated with.
            ///   - itemId: Unique ID for the output item associated with the web search call.
            public init(
                _type: Components.Schemas.ResponseWebSearchCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
            }
        }
        /// Emitted when a web search call is executing.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallSearchingEvent`.
        public struct ResponseWebSearchCallSearchingEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.web_search_call.searching`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallSearchingEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_webSearchCall_searching = "response.web_search_call.searching"
            }
            /// The type of the event. Always `response.web_search_call.searching`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallSearchingEvent/type`.
            public var _type: Components.Schemas.ResponseWebSearchCallSearchingEvent._TypePayload
            /// The index of the output item that the web search call is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallSearchingEvent/output_index`.
            public var outputIndex: Swift.Int
            /// Unique ID for the output item associated with the web search call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallSearchingEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseWebSearchCallSearchingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.web_search_call.searching`.
            ///   - outputIndex: The index of the output item that the web search call is associated with.
            ///   - itemId: Unique ID for the output item associated with the web search call.
            public init(
                _type: Components.Schemas.ResponseWebSearchCallSearchingEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
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
        /// Specifies the latency tier to use for processing the request. This parameter is relevant for customers subscribed to the scale tier service:
        ///   - If set to 'auto', and the Project is Scale tier enabled, the system
        ///     will utilize scale tier credits until they are exhausted.
        ///   - If set to 'auto', and the Project is not Scale tier enabled, the request will be processed using the default service tier with a lower uptime SLA and no latency guarentee.
        ///   - If set to 'default', the request will be processed using the default service tier with a lower uptime SLA and no latency guarentee.
        ///   - If set to 'flex', the request will be processed with the Flex Processing service tier. [Learn more](/docs/guides/flex-processing).
        ///   - When not set, the default behavior is 'auto'.
        ///
        ///   When this parameter is set, the response body will include the `service_tier` utilized.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ServiceTier`.
        @frozen public enum ServiceTier: String, Codable, Hashable, Sendable, CaseIterable {
            case auto = "auto"
            case _default = "default"
            case flex = "flex"
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
            public var name: Swift.String
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
                name: Swift.String,
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
        /// A text input to the model.
        ///
        /// - Remark: Generated from `#/components/schemas/InputTextContent`.
        public struct InputTextContent: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputTextContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputText = "input_text"
            }
            /// The type of the input item. Always `input_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputTextContent/type`.
            public var _type: Components.Schemas.InputTextContent._TypePayload
            /// The text input to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/InputTextContent/text`.
            public var text: Swift.String
            /// Creates a new `InputTextContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_text`.
            ///   - text: The text input to the model.
            public init(
                _type: Components.Schemas.InputTextContent._TypePayload,
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
        /// An image input to the model. Learn about [image inputs](/docs/guides/vision).
        ///
        /// - Remark: Generated from `#/components/schemas/InputImageContent`.
        public struct InputImageContent: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_image`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputImage = "input_image"
            }
            /// The type of the input item. Always `input_image`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContent/type`.
            public var _type: Components.Schemas.InputImageContent._TypePayload
            /// - Remark: Generated from `#/components/schemas/InputImageContent/image_url`.
            public struct ImageUrlPayload: Codable, Hashable, Sendable {
                /// The URL of the image to be sent to the model. A fully qualified URL or base64 encoded image in a data URL.
                ///
                /// - Remark: Generated from `#/components/schemas/InputImageContent/image_url/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/InputImageContent/image_url/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `ImageUrlPayload`.
                ///
                /// - Parameters:
                ///   - value1: The URL of the image to be sent to the model. A fully qualified URL or base64 encoded image in a data URL.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/InputImageContent/image_url`.
            public var imageUrl: Components.Schemas.InputImageContent.ImageUrlPayload?
            /// - Remark: Generated from `#/components/schemas/InputImageContent/file_id`.
            public struct FileIdPayload: Codable, Hashable, Sendable {
                /// The ID of the file to be sent to the model.
                ///
                /// - Remark: Generated from `#/components/schemas/InputImageContent/file_id/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/InputImageContent/file_id/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `FileIdPayload`.
                ///
                /// - Parameters:
                ///   - value1: The ID of the file to be sent to the model.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/InputImageContent/file_id`.
            public var fileId: Components.Schemas.InputImageContent.FileIdPayload?
            /// The detail level of the image to be sent to the model. One of `high`, `low`, or `auto`. Defaults to `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContent/detail`.
            @frozen public enum DetailPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case low = "low"
                case high = "high"
                case auto = "auto"
            }
            /// The detail level of the image to be sent to the model. One of `high`, `low`, or `auto`. Defaults to `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContent/detail`.
            public var detail: Components.Schemas.InputImageContent.DetailPayload
            /// Creates a new `InputImageContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_image`.
            ///   - imageUrl:
            ///   - fileId:
            ///   - detail: The detail level of the image to be sent to the model. One of `high`, `low`, or `auto`. Defaults to `auto`.
            public init(
                _type: Components.Schemas.InputImageContent._TypePayload,
                imageUrl: Components.Schemas.InputImageContent.ImageUrlPayload? = nil,
                fileId: Components.Schemas.InputImageContent.FileIdPayload? = nil,
                detail: Components.Schemas.InputImageContent.DetailPayload
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
        /// A file input to the model.
        ///
        /// - Remark: Generated from `#/components/schemas/InputFileContent`.
        public struct InputFileContent: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputFile = "input_file"
            }
            /// The type of the input item. Always `input_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/type`.
            public var _type: Components.Schemas.InputFileContent._TypePayload
            /// - Remark: Generated from `#/components/schemas/InputFileContent/file_id`.
            public struct FileIdPayload: Codable, Hashable, Sendable {
                /// The ID of the file to be sent to the model.
                ///
                /// - Remark: Generated from `#/components/schemas/InputFileContent/file_id/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/InputFileContent/file_id/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `FileIdPayload`.
                ///
                /// - Parameters:
                ///   - value1: The ID of the file to be sent to the model.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/InputFileContent/file_id`.
            public var fileId: Components.Schemas.InputFileContent.FileIdPayload?
            /// The name of the file to be sent to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/filename`.
            public var filename: Swift.String?
            /// The content of the file to be sent to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/file_data`.
            public var fileData: Swift.String?
            /// Creates a new `InputFileContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_file`.
            ///   - fileId:
            ///   - filename: The name of the file to be sent to the model.
            ///   - fileData: The content of the file to be sent to the model.
            public init(
                _type: Components.Schemas.InputFileContent._TypePayload,
                fileId: Components.Schemas.InputFileContent.FileIdPayload? = nil,
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
        /// - Remark: Generated from `#/components/schemas/RankingOptions`.
        public struct RankingOptions: Codable, Hashable, Sendable {
            /// The ranker to use for the file search.
            ///
            /// - Remark: Generated from `#/components/schemas/RankingOptions/ranker`.
            @frozen public enum RankerPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case default20241115 = "default-2024-11-15"
            }
            /// The ranker to use for the file search.
            ///
            /// - Remark: Generated from `#/components/schemas/RankingOptions/ranker`.
            public var ranker: Components.Schemas.RankingOptions.RankerPayload?
            /// The score threshold for the file search, a number between 0 and 1. Numbers closer to 1 will attempt to return only the most relevant results, but may return fewer results.
            ///
            /// - Remark: Generated from `#/components/schemas/RankingOptions/score_threshold`.
            public var scoreThreshold: Swift.Double?
            /// Creates a new `RankingOptions`.
            ///
            /// - Parameters:
            ///   - ranker: The ranker to use for the file search.
            ///   - scoreThreshold: The score threshold for the file search, a number between 0 and 1. Numbers closer to 1 will attempt to return only the most relevant results, but may return fewer results.
            public init(
                ranker: Components.Schemas.RankingOptions.RankerPayload? = nil,
                scoreThreshold: Swift.Double? = nil
            ) {
                self.ranker = ranker
                self.scoreThreshold = scoreThreshold
            }
            public enum CodingKeys: String, CodingKey {
                case ranker
                case scoreThreshold = "score_threshold"
            }
        }
        /// - Remark: Generated from `#/components/schemas/Filters`.
        public struct Filters: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Filters/value1`.
            public var value1: Components.Schemas.ComparisonFilter?
            /// - Remark: Generated from `#/components/schemas/Filters/value2`.
            public var value2: Components.Schemas.CompoundFilter?
            /// Creates a new `Filters`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.ComparisonFilter? = nil,
                value2: Components.Schemas.CompoundFilter? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
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
                try self.value1?.encode(to: encoder)
                try self.value2?.encode(to: encoder)
            }
        }
        /// A tool that searches for relevant content from uploaded files. Learn more about the [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        ///
        /// - Remark: Generated from `#/components/schemas/FileSearchTool`.
        public struct FileSearchTool: Codable, Hashable, Sendable {
            /// The type of the file search tool. Always `file_search`.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileSearch = "file_search"
            }
            /// The type of the file search tool. Always `file_search`.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/type`.
            public var _type: Components.Schemas.FileSearchTool._TypePayload
            /// The IDs of the vector stores to search.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/vector_store_ids`.
            public var vectorStoreIds: [Swift.String]
            /// The maximum number of results to return. This number should be between 1 and 50 inclusive.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/max_num_results`.
            public var maxNumResults: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options`.
            public var rankingOptions: Components.Schemas.RankingOptions?
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters`.
            public struct FiltersPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters/value1`.
                public var value1: Components.Schemas.Filters?
                /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `FiltersPayload`.
                ///
                /// - Parameters:
                ///   - value1:
                ///   - value2:
                public init(
                    value1: Components.Schemas.Filters? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
                ) {
                    self.value1 = value1
                    self.value2 = value2
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
                    try self.value1?.encode(to: encoder)
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters`.
            public var filters: Components.Schemas.FileSearchTool.FiltersPayload?
            /// Creates a new `FileSearchTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file search tool. Always `file_search`.
            ///   - vectorStoreIds: The IDs of the vector stores to search.
            ///   - maxNumResults: The maximum number of results to return. This number should be between 1 and 50 inclusive.
            ///   - rankingOptions:
            ///   - filters:
            public init(
                _type: Components.Schemas.FileSearchTool._TypePayload,
                vectorStoreIds: [Swift.String],
                maxNumResults: Swift.Int? = nil,
                rankingOptions: Components.Schemas.RankingOptions? = nil,
                filters: Components.Schemas.FileSearchTool.FiltersPayload? = nil
            ) {
                self._type = _type
                self.vectorStoreIds = vectorStoreIds
                self.maxNumResults = maxNumResults
                self.rankingOptions = rankingOptions
                self.filters = filters
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case vectorStoreIds = "vector_store_ids"
                case maxNumResults = "max_num_results"
                case rankingOptions = "ranking_options"
                case filters
            }
        }
        /// Defines a function in your own code the model can choose to call. Learn more about [function calling](https://platform.openai.com/docs/guides/function-calling).
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionTool`.
        public struct FunctionTool: Codable, Hashable, Sendable {
            /// The type of the function tool. Always `function`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case function = "function"
            }
            /// The type of the function tool. Always `function`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/type`.
            public var _type: Components.Schemas.FunctionTool._TypePayload
            /// The name of the function to call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/name`.
            public var name: Swift.String
            /// - Remark: Generated from `#/components/schemas/FunctionTool/description`.
            public struct DescriptionPayload: Codable, Hashable, Sendable {
                /// A description of the function. Used by the model to determine whether or not to call the function.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionTool/description/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/FunctionTool/description/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `DescriptionPayload`.
                ///
                /// - Parameters:
                ///   - value1: A description of the function. Used by the model to determine whether or not to call the function.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionTool/description`.
            public var description: Components.Schemas.FunctionTool.DescriptionPayload?
            /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters`.
            public struct ParametersPayload: Codable, Hashable, Sendable {
                /// A JSON schema object describing the parameters of the function.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters/value1`.
                public struct Value1Payload: Codable, Hashable, Sendable {
                    /// A container of undocumented properties.
                    public var additionalProperties: [String: OpenAPIRuntime.OpenAPIValueContainer]
                    /// Creates a new `Value1Payload`.
                    ///
                    /// - Parameters:
                    ///   - additionalProperties: A container of undocumented properties.
                    public init(additionalProperties: [String: OpenAPIRuntime.OpenAPIValueContainer] = .init()) {
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
                /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters/value1`.
                public var value1: Components.Schemas.FunctionTool.ParametersPayload.Value1Payload?
                /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `ParametersPayload`.
                ///
                /// - Parameters:
                ///   - value1: A JSON schema object describing the parameters of the function.
                ///   - value2:
                public init(
                    value1: Components.Schemas.FunctionTool.ParametersPayload.Value1Payload? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
                ) {
                    self.value1 = value1
                    self.value2 = value2
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
                    try self.value1?.encode(to: encoder)
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters`.
            public var parameters: Components.Schemas.FunctionTool.ParametersPayload
            /// - Remark: Generated from `#/components/schemas/FunctionTool/strict`.
            public struct StrictPayload: Codable, Hashable, Sendable {
                /// Whether to enforce strict parameter validation. Default `true`.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionTool/strict/value1`.
                public var value1: Swift.Bool?
                /// - Remark: Generated from `#/components/schemas/FunctionTool/strict/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `StrictPayload`.
                ///
                /// - Parameters:
                ///   - value1: Whether to enforce strict parameter validation. Default `true`.
                ///   - value2:
                public init(
                    value1: Swift.Bool? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionTool/strict`.
            public var strict: Components.Schemas.FunctionTool.StrictPayload
            /// Creates a new `FunctionTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the function tool. Always `function`.
            ///   - name: The name of the function to call.
            ///   - description:
            ///   - parameters:
            ///   - strict:
            public init(
                _type: Components.Schemas.FunctionTool._TypePayload,
                name: Swift.String,
                description: Components.Schemas.FunctionTool.DescriptionPayload? = nil,
                parameters: Components.Schemas.FunctionTool.ParametersPayload,
                strict: Components.Schemas.FunctionTool.StrictPayload
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
        /// - Remark: Generated from `#/components/schemas/ApproximateLocation`.
        public struct ApproximateLocation: Codable, Hashable, Sendable {
            /// The type of location approximation. Always `approximate`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case approximate = "approximate"
            }
            /// The type of location approximation. Always `approximate`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/type`.
            public var _type: Components.Schemas.ApproximateLocation._TypePayload
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/country`.
            public struct CountryPayload: Codable, Hashable, Sendable {
                /// The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of the user, e.g. `US`.
                ///
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/country/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/country/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `CountryPayload`.
                ///
                /// - Parameters:
                ///   - value1: The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of the user, e.g. `US`.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/country`.
            public var country: Components.Schemas.ApproximateLocation.CountryPayload?
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/region`.
            public struct RegionPayload: Codable, Hashable, Sendable {
                /// Free text input for the region of the user, e.g. `California`.
                ///
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/region/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/region/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `RegionPayload`.
                ///
                /// - Parameters:
                ///   - value1: Free text input for the region of the user, e.g. `California`.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/region`.
            public var region: Components.Schemas.ApproximateLocation.RegionPayload?
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/city`.
            public struct CityPayload: Codable, Hashable, Sendable {
                /// Free text input for the city of the user, e.g. `San Francisco`.
                ///
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/city/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/city/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `CityPayload`.
                ///
                /// - Parameters:
                ///   - value1: Free text input for the city of the user, e.g. `San Francisco`.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/city`.
            public var city: Components.Schemas.ApproximateLocation.CityPayload?
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/timezone`.
            public struct TimezonePayload: Codable, Hashable, Sendable {
                /// The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the user, e.g. `America/Los_Angeles`.
                ///
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/timezone/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ApproximateLocation/timezone/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `TimezonePayload`.
                ///
                /// - Parameters:
                ///   - value1: The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the user, e.g. `America/Los_Angeles`.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/timezone`.
            public var timezone: Components.Schemas.ApproximateLocation.TimezonePayload?
            /// Creates a new `ApproximateLocation`.
            ///
            /// - Parameters:
            ///   - _type: The type of location approximation. Always `approximate`.
            ///   - country:
            ///   - region:
            ///   - city:
            ///   - timezone:
            public init(
                _type: Components.Schemas.ApproximateLocation._TypePayload,
                country: Components.Schemas.ApproximateLocation.CountryPayload? = nil,
                region: Components.Schemas.ApproximateLocation.RegionPayload? = nil,
                city: Components.Schemas.ApproximateLocation.CityPayload? = nil,
                timezone: Components.Schemas.ApproximateLocation.TimezonePayload? = nil
            ) {
                self._type = _type
                self.country = country
                self.region = region
                self.city = city
                self.timezone = timezone
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case country
                case region
                case city
                case timezone
            }
        }
        /// This tool searches the web for relevant results to use in a response. Learn more about the [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool`.
        public struct WebSearchPreviewTool: Codable, Hashable, Sendable {
            /// The type of the web search tool. One of `web_search_preview` or `web_search_preview_2025_03_11`.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case webSearchPreview = "web_search_preview"
                case webSearchPreview20250311 = "web_search_preview_2025_03_11"
            }
            /// The type of the web search tool. One of `web_search_preview` or `web_search_preview_2025_03_11`.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/type`.
            public var _type: Components.Schemas.WebSearchPreviewTool._TypePayload
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/user_location`.
            public struct UserLocationPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/user_location/value1`.
                public var value1: Components.Schemas.ApproximateLocation?
                /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/user_location/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `UserLocationPayload`.
                ///
                /// - Parameters:
                ///   - value1:
                ///   - value2:
                public init(
                    value1: Components.Schemas.ApproximateLocation? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
                ) {
                    self.value1 = value1
                    self.value2 = value2
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
                    try self.value1?.encode(to: encoder)
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/user_location`.
            public var userLocation: Components.Schemas.WebSearchPreviewTool.UserLocationPayload?
            /// High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/search_context_size`.
            @frozen public enum SearchContextSizePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case low = "low"
                case medium = "medium"
                case high = "high"
            }
            /// High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/search_context_size`.
            public var searchContextSize: Components.Schemas.WebSearchPreviewTool.SearchContextSizePayload?
            /// Creates a new `WebSearchPreviewTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the web search tool. One of `web_search_preview` or `web_search_preview_2025_03_11`.
            ///   - userLocation:
            ///   - searchContextSize: High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            public init(
                _type: Components.Schemas.WebSearchPreviewTool._TypePayload,
                userLocation: Components.Schemas.WebSearchPreviewTool.UserLocationPayload? = nil,
                searchContextSize: Components.Schemas.WebSearchPreviewTool.SearchContextSizePayload? = nil
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
        /// A tool that controls a virtual computer. Learn more about the [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool`.
        public struct ComputerUsePreviewTool: Codable, Hashable, Sendable {
            /// The type of the computer use tool. Always `computer_use_preview`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computerUsePreview = "computer_use_preview"
            }
            /// The type of the computer use tool. Always `computer_use_preview`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool/type`.
            public var _type: Components.Schemas.ComputerUsePreviewTool._TypePayload
            /// The type of computer environment to control.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool/environment`.
            @frozen public enum EnvironmentPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case windows = "windows"
                case mac = "mac"
                case linux = "linux"
                case ubuntu = "ubuntu"
                case browser = "browser"
            }
            /// The type of computer environment to control.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool/environment`.
            public var environment: Components.Schemas.ComputerUsePreviewTool.EnvironmentPayload
            /// The width of the computer display.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool/display_width`.
            public var displayWidth: Swift.Int
            /// The height of the computer display.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerUsePreviewTool/display_height`.
            public var displayHeight: Swift.Int
            /// Creates a new `ComputerUsePreviewTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the computer use tool. Always `computer_use_preview`.
            ///   - environment: The type of computer environment to control.
            ///   - displayWidth: The width of the computer display.
            ///   - displayHeight: The height of the computer display.
            public init(
                _type: Components.Schemas.ComputerUsePreviewTool._TypePayload,
                environment: Components.Schemas.ComputerUsePreviewTool.EnvironmentPayload,
                displayWidth: Swift.Int,
                displayHeight: Swift.Int
            ) {
                self._type = _type
                self.environment = environment
                self.displayWidth = displayWidth
                self.displayHeight = displayHeight
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case environment
                case displayWidth = "display_width"
                case displayHeight = "display_height"
            }
        }
        /// - Remark: Generated from `#/components/schemas/Tool`.
        @frozen public enum Tool: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Tool/FileSearchTool`.
            case fileSearchTool(Components.Schemas.FileSearchTool)
            /// - Remark: Generated from `#/components/schemas/Tool/FunctionTool`.
            case functionTool(Components.Schemas.FunctionTool)
            /// - Remark: Generated from `#/components/schemas/Tool/WebSearchPreviewTool`.
            case webSearchPreviewTool(Components.Schemas.WebSearchPreviewTool)
            /// - Remark: Generated from `#/components/schemas/Tool/ComputerUsePreviewTool`.
            case computerUsePreviewTool(Components.Schemas.ComputerUsePreviewTool)
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
                case "FileSearchTool", "#/components/schemas/FileSearchTool":
                    self = .fileSearchTool(try .init(from: decoder))
                case "FunctionTool", "#/components/schemas/FunctionTool":
                    self = .functionTool(try .init(from: decoder))
                case "WebSearchPreviewTool", "#/components/schemas/WebSearchPreviewTool":
                    self = .webSearchPreviewTool(try .init(from: decoder))
                case "ComputerUsePreviewTool", "#/components/schemas/ComputerUsePreviewTool":
                    self = .computerUsePreviewTool(try .init(from: decoder))
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
                case let .fileSearchTool(value):
                    try value.encode(to: encoder)
                case let .functionTool(value):
                    try value.encode(to: encoder)
                case let .webSearchPreviewTool(value):
                    try value.encode(to: encoder)
                case let .computerUsePreviewTool(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A citation to a file.
        ///
        /// - Remark: Generated from `#/components/schemas/FileCitationBody`.
        public struct FileCitationBody: Codable, Hashable, Sendable {
            /// The type of the file citation. Always `file_citation`.
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitationBody/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileCitation = "file_citation"
            }
            /// The type of the file citation. Always `file_citation`.
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitationBody/type`.
            public var _type: Components.Schemas.FileCitationBody._TypePayload
            /// The ID of the file.
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitationBody/file_id`.
            public var fileId: Swift.String
            /// The index of the file in the list of files.
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitationBody/index`.
            public var index: Swift.Int
            /// Creates a new `FileCitationBody`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file citation. Always `file_citation`.
            ///   - fileId: The ID of the file.
            ///   - index: The index of the file in the list of files.
            public init(
                _type: Components.Schemas.FileCitationBody._TypePayload,
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
        /// A citation for a web resource used to generate a model response.
        ///
        /// - Remark: Generated from `#/components/schemas/UrlCitationBody`.
        public struct UrlCitationBody: Codable, Hashable, Sendable {
            /// The type of the URL citation. Always `url_citation`.
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitationBody/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case urlCitation = "url_citation"
            }
            /// The type of the URL citation. Always `url_citation`.
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitationBody/type`.
            public var _type: Components.Schemas.UrlCitationBody._TypePayload
            /// The URL of the web resource.
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitationBody/url`.
            public var url: Swift.String
            /// The index of the first character of the URL citation in the message.
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitationBody/start_index`.
            public var startIndex: Swift.Int
            /// The index of the last character of the URL citation in the message.
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitationBody/end_index`.
            public var endIndex: Swift.Int
            /// The title of the web resource.
            ///
            /// - Remark: Generated from `#/components/schemas/UrlCitationBody/title`.
            public var title: Swift.String
            /// Creates a new `UrlCitationBody`.
            ///
            /// - Parameters:
            ///   - _type: The type of the URL citation. Always `url_citation`.
            ///   - url: The URL of the web resource.
            ///   - startIndex: The index of the first character of the URL citation in the message.
            ///   - endIndex: The index of the last character of the URL citation in the message.
            ///   - title: The title of the web resource.
            public init(
                _type: Components.Schemas.UrlCitationBody._TypePayload,
                url: Swift.String,
                startIndex: Swift.Int,
                endIndex: Swift.Int,
                title: Swift.String
            ) {
                self._type = _type
                self.url = url
                self.startIndex = startIndex
                self.endIndex = endIndex
                self.title = title
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case url
                case startIndex = "start_index"
                case endIndex = "end_index"
                case title
            }
        }
        /// - Remark: Generated from `#/components/schemas/Annotation`.
        @frozen public enum Annotation: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Annotation/FileCitationBody`.
            case fileCitationBody(Components.Schemas.FileCitationBody)
            /// - Remark: Generated from `#/components/schemas/Annotation/UrlCitationBody`.
            case urlCitationBody(Components.Schemas.UrlCitationBody)
            /// - Remark: Generated from `#/components/schemas/Annotation/FilePath`.
            case filePath(Components.Schemas.FilePath)
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
                case "FileCitationBody", "#/components/schemas/FileCitationBody":
                    self = .fileCitationBody(try .init(from: decoder))
                case "UrlCitationBody", "#/components/schemas/UrlCitationBody":
                    self = .urlCitationBody(try .init(from: decoder))
                case "FilePath", "#/components/schemas/FilePath":
                    self = .filePath(try .init(from: decoder))
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
                case let .fileCitationBody(value):
                    try value.encode(to: encoder)
                case let .urlCitationBody(value):
                    try value.encode(to: encoder)
                case let .filePath(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A text output from the model.
        ///
        /// - Remark: Generated from `#/components/schemas/OutputTextContent`.
        public struct OutputTextContent: Codable, Hashable, Sendable {
            /// The type of the output text. Always `output_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/OutputTextContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case outputText = "output_text"
            }
            /// The type of the output text. Always `output_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/OutputTextContent/type`.
            public var _type: Components.Schemas.OutputTextContent._TypePayload
            /// The text output from the model.
            ///
            /// - Remark: Generated from `#/components/schemas/OutputTextContent/text`.
            public var text: Swift.String
            /// The annotations of the text output.
            ///
            /// - Remark: Generated from `#/components/schemas/OutputTextContent/annotations`.
            public var annotations: [Components.Schemas.Annotation]
            /// Creates a new `OutputTextContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the output text. Always `output_text`.
            ///   - text: The text output from the model.
            ///   - annotations: The annotations of the text output.
            public init(
                _type: Components.Schemas.OutputTextContent._TypePayload,
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
        /// A refusal from the model.
        ///
        /// - Remark: Generated from `#/components/schemas/RefusalContent`.
        public struct RefusalContent: Codable, Hashable, Sendable {
            /// The type of the refusal. Always `refusal`.
            ///
            /// - Remark: Generated from `#/components/schemas/RefusalContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case refusal = "refusal"
            }
            /// The type of the refusal. Always `refusal`.
            ///
            /// - Remark: Generated from `#/components/schemas/RefusalContent/type`.
            public var _type: Components.Schemas.RefusalContent._TypePayload
            /// The refusal explanationfrom the model.
            ///
            /// - Remark: Generated from `#/components/schemas/RefusalContent/refusal`.
            public var refusal: Swift.String
            /// Creates a new `RefusalContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the refusal. Always `refusal`.
            ///   - refusal: The refusal explanationfrom the model.
            public init(
                _type: Components.Schemas.RefusalContent._TypePayload,
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
        /// A pending safety check for the computer call.
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam`.
        public struct ComputerCallSafetyCheckParam: Codable, Hashable, Sendable {
            /// The ID of the pending safety check.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/id`.
            public var id: Swift.String
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/code`.
            public struct CodePayload: Codable, Hashable, Sendable {
                /// The type of the pending safety check.
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/code/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/code/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `CodePayload`.
                ///
                /// - Parameters:
                ///   - value1: The type of the pending safety check.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/code`.
            public var code: Components.Schemas.ComputerCallSafetyCheckParam.CodePayload?
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/message`.
            public struct MessagePayload: Codable, Hashable, Sendable {
                /// Details about the pending safety check.
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/message/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/message/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `MessagePayload`.
                ///
                /// - Parameters:
                ///   - value1: Details about the pending safety check.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/message`.
            public var message: Components.Schemas.ComputerCallSafetyCheckParam.MessagePayload?
            /// Creates a new `ComputerCallSafetyCheckParam`.
            ///
            /// - Parameters:
            ///   - id: The ID of the pending safety check.
            ///   - code:
            ///   - message:
            public init(
                id: Swift.String,
                code: Components.Schemas.ComputerCallSafetyCheckParam.CodePayload? = nil,
                message: Components.Schemas.ComputerCallSafetyCheckParam.MessagePayload? = nil
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
        /// The output of a computer tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam`.
        public struct ComputerCallOutputItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/id`.
            public struct IdPayload: Codable, Hashable, Sendable {
                /// The ID of the computer tool call output.
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/id/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/id/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `IdPayload`.
                ///
                /// - Parameters:
                ///   - value1: The ID of the computer tool call output.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/id`.
            public var id: Components.Schemas.ComputerCallOutputItemParam.IdPayload?
            /// The ID of the computer tool call that produced the output.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/call_id`.
            public var callId: Swift.String
            /// The type of the computer tool call output. Always `computer_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computerCallOutput = "computer_call_output"
            }
            /// The type of the computer tool call output. Always `computer_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/type`.
            public var _type: Components.Schemas.ComputerCallOutputItemParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/output`.
            public var output: Components.Schemas.ComputerScreenshotImage
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/acknowledged_safety_checks`.
            public struct AcknowledgedSafetyChecksPayload: Codable, Hashable, Sendable {
                /// The safety checks reported by the API that have been acknowledged by the developer.
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/acknowledged_safety_checks/value1`.
                public var value1: [Components.Schemas.ComputerCallSafetyCheckParam]?
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/acknowledged_safety_checks/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `AcknowledgedSafetyChecksPayload`.
                ///
                /// - Parameters:
                ///   - value1: The safety checks reported by the API that have been acknowledged by the developer.
                ///   - value2:
                public init(
                    value1: [Components.Schemas.ComputerCallSafetyCheckParam]? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/acknowledged_safety_checks`.
            public var acknowledgedSafetyChecks: Components.Schemas.ComputerCallOutputItemParam.AcknowledgedSafetyChecksPayload?
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/status`.
            public struct StatusPayload: Codable, Hashable, Sendable {
                /// The status of the message input. One of `in_progress`, `completed`, or `incomplete`. Populated when input items are returned via API.
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/status/value1`.
                @frozen public enum Value1Payload: String, Codable, Hashable, Sendable, CaseIterable {
                    case inProgress = "in_progress"
                    case completed = "completed"
                    case incomplete = "incomplete"
                }
                /// The status of the message input. One of `in_progress`, `completed`, or `incomplete`. Populated when input items are returned via API.
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/status/value1`.
                public var value1: Components.Schemas.ComputerCallOutputItemParam.StatusPayload.Value1Payload?
                /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/status/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `StatusPayload`.
                ///
                /// - Parameters:
                ///   - value1: The status of the message input. One of `in_progress`, `completed`, or `incomplete`. Populated when input items are returned via API.
                ///   - value2:
                public init(
                    value1: Components.Schemas.ComputerCallOutputItemParam.StatusPayload.Value1Payload? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/status`.
            public var status: Components.Schemas.ComputerCallOutputItemParam.StatusPayload?
            /// Creates a new `ComputerCallOutputItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId: The ID of the computer tool call that produced the output.
            ///   - _type: The type of the computer tool call output. Always `computer_call_output`.
            ///   - output:
            ///   - acknowledgedSafetyChecks:
            ///   - status:
            public init(
                id: Components.Schemas.ComputerCallOutputItemParam.IdPayload? = nil,
                callId: Swift.String,
                _type: Components.Schemas.ComputerCallOutputItemParam._TypePayload,
                output: Components.Schemas.ComputerScreenshotImage,
                acknowledgedSafetyChecks: Components.Schemas.ComputerCallOutputItemParam.AcknowledgedSafetyChecksPayload? = nil,
                status: Components.Schemas.ComputerCallOutputItemParam.StatusPayload? = nil
            ) {
                self.id = id
                self.callId = callId
                self._type = _type
                self.output = output
                self.acknowledgedSafetyChecks = acknowledgedSafetyChecks
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case callId = "call_id"
                case _type = "type"
                case output
                case acknowledgedSafetyChecks = "acknowledged_safety_checks"
                case status
            }
        }
        /// The output of a function tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam`.
        public struct FunctionCallOutputItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/id`.
            public struct IdPayload: Codable, Hashable, Sendable {
                /// The unique ID of the function tool call output. Populated when this item is returned via API.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/id/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/id/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `IdPayload`.
                ///
                /// - Parameters:
                ///   - value1: The unique ID of the function tool call output. Populated when this item is returned via API.
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/id`.
            public var id: Components.Schemas.FunctionCallOutputItemParam.IdPayload?
            /// The unique ID of the function tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/call_id`.
            public var callId: Swift.String
            /// The type of the function tool call output. Always `function_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case functionCallOutput = "function_call_output"
            }
            /// The type of the function tool call output. Always `function_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/type`.
            public var _type: Components.Schemas.FunctionCallOutputItemParam._TypePayload
            /// A JSON string of the output of the function tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output`.
            public var output: Swift.String
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/status`.
            public struct StatusPayload: Codable, Hashable, Sendable {
                /// The status of the item. One of `in_progress`, `completed`, or `incomplete`. Populated when items are returned via API.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/status/value1`.
                @frozen public enum Value1Payload: String, Codable, Hashable, Sendable, CaseIterable {
                    case inProgress = "in_progress"
                    case completed = "completed"
                    case incomplete = "incomplete"
                }
                /// The status of the item. One of `in_progress`, `completed`, or `incomplete`. Populated when items are returned via API.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/status/value1`.
                public var value1: Components.Schemas.FunctionCallOutputItemParam.StatusPayload.Value1Payload?
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/status/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `StatusPayload`.
                ///
                /// - Parameters:
                ///   - value1: The status of the item. One of `in_progress`, `completed`, or `incomplete`. Populated when items are returned via API.
                ///   - value2:
                public init(
                    value1: Components.Schemas.FunctionCallOutputItemParam.StatusPayload.Value1Payload? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/status`.
            public var status: Components.Schemas.FunctionCallOutputItemParam.StatusPayload?
            /// Creates a new `FunctionCallOutputItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId: The unique ID of the function tool call generated by the model.
            ///   - _type: The type of the function tool call output. Always `function_call_output`.
            ///   - output: A JSON string of the output of the function tool call.
            ///   - status:
            public init(
                id: Components.Schemas.FunctionCallOutputItemParam.IdPayload? = nil,
                callId: Swift.String,
                _type: Components.Schemas.FunctionCallOutputItemParam._TypePayload,
                output: Swift.String,
                status: Components.Schemas.FunctionCallOutputItemParam.StatusPayload? = nil
            ) {
                self.id = id
                self.callId = callId
                self._type = _type
                self.output = output
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case callId = "call_id"
                case _type = "type"
                case output
                case status
            }
        }
        /// An internal identifier for an item to reference.
        ///
        /// - Remark: Generated from `#/components/schemas/ItemReferenceParam`.
        public struct ItemReferenceParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/type`.
            public struct _TypePayload: Codable, Hashable, Sendable {
                /// The type of item to reference. Always `item_reference`.
                ///
                /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/type/value1`.
                @frozen public enum Value1Payload: String, Codable, Hashable, Sendable, CaseIterable {
                    case itemReference = "item_reference"
                }
                /// The type of item to reference. Always `item_reference`.
                ///
                /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/type/value1`.
                public var value1: Components.Schemas.ItemReferenceParam._TypePayload.Value1Payload?
                /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/type/value2`.
                public var value2: OpenAPIRuntime.OpenAPIValueContainer?
                /// Creates a new `_TypePayload`.
                ///
                /// - Parameters:
                ///   - value1: The type of item to reference. Always `item_reference`.
                ///   - value2:
                public init(
                    value1: Components.Schemas.ItemReferenceParam._TypePayload.Value1Payload? = nil,
                    value2: OpenAPIRuntime.OpenAPIValueContainer? = nil
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
                        self.value2 = try .init(from: decoder)
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
                        self.value1
                    ])
                    try self.value2?.encode(to: encoder)
                }
            }
            /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/type`.
            public var _type: Components.Schemas.ItemReferenceParam._TypePayload?
            /// The ID of the item to reference.
            ///
            /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/id`.
            public var id: Swift.String
            /// Creates a new `ItemReferenceParam`.
            ///
            /// - Parameters:
            ///   - _type:
            ///   - id: The ID of the item to reference.
            public init(
                _type: Components.Schemas.ItemReferenceParam._TypePayload? = nil,
                id: Swift.String
            ) {
                self._type = _type
                self.id = id
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
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
