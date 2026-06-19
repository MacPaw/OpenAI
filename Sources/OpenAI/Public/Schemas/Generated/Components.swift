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

public enum Components {
    /// Types generated from the `#/components/schemas` section of the OpenAPI document.
    public enum Schemas {
        /// The format of the output, in one of these options: `json`, `text`, `srt`, `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`, the only supported format is `json`. For `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and `diarized_json`, with `diarized_json` required to receive speaker annotations.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/AudioResponseFormat`.
        @frozen public enum AudioResponseFormat: String, Codable, Hashable, Sendable, CaseIterable {
            case json = "json"
            case text = "text"
            case srt = "srt"
            case verboseJson = "verbose_json"
            case vtt = "vtt"
            case diarizedJson = "diarized_json"
        }
        /// A tool that runs Python code to help generate a response to a prompt.
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
            /// The code interpreter container. Can be a container ID or an object that
            /// specifies uploaded file IDs to make available to your code, along with an
            /// optional `memory_limit` setting.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/container`.
            @frozen public enum ContainerPayload: Codable, Hashable, Sendable {
                /// The container ID.
                ///
                /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/container/case1`.
                case case1(Swift.String)
                /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/container/case2`.
                case AutoCodeInterpreterToolParam(Components.Schemas.AutoCodeInterpreterToolParam)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .AutoCodeInterpreterToolParam(try .init(from: decoder))
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .AutoCodeInterpreterToolParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// The code interpreter container. Can be a container ID or an object that
            /// specifies uploaded file IDs to make available to your code, along with an
            /// optional `memory_limit` setting.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterTool/container`.
            public var container: Components.Schemas.CodeInterpreterTool.ContainerPayload
            /// Creates a new `CodeInterpreterTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the code interpreter tool. Always `code_interpreter`.
            ///   - container: The code interpreter container. Can be a container ID or an object that
            public init(
                _type: Components.Schemas.CodeInterpreterTool._TypePayload,
                container: Components.Schemas.CodeInterpreterTool.ContainerPayload
            ) {
                self._type = _type
                self.container = container
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case container
            }
        }
        /// A tool call to run code.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall`.
        public struct CodeInterpreterToolCall: Codable, Hashable, Sendable {
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
            /// The unique ID of the code interpreter tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/id`.
            public var id: Swift.String
            /// The status of the code interpreter tool call. Valid values are `in_progress`, `completed`, `incomplete`, `interpreting`, and `failed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
                case interpreting = "interpreting"
                case failed = "failed"
            }
            /// The status of the code interpreter tool call. Valid values are `in_progress`, `completed`, `incomplete`, `interpreting`, and `failed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/status`.
            public var status: Components.Schemas.CodeInterpreterToolCall.StatusPayload
            /// The ID of the container used to run the code.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/container_id`.
            public var containerId: Swift.String
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/code`.
            public var code: Swift.String?
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/OutputsPayload`.
            @frozen public enum OutputsPayloadPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/OutputsPayload/CodeInterpreterOutputLogs`.
                case codeInterpreterOutputLogs(Components.Schemas.CodeInterpreterOutputLogs)
                /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/OutputsPayload/CodeInterpreterOutputImage`.
                case codeInterpreterOutputImage(Components.Schemas.CodeInterpreterOutputImage)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "CodeInterpreterOutputLogs", "#/components/schemas/CodeInterpreterOutputLogs", "logs":
                        self = .codeInterpreterOutputLogs(try .init(from: decoder))
                    case "CodeInterpreterOutputImage", "#/components/schemas/CodeInterpreterOutputImage", "image":
                        self = .codeInterpreterOutputImage(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .codeInterpreterOutputLogs(value):
                        try value.encode(to: encoder)
                    case let .codeInterpreterOutputImage(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// The outputs generated by the code interpreter, such as logs or images.
            /// Can be null if no outputs are available.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/outputs`.
            public typealias OutputsPayload = [Components.Schemas.CodeInterpreterToolCall.OutputsPayloadPayload]
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterToolCall/outputs`.
            public var outputs: Components.Schemas.CodeInterpreterToolCall.OutputsPayload?
            /// Creates a new `CodeInterpreterToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the code interpreter tool call. Always `code_interpreter_call`.
            ///   - id: The unique ID of the code interpreter tool call.
            ///   - status: The status of the code interpreter tool call. Valid values are `in_progress`, `completed`, `incomplete`, `interpreting`, and `failed`.
            ///   - containerId: The ID of the container used to run the code.
            ///   - code:
            ///   - outputs:
            public init(
                _type: Components.Schemas.CodeInterpreterToolCall._TypePayload,
                id: Swift.String,
                status: Components.Schemas.CodeInterpreterToolCall.StatusPayload,
                containerId: Swift.String,
                code: Swift.String? = nil,
                outputs: Components.Schemas.CodeInterpreterToolCall.OutputsPayload? = nil
            ) {
                self._type = _type
                self.id = id
                self.status = status
                self.containerId = containerId
                self.code = code
                self.outputs = outputs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case status
                case containerId = "container_id"
                case code
                case outputs
            }
        }
        /// A filter used to compare a specified attribute key to a given value using a defined comparison operation.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComparisonFilter`.
        public struct ComparisonFilter: Codable, Hashable, Sendable {
            /// Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `nin`.
            /// - `eq`: equals
            /// - `ne`: not equal
            /// - `gt`: greater than
            /// - `gte`: greater than or equal
            /// - `lt`: less than
            /// - `lte`: less than or equal
            /// - `in`: in
            /// - `nin`: not in
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
                case _in = "in"
                case nin = "nin"
            }
            /// Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `nin`.
            /// - `eq`: equals
            /// - `ne`: not equal
            /// - `gt`: greater than
            /// - `gte`: greater than or equal
            /// - `lt`: less than
            /// - `lte`: less than or equal
            /// - `in`: in
            /// - `nin`: not in
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
                /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/Case4Payload`.
                @frozen public enum Case4PayloadPayload: Codable, Hashable, Sendable {
                    /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/Case4Payload/case1`.
                    case case1(Swift.String)
                    /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/Case4Payload/case2`.
                    case case2(Swift.Double)
                    public init(from decoder: any Swift.Decoder) throws {
                        var errors: [any Swift.Error] = []
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
                    public func encode(to encoder: any Swift.Encoder) throws {
                        switch self {
                        case let .case1(value):
                            try encoder.encodeToSingleValueContainer(value)
                        case let .case2(value):
                            try encoder.encodeToSingleValueContainer(value)
                        }
                    }
                }
                /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/case4`.
                public typealias Case4Payload = [Components.Schemas.ComparisonFilter.ValuePayload.Case4PayloadPayload]
                /// - Remark: Generated from `#/components/schemas/ComparisonFilter/value/case4`.
                case case4(Components.Schemas.ComparisonFilter.ValuePayload.Case4Payload)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                    do {
                        self = .case4(try decoder.decodeFromSingleValueContainer())
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case3(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case4(value):
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
            ///   - _type: Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `nin`.
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
            public init(from decoder: any Swift.Decoder) throws {
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
            public var _type: Components.Schemas.CompoundFilter._TypePayload {
                get  {
                    self.storage.value._type
                }
                _modify {
                    yield &self.storage.value._type
                }
            }
            /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload`.
            @frozen public enum FiltersPayloadPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/ComparisonFilter`.
                case comparisonFilter(Components.Schemas.ComparisonFilter)
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/CompoundFilter`.
                case compoundFilter(Components.Schemas.CompoundFilter)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "ComparisonFilter", "#/components/schemas/ComparisonFilter", "eq", "ne", "gt", "gte", "lt", "lte", "in", "nin":
                        self = .comparisonFilter(try .init(from: decoder))
                    case "CompoundFilter", "#/components/schemas/CompoundFilter", "and", "or":
                        self = .compoundFilter(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .comparisonFilter(value):
                        try value.encode(to: encoder)
                    case let .compoundFilter(value):
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
            public var filters: Components.Schemas.CompoundFilter.FiltersPayload {
                get  {
                    self.storage.value.filters
                }
                _modify {
                    yield &self.storage.value.filters
                }
            }
            /// Creates a new `CompoundFilter`.
            ///
            /// - Parameters:
            ///   - _type: Type of operation: `and` or `or`.
            ///   - filters: Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
            public init(
                _type: Components.Schemas.CompoundFilter._TypePayload,
                filters: Components.Schemas.CompoundFilter.FiltersPayload
            ) {
                self.storage = .init(value: .init(
                    _type: _type,
                    filters: filters
                ))
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case filters
            }
            public init(from decoder: any Swift.Decoder) throws {
                self.storage = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.storage.encode(to: encoder)
            }
            /// Internal reference storage to allow type recursion.
            private var storage: OpenAPIRuntime.CopyOnWriteBox<Storage>
            private struct Storage: Codable, Hashable, Sendable {
                /// Type of operation: `and` or `or`.
                ///
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/type`.
                enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case and = "and"
                    case or = "or"
                }
                /// Type of operation: `and` or `or`.
                ///
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/type`.
                var _type: Components.Schemas.CompoundFilter._TypePayload
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload`.
                enum FiltersPayloadPayload: Codable, Hashable, Sendable {
                    /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/ComparisonFilter`.
                    case comparisonFilter(Components.Schemas.ComparisonFilter)
                    /// - Remark: Generated from `#/components/schemas/CompoundFilter/FiltersPayload/CompoundFilter`.
                    case compoundFilter(Components.Schemas.CompoundFilter)
                    public enum CodingKeys: String, CodingKey {
                        case _type = "type"
                    }
                    public init(from decoder: any Swift.Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        let discriminator = try container.decode(
                            Swift.String.self,
                            forKey: ._type
                        )
                        switch discriminator {
                        case "ComparisonFilter", "#/components/schemas/ComparisonFilter", "eq", "ne", "gt", "gte", "lt", "lte", "in", "nin":
                            self = .comparisonFilter(try .init(from: decoder))
                        case "CompoundFilter", "#/components/schemas/CompoundFilter", "and", "or":
                            self = .compoundFilter(try .init(from: decoder))
                        default:
                            throw Swift.DecodingError.unknownOneOfDiscriminator(
                                discriminatorKey: CodingKeys._type,
                                discriminatorValue: discriminator,
                                codingPath: decoder.codingPath
                            )
                        }
                    }
                    public func encode(to encoder: any Swift.Encoder) throws {
                        switch self {
                        case let .comparisonFilter(value):
                            try value.encode(to: encoder)
                        case let .compoundFilter(value):
                            try value.encode(to: encoder)
                        }
                    }
                }
                /// Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
                ///
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/filters`.
                typealias FiltersPayload = [Components.Schemas.CompoundFilter.FiltersPayloadPayload]
                /// Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`.
                ///
                /// - Remark: Generated from `#/components/schemas/CompoundFilter/filters`.
                var filters: Components.Schemas.CompoundFilter.FiltersPayload
                init(
                    _type: Components.Schemas.CompoundFilter._TypePayload,
                    filters: Components.Schemas.CompoundFilter.FiltersPayload
                ) {
                    self._type = _type
                    self.filters = filters
                }
                typealias CodingKeys = Components.Schemas.CompoundFilter.CodingKeys
                init(from decoder: any Swift.Decoder) throws {
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
        }
        /// - Remark: Generated from `#/components/schemas/ComputerAction`.
        @frozen public enum ComputerAction: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ComputerAction/ClickParam`.
            case clickParam(Components.Schemas.ClickParam)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/DoubleClickAction`.
            case doubleClickAction(Components.Schemas.DoubleClickAction)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/DragParam`.
            case dragParam(Components.Schemas.DragParam)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/KeyPressAction`.
            case keyPressAction(Components.Schemas.KeyPressAction)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/MoveParam`.
            case moveParam(Components.Schemas.MoveParam)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/ScreenshotParam`.
            case screenshotParam(Components.Schemas.ScreenshotParam)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/ScrollParam`.
            case scrollParam(Components.Schemas.ScrollParam)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/TypeParam`.
            case typeParam(Components.Schemas.TypeParam)
            /// - Remark: Generated from `#/components/schemas/ComputerAction/WaitParam`.
            case waitParam(Components.Schemas.WaitParam)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "ClickParam", "#/components/schemas/ClickParam", "click":
                    self = .clickParam(try .init(from: decoder))
                case "DoubleClickAction", "#/components/schemas/DoubleClickAction", "double_click":
                    self = .doubleClickAction(try .init(from: decoder))
                case "DragParam", "#/components/schemas/DragParam", "drag":
                    self = .dragParam(try .init(from: decoder))
                case "KeyPressAction", "#/components/schemas/KeyPressAction", "keypress":
                    self = .keyPressAction(try .init(from: decoder))
                case "MoveParam", "#/components/schemas/MoveParam", "move":
                    self = .moveParam(try .init(from: decoder))
                case "ScreenshotParam", "#/components/schemas/ScreenshotParam", "screenshot":
                    self = .screenshotParam(try .init(from: decoder))
                case "ScrollParam", "#/components/schemas/ScrollParam", "scroll":
                    self = .scrollParam(try .init(from: decoder))
                case "TypeParam", "#/components/schemas/TypeParam", "type":
                    self = .typeParam(try .init(from: decoder))
                case "WaitParam", "#/components/schemas/WaitParam", "wait":
                    self = .waitParam(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .clickParam(value):
                    try value.encode(to: encoder)
                case let .doubleClickAction(value):
                    try value.encode(to: encoder)
                case let .dragParam(value):
                    try value.encode(to: encoder)
                case let .keyPressAction(value):
                    try value.encode(to: encoder)
                case let .moveParam(value):
                    try value.encode(to: encoder)
                case let .screenshotParam(value):
                    try value.encode(to: encoder)
                case let .scrollParam(value):
                    try value.encode(to: encoder)
                case let .typeParam(value):
                    try value.encode(to: encoder)
                case let .waitParam(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// Flattened batched actions for `computer_use`. Each action includes an
        /// `type` discriminator and action-specific fields.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerActionList`.
        public typealias ComputerActionList = [Components.Schemas.ComputerAction]
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
            public var action: Components.Schemas.ComputerAction?
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/actions`.
            public var actions: Components.Schemas.ComputerActionList?
            /// The pending safety checks for the computer call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerToolCall/pending_safety_checks`.
            public var pendingSafetyChecks: [Components.Schemas.ComputerCallSafetyCheckParam]
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
            ///   - actions:
            ///   - pendingSafetyChecks: The pending safety checks for the computer call.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                _type: Components.Schemas.ComputerToolCall._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                action: Components.Schemas.ComputerAction? = nil,
                actions: Components.Schemas.ComputerActionList? = nil,
                pendingSafetyChecks: [Components.Schemas.ComputerCallSafetyCheckParam],
                status: Components.Schemas.ComputerToolCall.StatusPayload
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.action = action
                self.actions = actions
                self.pendingSafetyChecks = pendingSafetyChecks
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case action
                case actions
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
            public var acknowledgedSafetyChecks: [Components.Schemas.ComputerCallSafetyCheckParam]?
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
                acknowledgedSafetyChecks: [Components.Schemas.ComputerCallSafetyCheckParam]? = nil,
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
                /// The status of the message input. One of `in_progress`, `completed`, or
                /// `incomplete`. Populated when input items are returned via API.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource/value2/status`.
                public var status: Components.Schemas.ComputerCallOutputStatus
                /// The identifier of the actor that created the item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ComputerToolCallOutputResource/value2/created_by`.
                public var createdBy: Swift.String?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the computer call tool output.
                ///   - status: The status of the message input. One of `in_progress`, `completed`, or
                ///   - createdBy: The identifier of the actor that created the item.
                public init(
                    id: Swift.String,
                    status: Components.Schemas.ComputerCallOutputStatus,
                    createdBy: Swift.String? = nil
                ) {
                    self.id = id
                    self.status = status
                    self.createdBy = createdBy
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case status
                    case createdBy = "created_by"
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
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// The conversation that this response belongs to. Items from this conversation are prepended to `input_items` for this response request.
        /// Input items and output items from this response are automatically added to this conversation after this response completes.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ConversationParam`.
        @frozen public enum ConversationParam: Codable, Hashable, Sendable {
            /// The unique ID of the conversation.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ConversationParam/case1`.
            case case1(Swift.String)
            /// - Remark: Generated from `#/components/schemas/ConversationParam/case2`.
            case ConversationParam2(Components.Schemas.ConversationParam2)
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
                do {
                    self = .case1(try decoder.decodeFromSingleValueContainer())
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .ConversationParam2(try .init(from: decoder))
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
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .case1(value):
                    try encoder.encodeToSingleValueContainer(value)
                case let .ConversationParam2(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties`.
        public struct CreateModelResponseProperties: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties/value1`.
            public var value1: Components.Schemas.ModelResponseProperties
            /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// An integer between 0 and 20 specifying the maximum number of most likely
                /// tokens to return at each token position, each with an associated log
                /// probability. In some cases, the number of returned tokens may be fewer than
                /// requested.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties/value2/top_logprobs`.
                public var topLogprobs: Swift.Int?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - topLogprobs: An integer between 0 and 20 specifying the maximum number of most likely
                public init(topLogprobs: Swift.Int? = nil) {
                    self.topLogprobs = topLogprobs
                }
                public enum CodingKeys: String, CodingKey {
                    case topLogprobs = "top_logprobs"
                }
            }
            /// - Remark: Generated from `#/components/schemas/CreateModelResponseProperties/value2`.
            public var value2: Components.Schemas.CreateModelResponseProperties.Value2Payload
            /// Creates a new `CreateModelResponseProperties`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.ModelResponseProperties,
                value2: Components.Schemas.CreateModelResponseProperties.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
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
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/input`.
                public var input: Components.Schemas.InputParam?
                /// - Remark: Generated from `#/components/schemas/IncludeEnum`.
                public typealias IncludeEnum = [Components.Schemas.IncludeEnum]
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/include`.
                public var include: [Components.Schemas.IncludeEnum]?
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/parallel_tool_calls`.
                public var parallelToolCalls: Swift.Bool?
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/store`.
                public var store: Swift.Bool?
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/instructions`.
                public var instructions: Swift.String?
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/stream`.
                public var stream: Swift.Bool?
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/stream_options`.
                public var streamOptions: Components.Schemas.ResponseStreamOptions?
                /// - Remark: Generated from `#/components/schemas/ConversationParam`.
                public typealias ConversationParam = Components.Schemas.ConversationParam
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/conversation`.
                public var conversation: Components.Schemas.ConversationParam?
                /// - Remark: Generated from `#/components/schemas/ContextManagementParam`.
                public typealias ContextManagementParam = [Components.Schemas.ContextManagementParam]
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/context_management`.
                public var contextManagement: [Components.Schemas.ContextManagementParam]?
                /// - Remark: Generated from `#/components/schemas/CreateResponse/value3/max_output_tokens`.
                public var maxOutputTokens: Swift.Int?
                /// Creates a new `Value3Payload`.
                ///
                /// - Parameters:
                ///   - input:
                ///   - include:
                ///   - parallelToolCalls:
                ///   - store:
                ///   - instructions:
                ///   - stream:
                ///   - streamOptions:
                ///   - conversation:
                ///   - contextManagement:
                ///   - maxOutputTokens:
                public init(
                    input: Components.Schemas.InputParam? = nil,
                    include: [Components.Schemas.IncludeEnum]? = nil,
                    parallelToolCalls: Swift.Bool? = nil,
                    store: Swift.Bool? = nil,
                    instructions: Swift.String? = nil,
                    stream: Swift.Bool? = nil,
                    streamOptions: Components.Schemas.ResponseStreamOptions? = nil,
                    conversation: Components.Schemas.ConversationParam? = nil,
                    contextManagement: [Components.Schemas.ContextManagementParam]? = nil,
                    maxOutputTokens: Swift.Int? = nil
                ) {
                    self.input = input
                    self.include = include
                    self.parallelToolCalls = parallelToolCalls
                    self.store = store
                    self.instructions = instructions
                    self.stream = stream
                    self.streamOptions = streamOptions
                    self.conversation = conversation
                    self.contextManagement = contextManagement
                    self.maxOutputTokens = maxOutputTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case input
                    case include
                    case parallelToolCalls = "parallel_tool_calls"
                    case store
                    case instructions
                    case stream
                    case streamOptions = "stream_options"
                    case conversation
                    case contextManagement = "context_management"
                    case maxOutputTokens = "max_output_tokens"
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
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
                self.value3 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
                try self.value3.encode(to: encoder)
            }
        }
        /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest`.
        @frozen public enum CreateTranscriptionRequest: Sendable, Hashable {
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/file`.
            public struct FilePayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `FilePayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case file(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.FilePayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/model`.
            public struct ModelPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `ModelPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case model(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.ModelPayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/language`.
            public struct LanguagePayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `LanguagePayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case language(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.LanguagePayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/prompt`.
            public struct PromptPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `PromptPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case prompt(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.PromptPayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/response_format`.
            public struct ResponseFormatPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `ResponseFormatPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case responseFormat(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.ResponseFormatPayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/temperature`.
            public struct TemperaturePayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `TemperaturePayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case temperature(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.TemperaturePayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/include`.
            public struct IncludePayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `IncludePayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case include(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.IncludePayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/timestamp_granularities`.
            public struct TimestampGranularitiesPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `TimestampGranularitiesPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case timestampGranularities(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.TimestampGranularitiesPayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/chunking_strategy`.
            public struct ChunkingStrategyPayload: Sendable, Hashable {
                /// Controls how the audio is cut into chunks. When set to `"auto"`, the server first normalizes loudness and then uses voice activity detection (VAD) to choose boundaries. `server_vad` object can be provided to tweak VAD detection parameters manually. If unset, the audio is transcribed as a single block. Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30 seconds. 
                ///
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/chunking_strategy/content/body`.
                public struct BodyPayload: Codable, Hashable, Sendable {
                    /// Automatically set chunking parameters based on the audio. Must be set to `"auto"`.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/chunking_strategy/content/body/value1`.
                    @frozen public enum Value1Payload: String, Codable, Hashable, Sendable, CaseIterable {
                        case auto = "auto"
                    }
                    /// Automatically set chunking parameters based on the audio. Must be set to `"auto"`.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/chunking_strategy/content/body/value1`.
                    public var value1: Components.Schemas.CreateTranscriptionRequest.ChunkingStrategyPayload.BodyPayload.Value1Payload?
                    /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/chunking_strategy/content/body/value2`.
                    public var value2: Components.Schemas.VadConfig?
                    /// Creates a new `BodyPayload`.
                    ///
                    /// - Parameters:
                    ///   - value1: Automatically set chunking parameters based on the audio. Must be set to `"auto"`.
                    ///   - value2:
                    public init(
                        value1: Components.Schemas.CreateTranscriptionRequest.ChunkingStrategyPayload.BodyPayload.Value1Payload? = nil,
                        value2: Components.Schemas.VadConfig? = nil
                    ) {
                        self.value1 = value1
                        self.value2 = value2
                    }
                    public init(from decoder: any Swift.Decoder) throws {
                        var errors: [any Swift.Error] = []
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
                    public func encode(to encoder: any Swift.Encoder) throws {
                        try encoder.encodeFirstNonNilValueToSingleValueContainer([
                            self.value1
                        ])
                        try self.value2?.encode(to: encoder)
                    }
                }
                public var body: Components.Schemas.CreateTranscriptionRequest.ChunkingStrategyPayload.BodyPayload?
                /// Creates a new `ChunkingStrategyPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: Components.Schemas.CreateTranscriptionRequest.ChunkingStrategyPayload.BodyPayload? = nil) {
                    self.body = body
                }
            }
            case chunkingStrategy(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.ChunkingStrategyPayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/known_speaker_names`.
            public struct KnownSpeakerNamesPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `KnownSpeakerNamesPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case knownSpeakerNames(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.KnownSpeakerNamesPayload>)
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionRequest/known_speaker_references`.
            public struct KnownSpeakerReferencesPayload: Sendable, Hashable {
                public var body: OpenAPIRuntime.HTTPBody
                /// Creates a new `KnownSpeakerReferencesPayload`.
                ///
                /// - Parameters:
                ///   - body:
                public init(body: OpenAPIRuntime.HTTPBody) {
                    self.body = body
                }
            }
            case knownSpeakerReferences(OpenAPIRuntime.MultipartPart<Components.Schemas.CreateTranscriptionRequest.KnownSpeakerReferencesPayload>)
        }
        /// Represents a diarized transcription response returned by the model, including the combined transcript and speaker-segment annotations.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson`.
        public struct CreateTranscriptionResponseDiarizedJson: Codable, Hashable, Sendable {
            /// The type of task that was run. Always `transcribe`.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/task`.
            @frozen public enum TaskPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case transcribe = "transcribe"
            }
            /// The type of task that was run. Always `transcribe`.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/task`.
            public var task: Components.Schemas.CreateTranscriptionResponseDiarizedJson.TaskPayload
            /// Duration of the input audio in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/duration`.
            public var duration: Swift.Double
            /// The concatenated transcript text for the entire audio input.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/text`.
            public var text: Swift.String
            /// Segments of the transcript annotated with timestamps and speaker labels.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/segments`.
            public var segments: [Components.Schemas.TranscriptionDiarizedSegment]
            /// Token or duration usage statistics for the request.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/usage`.
            @frozen public enum UsagePayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/usage/TranscriptTextUsageTokens`.
                case transcriptTextUsageTokens(Components.Schemas.TranscriptTextUsageTokens)
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/usage/TranscriptTextUsageDuration`.
                case transcriptTextUsageDuration(Components.Schemas.TranscriptTextUsageDuration)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "TranscriptTextUsageTokens", "#/components/schemas/TranscriptTextUsageTokens", "tokens":
                        self = .transcriptTextUsageTokens(try .init(from: decoder))
                    case "TranscriptTextUsageDuration", "#/components/schemas/TranscriptTextUsageDuration", "duration":
                        self = .transcriptTextUsageDuration(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .transcriptTextUsageTokens(value):
                        try value.encode(to: encoder)
                    case let .transcriptTextUsageDuration(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// Token or duration usage statistics for the request.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseDiarizedJson/usage`.
            public var usage: Components.Schemas.CreateTranscriptionResponseDiarizedJson.UsagePayload?
            /// Creates a new `CreateTranscriptionResponseDiarizedJson`.
            ///
            /// - Parameters:
            ///   - task: The type of task that was run. Always `transcribe`.
            ///   - duration: Duration of the input audio in seconds.
            ///   - text: The concatenated transcript text for the entire audio input.
            ///   - segments: Segments of the transcript annotated with timestamps and speaker labels.
            ///   - usage: Token or duration usage statistics for the request.
            public init(
                task: Components.Schemas.CreateTranscriptionResponseDiarizedJson.TaskPayload,
                duration: Swift.Double,
                text: Swift.String,
                segments: [Components.Schemas.TranscriptionDiarizedSegment],
                usage: Components.Schemas.CreateTranscriptionResponseDiarizedJson.UsagePayload? = nil
            ) {
                self.task = task
                self.duration = duration
                self.text = text
                self.segments = segments
                self.usage = usage
            }
            public enum CodingKeys: String, CodingKey {
                case task
                case duration
                case text
                case segments
                case usage
            }
        }
        /// Represents a transcription response returned by model, based on the provided input.
        ///
        /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson`.
        public struct CreateTranscriptionResponseJson: Codable, Hashable, Sendable {
            /// The transcribed text.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/text`.
            public var text: Swift.String
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/LogprobsPayload`.
            public struct LogprobsPayloadPayload: Codable, Hashable, Sendable {
                /// The token in the transcription.
                ///
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/LogprobsPayload/token`.
                public var token: Swift.String?
                /// The log probability of the token.
                ///
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/LogprobsPayload/logprob`.
                public var logprob: Swift.Double?
                /// The bytes of the token.
                ///
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/LogprobsPayload/bytes`.
                public var bytes: [Swift.Double]?
                /// Creates a new `LogprobsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - token: The token in the transcription.
                ///   - logprob: The log probability of the token.
                ///   - bytes: The bytes of the token.
                public init(
                    token: Swift.String? = nil,
                    logprob: Swift.Double? = nil,
                    bytes: [Swift.Double]? = nil
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
            /// The log probabilities of the tokens in the transcription. Only returned with the models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added to the `include` array.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/logprobs`.
            public typealias LogprobsPayload = [Components.Schemas.CreateTranscriptionResponseJson.LogprobsPayloadPayload]
            /// The log probabilities of the tokens in the transcription. Only returned with the models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added to the `include` array.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/logprobs`.
            public var logprobs: Components.Schemas.CreateTranscriptionResponseJson.LogprobsPayload?
            /// Token usage statistics for the request.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/usage`.
            @frozen public enum UsagePayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/usage/case1`.
                case TranscriptTextUsageTokens(Components.Schemas.TranscriptTextUsageTokens)
                /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/usage/case2`.
                case TranscriptTextUsageDuration(Components.Schemas.TranscriptTextUsageDuration)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
                    do {
                        self = .TranscriptTextUsageTokens(try .init(from: decoder))
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .TranscriptTextUsageDuration(try .init(from: decoder))
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .TranscriptTextUsageTokens(value):
                        try value.encode(to: encoder)
                    case let .TranscriptTextUsageDuration(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// Token usage statistics for the request.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseJson/usage`.
            public var usage: Components.Schemas.CreateTranscriptionResponseJson.UsagePayload?
            /// Creates a new `CreateTranscriptionResponseJson`.
            ///
            /// - Parameters:
            ///   - text: The transcribed text.
            ///   - logprobs: The log probabilities of the tokens in the transcription. Only returned with the models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added to the `include` array.
            ///   - usage: Token usage statistics for the request.
            public init(
                text: Swift.String,
                logprobs: Components.Schemas.CreateTranscriptionResponseJson.LogprobsPayload? = nil,
                usage: Components.Schemas.CreateTranscriptionResponseJson.UsagePayload? = nil
            ) {
                self.text = text
                self.logprobs = logprobs
                self.usage = usage
            }
            public enum CodingKeys: String, CodingKey {
                case text
                case logprobs
                case usage
            }
        }
        /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseStreamEvent`.
        public struct CreateTranscriptionResponseStreamEvent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseStreamEvent/value1`.
            public var value1: Components.Schemas.TranscriptTextSegmentEvent?
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseStreamEvent/value2`.
            public var value2: Components.Schemas.TranscriptTextDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseStreamEvent/value3`.
            public var value3: Components.Schemas.TranscriptTextDoneEvent?
            /// Creates a new `CreateTranscriptionResponseStreamEvent`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            ///   - value3:
            public init(
                value1: Components.Schemas.TranscriptTextSegmentEvent? = nil,
                value2: Components.Schemas.TranscriptTextDeltaEvent? = nil,
                value3: Components.Schemas.TranscriptTextDoneEvent? = nil
            ) {
                self.value1 = value1
                self.value2 = value2
                self.value3 = value3
            }
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
                try Swift.DecodingError.verifyAtLeastOneSchemaIsNotNil(
                    [
                        self.value1,
                        self.value2,
                        self.value3
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1?.encode(to: encoder)
                try self.value2?.encode(to: encoder)
                try self.value3?.encode(to: encoder)
            }
        }
        /// Represents a verbose json transcription response returned by model, based on the provided input.
        ///
        /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson`.
        public struct CreateTranscriptionResponseVerboseJson: Codable, Hashable, Sendable {
            /// The language of the input audio.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson/language`.
            public var language: Swift.String
            /// The duration of the input audio.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson/duration`.
            public var duration: Swift.Double
            /// The transcribed text.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson/text`.
            public var text: Swift.String
            /// Extracted words and their corresponding timestamps.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson/words`.
            public var words: [Components.Schemas.TranscriptionWord]?
            /// Segments of the transcribed text and their corresponding details.
            ///
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson/segments`.
            public var segments: [Components.Schemas.TranscriptionSegment]?
            /// - Remark: Generated from `#/components/schemas/CreateTranscriptionResponseVerboseJson/usage`.
            public var usage: Components.Schemas.TranscriptTextUsageDuration?
            /// Creates a new `CreateTranscriptionResponseVerboseJson`.
            ///
            /// - Parameters:
            ///   - language: The language of the input audio.
            ///   - duration: The duration of the input audio.
            ///   - text: The transcribed text.
            ///   - words: Extracted words and their corresponding timestamps.
            ///   - segments: Segments of the transcribed text and their corresponding details.
            ///   - usage:
            public init(
                language: Swift.String,
                duration: Swift.Double,
                text: Swift.String,
                words: [Components.Schemas.TranscriptionWord]? = nil,
                segments: [Components.Schemas.TranscriptionSegment]? = nil,
                usage: Components.Schemas.TranscriptTextUsageDuration? = nil
            ) {
                self.language = language
                self.duration = duration
                self.text = text
                self.words = words
                self.segments = segments
                self.usage = usage
            }
            public enum CodingKeys: String, CodingKey {
                case language
                case duration
                case text
                case words
                case segments
                case usage
            }
        }
        /// A call to a custom tool created by the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CustomToolCall`.
        public struct CustomToolCall: Codable, Hashable, Sendable {
            /// The type of the custom tool call. Always `custom_tool_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case customToolCall = "custom_tool_call"
            }
            /// The type of the custom tool call. Always `custom_tool_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/type`.
            public var _type: Components.Schemas.CustomToolCall._TypePayload
            /// The unique ID of the custom tool call in the OpenAI platform.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/id`.
            public var id: Swift.String?
            /// An identifier used to map this custom tool call to a tool call output.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/call_id`.
            public var callId: Swift.String
            /// The namespace of the custom tool being called.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/namespace`.
            public var namespace: Swift.String?
            /// The name of the custom tool being called.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/name`.
            public var name: Swift.String
            /// The input for the custom tool call generated by the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCall/input`.
            public var input: Swift.String
            /// Creates a new `CustomToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the custom tool call. Always `custom_tool_call`.
            ///   - id: The unique ID of the custom tool call in the OpenAI platform.
            ///   - callId: An identifier used to map this custom tool call to a tool call output.
            ///   - namespace: The namespace of the custom tool being called.
            ///   - name: The name of the custom tool being called.
            ///   - input: The input for the custom tool call generated by the model.
            public init(
                _type: Components.Schemas.CustomToolCall._TypePayload,
                id: Swift.String? = nil,
                callId: Swift.String,
                namespace: Swift.String? = nil,
                name: Swift.String,
                input: Swift.String
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.namespace = namespace
                self.name = name
                self.input = input
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case namespace
                case name
                case input
            }
        }
        /// The output of a custom tool call from your code, being sent back to the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput`.
        public struct CustomToolCallOutput: Codable, Hashable, Sendable {
            /// The type of the custom tool call output. Always `custom_tool_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case customToolCallOutput = "custom_tool_call_output"
            }
            /// The type of the custom tool call output. Always `custom_tool_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/type`.
            public var _type: Components.Schemas.CustomToolCallOutput._TypePayload
            /// The unique ID of the custom tool call output in the OpenAI platform.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/id`.
            public var id: Swift.String?
            /// The call ID, used to map this custom tool call output to a custom tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/call_id`.
            public var callId: Swift.String
            /// The output from the custom tool call generated by your code.
            /// Can be a string or an list of output content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/output`.
            @frozen public enum OutputPayload: Codable, Hashable, Sendable {
                /// A string of the output of the custom tool call.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/output/case1`.
                case case1(Swift.String)
                /// Text, image, or file output of the custom tool call.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/output/case2`.
                case case2([Components.Schemas.FunctionAndCustomToolCallOutput])
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// The output from the custom tool call generated by your code.
            /// Can be a string or an list of output content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutput/output`.
            public var output: Components.Schemas.CustomToolCallOutput.OutputPayload
            /// Creates a new `CustomToolCallOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the custom tool call output. Always `custom_tool_call_output`.
            ///   - id: The unique ID of the custom tool call output in the OpenAI platform.
            ///   - callId: The call ID, used to map this custom tool call output to a custom tool call.
            ///   - output: The output from the custom tool call generated by your code.
            public init(
                _type: Components.Schemas.CustomToolCallOutput._TypePayload,
                id: Swift.String? = nil,
                callId: Swift.String,
                output: Components.Schemas.CustomToolCallOutput.OutputPayload
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.output = output
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case output
            }
        }
        /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource`.
        public struct CustomToolCallOutputResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource/value1`.
            public var value1: Components.Schemas.CustomToolCallOutput
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// The unique ID of the custom tool call output item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource/value2/id`.
                public var id: Swift.String
                /// The status of the item. One of `in_progress`, `completed`, or
                /// `incomplete`. Populated when items are returned via API.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource/value2/status`.
                public var status: Components.Schemas.FunctionCallOutputStatusEnum
                /// The identifier of the actor that created the item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource/value2/created_by`.
                public var createdBy: Swift.String?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the custom tool call output item.
                ///   - status: The status of the item. One of `in_progress`, `completed`, or
                ///   - createdBy: The identifier of the actor that created the item.
                public init(
                    id: Swift.String,
                    status: Components.Schemas.FunctionCallOutputStatusEnum,
                    createdBy: Swift.String? = nil
                ) {
                    self.id = id
                    self.status = status
                    self.createdBy = createdBy
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case status
                    case createdBy = "created_by"
                }
            }
            /// - Remark: Generated from `#/components/schemas/CustomToolCallOutputResource/value2`.
            public var value2: Components.Schemas.CustomToolCallOutputResource.Value2Payload
            /// Creates a new `CustomToolCallOutputResource`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.CustomToolCallOutput,
                value2: Components.Schemas.CustomToolCallOutputResource.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// - Remark: Generated from `#/components/schemas/CustomToolCallResource`.
        public struct CustomToolCallResource: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CustomToolCallResource/value1`.
            public var value1: Components.Schemas.CustomToolCall
            /// - Remark: Generated from `#/components/schemas/CustomToolCallResource/value2`.
            public struct Value2Payload: Codable, Hashable, Sendable {
                /// The unique ID of the custom tool call item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallResource/value2/id`.
                public var id: Swift.String
                /// The status of the item. One of `in_progress`, `completed`, or
                /// `incomplete`. Populated when items are returned via API.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallResource/value2/status`.
                public var status: Components.Schemas.FunctionCallStatus
                /// The identifier of the actor that created the item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/CustomToolCallResource/value2/created_by`.
                public var createdBy: Swift.String?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the custom tool call item.
                ///   - status: The status of the item. One of `in_progress`, `completed`, or
                ///   - createdBy: The identifier of the actor that created the item.
                public init(
                    id: Swift.String,
                    status: Components.Schemas.FunctionCallStatus,
                    createdBy: Swift.String? = nil
                ) {
                    self.id = id
                    self.status = status
                    self.createdBy = createdBy
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case status
                    case createdBy = "created_by"
                }
            }
            /// - Remark: Generated from `#/components/schemas/CustomToolCallResource/value2`.
            public var value2: Components.Schemas.CustomToolCallResource.Value2Payload
            /// Creates a new `CustomToolCallResource`.
            ///
            /// - Parameters:
            ///   - value1:
            ///   - value2:
            public init(
                value1: Components.Schemas.CustomToolCall,
                value2: Components.Schemas.CustomToolCallResource.Value2Payload
            ) {
                self.value1 = value1
                self.value2 = value2
            }
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
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
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
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
            /// - Remark: Generated from `#/components/schemas/MessagePhase`.
            public typealias MessagePhase = Components.Schemas.MessagePhase
            /// - Remark: Generated from `#/components/schemas/EasyInputMessage/phase`.
            public var phase: Components.Schemas.MessagePhase?
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
            ///   - phase:
            ///   - _type: The type of the message input. Always `message`.
            public init(
                role: Components.Schemas.EasyInputMessage.RolePayload,
                content: Components.Schemas.EasyInputMessage.ContentPayload,
                phase: Components.Schemas.MessagePhase? = nil,
                _type: Components.Schemas.EasyInputMessage._TypePayload? = nil
            ) {
                self.role = role
                self.content = content
                self.phase = phase
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case role
                case content
                case phase
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
            /// - Remark: Generated from `#/components/schemas/FileSearchToolCall/results`.
            public var results: Components.Schemas.FileSearchToolCall.ResultsPayload?
            /// Creates a new `FileSearchToolCall`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the file search tool call.
            ///   - _type: The type of the file search tool call. Always `file_search_call`.
            ///   - status: The status of the file search tool call. One of `in_progress`,
            ///   - queries: The queries used to search for files.
            ///   - results:
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
        /// - Remark: Generated from `#/components/schemas/FunctionAndCustomToolCallOutput`.
        @frozen public enum FunctionAndCustomToolCallOutput: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionAndCustomToolCallOutput/InputTextContent`.
            case inputTextContent(Components.Schemas.InputTextContent)
            /// - Remark: Generated from `#/components/schemas/FunctionAndCustomToolCallOutput/InputImageContent`.
            case inputImageContent(Components.Schemas.InputImageContent)
            /// - Remark: Generated from `#/components/schemas/FunctionAndCustomToolCallOutput/InputFileContent`.
            case inputFileContent(Components.Schemas.InputFileContent)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "InputTextContent", "#/components/schemas/InputTextContent", "input_text":
                    self = .inputTextContent(try .init(from: decoder))
                case "InputImageContent", "#/components/schemas/InputImageContent", "input_image":
                    self = .inputImageContent(try .init(from: decoder))
                case "InputFileContent", "#/components/schemas/InputFileContent", "input_file":
                    self = .inputFileContent(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .inputTextContent(value):
                    try value.encode(to: encoder)
                case let .inputImageContent(value):
                    try value.encode(to: encoder)
                case let .inputFileContent(value):
                    try value.encode(to: encoder)
                }
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
            /// The namespace of the function to run.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCall/namespace`.
            public var namespace: Swift.String?
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
            ///   - namespace: The namespace of the function to run.
            ///   - name: The name of the function to run.
            ///   - arguments: A JSON string of the arguments to pass to the function.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                id: Swift.String? = nil,
                _type: Components.Schemas.FunctionToolCall._TypePayload,
                callId: Swift.String,
                namespace: Swift.String? = nil,
                name: Swift.String,
                arguments: Swift.String,
                status: Components.Schemas.FunctionToolCall.StatusPayload? = nil
            ) {
                self.id = id
                self._type = _type
                self.callId = callId
                self.namespace = namespace
                self.name = name
                self.arguments = arguments
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case callId = "call_id"
                case namespace
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
            /// The output from the function call generated by your code.
            /// Can be a string or an list of output content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/output`.
            @frozen public enum OutputPayload: Codable, Hashable, Sendable {
                /// A string of the output of the function call.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/output/case1`.
                case case1(Swift.String)
                /// Text, image, or file output of the function call.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/output/case2`.
                case case2([Components.Schemas.FunctionAndCustomToolCallOutput])
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// The output from the function call generated by your code.
            /// Can be a string or an list of output content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutput/output`.
            public var output: Components.Schemas.FunctionToolCallOutput.OutputPayload
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
            ///   - output: The output from the function call generated by your code.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                id: Swift.String? = nil,
                _type: Components.Schemas.FunctionToolCallOutput._TypePayload,
                callId: Swift.String,
                output: Components.Schemas.FunctionToolCallOutput.OutputPayload,
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
                /// The status of the item. One of `in_progress`, `completed`, or
                /// `incomplete`. Populated when items are returned via API.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource/value2/status`.
                public var status: Components.Schemas.FunctionCallOutputStatusEnum
                /// The identifier of the actor that created the item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallOutputResource/value2/created_by`.
                public var createdBy: Swift.String?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the function call tool output.
                ///   - status: The status of the item. One of `in_progress`, `completed`, or
                ///   - createdBy: The identifier of the actor that created the item.
                public init(
                    id: Swift.String,
                    status: Components.Schemas.FunctionCallOutputStatusEnum,
                    createdBy: Swift.String? = nil
                ) {
                    self.id = id
                    self.status = status
                    self.createdBy = createdBy
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case status
                    case createdBy = "created_by"
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
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
                /// The status of the item. One of `in_progress`, `completed`, or
                /// `incomplete`. Populated when items are returned via API.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource/value2/status`.
                public var status: Components.Schemas.FunctionCallStatus
                /// The identifier of the actor that created the item.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionToolCallResource/value2/created_by`.
                public var createdBy: Swift.String?
                /// Creates a new `Value2Payload`.
                ///
                /// - Parameters:
                ///   - id: The unique ID of the function tool call.
                ///   - status: The status of the item. One of `in_progress`, `completed`, or
                ///   - createdBy: The identifier of the actor that created the item.
                public init(
                    id: Swift.String,
                    status: Components.Schemas.FunctionCallStatus,
                    createdBy: Swift.String? = nil
                ) {
                    self.id = id
                    self.status = status
                    self.createdBy = createdBy
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case status
                    case createdBy = "created_by"
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
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
            }
        }
        /// A tool that generates images using the GPT image models.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ImageGenTool`.
        public struct ImageGenTool: Codable, Hashable, Sendable {
            /// The type of the image generation tool. Always `image_generation`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case imageGeneration = "image_generation"
            }
            /// The type of the image generation tool. Always `image_generation`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/type`.
            public var _type: Components.Schemas.ImageGenTool._TypePayload
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/model`.
            public struct ModelPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/model/value1`.
                public var value1: Swift.String?
                /// The image generation model to use. Default: `gpt-image-1`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/model/value2`.
                @frozen public enum Value2Payload: String, Codable, Hashable, Sendable, CaseIterable {
                    case gptImage1 = "gpt-image-1"
                    case gptImage1Mini = "gpt-image-1-mini"
                    case gptImage1_5 = "gpt-image-1.5"
                }
                /// The image generation model to use. Default: `gpt-image-1`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/model/value2`.
                public var value2: Components.Schemas.ImageGenTool.ModelPayload.Value2Payload?
                /// Creates a new `ModelPayload`.
                ///
                /// - Parameters:
                ///   - value1:
                ///   - value2: The image generation model to use. Default: `gpt-image-1`.
                public init(
                    value1: Swift.String? = nil,
                    value2: Components.Schemas.ImageGenTool.ModelPayload.Value2Payload? = nil
                ) {
                    self.value1 = value1
                    self.value2 = value2
                }
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    try encoder.encodeFirstNonNilValueToSingleValueContainer([
                        self.value1,
                        self.value2
                    ])
                }
            }
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/model`.
            public var model: Components.Schemas.ImageGenTool.ModelPayload?
            /// The quality of the generated image. One of `low`, `medium`, `high`,
            /// or `auto`. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/quality`.
            @frozen public enum QualityPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case low = "low"
                case medium = "medium"
                case high = "high"
                case auto = "auto"
            }
            /// The quality of the generated image. One of `low`, `medium`, `high`,
            /// or `auto`. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/quality`.
            public var quality: Components.Schemas.ImageGenTool.QualityPayload?
            /// The size of the generated images. For `gpt-image-2` and `gpt-image-2-2026-04-21`, arbitrary resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`. Width and height must both be divisible by 16 and the requested aspect ratio must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and the maximum supported resolution is `3840x2160`. The requested size must also satisfy the model's current pixel and edge limits. The standard sizes `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models; `auto` is supported for models that allow automatic sizing. For `dall-e-2`, use one of `256x256`, `512x512`, or `1024x1024`. For `dall-e-3`, use one of `1024x1024`, `1792x1024`, or `1024x1792`.
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/size`.
            public struct SizePayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/size/value1`.
                public var value1: Swift.String?
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/size/value2`.
                @frozen public enum Value2Payload: String, Codable, Hashable, Sendable, CaseIterable {
                    case _1024x1024 = "1024x1024"
                    case _1024x1536 = "1024x1536"
                    case _1536x1024 = "1536x1024"
                    case auto = "auto"
                }
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/size/value2`.
                public var value2: Components.Schemas.ImageGenTool.SizePayload.Value2Payload?
                /// Creates a new `SizePayload`.
                ///
                /// - Parameters:
                ///   - value1:
                ///   - value2:
                public init(
                    value1: Swift.String? = nil,
                    value2: Components.Schemas.ImageGenTool.SizePayload.Value2Payload? = nil
                ) {
                    self.value1 = value1
                    self.value2 = value2
                }
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    try encoder.encodeFirstNonNilValueToSingleValueContainer([
                        self.value1,
                        self.value2
                    ])
                }
            }
            /// The size of the generated images. For `gpt-image-2` and `gpt-image-2-2026-04-21`, arbitrary resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`. Width and height must both be divisible by 16 and the requested aspect ratio must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and the maximum supported resolution is `3840x2160`. The requested size must also satisfy the model's current pixel and edge limits. The standard sizes `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models; `auto` is supported for models that allow automatic sizing. For `dall-e-2`, use one of `256x256`, `512x512`, or `1024x1024`. For `dall-e-3`, use one of `1024x1024`, `1792x1024`, or `1024x1792`.
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/size`.
            public var size: Components.Schemas.ImageGenTool.SizePayload?
            /// The output format of the generated image. One of `png`, `webp`, or
            /// `jpeg`. Default: `png`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/output_format`.
            @frozen public enum OutputFormatPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case png = "png"
                case webp = "webp"
                case jpeg = "jpeg"
            }
            /// The output format of the generated image. One of `png`, `webp`, or
            /// `jpeg`. Default: `png`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/output_format`.
            public var outputFormat: Components.Schemas.ImageGenTool.OutputFormatPayload?
            /// Compression level for the output image. Default: 100.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/output_compression`.
            public var outputCompression: Swift.Int?
            /// Moderation level for the generated image. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/moderation`.
            @frozen public enum ModerationPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case low = "low"
            }
            /// Moderation level for the generated image. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/moderation`.
            public var moderation: Components.Schemas.ImageGenTool.ModerationPayload?
            /// Background type for the generated image. One of `transparent`,
            /// `opaque`, or `auto`. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/background`.
            @frozen public enum BackgroundPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case transparent = "transparent"
                case opaque = "opaque"
                case auto = "auto"
            }
            /// Background type for the generated image. One of `transparent`,
            /// `opaque`, or `auto`. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/background`.
            public var background: Components.Schemas.ImageGenTool.BackgroundPayload?
            /// - Remark: Generated from `#/components/schemas/InputFidelity`.
            public typealias InputFidelity = Components.Schemas.InputFidelity
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/input_fidelity`.
            public var inputFidelity: Components.Schemas.InputFidelity?
            /// Optional mask for inpainting. Contains `image_url`
            /// (string, optional) and `file_id` (string, optional).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/input_image_mask`.
            public struct InputImageMaskPayload: Codable, Hashable, Sendable {
                /// Base64-encoded mask image.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/input_image_mask/image_url`.
                public var imageUrl: Swift.String?
                /// File ID for the mask image.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/ImageGenTool/input_image_mask/file_id`.
                public var fileId: Swift.String?
                /// Creates a new `InputImageMaskPayload`.
                ///
                /// - Parameters:
                ///   - imageUrl: Base64-encoded mask image.
                ///   - fileId: File ID for the mask image.
                public init(
                    imageUrl: Swift.String? = nil,
                    fileId: Swift.String? = nil
                ) {
                    self.imageUrl = imageUrl
                    self.fileId = fileId
                }
                public enum CodingKeys: String, CodingKey {
                    case imageUrl = "image_url"
                    case fileId = "file_id"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    self.imageUrl = try container.decodeIfPresent(
                        Swift.String.self,
                        forKey: .imageUrl
                    )
                    self.fileId = try container.decodeIfPresent(
                        Swift.String.self,
                        forKey: .fileId
                    )
                    try decoder.ensureNoAdditionalProperties(knownKeys: [
                        "image_url",
                        "file_id"
                    ])
                }
            }
            /// Optional mask for inpainting. Contains `image_url`
            /// (string, optional) and `file_id` (string, optional).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/input_image_mask`.
            public var inputImageMask: Components.Schemas.ImageGenTool.InputImageMaskPayload?
            /// Number of partial images to generate in streaming mode, from 0 (default value) to 3.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/partial_images`.
            public var partialImages: Swift.Int?
            /// Whether to generate a new image or edit an existing image. Default: `auto`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenTool/action`.
            public var action: Components.Schemas.ImageGenActionEnum?
            /// Creates a new `ImageGenTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the image generation tool. Always `image_generation`.
            ///   - model:
            ///   - quality: The quality of the generated image. One of `low`, `medium`, `high`,
            ///   - size: The size of the generated images. For `gpt-image-2` and `gpt-image-2-2026-04-21`, arbitrary resolutions are supported as `WIDTHxHEIGHT` strings, for example `1536x864`. Width and height must both be divisible by 16 and the requested aspect ratio must be between 1:3 and 3:1. Resolutions above `2560x1440` are experimental, and the maximum supported resolution is `3840x2160`. The requested size must also satisfy the model's current pixel and edge limits. The standard sizes `1024x1024`, `1536x1024`, and `1024x1536` are supported by the GPT image models; `auto` is supported for models that allow automatic sizing. For `dall-e-2`, use one of `256x256`, `512x512`, or `1024x1024`. For `dall-e-3`, use one of `1024x1024`, `1792x1024`, or `1024x1792`.
            ///   - outputFormat: The output format of the generated image. One of `png`, `webp`, or
            ///   - outputCompression: Compression level for the output image. Default: 100.
            ///   - moderation: Moderation level for the generated image. Default: `auto`.
            ///   - background: Background type for the generated image. One of `transparent`,
            ///   - inputFidelity:
            ///   - inputImageMask: Optional mask for inpainting. Contains `image_url`
            ///   - partialImages: Number of partial images to generate in streaming mode, from 0 (default value) to 3.
            ///   - action: Whether to generate a new image or edit an existing image. Default: `auto`.
            public init(
                _type: Components.Schemas.ImageGenTool._TypePayload,
                model: Components.Schemas.ImageGenTool.ModelPayload? = nil,
                quality: Components.Schemas.ImageGenTool.QualityPayload? = nil,
                size: Components.Schemas.ImageGenTool.SizePayload? = nil,
                outputFormat: Components.Schemas.ImageGenTool.OutputFormatPayload? = nil,
                outputCompression: Swift.Int? = nil,
                moderation: Components.Schemas.ImageGenTool.ModerationPayload? = nil,
                background: Components.Schemas.ImageGenTool.BackgroundPayload? = nil,
                inputFidelity: Components.Schemas.InputFidelity? = nil,
                inputImageMask: Components.Schemas.ImageGenTool.InputImageMaskPayload? = nil,
                partialImages: Swift.Int? = nil,
                action: Components.Schemas.ImageGenActionEnum? = nil
            ) {
                self._type = _type
                self.model = model
                self.quality = quality
                self.size = size
                self.outputFormat = outputFormat
                self.outputCompression = outputCompression
                self.moderation = moderation
                self.background = background
                self.inputFidelity = inputFidelity
                self.inputImageMask = inputImageMask
                self.partialImages = partialImages
                self.action = action
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case model
                case quality
                case size
                case outputFormat = "output_format"
                case outputCompression = "output_compression"
                case moderation
                case background
                case inputFidelity = "input_fidelity"
                case inputImageMask = "input_image_mask"
                case partialImages = "partial_images"
                case action
            }
        }
        /// An image generation request made by the model.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ImageGenToolCall`.
        public struct ImageGenToolCall: Codable, Hashable, Sendable {
            /// The type of the image generation call. Always `image_generation_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case imageGenerationCall = "image_generation_call"
            }
            /// The type of the image generation call. Always `image_generation_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenToolCall/type`.
            public var _type: Components.Schemas.ImageGenToolCall._TypePayload
            /// The unique ID of the image generation call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenToolCall/id`.
            public var id: Swift.String
            /// The status of the image generation call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case generating = "generating"
                case failed = "failed"
            }
            /// The status of the image generation call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ImageGenToolCall/status`.
            public var status: Components.Schemas.ImageGenToolCall.StatusPayload
            /// - Remark: Generated from `#/components/schemas/ImageGenToolCall/result`.
            public var result: Swift.String?
            /// Creates a new `ImageGenToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the image generation call. Always `image_generation_call`.
            ///   - id: The unique ID of the image generation call.
            ///   - status: The status of the image generation call.
            ///   - result:
            public init(
                _type: Components.Schemas.ImageGenToolCall._TypePayload,
                id: Swift.String,
                status: Components.Schemas.ImageGenToolCall.StatusPayload,
                result: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.status = status
                self.result = result
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case status
                case result
            }
        }
        /// - Remark: Generated from `#/components/schemas/InputContent`.
        @frozen public enum InputContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/InputContent/InputTextContent`.
            case inputTextContent(Components.Schemas.InputTextContent)
            /// - Remark: Generated from `#/components/schemas/InputContent/InputImageContent`.
            case inputImageContent(Components.Schemas.InputImageContent)
            /// - Remark: Generated from `#/components/schemas/InputContent/InputFileContent`.
            case inputFileContent(Components.Schemas.InputFileContent)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "InputTextContent", "#/components/schemas/InputTextContent", "input_text":
                    self = .inputTextContent(try .init(from: decoder))
                case "InputImageContent", "#/components/schemas/InputImageContent", "input_image":
                    self = .inputImageContent(try .init(from: decoder))
                case "InputFileContent", "#/components/schemas/InputFileContent", "input_file":
                    self = .inputFileContent(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .inputTextContent(value):
                    try value.encode(to: encoder)
                case let .inputImageContent(value):
                    try value.encode(to: encoder)
                case let .inputFileContent(value):
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
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "EasyInputMessage", "#/components/schemas/EasyInputMessage", "message":
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
            public func encode(to encoder: any Swift.Encoder) throws {
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
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try self.value1.encode(to: encoder)
                try self.value2.encode(to: encoder)
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
        /// - Remark: Generated from `#/components/schemas/InputParam`.
        @frozen public enum InputParam: Codable, Hashable, Sendable {
            /// A text input to the model, equivalent to a text input with the
            /// `user` role.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputParam/case1`.
            case case1(Swift.String)
            /// A list of one or many input items to the model, containing
            /// different content types.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputParam/case2`.
            case case2([Components.Schemas.InputItem])
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .case1(value):
                    try encoder.encodeToSingleValueContainer(value)
                case let .case2(value):
                    try encoder.encodeToSingleValueContainer(value)
                }
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
            /// - Remark: Generated from `#/components/schemas/Item/ToolSearchCallItemParam`.
            case toolSearchCallItemParam(Components.Schemas.ToolSearchCallItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/ToolSearchOutputItemParam`.
            case toolSearchOutputItemParam(Components.Schemas.ToolSearchOutputItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/ReasoningItem`.
            case reasoningItem(Components.Schemas.ReasoningItem)
            /// - Remark: Generated from `#/components/schemas/Item/CompactionSummaryItemParam`.
            case compactionSummaryItemParam(Components.Schemas.CompactionSummaryItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/ImageGenToolCall`.
            case imageGenToolCall(Components.Schemas.ImageGenToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/CodeInterpreterToolCall`.
            case codeInterpreterToolCall(Components.Schemas.CodeInterpreterToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/LocalShellToolCall`.
            case localShellToolCall(Components.Schemas.LocalShellToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/LocalShellToolCallOutput`.
            case localShellToolCallOutput(Components.Schemas.LocalShellToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/Item/FunctionShellCallItemParam`.
            case functionShellCallItemParam(Components.Schemas.FunctionShellCallItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/FunctionShellCallOutputItemParam`.
            case functionShellCallOutputItemParam(Components.Schemas.FunctionShellCallOutputItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/ApplyPatchToolCallItemParam`.
            case applyPatchToolCallItemParam(Components.Schemas.ApplyPatchToolCallItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/ApplyPatchToolCallOutputItemParam`.
            case applyPatchToolCallOutputItemParam(Components.Schemas.ApplyPatchToolCallOutputItemParam)
            /// - Remark: Generated from `#/components/schemas/Item/MCPListTools`.
            case mcpListTools(Components.Schemas.MCPListTools)
            /// - Remark: Generated from `#/components/schemas/Item/MCPApprovalRequest`.
            case mcpApprovalRequest(Components.Schemas.MCPApprovalRequest)
            /// - Remark: Generated from `#/components/schemas/Item/MCPApprovalResponse`.
            case mcpApprovalResponse(Components.Schemas.MCPApprovalResponse)
            /// - Remark: Generated from `#/components/schemas/Item/MCPToolCall`.
            case mcpToolCall(Components.Schemas.MCPToolCall)
            /// - Remark: Generated from `#/components/schemas/Item/CustomToolCallOutput`.
            case customToolCallOutput(Components.Schemas.CustomToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/Item/CustomToolCall`.
            case customToolCall(Components.Schemas.CustomToolCall)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "InputMessage", "#/components/schemas/InputMessage", "message":
                    self = .inputMessage(try .init(from: decoder))
                case "OutputMessage", "#/components/schemas/OutputMessage", "message":
                    self = .outputMessage(try .init(from: decoder))
                case "FileSearchToolCall", "#/components/schemas/FileSearchToolCall", "file_search_call":
                    self = .fileSearchToolCall(try .init(from: decoder))
                case "ComputerToolCall", "#/components/schemas/ComputerToolCall", "computer_call":
                    self = .computerToolCall(try .init(from: decoder))
                case "ComputerCallOutputItemParam", "#/components/schemas/ComputerCallOutputItemParam", "computer_call_output":
                    self = .computerCallOutputItemParam(try .init(from: decoder))
                case "WebSearchToolCall", "#/components/schemas/WebSearchToolCall", "web_search_call":
                    self = .webSearchToolCall(try .init(from: decoder))
                case "FunctionToolCall", "#/components/schemas/FunctionToolCall", "function_call":
                    self = .functionToolCall(try .init(from: decoder))
                case "FunctionCallOutputItemParam", "#/components/schemas/FunctionCallOutputItemParam", "function_call_output":
                    self = .functionCallOutputItemParam(try .init(from: decoder))
                case "ToolSearchCallItemParam", "#/components/schemas/ToolSearchCallItemParam", "tool_search_call":
                    self = .toolSearchCallItemParam(try .init(from: decoder))
                case "ToolSearchOutputItemParam", "#/components/schemas/ToolSearchOutputItemParam", "tool_search_output":
                    self = .toolSearchOutputItemParam(try .init(from: decoder))
                case "ReasoningItem", "#/components/schemas/ReasoningItem", "reasoning":
                    self = .reasoningItem(try .init(from: decoder))
                case "CompactionSummaryItemParam", "#/components/schemas/CompactionSummaryItemParam", "compaction":
                    self = .compactionSummaryItemParam(try .init(from: decoder))
                case "ImageGenToolCall", "#/components/schemas/ImageGenToolCall", "image_generation_call":
                    self = .imageGenToolCall(try .init(from: decoder))
                case "CodeInterpreterToolCall", "#/components/schemas/CodeInterpreterToolCall", "code_interpreter_call":
                    self = .codeInterpreterToolCall(try .init(from: decoder))
                case "LocalShellToolCall", "#/components/schemas/LocalShellToolCall", "local_shell_call":
                    self = .localShellToolCall(try .init(from: decoder))
                case "LocalShellToolCallOutput", "#/components/schemas/LocalShellToolCallOutput", "local_shell_call_output":
                    self = .localShellToolCallOutput(try .init(from: decoder))
                case "FunctionShellCallItemParam", "#/components/schemas/FunctionShellCallItemParam", "shell_call":
                    self = .functionShellCallItemParam(try .init(from: decoder))
                case "FunctionShellCallOutputItemParam", "#/components/schemas/FunctionShellCallOutputItemParam", "shell_call_output":
                    self = .functionShellCallOutputItemParam(try .init(from: decoder))
                case "ApplyPatchToolCallItemParam", "#/components/schemas/ApplyPatchToolCallItemParam", "apply_patch_call":
                    self = .applyPatchToolCallItemParam(try .init(from: decoder))
                case "ApplyPatchToolCallOutputItemParam", "#/components/schemas/ApplyPatchToolCallOutputItemParam", "apply_patch_call_output":
                    self = .applyPatchToolCallOutputItemParam(try .init(from: decoder))
                case "MCPListTools", "#/components/schemas/MCPListTools", "mcp_list_tools":
                    self = .mcpListTools(try .init(from: decoder))
                case "MCPApprovalRequest", "#/components/schemas/MCPApprovalRequest", "mcp_approval_request":
                    self = .mcpApprovalRequest(try .init(from: decoder))
                case "MCPApprovalResponse", "#/components/schemas/MCPApprovalResponse", "mcp_approval_response":
                    self = .mcpApprovalResponse(try .init(from: decoder))
                case "MCPToolCall", "#/components/schemas/MCPToolCall", "mcp_call":
                    self = .mcpToolCall(try .init(from: decoder))
                case "CustomToolCallOutput", "#/components/schemas/CustomToolCallOutput", "custom_tool_call_output":
                    self = .customToolCallOutput(try .init(from: decoder))
                case "CustomToolCall", "#/components/schemas/CustomToolCall", "custom_tool_call":
                    self = .customToolCall(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
                case let .toolSearchCallItemParam(value):
                    try value.encode(to: encoder)
                case let .toolSearchOutputItemParam(value):
                    try value.encode(to: encoder)
                case let .reasoningItem(value):
                    try value.encode(to: encoder)
                case let .compactionSummaryItemParam(value):
                    try value.encode(to: encoder)
                case let .imageGenToolCall(value):
                    try value.encode(to: encoder)
                case let .codeInterpreterToolCall(value):
                    try value.encode(to: encoder)
                case let .localShellToolCall(value):
                    try value.encode(to: encoder)
                case let .localShellToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .functionShellCallItemParam(value):
                    try value.encode(to: encoder)
                case let .functionShellCallOutputItemParam(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolCallItemParam(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolCallOutputItemParam(value):
                    try value.encode(to: encoder)
                case let .mcpListTools(value):
                    try value.encode(to: encoder)
                case let .mcpApprovalRequest(value):
                    try value.encode(to: encoder)
                case let .mcpApprovalResponse(value):
                    try value.encode(to: encoder)
                case let .mcpToolCall(value):
                    try value.encode(to: encoder)
                case let .customToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .customToolCall(value):
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
            /// - Remark: Generated from `#/components/schemas/ItemResource/ToolSearchCall`.
            case toolSearchCall(Components.Schemas.ToolSearchCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ToolSearchOutput`.
            case toolSearchOutput(Components.Schemas.ToolSearchOutput)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ReasoningItem`.
            case reasoningItem(Components.Schemas.ReasoningItem)
            /// - Remark: Generated from `#/components/schemas/ItemResource/CompactionBody`.
            case compactionBody(Components.Schemas.CompactionBody)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ImageGenToolCall`.
            case imageGenToolCall(Components.Schemas.ImageGenToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/CodeInterpreterToolCall`.
            case codeInterpreterToolCall(Components.Schemas.CodeInterpreterToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/LocalShellToolCall`.
            case localShellToolCall(Components.Schemas.LocalShellToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/LocalShellToolCallOutput`.
            case localShellToolCallOutput(Components.Schemas.LocalShellToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/ItemResource/FunctionShellCall`.
            case functionShellCall(Components.Schemas.FunctionShellCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/FunctionShellCallOutput`.
            case functionShellCallOutput(Components.Schemas.FunctionShellCallOutput)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ApplyPatchToolCall`.
            case applyPatchToolCall(Components.Schemas.ApplyPatchToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/ApplyPatchToolCallOutput`.
            case applyPatchToolCallOutput(Components.Schemas.ApplyPatchToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/ItemResource/MCPListTools`.
            case mcpListTools(Components.Schemas.MCPListTools)
            /// - Remark: Generated from `#/components/schemas/ItemResource/MCPApprovalRequest`.
            case mcpApprovalRequest(Components.Schemas.MCPApprovalRequest)
            /// - Remark: Generated from `#/components/schemas/ItemResource/MCPApprovalResponseResource`.
            case mcpApprovalResponseResource(Components.Schemas.MCPApprovalResponseResource)
            /// - Remark: Generated from `#/components/schemas/ItemResource/MCPToolCall`.
            case mcpToolCall(Components.Schemas.MCPToolCall)
            /// - Remark: Generated from `#/components/schemas/ItemResource/CustomToolCallResource`.
            case customToolCallResource(Components.Schemas.CustomToolCallResource)
            /// - Remark: Generated from `#/components/schemas/ItemResource/CustomToolCallOutputResource`.
            case customToolCallOutputResource(Components.Schemas.CustomToolCallOutputResource)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "InputMessageResource", "#/components/schemas/InputMessageResource":
                    self = .inputMessageResource(try .init(from: decoder))
                case "OutputMessage", "#/components/schemas/OutputMessage", "message":
                    self = .outputMessage(try .init(from: decoder))
                case "FileSearchToolCall", "#/components/schemas/FileSearchToolCall", "file_search_call":
                    self = .fileSearchToolCall(try .init(from: decoder))
                case "ComputerToolCall", "#/components/schemas/ComputerToolCall", "computer_call":
                    self = .computerToolCall(try .init(from: decoder))
                case "ComputerToolCallOutputResource", "#/components/schemas/ComputerToolCallOutputResource":
                    self = .computerToolCallOutputResource(try .init(from: decoder))
                case "WebSearchToolCall", "#/components/schemas/WebSearchToolCall", "web_search_call":
                    self = .webSearchToolCall(try .init(from: decoder))
                case "FunctionToolCallResource", "#/components/schemas/FunctionToolCallResource":
                    self = .functionToolCallResource(try .init(from: decoder))
                case "FunctionToolCallOutputResource", "#/components/schemas/FunctionToolCallOutputResource":
                    self = .functionToolCallOutputResource(try .init(from: decoder))
                case "ToolSearchCall", "#/components/schemas/ToolSearchCall", "tool_search_call":
                    self = .toolSearchCall(try .init(from: decoder))
                case "ToolSearchOutput", "#/components/schemas/ToolSearchOutput", "tool_search_output":
                    self = .toolSearchOutput(try .init(from: decoder))
                case "ReasoningItem", "#/components/schemas/ReasoningItem", "reasoning":
                    self = .reasoningItem(try .init(from: decoder))
                case "CompactionBody", "#/components/schemas/CompactionBody", "compaction":
                    self = .compactionBody(try .init(from: decoder))
                case "ImageGenToolCall", "#/components/schemas/ImageGenToolCall", "image_generation_call":
                    self = .imageGenToolCall(try .init(from: decoder))
                case "CodeInterpreterToolCall", "#/components/schemas/CodeInterpreterToolCall", "code_interpreter_call":
                    self = .codeInterpreterToolCall(try .init(from: decoder))
                case "LocalShellToolCall", "#/components/schemas/LocalShellToolCall", "local_shell_call":
                    self = .localShellToolCall(try .init(from: decoder))
                case "LocalShellToolCallOutput", "#/components/schemas/LocalShellToolCallOutput", "local_shell_call_output":
                    self = .localShellToolCallOutput(try .init(from: decoder))
                case "FunctionShellCall", "#/components/schemas/FunctionShellCall", "shell_call":
                    self = .functionShellCall(try .init(from: decoder))
                case "FunctionShellCallOutput", "#/components/schemas/FunctionShellCallOutput", "shell_call_output":
                    self = .functionShellCallOutput(try .init(from: decoder))
                case "ApplyPatchToolCall", "#/components/schemas/ApplyPatchToolCall", "apply_patch_call":
                    self = .applyPatchToolCall(try .init(from: decoder))
                case "ApplyPatchToolCallOutput", "#/components/schemas/ApplyPatchToolCallOutput", "apply_patch_call_output":
                    self = .applyPatchToolCallOutput(try .init(from: decoder))
                case "MCPListTools", "#/components/schemas/MCPListTools", "mcp_list_tools":
                    self = .mcpListTools(try .init(from: decoder))
                case "MCPApprovalRequest", "#/components/schemas/MCPApprovalRequest", "mcp_approval_request":
                    self = .mcpApprovalRequest(try .init(from: decoder))
                case "MCPApprovalResponseResource", "#/components/schemas/MCPApprovalResponseResource", "mcp_approval_response":
                    self = .mcpApprovalResponseResource(try .init(from: decoder))
                case "MCPToolCall", "#/components/schemas/MCPToolCall", "mcp_call":
                    self = .mcpToolCall(try .init(from: decoder))
                case "CustomToolCallResource", "#/components/schemas/CustomToolCallResource":
                    self = .customToolCallResource(try .init(from: decoder))
                case "CustomToolCallOutputResource", "#/components/schemas/CustomToolCallOutputResource":
                    self = .customToolCallOutputResource(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
                case let .toolSearchCall(value):
                    try value.encode(to: encoder)
                case let .toolSearchOutput(value):
                    try value.encode(to: encoder)
                case let .reasoningItem(value):
                    try value.encode(to: encoder)
                case let .compactionBody(value):
                    try value.encode(to: encoder)
                case let .imageGenToolCall(value):
                    try value.encode(to: encoder)
                case let .codeInterpreterToolCall(value):
                    try value.encode(to: encoder)
                case let .localShellToolCall(value):
                    try value.encode(to: encoder)
                case let .localShellToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .functionShellCall(value):
                    try value.encode(to: encoder)
                case let .functionShellCallOutput(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolCall(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .mcpListTools(value):
                    try value.encode(to: encoder)
                case let .mcpApprovalRequest(value):
                    try value.encode(to: encoder)
                case let .mcpApprovalResponseResource(value):
                    try value.encode(to: encoder)
                case let .mcpToolCall(value):
                    try value.encode(to: encoder)
                case let .customToolCallResource(value):
                    try value.encode(to: encoder)
                case let .customToolCallOutputResource(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A tool call to run a command on the local shell.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/LocalShellToolCall`.
        public struct LocalShellToolCall: Codable, Hashable, Sendable {
            /// The type of the local shell call. Always `local_shell_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case localShellCall = "local_shell_call"
            }
            /// The type of the local shell call. Always `local_shell_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/type`.
            public var _type: Components.Schemas.LocalShellToolCall._TypePayload
            /// The unique ID of the local shell call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/id`.
            public var id: Swift.String
            /// The unique ID of the local shell tool call generated by the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/call_id`.
            public var callId: Swift.String
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/action`.
            public var action: Components.Schemas.LocalShellExecAction
            /// The status of the local shell call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// The status of the local shell call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCall/status`.
            public var status: Components.Schemas.LocalShellToolCall.StatusPayload
            /// Creates a new `LocalShellToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the local shell call. Always `local_shell_call`.
            ///   - id: The unique ID of the local shell call.
            ///   - callId: The unique ID of the local shell tool call generated by the model.
            ///   - action:
            ///   - status: The status of the local shell call.
            public init(
                _type: Components.Schemas.LocalShellToolCall._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                action: Components.Schemas.LocalShellExecAction,
                status: Components.Schemas.LocalShellToolCall.StatusPayload
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.action = action
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case action
                case status
            }
        }
        /// The output of a local shell tool call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput`.
        public struct LocalShellToolCallOutput: Codable, Hashable, Sendable {
            /// The type of the local shell tool call output. Always `local_shell_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case localShellCallOutput = "local_shell_call_output"
            }
            /// The type of the local shell tool call output. Always `local_shell_call_output`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput/type`.
            public var _type: Components.Schemas.LocalShellToolCallOutput._TypePayload
            /// The unique ID of the local shell tool call generated by the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput/id`.
            public var id: Swift.String
            /// A JSON string of the output of the local shell tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput/output`.
            public var output: Swift.String
            /// The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput/status`.
            @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inProgress = "in_progress"
                case completed = "completed"
                case incomplete = "incomplete"
            }
            /// - Remark: Generated from `#/components/schemas/LocalShellToolCallOutput/status`.
            public var status: Components.Schemas.LocalShellToolCallOutput.StatusPayload?
            /// Creates a new `LocalShellToolCallOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the local shell tool call output. Always `local_shell_call_output`.
            ///   - id: The unique ID of the local shell tool call generated by the model.
            ///   - output: A JSON string of the output of the local shell tool call.
            ///   - status:
            public init(
                _type: Components.Schemas.LocalShellToolCallOutput._TypePayload,
                id: Swift.String,
                output: Swift.String,
                status: Components.Schemas.LocalShellToolCallOutput.StatusPayload? = nil
            ) {
                self._type = _type
                self.id = id
                self.output = output
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case output
                case status
            }
        }
        /// A request for human approval of a tool invocation.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest`.
        public struct MCPApprovalRequest: Codable, Hashable, Sendable {
            /// The type of the item. Always `mcp_approval_request`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcpApprovalRequest = "mcp_approval_request"
            }
            /// The type of the item. Always `mcp_approval_request`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest/type`.
            public var _type: Components.Schemas.MCPApprovalRequest._TypePayload
            /// The unique ID of the approval request.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest/id`.
            public var id: Swift.String
            /// The label of the MCP server making the request.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest/server_label`.
            public var serverLabel: Swift.String
            /// The name of the tool to run.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest/name`.
            public var name: Swift.String
            /// A JSON string of arguments for the tool.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalRequest/arguments`.
            public var arguments: Swift.String
            /// Creates a new `MCPApprovalRequest`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `mcp_approval_request`.
            ///   - id: The unique ID of the approval request.
            ///   - serverLabel: The label of the MCP server making the request.
            ///   - name: The name of the tool to run.
            ///   - arguments: A JSON string of arguments for the tool.
            public init(
                _type: Components.Schemas.MCPApprovalRequest._TypePayload,
                id: Swift.String,
                serverLabel: Swift.String,
                name: Swift.String,
                arguments: Swift.String
            ) {
                self._type = _type
                self.id = id
                self.serverLabel = serverLabel
                self.name = name
                self.arguments = arguments
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case serverLabel = "server_label"
                case name
                case arguments
            }
        }
        /// A response to an MCP approval request.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse`.
        public struct MCPApprovalResponse: Codable, Hashable, Sendable {
            /// The type of the item. Always `mcp_approval_response`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcpApprovalResponse = "mcp_approval_response"
            }
            /// The type of the item. Always `mcp_approval_response`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse/type`.
            public var _type: Components.Schemas.MCPApprovalResponse._TypePayload
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse/id`.
            public var id: Swift.String?
            /// The ID of the approval request being answered.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse/approval_request_id`.
            public var approvalRequestId: Swift.String
            /// Whether the request was approved.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse/approve`.
            public var approve: Swift.Bool
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponse/reason`.
            public var reason: Swift.String?
            /// Creates a new `MCPApprovalResponse`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `mcp_approval_response`.
            ///   - id:
            ///   - approvalRequestId: The ID of the approval request being answered.
            ///   - approve: Whether the request was approved.
            ///   - reason:
            public init(
                _type: Components.Schemas.MCPApprovalResponse._TypePayload,
                id: Swift.String? = nil,
                approvalRequestId: Swift.String,
                approve: Swift.Bool,
                reason: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.approvalRequestId = approvalRequestId
                self.approve = approve
                self.reason = reason
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case approvalRequestId = "approval_request_id"
                case approve
                case reason
            }
        }
        /// A response to an MCP approval request.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource`.
        public struct MCPApprovalResponseResource: Codable, Hashable, Sendable {
            /// The type of the item. Always `mcp_approval_response`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcpApprovalResponse = "mcp_approval_response"
            }
            /// The type of the item. Always `mcp_approval_response`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource/type`.
            public var _type: Components.Schemas.MCPApprovalResponseResource._TypePayload
            /// The unique ID of the approval response
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource/id`.
            public var id: Swift.String
            /// The ID of the approval request being answered.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource/approval_request_id`.
            public var approvalRequestId: Swift.String
            /// Whether the request was approved.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource/approve`.
            public var approve: Swift.Bool
            /// - Remark: Generated from `#/components/schemas/MCPApprovalResponseResource/reason`.
            public var reason: Swift.String?
            /// Creates a new `MCPApprovalResponseResource`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `mcp_approval_response`.
            ///   - id: The unique ID of the approval response
            ///   - approvalRequestId: The ID of the approval request being answered.
            ///   - approve: Whether the request was approved.
            ///   - reason:
            public init(
                _type: Components.Schemas.MCPApprovalResponseResource._TypePayload,
                id: Swift.String,
                approvalRequestId: Swift.String,
                approve: Swift.Bool,
                reason: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.approvalRequestId = approvalRequestId
                self.approve = approve
                self.reason = reason
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case approvalRequestId = "approval_request_id"
                case approve
                case reason
            }
        }
        /// A list of tools available on an MCP server.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPListTools`.
        public struct MCPListTools: Codable, Hashable, Sendable {
            /// The type of the item. Always `mcp_list_tools`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListTools/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcpListTools = "mcp_list_tools"
            }
            /// The type of the item. Always `mcp_list_tools`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListTools/type`.
            public var _type: Components.Schemas.MCPListTools._TypePayload
            /// The unique ID of the list.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListTools/id`.
            public var id: Swift.String
            /// The label of the MCP server.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListTools/server_label`.
            public var serverLabel: Swift.String
            /// The tools available on the server.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListTools/tools`.
            public var tools: [Components.Schemas.MCPListToolsTool]
            /// - Remark: Generated from `#/components/schemas/MCPListTools/error`.
            public var error: Swift.String?
            /// Creates a new `MCPListTools`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `mcp_list_tools`.
            ///   - id: The unique ID of the list.
            ///   - serverLabel: The label of the MCP server.
            ///   - tools: The tools available on the server.
            ///   - error:
            public init(
                _type: Components.Schemas.MCPListTools._TypePayload,
                id: Swift.String,
                serverLabel: Swift.String,
                tools: [Components.Schemas.MCPListToolsTool],
                error: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.serverLabel = serverLabel
                self.tools = tools
                self.error = error
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case serverLabel = "server_label"
                case tools
                case error
            }
        }
        /// A tool available on an MCP server.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPListToolsTool`.
        public struct MCPListToolsTool: Codable, Hashable, Sendable {
            /// The name of the tool.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListToolsTool/name`.
            public var name: Swift.String
            /// - Remark: Generated from `#/components/schemas/MCPListToolsTool/description`.
            public var description: Swift.String?
            /// The JSON schema describing the tool's input.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPListToolsTool/input_schema`.
            public var inputSchema: OpenAPIRuntime.OpenAPIObjectContainer
            public typealias OpenAPIObjectContainer = OpenAPIRuntime.OpenAPIObjectContainer
            /// - Remark: Generated from `#/components/schemas/MCPListToolsTool/annotations`.
            public var annotations: OpenAPIRuntime.OpenAPIObjectContainer?
            /// Creates a new `MCPListToolsTool`.
            ///
            /// - Parameters:
            ///   - name: The name of the tool.
            ///   - description:
            ///   - inputSchema: The JSON schema describing the tool's input.
            ///   - annotations:
            public init(
                name: Swift.String,
                description: Swift.String? = nil,
                inputSchema: OpenAPIRuntime.OpenAPIObjectContainer,
                annotations: OpenAPIRuntime.OpenAPIObjectContainer? = nil
            ) {
                self.name = name
                self.description = description
                self.inputSchema = inputSchema
                self.annotations = annotations
            }
            public enum CodingKeys: String, CodingKey {
                case name
                case description
                case inputSchema = "input_schema"
                case annotations
            }
        }
        /// Give the model access to additional tools via remote Model Context Protocol
        /// (MCP) servers. [Learn more about MCP](/docs/guides/tools-remote-mcp).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPTool`.
        public struct MCPTool: Codable, Hashable, Sendable {
            /// The type of the MCP tool. Always `mcp`.
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcp = "mcp"
            }
            /// The type of the MCP tool. Always `mcp`.
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/type`.
            public var _type: Components.Schemas.MCPTool._TypePayload
            /// A label for this MCP server, used to identify it in tool calls.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/server_label`.
            public var serverLabel: Swift.String
            /// The URL for the MCP server. One of `server_url` or `connector_id` must be
            /// provided.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/server_url`.
            public var serverUrl: Swift.String?
            /// Identifier for service connectors, like those available in ChatGPT. One of
            /// `server_url` or `connector_id` must be provided. Learn more about service
            /// connectors [here](/docs/guides/tools-remote-mcp#connectors).
            ///
            /// Currently supported `connector_id` values are:
            ///
            /// - Dropbox: `connector_dropbox`
            /// - Gmail: `connector_gmail`
            /// - Google Calendar: `connector_googlecalendar`
            /// - Google Drive: `connector_googledrive`
            /// - Microsoft Teams: `connector_microsoftteams`
            /// - Outlook Calendar: `connector_outlookcalendar`
            /// - Outlook Email: `connector_outlookemail`
            /// - SharePoint: `connector_sharepoint`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/connector_id`.
            @frozen public enum ConnectorIdPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case connectorDropbox = "connector_dropbox"
                case connectorGmail = "connector_gmail"
                case connectorGooglecalendar = "connector_googlecalendar"
                case connectorGoogledrive = "connector_googledrive"
                case connectorMicrosoftteams = "connector_microsoftteams"
                case connectorOutlookcalendar = "connector_outlookcalendar"
                case connectorOutlookemail = "connector_outlookemail"
                case connectorSharepoint = "connector_sharepoint"
            }
            /// Identifier for service connectors, like those available in ChatGPT. One of
            /// `server_url` or `connector_id` must be provided. Learn more about service
            /// connectors [here](/docs/guides/tools-remote-mcp#connectors).
            ///
            /// Currently supported `connector_id` values are:
            ///
            /// - Dropbox: `connector_dropbox`
            /// - Gmail: `connector_gmail`
            /// - Google Calendar: `connector_googlecalendar`
            /// - Google Drive: `connector_googledrive`
            /// - Microsoft Teams: `connector_microsoftteams`
            /// - Outlook Calendar: `connector_outlookcalendar`
            /// - Outlook Email: `connector_outlookemail`
            /// - SharePoint: `connector_sharepoint`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/connector_id`.
            public var connectorId: Components.Schemas.MCPTool.ConnectorIdPayload?
            /// An OAuth access token that can be used with a remote MCP server, either
            /// with a custom MCP server URL or a service connector. Your application
            /// must handle the OAuth authorization flow and provide the token here.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/authorization`.
            public var authorization: Swift.String?
            /// Optional description of the MCP server, used to provide more context.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/server_description`.
            public var serverDescription: Swift.String?
            /// Optional HTTP headers to send to the MCP server. Use for authentication
            /// or other purposes.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/headers`.
            public struct HeadersPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                public var additionalProperties: [String: Swift.String]
                /// Creates a new `HeadersPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                public init(additionalProperties: [String: Swift.String] = .init()) {
                    self.additionalProperties = additionalProperties
                }
                public init(from decoder: any Swift.Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// - Remark: Generated from `#/components/schemas/MCPTool/headers`.
            public var headers: Components.Schemas.MCPTool.HeadersPayload?
            /// List of allowed tool names or a filter object.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/allowed_tools`.
            @frozen public enum AllowedToolsPayload: Codable, Hashable, Sendable {
                /// A string array of allowed tool names
                ///
                /// - Remark: Generated from `#/components/schemas/MCPTool/allowed_tools/case1`.
                case case1([Swift.String])
                /// - Remark: Generated from `#/components/schemas/MCPTool/allowed_tools/case2`.
                case MCPToolFilter(Components.Schemas.MCPToolFilter)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
                    do {
                        self = .MCPToolFilter(try .init(from: decoder))
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .MCPToolFilter(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// - Remark: Generated from `#/components/schemas/MCPTool/allowed_tools`.
            public var allowedTools: Components.Schemas.MCPTool.AllowedToolsPayload?
            /// Specify which of the MCP server's tools require approval.
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval`.
            @frozen public enum RequireApprovalPayload: Codable, Hashable, Sendable {
                /// Specify which of the MCP server's tools require approval. Can be
                /// `always`, `never`, or a filter object associated with tools
                /// that require approval.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval/case1`.
                public struct Case1Payload: Codable, Hashable, Sendable {
                    /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval/case1/always`.
                    public var always: Components.Schemas.MCPToolFilter?
                    /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval/case1/never`.
                    public var never: Components.Schemas.MCPToolFilter?
                    /// Creates a new `Case1Payload`.
                    ///
                    /// - Parameters:
                    ///   - always:
                    ///   - never:
                    public init(
                        always: Components.Schemas.MCPToolFilter? = nil,
                        never: Components.Schemas.MCPToolFilter? = nil
                    ) {
                        self.always = always
                        self.never = never
                    }
                    public enum CodingKeys: String, CodingKey {
                        case always
                        case never
                    }
                    public init(from decoder: any Swift.Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        self.always = try container.decodeIfPresent(
                            Components.Schemas.MCPToolFilter.self,
                            forKey: .always
                        )
                        self.never = try container.decodeIfPresent(
                            Components.Schemas.MCPToolFilter.self,
                            forKey: .never
                        )
                        try decoder.ensureNoAdditionalProperties(knownKeys: [
                            "always",
                            "never"
                        ])
                    }
                }
                /// Specify which of the MCP server's tools require approval. Can be
                /// `always`, `never`, or a filter object associated with tools
                /// that require approval.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval/case1`.
                case case1(Components.Schemas.MCPTool.RequireApprovalPayload.Case1Payload)
                /// Specify a single approval policy for all tools. One of `always` or
                /// `never`. When set to `always`, all tools will require approval. When
                /// set to `never`, all tools will not require approval.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval/case2`.
                @frozen public enum Case2Payload: String, Codable, Hashable, Sendable, CaseIterable {
                    case always = "always"
                    case never = "never"
                }
                /// Specify a single approval policy for all tools. One of `always` or
                /// `never`. When set to `always`, all tools will require approval. When
                /// set to `never`, all tools will not require approval.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval/case2`.
                case case2(Components.Schemas.MCPTool.RequireApprovalPayload.Case2Payload)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
                    do {
                        self = .case1(try .init(from: decoder))
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try value.encode(to: encoder)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// - Remark: Generated from `#/components/schemas/MCPTool/require_approval`.
            public var requireApproval: Components.Schemas.MCPTool.RequireApprovalPayload?
            /// Whether this MCP tool is deferred and discovered via tool search.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPTool/defer_loading`.
            public var deferLoading: Swift.Bool?
            /// Creates a new `MCPTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the MCP tool. Always `mcp`.
            ///   - serverLabel: A label for this MCP server, used to identify it in tool calls.
            ///   - serverUrl: The URL for the MCP server. One of `server_url` or `connector_id` must be
            ///   - connectorId: Identifier for service connectors, like those available in ChatGPT. One of
            ///   - authorization: An OAuth access token that can be used with a remote MCP server, either
            ///   - serverDescription: Optional description of the MCP server, used to provide more context.
            ///   - headers:
            ///   - allowedTools:
            ///   - requireApproval:
            ///   - deferLoading: Whether this MCP tool is deferred and discovered via tool search.
            public init(
                _type: Components.Schemas.MCPTool._TypePayload,
                serverLabel: Swift.String,
                serverUrl: Swift.String? = nil,
                connectorId: Components.Schemas.MCPTool.ConnectorIdPayload? = nil,
                authorization: Swift.String? = nil,
                serverDescription: Swift.String? = nil,
                headers: Components.Schemas.MCPTool.HeadersPayload? = nil,
                allowedTools: Components.Schemas.MCPTool.AllowedToolsPayload? = nil,
                requireApproval: Components.Schemas.MCPTool.RequireApprovalPayload? = nil,
                deferLoading: Swift.Bool? = nil
            ) {
                self._type = _type
                self.serverLabel = serverLabel
                self.serverUrl = serverUrl
                self.connectorId = connectorId
                self.authorization = authorization
                self.serverDescription = serverDescription
                self.headers = headers
                self.allowedTools = allowedTools
                self.requireApproval = requireApproval
                self.deferLoading = deferLoading
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case serverLabel = "server_label"
                case serverUrl = "server_url"
                case connectorId = "connector_id"
                case authorization
                case serverDescription = "server_description"
                case headers
                case allowedTools = "allowed_tools"
                case requireApproval = "require_approval"
                case deferLoading = "defer_loading"
            }
        }
        /// An invocation of a tool on an MCP server.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPToolCall`.
        public struct MCPToolCall: Codable, Hashable, Sendable {
            /// The type of the item. Always `mcp_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcpCall = "mcp_call"
            }
            /// The type of the item. Always `mcp_call`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/type`.
            public var _type: Components.Schemas.MCPToolCall._TypePayload
            /// The unique ID of the tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/id`.
            public var id: Swift.String
            /// The label of the MCP server running the tool.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/server_label`.
            public var serverLabel: Swift.String
            /// The name of the tool that was run.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/name`.
            public var name: Swift.String
            /// A JSON string of the arguments passed to the tool.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/arguments`.
            public var arguments: Swift.String
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/output`.
            public var output: Swift.String?
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/error`.
            public var error: Swift.String?
            /// The status of the tool call. One of `in_progress`, `completed`, `incomplete`, `calling`, or `failed`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/status`.
            public var status: Components.Schemas.MCPToolCallStatus?
            /// - Remark: Generated from `#/components/schemas/MCPToolCall/approval_request_id`.
            public var approvalRequestId: Swift.String?
            /// Creates a new `MCPToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `mcp_call`.
            ///   - id: The unique ID of the tool call.
            ///   - serverLabel: The label of the MCP server running the tool.
            ///   - name: The name of the tool that was run.
            ///   - arguments: A JSON string of the arguments passed to the tool.
            ///   - output:
            ///   - error:
            ///   - status: The status of the tool call. One of `in_progress`, `completed`, `incomplete`, `calling`, or `failed`.
            ///   - approvalRequestId:
            public init(
                _type: Components.Schemas.MCPToolCall._TypePayload,
                id: Swift.String,
                serverLabel: Swift.String,
                name: Swift.String,
                arguments: Swift.String,
                output: Swift.String? = nil,
                error: Swift.String? = nil,
                status: Components.Schemas.MCPToolCallStatus? = nil,
                approvalRequestId: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.serverLabel = serverLabel
                self.name = name
                self.arguments = arguments
                self.output = output
                self.error = error
                self.status = status
                self.approvalRequestId = approvalRequestId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case serverLabel = "server_label"
                case name
                case arguments
                case output
                case error
                case status
                case approvalRequestId = "approval_request_id"
            }
        }
        /// A filter object to specify which tools are allowed.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MCPToolFilter`.
        public struct MCPToolFilter: Codable, Hashable, Sendable {
            /// List of allowed tool names.
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolFilter/tool_names`.
            public var toolNames: [Swift.String]?
            /// Indicates whether or not a tool modifies data or is read-only. If an
            /// MCP server is [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
            /// it will match this filter.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/MCPToolFilter/read_only`.
            public var readOnly: Swift.Bool?
            /// Creates a new `MCPToolFilter`.
            ///
            /// - Parameters:
            ///   - toolNames: List of allowed tool names.
            ///   - readOnly: Indicates whether or not a tool modifies data or is read-only. If an
            public init(
                toolNames: [Swift.String]? = nil,
                readOnly: Swift.Bool? = nil
            ) {
                self.toolNames = toolNames
                self.readOnly = readOnly
            }
            public enum CodingKeys: String, CodingKey {
                case toolNames = "tool_names"
                case readOnly = "read_only"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.toolNames = try container.decodeIfPresent(
                    [Swift.String].self,
                    forKey: .toolNames
                )
                self.readOnly = try container.decodeIfPresent(
                    Swift.Bool.self,
                    forKey: .readOnly
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "tool_names",
                    "read_only"
                ])
            }
        }
        /// Labels an `assistant` message as intermediate commentary (`commentary`) or the final answer (`final_answer`).
        /// For models like `gpt-5.3-codex` and beyond, when sending follow-up requests, preserve and resend
        /// phase on all assistant messages — dropping it can degrade performance. Not used for user messages.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/MessagePhase`.
        @frozen public enum MessagePhase: String, Codable, Hashable, Sendable, CaseIterable {
            case commentary = "commentary"
            case finalAnswer = "final_answer"
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
            public init(from decoder: any Swift.Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
                case o3Pro = "o3-pro"
                case o3Pro20250610 = "o3-pro-2025-06-10"
                case o3DeepResearch = "o3-deep-research"
                case o3DeepResearch20250626 = "o3-deep-research-2025-06-26"
                case o4MiniDeepResearch = "o4-mini-deep-research"
                case o4MiniDeepResearch20250626 = "o4-mini-deep-research-2025-06-26"
                case computerUsePreview = "computer-use-preview"
                case computerUsePreview20250311 = "computer-use-preview-2025-03-11"
                case gpt5Codex = "gpt-5-codex"
                case gpt5Pro = "gpt-5-pro"
                case gpt5Pro20251006 = "gpt-5-pro-2025-10-06"
                case gpt5_1CodexMax = "gpt-5.1-codex-max"
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
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
            public func encode(to encoder: any Swift.Encoder) throws {
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
                case gpt5_4 = "gpt-5.4"
                case gpt5_4Mini = "gpt-5.4-mini"
                case gpt5_4Nano = "gpt-5.4-nano"
                case gpt5_4Mini20260317 = "gpt-5.4-mini-2026-03-17"
                case gpt5_4Nano20260317 = "gpt-5.4-nano-2026-03-17"
                case gpt5_3ChatLatest = "gpt-5.3-chat-latest"
                case gpt5_2 = "gpt-5.2"
                case gpt5_220251211 = "gpt-5.2-2025-12-11"
                case gpt5_2ChatLatest = "gpt-5.2-chat-latest"
                case gpt5_2Pro = "gpt-5.2-pro"
                case gpt5_2Pro20251211 = "gpt-5.2-pro-2025-12-11"
                case gpt5_1 = "gpt-5.1"
                case gpt5_120251113 = "gpt-5.1-2025-11-13"
                case gpt5_1Codex = "gpt-5.1-codex"
                case gpt5_1Mini = "gpt-5.1-mini"
                case gpt5_1ChatLatest = "gpt-5.1-chat-latest"
                case gpt5 = "gpt-5"
                case gpt5Mini = "gpt-5-mini"
                case gpt5Nano = "gpt-5-nano"
                case gpt520250807 = "gpt-5-2025-08-07"
                case gpt5Mini20250807 = "gpt-5-mini-2025-08-07"
                case gpt5Nano20250807 = "gpt-5-nano-2025-08-07"
                case gpt5ChatLatest = "gpt-5-chat-latest"
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
                case gpt4oAudioPreview20250603 = "gpt-4o-audio-preview-2025-06-03"
                case gpt4oMiniAudioPreview = "gpt-4o-mini-audio-preview"
                case gpt4oMiniAudioPreview20241217 = "gpt-4o-mini-audio-preview-2024-12-17"
                case gpt4oSearchPreview = "gpt-4o-search-preview"
                case gpt4oMiniSearchPreview = "gpt-4o-mini-search-preview"
                case gpt4oSearchPreview20250311 = "gpt-4o-search-preview-2025-03-11"
                case gpt4oMiniSearchPreview20250311 = "gpt-4o-mini-search-preview-2025-03-11"
                case chatgpt4oLatest = "chatgpt-4o-latest"
                case codexMiniLatest = "codex-mini-latest"
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
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
            public func encode(to encoder: any Swift.Encoder) throws {
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
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/top_logprobs`.
            public var topLogprobs: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/temperature`.
            public var temperature: Swift.Double?
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/top_p`.
            public var topP: Swift.Double?
            /// This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching optimizations.
            /// A stable identifier for your end-users.
            /// Used to boost cache hit rates by better bucketing similar requests and  to help OpenAI detect and prevent abuse. [Learn more](/docs/guides/safety-best-practices#safety-identifiers).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/user`.
            @available(*, deprecated)
            public var user: Swift.String?
            /// A stable identifier used to help detect users of your application that may be violating OpenAI's usage policies.
            /// The IDs should be a string that uniquely identifies each user, with a maximum length of 64 characters. We recommend hashing their username or email address, in order to avoid sending us any identifying information. [Learn more](/docs/guides/safety-best-practices#safety-identifiers).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/safety_identifier`.
            public var safetyIdentifier: Swift.String?
            /// Used by OpenAI to cache responses for similar requests to optimize your cache hit rates. Replaces the `user` field. [Learn more](/docs/guides/prompt-caching).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/prompt_cache_key`.
            public var promptCacheKey: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/service_tier`.
            public var serviceTier: Components.Schemas.ServiceTier?
            /// The retention policy for the prompt cache. Set to `24h` to enable extended prompt caching, which keeps cached prefixes active for longer, up to a maximum of 24 hours. [Learn more](/docs/guides/prompt-caching#prompt-cache-retention).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/prompt_cache_retention`.
            @frozen public enum PromptCacheRetentionPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inMemory = "in_memory"
                case _24h = "24h"
            }
            /// - Remark: Generated from `#/components/schemas/ModelResponseProperties/prompt_cache_retention`.
            public var promptCacheRetention: Components.Schemas.ModelResponseProperties.PromptCacheRetentionPayload?
            /// Creates a new `ModelResponseProperties`.
            ///
            /// - Parameters:
            ///   - metadata:
            ///   - topLogprobs:
            ///   - temperature:
            ///   - topP:
            ///   - user: This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching optimizations.
            ///   - safetyIdentifier: A stable identifier used to help detect users of your application that may be violating OpenAI's usage policies.
            ///   - promptCacheKey: Used by OpenAI to cache responses for similar requests to optimize your cache hit rates. Replaces the `user` field. [Learn more](/docs/guides/prompt-caching).
            ///   - serviceTier:
            ///   - promptCacheRetention:
            public init(
                metadata: Components.Schemas.Metadata? = nil,
                topLogprobs: Swift.Int? = nil,
                temperature: Swift.Double? = nil,
                topP: Swift.Double? = nil,
                user: Swift.String? = nil,
                safetyIdentifier: Swift.String? = nil,
                promptCacheKey: Swift.String? = nil,
                serviceTier: Components.Schemas.ServiceTier? = nil,
                promptCacheRetention: Components.Schemas.ModelResponseProperties.PromptCacheRetentionPayload? = nil
            ) {
                self.metadata = metadata
                self.topLogprobs = topLogprobs
                self.temperature = temperature
                self.topP = topP
                self.user = user
                self.safetyIdentifier = safetyIdentifier
                self.promptCacheKey = promptCacheKey
                self.serviceTier = serviceTier
                self.promptCacheRetention = promptCacheRetention
            }
            public enum CodingKeys: String, CodingKey {
                case metadata
                case topLogprobs = "top_logprobs"
                case temperature
                case topP = "top_p"
                case user
                case safetyIdentifier = "safety_identifier"
                case promptCacheKey = "prompt_cache_key"
                case serviceTier = "service_tier"
                case promptCacheRetention = "prompt_cache_retention"
            }
        }
        /// - Remark: Generated from `#/components/schemas/OutputContent`.
        @frozen public enum OutputContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/OutputContent/OutputTextContent`.
            case outputTextContent(Components.Schemas.OutputTextContent)
            /// - Remark: Generated from `#/components/schemas/OutputContent/RefusalContent`.
            case refusalContent(Components.Schemas.RefusalContent)
            /// - Remark: Generated from `#/components/schemas/OutputContent/ReasoningTextContent`.
            case reasoningTextContent(Components.Schemas.ReasoningTextContent)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "OutputTextContent", "#/components/schemas/OutputTextContent", "output_text":
                    self = .outputTextContent(try .init(from: decoder))
                case "RefusalContent", "#/components/schemas/RefusalContent", "refusal":
                    self = .refusalContent(try .init(from: decoder))
                case "ReasoningTextContent", "#/components/schemas/ReasoningTextContent", "reasoning_text":
                    self = .reasoningTextContent(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .outputTextContent(value):
                    try value.encode(to: encoder)
                case let .refusalContent(value):
                    try value.encode(to: encoder)
                case let .reasoningTextContent(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// - Remark: Generated from `#/components/schemas/OutputItem`.
        @frozen public enum OutputItem: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/OutputItem/OutputMessage`.
            case outputMessage(Components.Schemas.OutputMessage)
            /// - Remark: Generated from `#/components/schemas/OutputItem/FileSearchToolCall`.
            case fileSearchToolCall(Components.Schemas.FileSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/FunctionToolCall`.
            case functionToolCall(Components.Schemas.FunctionToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/FunctionToolCallOutputResource`.
            case functionToolCallOutputResource(Components.Schemas.FunctionToolCallOutputResource)
            /// - Remark: Generated from `#/components/schemas/OutputItem/WebSearchToolCall`.
            case webSearchToolCall(Components.Schemas.WebSearchToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ComputerToolCall`.
            case computerToolCall(Components.Schemas.ComputerToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ComputerToolCallOutputResource`.
            case computerToolCallOutputResource(Components.Schemas.ComputerToolCallOutputResource)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ReasoningItem`.
            case reasoningItem(Components.Schemas.ReasoningItem)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ToolSearchCall`.
            case toolSearchCall(Components.Schemas.ToolSearchCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ToolSearchOutput`.
            case toolSearchOutput(Components.Schemas.ToolSearchOutput)
            /// - Remark: Generated from `#/components/schemas/OutputItem/CompactionBody`.
            case compactionBody(Components.Schemas.CompactionBody)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ImageGenToolCall`.
            case imageGenToolCall(Components.Schemas.ImageGenToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/CodeInterpreterToolCall`.
            case codeInterpreterToolCall(Components.Schemas.CodeInterpreterToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/LocalShellToolCall`.
            case localShellToolCall(Components.Schemas.LocalShellToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/LocalShellToolCallOutput`.
            case localShellToolCallOutput(Components.Schemas.LocalShellToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/OutputItem/FunctionShellCall`.
            case functionShellCall(Components.Schemas.FunctionShellCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/FunctionShellCallOutput`.
            case functionShellCallOutput(Components.Schemas.FunctionShellCallOutput)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ApplyPatchToolCall`.
            case applyPatchToolCall(Components.Schemas.ApplyPatchToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/ApplyPatchToolCallOutput`.
            case applyPatchToolCallOutput(Components.Schemas.ApplyPatchToolCallOutput)
            /// - Remark: Generated from `#/components/schemas/OutputItem/MCPToolCall`.
            case mcpToolCall(Components.Schemas.MCPToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/MCPListTools`.
            case mcpListTools(Components.Schemas.MCPListTools)
            /// - Remark: Generated from `#/components/schemas/OutputItem/MCPApprovalRequest`.
            case mcpApprovalRequest(Components.Schemas.MCPApprovalRequest)
            /// - Remark: Generated from `#/components/schemas/OutputItem/MCPApprovalResponseResource`.
            case mcpApprovalResponseResource(Components.Schemas.MCPApprovalResponseResource)
            /// - Remark: Generated from `#/components/schemas/OutputItem/CustomToolCall`.
            case customToolCall(Components.Schemas.CustomToolCall)
            /// - Remark: Generated from `#/components/schemas/OutputItem/CustomToolCallOutputResource`.
            case customToolCallOutputResource(Components.Schemas.CustomToolCallOutputResource)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "OutputMessage", "#/components/schemas/OutputMessage", "message":
                    self = .outputMessage(try .init(from: decoder))
                case "FileSearchToolCall", "#/components/schemas/FileSearchToolCall", "file_search_call":
                    self = .fileSearchToolCall(try .init(from: decoder))
                case "FunctionToolCall", "#/components/schemas/FunctionToolCall", "function_call":
                    self = .functionToolCall(try .init(from: decoder))
                case "FunctionToolCallOutputResource", "#/components/schemas/FunctionToolCallOutputResource":
                    self = .functionToolCallOutputResource(try .init(from: decoder))
                case "WebSearchToolCall", "#/components/schemas/WebSearchToolCall", "web_search_call":
                    self = .webSearchToolCall(try .init(from: decoder))
                case "ComputerToolCall", "#/components/schemas/ComputerToolCall", "computer_call":
                    self = .computerToolCall(try .init(from: decoder))
                case "ComputerToolCallOutputResource", "#/components/schemas/ComputerToolCallOutputResource":
                    self = .computerToolCallOutputResource(try .init(from: decoder))
                case "ReasoningItem", "#/components/schemas/ReasoningItem", "reasoning":
                    self = .reasoningItem(try .init(from: decoder))
                case "ToolSearchCall", "#/components/schemas/ToolSearchCall", "tool_search_call":
                    self = .toolSearchCall(try .init(from: decoder))
                case "ToolSearchOutput", "#/components/schemas/ToolSearchOutput", "tool_search_output":
                    self = .toolSearchOutput(try .init(from: decoder))
                case "CompactionBody", "#/components/schemas/CompactionBody", "compaction":
                    self = .compactionBody(try .init(from: decoder))
                case "ImageGenToolCall", "#/components/schemas/ImageGenToolCall", "image_generation_call":
                    self = .imageGenToolCall(try .init(from: decoder))
                case "CodeInterpreterToolCall", "#/components/schemas/CodeInterpreterToolCall", "code_interpreter_call":
                    self = .codeInterpreterToolCall(try .init(from: decoder))
                case "LocalShellToolCall", "#/components/schemas/LocalShellToolCall", "local_shell_call":
                    self = .localShellToolCall(try .init(from: decoder))
                case "LocalShellToolCallOutput", "#/components/schemas/LocalShellToolCallOutput", "local_shell_call_output":
                    self = .localShellToolCallOutput(try .init(from: decoder))
                case "FunctionShellCall", "#/components/schemas/FunctionShellCall", "shell_call":
                    self = .functionShellCall(try .init(from: decoder))
                case "FunctionShellCallOutput", "#/components/schemas/FunctionShellCallOutput", "shell_call_output":
                    self = .functionShellCallOutput(try .init(from: decoder))
                case "ApplyPatchToolCall", "#/components/schemas/ApplyPatchToolCall", "apply_patch_call":
                    self = .applyPatchToolCall(try .init(from: decoder))
                case "ApplyPatchToolCallOutput", "#/components/schemas/ApplyPatchToolCallOutput", "apply_patch_call_output":
                    self = .applyPatchToolCallOutput(try .init(from: decoder))
                case "MCPToolCall", "#/components/schemas/MCPToolCall", "mcp_call":
                    self = .mcpToolCall(try .init(from: decoder))
                case "MCPListTools", "#/components/schemas/MCPListTools", "mcp_list_tools":
                    self = .mcpListTools(try .init(from: decoder))
                case "MCPApprovalRequest", "#/components/schemas/MCPApprovalRequest", "mcp_approval_request":
                    self = .mcpApprovalRequest(try .init(from: decoder))
                case "MCPApprovalResponseResource", "#/components/schemas/MCPApprovalResponseResource", "mcp_approval_response":
                    self = .mcpApprovalResponseResource(try .init(from: decoder))
                case "CustomToolCall", "#/components/schemas/CustomToolCall", "custom_tool_call":
                    self = .customToolCall(try .init(from: decoder))
                case "CustomToolCallOutputResource", "#/components/schemas/CustomToolCallOutputResource":
                    self = .customToolCallOutputResource(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .outputMessage(value):
                    try value.encode(to: encoder)
                case let .fileSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .functionToolCall(value):
                    try value.encode(to: encoder)
                case let .functionToolCallOutputResource(value):
                    try value.encode(to: encoder)
                case let .webSearchToolCall(value):
                    try value.encode(to: encoder)
                case let .computerToolCall(value):
                    try value.encode(to: encoder)
                case let .computerToolCallOutputResource(value):
                    try value.encode(to: encoder)
                case let .reasoningItem(value):
                    try value.encode(to: encoder)
                case let .toolSearchCall(value):
                    try value.encode(to: encoder)
                case let .toolSearchOutput(value):
                    try value.encode(to: encoder)
                case let .compactionBody(value):
                    try value.encode(to: encoder)
                case let .imageGenToolCall(value):
                    try value.encode(to: encoder)
                case let .codeInterpreterToolCall(value):
                    try value.encode(to: encoder)
                case let .localShellToolCall(value):
                    try value.encode(to: encoder)
                case let .localShellToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .functionShellCall(value):
                    try value.encode(to: encoder)
                case let .functionShellCallOutput(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolCall(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolCallOutput(value):
                    try value.encode(to: encoder)
                case let .mcpToolCall(value):
                    try value.encode(to: encoder)
                case let .mcpListTools(value):
                    try value.encode(to: encoder)
                case let .mcpApprovalRequest(value):
                    try value.encode(to: encoder)
                case let .mcpApprovalResponseResource(value):
                    try value.encode(to: encoder)
                case let .customToolCall(value):
                    try value.encode(to: encoder)
                case let .customToolCallOutputResource(value):
                    try value.encode(to: encoder)
                }
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
            public var content: [Components.Schemas.OutputMessageContent]
            /// - Remark: Generated from `#/components/schemas/MessagePhase`.
            public typealias MessagePhase = Components.Schemas.MessagePhase
            /// - Remark: Generated from `#/components/schemas/OutputMessage/phase`.
            public var phase: Components.Schemas.MessagePhase?
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
            ///   - phase:
            ///   - status: The status of the message input. One of `in_progress`, `completed`, or
            public init(
                id: Swift.String,
                _type: Components.Schemas.OutputMessage._TypePayload,
                role: Components.Schemas.OutputMessage.RolePayload,
                content: [Components.Schemas.OutputMessageContent],
                phase: Components.Schemas.MessagePhase? = nil,
                status: Components.Schemas.OutputMessage.StatusPayload
            ) {
                self.id = id
                self._type = _type
                self.role = role
                self.content = content
                self.phase = phase
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case role
                case content
                case phase
                case status
            }
        }
        /// - Remark: Generated from `#/components/schemas/OutputMessageContent`.
        @frozen public enum OutputMessageContent: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/OutputMessageContent/OutputTextContent`.
            case outputTextContent(Components.Schemas.OutputTextContent)
            /// - Remark: Generated from `#/components/schemas/OutputMessageContent/RefusalContent`.
            case refusalContent(Components.Schemas.RefusalContent)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "OutputTextContent", "#/components/schemas/OutputTextContent", "output_text":
                    self = .outputTextContent(try .init(from: decoder))
                case "RefusalContent", "#/components/schemas/RefusalContent", "refusal":
                    self = .refusalContent(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .outputTextContent(value):
                    try value.encode(to: encoder)
                case let .refusalContent(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// Reference to a prompt template and its variables.
        /// [Learn more](/docs/guides/text?api-mode=responses#reusable-prompts).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Prompt`.
        public struct Prompt: Codable, Hashable, Sendable {
            /// The unique identifier of the prompt template to use.
            ///
            /// - Remark: Generated from `#/components/schemas/Prompt/id`.
            public var id: Swift.String
            /// - Remark: Generated from `#/components/schemas/Prompt/version`.
            public var version: Swift.String?
            /// - Remark: Generated from `#/components/schemas/Prompt/variables`.
            public var variables: Components.Schemas.ResponsePromptVariables?
            /// Creates a new `Prompt`.
            ///
            /// - Parameters:
            ///   - id: The unique identifier of the prompt template to use.
            ///   - version:
            ///   - variables:
            public init(
                id: Swift.String,
                version: Swift.String? = nil,
                variables: Components.Schemas.ResponsePromptVariables? = nil
            ) {
                self.id = id
                self.version = version
                self.variables = variables
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case version
                case variables
            }
        }
        /// **gpt-5 and o-series models only**
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
            /// `concise` is supported for `computer-use-preview` models and all reasoning models after `gpt-5`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/Reasoning/summary`.
            @frozen public enum SummaryPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case concise = "concise"
                case detailed = "detailed"
            }
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
            /// - Remark: Generated from `#/components/schemas/Reasoning/generate_summary`.
            public var generateSummary: Components.Schemas.Reasoning.GenerateSummaryPayload?
            /// Creates a new `Reasoning`.
            ///
            /// - Parameters:
            ///   - effort:
            ///   - summary:
            ///   - generateSummary:
            public init(
                effort: Components.Schemas.ReasoningEffort? = nil,
                summary: Components.Schemas.Reasoning.SummaryPayload? = nil,
                generateSummary: Components.Schemas.Reasoning.GenerateSummaryPayload? = nil
            ) {
                self.effort = effort
                self.summary = summary
                self.generateSummary = generateSummary
            }
            public enum CodingKeys: String, CodingKey {
                case effort
                case summary
                case generateSummary = "generate_summary"
            }
        }
        /// Constrains effort on reasoning for
        /// [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        /// Currently supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`. Reducing
        /// reasoning effort can result in faster responses and fewer tokens used
        /// on reasoning in a response.
        ///
        /// - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool calls are supported for all reasoning values in gpt-5.1.
        /// - All models before `gpt-5.1` default to `medium` reasoning effort, and do not support `none`.
        /// - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
        /// - `xhigh` is supported for all models after `gpt-5.1-codex-max`.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ReasoningEffort`.
        @frozen public enum ReasoningEffort: String, Codable, Hashable, Sendable, CaseIterable {
            case none = "none"
            case minimal = "minimal"
            case low = "low"
            case medium = "medium"
            case high = "high"
            case xhigh = "xhigh"
        }
        /// A description of the chain of thought used by a reasoning model while generating
        /// a response. Be sure to include these items in your `input` to the Responses API
        /// for subsequent turns of a conversation if you are manually
        /// [managing context](/docs/guides/conversation-state).
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
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/encrypted_content`.
            public var encryptedContent: Swift.String?
            /// Reasoning summary content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/summary`.
            public var summary: [Components.Schemas.SummaryTextContent]
            /// Reasoning text content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningItem/content`.
            public var content: [Components.Schemas.ReasoningTextContent]?
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
            ///   - encryptedContent:
            ///   - summary: Reasoning summary content.
            ///   - content: Reasoning text content.
            ///   - status: The status of the item. One of `in_progress`, `completed`, or
            public init(
                _type: Components.Schemas.ReasoningItem._TypePayload,
                id: Swift.String,
                encryptedContent: Swift.String? = nil,
                summary: [Components.Schemas.SummaryTextContent],
                content: [Components.Schemas.ReasoningTextContent]? = nil,
                status: Components.Schemas.ReasoningItem.StatusPayload? = nil
            ) {
                self._type = _type
                self.id = id
                self.encryptedContent = encryptedContent
                self.summary = summary
                self.content = content
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case encryptedContent = "encrypted_content"
                case summary
                case content
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
                /// `in_progress`, `cancelled`, `queued`, or `incomplete`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/status`.
                @frozen public enum StatusPayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case completed = "completed"
                    case failed = "failed"
                    case inProgress = "in_progress"
                    case cancelled = "cancelled"
                    case queued = "queued"
                    case incomplete = "incomplete"
                }
                /// The status of the response generation. One of `completed`, `failed`,
                /// `in_progress`, `cancelled`, `queued`, or `incomplete`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/status`.
                public var status: Components.Schemas.Response.Value3Payload.StatusPayload?
                /// Unix timestamp (in seconds) of when this Response was created.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/created_at`.
                public var createdAt: Swift.Double
                /// - Remark: Generated from `#/components/schemas/Response/value3/completed_at`.
                public var completedAt: Swift.Double?
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
                /// A system (or developer) message inserted into the model's context.
                ///
                /// When using along with `previous_response_id`, the instructions from a previous
                /// response will not be carried over to the next response. This makes it simple
                /// to swap out system (or developer) messages in new responses.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/instructions`.
                @frozen public enum InstructionsPayload: Codable, Hashable, Sendable {
                    /// A text input to the model, equivalent to a text input with the
                    /// `developer` role.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/Response/value3/instructions/case1`.
                    case case1(Swift.String)
                    /// A list of one or many input items to the model, containing
                    /// different content types.
                    ///
                    ///
                    /// - Remark: Generated from `#/components/schemas/Response/value3/instructions/case2`.
                    case case2([Components.Schemas.InputItem])
                    public init(from decoder: any Swift.Decoder) throws {
                        var errors: [any Swift.Error] = []
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
                    public func encode(to encoder: any Swift.Encoder) throws {
                        switch self {
                        case let .case1(value):
                            try encoder.encodeToSingleValueContainer(value)
                        case let .case2(value):
                            try encoder.encodeToSingleValueContainer(value)
                        }
                    }
                }
                /// - Remark: Generated from `#/components/schemas/Response/value3/instructions`.
                public var instructions: Components.Schemas.Response.Value3Payload.InstructionsPayload?
                /// - Remark: Generated from `#/components/schemas/Response/value3/output_text`.
                public var outputText: Swift.String?
                /// - Remark: Generated from `#/components/schemas/Response/value3/usage`.
                public var usage: Components.Schemas.ResponseUsage?
                /// Whether to allow the model to run tool calls in parallel.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/Response/value3/parallel_tool_calls`.
                public var parallelToolCalls: Swift.Bool
                /// - Remark: Generated from `#/components/schemas/Conversation-2`.
                public typealias Conversation2 = Components.Schemas.Conversation2
                /// - Remark: Generated from `#/components/schemas/Response/value3/conversation`.
                public var conversation: Components.Schemas.Conversation2?
                /// - Remark: Generated from `#/components/schemas/Response/value3/max_output_tokens`.
                public var maxOutputTokens: Swift.Int?
                /// Creates a new `Value3Payload`.
                ///
                /// - Parameters:
                ///   - id: Unique identifier for this Response.
                ///   - object: The object type of this resource - always set to `response`.
                ///   - status: The status of the response generation. One of `completed`, `failed`,
                ///   - createdAt: Unix timestamp (in seconds) of when this Response was created.
                ///   - completedAt:
                ///   - error:
                ///   - incompleteDetails:
                ///   - output: An array of content items generated by the model.
                ///   - instructions:
                ///   - outputText:
                ///   - usage:
                ///   - parallelToolCalls: Whether to allow the model to run tool calls in parallel.
                ///   - conversation:
                ///   - maxOutputTokens:
                public init(
                    id: Swift.String,
                    object: Components.Schemas.Response.Value3Payload.ObjectPayload,
                    status: Components.Schemas.Response.Value3Payload.StatusPayload? = nil,
                    createdAt: Swift.Double,
                    completedAt: Swift.Double? = nil,
                    error: Components.Schemas.ResponseError? = nil,
                    incompleteDetails: Components.Schemas.Response.Value3Payload.IncompleteDetailsPayload? = nil,
                    output: [Components.Schemas.OutputItem],
                    instructions: Components.Schemas.Response.Value3Payload.InstructionsPayload? = nil,
                    outputText: Swift.String? = nil,
                    usage: Components.Schemas.ResponseUsage? = nil,
                    parallelToolCalls: Swift.Bool,
                    conversation: Components.Schemas.Conversation2? = nil,
                    maxOutputTokens: Swift.Int? = nil
                ) {
                    self.id = id
                    self.object = object
                    self.status = status
                    self.createdAt = createdAt
                    self.completedAt = completedAt
                    self.error = error
                    self.incompleteDetails = incompleteDetails
                    self.output = output
                    self.instructions = instructions
                    self.outputText = outputText
                    self.usage = usage
                    self.parallelToolCalls = parallelToolCalls
                    self.conversation = conversation
                    self.maxOutputTokens = maxOutputTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case id
                    case object
                    case status
                    case createdAt = "created_at"
                    case completedAt = "completed_at"
                    case error
                    case incompleteDetails = "incomplete_details"
                    case output
                    case instructions
                    case outputText = "output_text"
                    case usage
                    case parallelToolCalls = "parallel_tool_calls"
                    case conversation
                    case maxOutputTokens = "max_output_tokens"
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
            public init(from decoder: any Swift.Decoder) throws {
                self.value1 = try .init(from: decoder)
                self.value2 = try .init(from: decoder)
                self.value3 = try .init(from: decoder)
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
            /// A sequence number for this chunk of the stream response.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// A chunk of Base64 encoded response audio bytes.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseAudioDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.delta`.
            ///   - sequenceNumber: A sequence number for this chunk of the stream response.
            ///   - delta: A chunk of Base64 encoded response audio bytes.
            public init(
                _type: Components.Schemas.ResponseAudioDeltaEvent._TypePayload,
                sequenceNumber: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of the delta.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseAudioDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.done`.
            ///   - sequenceNumber: The sequence number of the delta.
            public init(
                _type: Components.Schemas.ResponseAudioDoneEvent._TypePayload,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseAudioTranscriptDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.transcript.delta`.
            ///   - delta: The partial transcript of the audio response.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseAudioTranscriptDeltaEvent._TypePayload,
                delta: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.delta = delta
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case delta
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseAudioTranscriptDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseAudioTranscriptDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.audio.transcript.done`.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseAudioTranscriptDoneEvent._TypePayload,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when a partial code snippet is streamed by the code interpreter.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent`.
        public struct ResponseCodeInterpreterCallCodeDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call_code.delta`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCallCode_delta = "response.code_interpreter_call_code.delta"
            }
            /// The type of the event. Always `response.code_interpreter_call_code.delta`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallCodeDeltaEvent._TypePayload
            /// The index of the output item in the response for which the code is being streamed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the code interpreter tool call item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The partial code snippet being streamed by the code interpreter.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/delta`.
            public var delta: Swift.String
            /// The sequence number of this event, used to order streaming events.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCodeInterpreterCallCodeDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call_code.delta`.
            ///   - outputIndex: The index of the output item in the response for which the code is being streamed.
            ///   - itemId: The unique identifier of the code interpreter tool call item.
            ///   - delta: The partial code snippet being streamed by the code interpreter.
            ///   - sequenceNumber: The sequence number of this event, used to order streaming events.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallCodeDeltaEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                delta: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.delta = delta
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case delta
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when the code snippet is finalized by the code interpreter.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent`.
        public struct ResponseCodeInterpreterCallCodeDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call_code.done`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCallCode_done = "response.code_interpreter_call_code.done"
            }
            /// The type of the event. Always `response.code_interpreter_call_code.done`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallCodeDoneEvent._TypePayload
            /// The index of the output item in the response for which the code is finalized.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the code interpreter tool call item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The final code snippet output by the code interpreter.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/code`.
            public var code: Swift.String
            /// The sequence number of this event, used to order streaming events.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCodeDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCodeInterpreterCallCodeDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call_code.done`.
            ///   - outputIndex: The index of the output item in the response for which the code is finalized.
            ///   - itemId: The unique identifier of the code interpreter tool call item.
            ///   - code: The final code snippet output by the code interpreter.
            ///   - sequenceNumber: The sequence number of this event, used to order streaming events.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallCodeDoneEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                code: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.code = code
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case code
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when the code interpreter call is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent`.
        public struct ResponseCodeInterpreterCallCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.completed`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_completed = "response.code_interpreter_call.completed"
            }
            /// The type of the event. Always `response.code_interpreter_call.completed`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallCompletedEvent._TypePayload
            /// The index of the output item in the response for which the code interpreter call is completed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the code interpreter tool call item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/item_id`.
            public var itemId: Swift.String
            /// The sequence number of this event, used to order streaming events.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCodeInterpreterCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.completed`.
            ///   - outputIndex: The index of the output item in the response for which the code interpreter call is completed.
            ///   - itemId: The unique identifier of the code interpreter tool call item.
            ///   - sequenceNumber: The sequence number of this event, used to order streaming events.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when a code interpreter call is in progress.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent`.
        public struct ResponseCodeInterpreterCallInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.in_progress`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_inProgress = "response.code_interpreter_call.in_progress"
            }
            /// The type of the event. Always `response.code_interpreter_call.in_progress`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallInProgressEvent._TypePayload
            /// The index of the output item in the response for which the code interpreter call is in progress.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the code interpreter tool call item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/item_id`.
            public var itemId: Swift.String
            /// The sequence number of this event, used to order streaming events.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCodeInterpreterCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.in_progress`.
            ///   - outputIndex: The index of the output item in the response for which the code interpreter call is in progress.
            ///   - itemId: The unique identifier of the code interpreter tool call item.
            ///   - sequenceNumber: The sequence number of this event, used to order streaming events.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when the code interpreter is actively interpreting the code snippet.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent`.
        public struct ResponseCodeInterpreterCallInterpretingEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.code_interpreter_call.interpreting`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_codeInterpreterCall_interpreting = "response.code_interpreter_call.interpreting"
            }
            /// The type of the event. Always `response.code_interpreter_call.interpreting`.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/type`.
            public var _type: Components.Schemas.ResponseCodeInterpreterCallInterpretingEvent._TypePayload
            /// The index of the output item in the response for which the code interpreter is interpreting code.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the code interpreter tool call item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/item_id`.
            public var itemId: Swift.String
            /// The sequence number of this event, used to order streaming events.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCodeInterpreterCallInterpretingEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCodeInterpreterCallInterpretingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.code_interpreter_call.interpreting`.
            ///   - outputIndex: The index of the output item in the response for which the code interpreter is interpreting code.
            ///   - itemId: The unique identifier of the code interpreter tool call item.
            ///   - sequenceNumber: The sequence number of this event, used to order streaming events.
            public init(
                _type: Components.Schemas.ResponseCodeInterpreterCallInterpretingEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
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
            /// Properties of the completed response.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCompletedEvent/response`.
            public var response: Components.Schemas.Response
            /// The sequence number for this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.completed`.
            ///   - response: Properties of the completed response.
            ///   - sequenceNumber: The sequence number for this event.
            public init(
                _type: Components.Schemas.ResponseCompletedEvent._TypePayload,
                response: Components.Schemas.Response,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.response = response
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
                case sequenceNumber = "sequence_number"
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
            /// The content part that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/part`.
            public var part: Components.Schemas.OutputContent
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartAddedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseContentPartAddedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.content_part.added`.
            ///   - itemId: The ID of the output item that the content part was added to.
            ///   - outputIndex: The index of the output item that the content part was added to.
            ///   - contentIndex: The index of the content part that was added.
            ///   - part: The content part that was added.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseContentPartAddedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                part: Components.Schemas.OutputContent,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.part = part
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case part
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The content part that is done.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseContentPartDoneEvent/part`.
            public var part: Components.Schemas.OutputContent
            /// Creates a new `ResponseContentPartDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.content_part.done`.
            ///   - itemId: The ID of the output item that the content part was added to.
            ///   - outputIndex: The index of the output item that the content part was added to.
            ///   - contentIndex: The index of the content part that is done.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - part: The content part that is done.
            public init(
                _type: Components.Schemas.ResponseContentPartDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                part: Components.Schemas.OutputContent
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.sequenceNumber = sequenceNumber
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case sequenceNumber = "sequence_number"
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
            /// The response that was created.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCreatedEvent/response`.
            public var response: Components.Schemas.Response
            /// The sequence number for this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCreatedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseCreatedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.created`.
            ///   - response: The response that was created.
            ///   - sequenceNumber: The sequence number for this event.
            public init(
                _type: Components.Schemas.ResponseCreatedEvent._TypePayload,
                response: Components.Schemas.Response,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.response = response
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
                case sequenceNumber = "sequence_number"
            }
        }
        /// Event representing a delta (partial update) to the input of a custom tool call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent`.
        public struct ResponseCustomToolCallInputDeltaEvent: Codable, Hashable, Sendable {
            /// The event type identifier.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_customToolCallInput_delta = "response.custom_tool_call_input.delta"
            }
            /// The event type identifier.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseCustomToolCallInputDeltaEvent._TypePayload
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The index of the output this delta applies to.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// Unique identifier for the API item associated with this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The incremental input data (delta) for the custom tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDeltaEvent/delta`.
            public var delta: Swift.String
            /// Creates a new `ResponseCustomToolCallInputDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The event type identifier.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - outputIndex: The index of the output this delta applies to.
            ///   - itemId: Unique identifier for the API item associated with this event.
            ///   - delta: The incremental input data (delta) for the custom tool call.
            public init(
                _type: Components.Schemas.ResponseCustomToolCallInputDeltaEvent._TypePayload,
                sequenceNumber: Swift.Int,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                delta: Swift.String
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case delta
            }
        }
        /// Event indicating that input for a custom tool call is complete.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent`.
        public struct ResponseCustomToolCallInputDoneEvent: Codable, Hashable, Sendable {
            /// The event type identifier.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_customToolCallInput_done = "response.custom_tool_call_input.done"
            }
            /// The event type identifier.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent/type`.
            public var _type: Components.Schemas.ResponseCustomToolCallInputDoneEvent._TypePayload
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The index of the output this event applies to.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// Unique identifier for the API item associated with this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The complete input data for the custom tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseCustomToolCallInputDoneEvent/input`.
            public var input: Swift.String
            /// Creates a new `ResponseCustomToolCallInputDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The event type identifier.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - outputIndex: The index of the output this event applies to.
            ///   - itemId: Unique identifier for the API item associated with this event.
            ///   - input: The complete input data for the custom tool call.
            public init(
                _type: Components.Schemas.ResponseCustomToolCallInputDoneEvent._TypePayload,
                sequenceNumber: Swift.Int,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                input: Swift.String
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.input = input
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case input
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
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/code`.
            public var code: Swift.String?
            /// The error message.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/message`.
            public var message: Swift.String
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/param`.
            public var param: Swift.String?
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseErrorEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseErrorEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `error`.
            ///   - code:
            ///   - message: The error message.
            ///   - param:
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseErrorEvent._TypePayload,
                code: Swift.String? = nil,
                message: Swift.String,
                param: Swift.String? = nil,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.code = code
                self.message = message
                self.param = param
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case code
                case message
                case param
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFailedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The response that failed.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFailedEvent/response`.
            public var response: Components.Schemas.Response
            /// Creates a new `ResponseFailedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.failed`.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - response: The response that failed.
            public init(
                _type: Components.Schemas.ResponseFailedEvent._TypePayload,
                sequenceNumber: Swift.Int,
                response: Components.Schemas.Response
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
                self.response = response
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseFileSearchCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.file_search_call.completed`.
            ///   - outputIndex: The index of the output item that the file search call is initiated.
            ///   - itemId: The ID of the output item that the file search call is initiated.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseFileSearchCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseFileSearchCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.file_search_call.in_progress`.
            ///   - outputIndex: The index of the output item that the file search call is initiated.
            ///   - itemId: The ID of the output item that the file search call is initiated.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseFileSearchCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFileSearchCallSearchingEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseFileSearchCallSearchingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.file_search_call.searching`.
            ///   - outputIndex: The index of the output item that the file search call is searching.
            ///   - itemId: The ID of the output item that the file search call is initiated.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseFileSearchCallSearchingEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
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
            public init(from decoder: any Swift.Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
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
            ///   - sequenceNumber: The sequence number of this event.
            ///   - delta: The function-call arguments delta that is added.
            public init(
                _type: Components.Schemas.ResponseFunctionCallArgumentsDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                delta: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
                self.delta = delta
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
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
            /// The name of the function that was called.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/name`.
            public var name: Swift.String
            /// The index of the output item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The function-call arguments.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFunctionCallArgumentsDoneEvent/arguments`.
            public var arguments: Swift.String
            /// Creates a new `ResponseFunctionCallArgumentsDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type:
            ///   - itemId: The ID of the item.
            ///   - name: The name of the function that was called.
            ///   - outputIndex: The index of the output item.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - arguments: The function-call arguments.
            public init(
                _type: Components.Schemas.ResponseFunctionCallArgumentsDoneEvent._TypePayload,
                itemId: Swift.String,
                name: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                arguments: Swift.String
            ) {
                self._type = _type
                self.itemId = itemId
                self.name = name
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
                self.arguments = arguments
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case name
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
                case arguments
            }
        }
        /// Emitted when an image generation tool call has completed and the final image is available.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallCompletedEvent`.
        public struct ResponseImageGenCallCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.image_generation_call.completed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_imageGenerationCall_completed = "response.image_generation_call.completed"
            }
            /// The type of the event. Always 'response.image_generation_call.completed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseImageGenCallCompletedEvent._TypePayload
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The unique identifier of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallCompletedEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseImageGenCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.image_generation_call.completed'.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - itemId: The unique identifier of the image generation item being processed.
            public init(
                _type: Components.Schemas.ResponseImageGenCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
                case itemId = "item_id"
            }
        }
        /// Emitted when an image generation tool call is actively generating an image (intermediate state).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallGeneratingEvent`.
        public struct ResponseImageGenCallGeneratingEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.image_generation_call.generating'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallGeneratingEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_imageGenerationCall_generating = "response.image_generation_call.generating"
            }
            /// The type of the event. Always 'response.image_generation_call.generating'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallGeneratingEvent/type`.
            public var _type: Components.Schemas.ResponseImageGenCallGeneratingEvent._TypePayload
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallGeneratingEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallGeneratingEvent/item_id`.
            public var itemId: Swift.String
            /// The sequence number of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallGeneratingEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseImageGenCallGeneratingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.image_generation_call.generating'.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - itemId: The unique identifier of the image generation item being processed.
            ///   - sequenceNumber: The sequence number of the image generation item being processed.
            public init(
                _type: Components.Schemas.ResponseImageGenCallGeneratingEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when an image generation tool call is in progress.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallInProgressEvent`.
        public struct ResponseImageGenCallInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.image_generation_call.in_progress'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_imageGenerationCall_inProgress = "response.image_generation_call.in_progress"
            }
            /// The type of the event. Always 'response.image_generation_call.in_progress'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseImageGenCallInProgressEvent._TypePayload
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallInProgressEvent/item_id`.
            public var itemId: Swift.String
            /// The sequence number of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseImageGenCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.image_generation_call.in_progress'.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - itemId: The unique identifier of the image generation item being processed.
            ///   - sequenceNumber: The sequence number of the image generation item being processed.
            public init(
                _type: Components.Schemas.ResponseImageGenCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when a partial image is available during image generation streaming.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent`.
        public struct ResponseImageGenCallPartialImageEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.image_generation_call.partial_image'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_imageGenerationCall_partialImage = "response.image_generation_call.partial_image"
            }
            /// The type of the event. Always 'response.image_generation_call.partial_image'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/type`.
            public var _type: Components.Schemas.ResponseImageGenCallPartialImageEvent._TypePayload
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/item_id`.
            public var itemId: Swift.String
            /// The sequence number of the image generation item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// 0-based index for the partial image (backend is 1-based, but this is 0-based for the user).
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/partial_image_index`.
            public var partialImageIndex: Swift.Int
            /// Base64-encoded partial image data, suitable for rendering as an image.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseImageGenCallPartialImageEvent/partial_image_b64`.
            public var partialImageB64: Swift.String
            /// Creates a new `ResponseImageGenCallPartialImageEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.image_generation_call.partial_image'.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - itemId: The unique identifier of the image generation item being processed.
            ///   - sequenceNumber: The sequence number of the image generation item being processed.
            ///   - partialImageIndex: 0-based index for the partial image (backend is 1-based, but this is 0-based for the user).
            ///   - partialImageB64: Base64-encoded partial image data, suitable for rendering as an image.
            public init(
                _type: Components.Schemas.ResponseImageGenCallPartialImageEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int,
                partialImageIndex: Swift.Int,
                partialImageB64: Swift.String
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
                self.partialImageIndex = partialImageIndex
                self.partialImageB64 = partialImageB64
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
                case partialImageIndex = "partial_image_index"
                case partialImageB64 = "partial_image_b64"
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
            /// The response that is in progress.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseInProgressEvent/response`.
            public var response: Components.Schemas.Response
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.in_progress`.
            ///   - response: The response that is in progress.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseInProgressEvent._TypePayload,
                response: Components.Schemas.Response,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.response = response
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
                case sequenceNumber = "sequence_number"
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
            /// The response that was incomplete.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseIncompleteEvent/response`.
            public var response: Components.Schemas.Response
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseIncompleteEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseIncompleteEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.incomplete`.
            ///   - response: The response that was incomplete.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseIncompleteEvent._TypePayload,
                response: Components.Schemas.Response,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.response = response
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
                case sequenceNumber = "sequence_number"
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
        /// A logprob is the logarithmic probability that the model assigns to producing 
        /// a particular token at a given position in the sequence. Less-negative (higher) 
        /// logprob values indicate greater model confidence in that token choice.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseLogProb`.
        public struct ResponseLogProb: Codable, Hashable, Sendable {
            /// A possible text token.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseLogProb/token`.
            public var token: Swift.String
            /// The log probability of this token.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseLogProb/logprob`.
            public var logprob: Swift.Double
            /// - Remark: Generated from `#/components/schemas/ResponseLogProb/TopLogprobsPayload`.
            public struct TopLogprobsPayloadPayload: Codable, Hashable, Sendable {
                /// A possible text token.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseLogProb/TopLogprobsPayload/token`.
                public var token: Swift.String?
                /// The log probability of this token.
                ///
                /// - Remark: Generated from `#/components/schemas/ResponseLogProb/TopLogprobsPayload/logprob`.
                public var logprob: Swift.Double?
                /// Creates a new `TopLogprobsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - token: A possible text token.
                ///   - logprob: The log probability of this token.
                public init(
                    token: Swift.String? = nil,
                    logprob: Swift.Double? = nil
                ) {
                    self.token = token
                    self.logprob = logprob
                }
                public enum CodingKeys: String, CodingKey {
                    case token
                    case logprob
                }
            }
            /// The log probabilities of up to 20 of the most likely tokens.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseLogProb/top_logprobs`.
            public typealias TopLogprobsPayload = [Components.Schemas.ResponseLogProb.TopLogprobsPayloadPayload]
            /// The log probabilities of up to 20 of the most likely tokens.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseLogProb/top_logprobs`.
            public var topLogprobs: Components.Schemas.ResponseLogProb.TopLogprobsPayload?
            /// Creates a new `ResponseLogProb`.
            ///
            /// - Parameters:
            ///   - token: A possible text token.
            ///   - logprob: The log probability of this token.
            ///   - topLogprobs: The log probabilities of up to 20 of the most likely tokens.
            public init(
                token: Swift.String,
                logprob: Swift.Double,
                topLogprobs: Components.Schemas.ResponseLogProb.TopLogprobsPayload? = nil
            ) {
                self.token = token
                self.logprob = logprob
                self.topLogprobs = topLogprobs
            }
            public enum CodingKeys: String, CodingKey {
                case token
                case logprob
                case topLogprobs = "top_logprobs"
            }
        }
        /// Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent`.
        public struct ResponseMCPCallArgumentsDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_call_arguments.delta'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpCallArguments_delta = "response.mcp_call_arguments.delta"
            }
            /// The type of the event. Always 'response.mcp_call_arguments.delta'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseMCPCallArgumentsDeltaEvent._TypePayload
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the MCP tool call item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// A JSON string containing the partial update to the arguments for the MCP tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/delta`.
            public var delta: Swift.String
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPCallArgumentsDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_call_arguments.delta'.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - itemId: The unique identifier of the MCP tool call item being processed.
            ///   - delta: A JSON string containing the partial update to the arguments for the MCP tool call.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPCallArgumentsDeltaEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                delta: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.delta = delta
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case delta
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when the arguments for an MCP tool call are finalized.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent`.
        public struct ResponseMCPCallArgumentsDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_call_arguments.done'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpCallArguments_done = "response.mcp_call_arguments.done"
            }
            /// The type of the event. Always 'response.mcp_call_arguments.done'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/type`.
            public var _type: Components.Schemas.ResponseMCPCallArgumentsDoneEvent._TypePayload
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the MCP tool call item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/item_id`.
            public var itemId: Swift.String
            /// A JSON string containing the finalized arguments for the MCP tool call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/arguments`.
            public var arguments: Swift.String
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallArgumentsDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPCallArgumentsDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_call_arguments.done'.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - itemId: The unique identifier of the MCP tool call item being processed.
            ///   - arguments: A JSON string containing the finalized arguments for the MCP tool call.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPCallArgumentsDoneEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                arguments: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.arguments = arguments
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case arguments
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when an MCP  tool call has completed successfully.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPCallCompletedEvent`.
        public struct ResponseMCPCallCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_call.completed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpCall_completed = "response.mcp_call.completed"
            }
            /// The type of the event. Always 'response.mcp_call.completed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseMCPCallCompletedEvent._TypePayload
            /// The ID of the MCP tool call item that completed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallCompletedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that completed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_call.completed'.
            ///   - itemId: The ID of the MCP tool call item that completed.
            ///   - outputIndex: The index of the output item that completed.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPCallCompletedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when an MCP  tool call has failed.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPCallFailedEvent`.
        public struct ResponseMCPCallFailedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_call.failed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallFailedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpCall_failed = "response.mcp_call.failed"
            }
            /// The type of the event. Always 'response.mcp_call.failed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallFailedEvent/type`.
            public var _type: Components.Schemas.ResponseMCPCallFailedEvent._TypePayload
            /// The ID of the MCP tool call item that failed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallFailedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that failed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallFailedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallFailedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPCallFailedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_call.failed'.
            ///   - itemId: The ID of the MCP tool call item that failed.
            ///   - outputIndex: The index of the output item that failed.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPCallFailedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when an MCP  tool call is in progress.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPCallInProgressEvent`.
        public struct ResponseMCPCallInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_call.in_progress'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpCall_inProgress = "response.mcp_call.in_progress"
            }
            /// The type of the event. Always 'response.mcp_call.in_progress'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseMCPCallInProgressEvent._TypePayload
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The unique identifier of the MCP tool call item being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPCallInProgressEvent/item_id`.
            public var itemId: Swift.String
            /// Creates a new `ResponseMCPCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_call.in_progress'.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - itemId: The unique identifier of the MCP tool call item being processed.
            public init(
                _type: Components.Schemas.ResponseMCPCallInProgressEvent._TypePayload,
                sequenceNumber: Swift.Int,
                outputIndex: Swift.Int,
                itemId: Swift.String
            ) {
                self._type = _type
                self.sequenceNumber = sequenceNumber
                self.outputIndex = outputIndex
                self.itemId = itemId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case sequenceNumber = "sequence_number"
                case outputIndex = "output_index"
                case itemId = "item_id"
            }
        }
        /// Emitted when the list of available MCP tools has been successfully retrieved.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsCompletedEvent`.
        public struct ResponseMCPListToolsCompletedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_list_tools.completed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsCompletedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpListTools_completed = "response.mcp_list_tools.completed"
            }
            /// The type of the event. Always 'response.mcp_list_tools.completed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsCompletedEvent/type`.
            public var _type: Components.Schemas.ResponseMCPListToolsCompletedEvent._TypePayload
            /// The ID of the MCP tool call item that produced this output.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsCompletedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that was processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsCompletedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPListToolsCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_list_tools.completed'.
            ///   - itemId: The ID of the MCP tool call item that produced this output.
            ///   - outputIndex: The index of the output item that was processed.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPListToolsCompletedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when the attempt to list available MCP tools has failed.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsFailedEvent`.
        public struct ResponseMCPListToolsFailedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_list_tools.failed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsFailedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpListTools_failed = "response.mcp_list_tools.failed"
            }
            /// The type of the event. Always 'response.mcp_list_tools.failed'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsFailedEvent/type`.
            public var _type: Components.Schemas.ResponseMCPListToolsFailedEvent._TypePayload
            /// The ID of the MCP tool call item that failed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsFailedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that failed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsFailedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsFailedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPListToolsFailedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_list_tools.failed'.
            ///   - itemId: The ID of the MCP tool call item that failed.
            ///   - outputIndex: The index of the output item that failed.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPListToolsFailedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when the system is in the process of retrieving the list of available MCP tools.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsInProgressEvent`.
        public struct ResponseMCPListToolsInProgressEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.mcp_list_tools.in_progress'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsInProgressEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_mcpListTools_inProgress = "response.mcp_list_tools.in_progress"
            }
            /// The type of the event. Always 'response.mcp_list_tools.in_progress'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsInProgressEvent/type`.
            public var _type: Components.Schemas.ResponseMCPListToolsInProgressEvent._TypePayload
            /// The ID of the MCP tool call item that is being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsInProgressEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item that is being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsInProgressEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseMCPListToolsInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseMCPListToolsInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.mcp_list_tools.in_progress'.
            ///   - itemId: The ID of the MCP tool call item that is being processed.
            ///   - outputIndex: The index of the output item that is being processed.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseMCPListToolsInProgressEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The output item that was added.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemAddedEvent/item`.
            public var item: Components.Schemas.OutputItem
            /// Creates a new `ResponseOutputItemAddedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_item.added`.
            ///   - outputIndex: The index of the output item that was added.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - item: The output item that was added.
            public init(
                _type: Components.Schemas.ResponseOutputItemAddedEvent._TypePayload,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                item: Components.Schemas.OutputItem
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
                self.item = item
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The output item that was marked done.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputItemDoneEvent/item`.
            public var item: Components.Schemas.OutputItem
            /// Creates a new `ResponseOutputItemDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_item.done`.
            ///   - outputIndex: The index of the output item that was marked done.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - item: The output item that was marked done.
            public init(
                _type: Components.Schemas.ResponseOutputItemDoneEvent._TypePayload,
                outputIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                item: Components.Schemas.OutputItem
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.sequenceNumber = sequenceNumber
                self.item = item
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case sequenceNumber = "sequence_number"
                case item
            }
        }
        /// Emitted when an annotation is added to output text content.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent`.
        public struct ResponseOutputTextAnnotationAddedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.output_text.annotation.added'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_outputText_annotation_added = "response.output_text.annotation.added"
            }
            /// The type of the event. Always 'response.output_text.annotation.added'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/type`.
            public var _type: Components.Schemas.ResponseOutputTextAnnotationAddedEvent._TypePayload
            /// The unique identifier of the item to which the annotation is being added.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item in the response's output array.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the content part within the output item.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The index of the annotation within the content part.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/annotation_index`.
            public var annotationIndex: Swift.Int
            /// The sequence number of this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The annotation object being added. (See annotation schema for details.)
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseOutputTextAnnotationAddedEvent/annotation`.
            public var annotation: OpenAPIRuntime.OpenAPIObjectContainer
            /// Creates a new `ResponseOutputTextAnnotationAddedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.output_text.annotation.added'.
            ///   - itemId: The unique identifier of the item to which the annotation is being added.
            ///   - outputIndex: The index of the output item in the response's output array.
            ///   - contentIndex: The index of the content part within the output item.
            ///   - annotationIndex: The index of the annotation within the content part.
            ///   - sequenceNumber: The sequence number of this event.
            ///   - annotation: The annotation object being added. (See annotation schema for details.)
            public init(
                _type: Components.Schemas.ResponseOutputTextAnnotationAddedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                annotationIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                annotation: OpenAPIRuntime.OpenAPIObjectContainer
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.annotationIndex = annotationIndex
                self.sequenceNumber = sequenceNumber
                self.annotation = annotation
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case annotationIndex = "annotation_index"
                case sequenceNumber = "sequence_number"
                case annotation
            }
        }
        /// Optional map of values to substitute in for variables in your
        /// prompt. The substitution values can either be strings, or other
        /// Response input types like images or files.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponsePromptVariables`.
        public struct ResponsePromptVariables: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ResponsePromptVariables/additionalProperties`.
            @frozen public enum AdditionalPropertiesPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ResponsePromptVariables/additionalProperties/case1`.
                case case1(Swift.String)
                /// - Remark: Generated from `#/components/schemas/ResponsePromptVariables/additionalProperties/case2`.
                case InputTextContent(Components.Schemas.InputTextContent)
                /// - Remark: Generated from `#/components/schemas/ResponsePromptVariables/additionalProperties/case3`.
                case InputImageContent(Components.Schemas.InputImageContent)
                /// - Remark: Generated from `#/components/schemas/ResponsePromptVariables/additionalProperties/case4`.
                case InputFileContent(Components.Schemas.InputFileContent)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
                    do {
                        self = .case1(try decoder.decodeFromSingleValueContainer())
                        return
                    } catch {
                        errors.append(error)
                    }
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .InputTextContent(value):
                        try value.encode(to: encoder)
                    case let .InputImageContent(value):
                        try value.encode(to: encoder)
                    case let .InputFileContent(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// A container of undocumented properties.
            public var additionalProperties: [String: Components.Schemas.ResponsePromptVariables.AdditionalPropertiesPayload]
            /// Creates a new `ResponsePromptVariables`.
            ///
            /// - Parameters:
            ///   - additionalProperties: A container of undocumented properties.
            public init(additionalProperties: [String: Components.Schemas.ResponsePromptVariables.AdditionalPropertiesPayload] = .init()) {
                self.additionalProperties = additionalProperties
            }
            public init(from decoder: any Swift.Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try encoder.encodeAdditionalProperties(additionalProperties)
            }
        }
        /// - Remark: Generated from `#/components/schemas/ResponseProperties`.
        public struct ResponseProperties: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/previous_response_id`.
            public var previousResponseId: Swift.String?
            /// Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
            /// offers a wide range of models with different capabilities, performance
            /// characteristics, and price points. Refer to the [model guide](/docs/models)
            /// to browse and compare available models.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/model`.
            public var model: Components.Schemas.ModelIdsResponses?
            /// - Remark: Generated from `#/components/schemas/Reasoning`.
            public typealias Reasoning = Components.Schemas.Reasoning
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/reasoning`.
            public var reasoning: Components.Schemas.Reasoning?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/background`.
            public var background: Swift.Bool?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/max_tool_calls`.
            public var maxToolCalls: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/text`.
            public var text: Components.Schemas.ResponseTextParam?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/tools`.
            public var tools: Components.Schemas.ToolsArray?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/tool_choice`.
            public var toolChoice: Components.Schemas.ToolChoiceParam?
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/prompt`.
            public var prompt: Components.Schemas.Prompt?
            /// The truncation strategy to use for the model response.
            /// - `auto`: If the input to this Response exceeds
            ///   the model's context window size, the model will truncate the
            ///   response to fit the context window by dropping items from the beginning of the conversation.
            /// - `disabled` (default): If the input size will exceed the context window
            ///   size for a model, the request will fail with a 400 error.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/truncation`.
            @frozen public enum TruncationPayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case disabled = "disabled"
            }
            /// - Remark: Generated from `#/components/schemas/ResponseProperties/truncation`.
            public var truncation: Components.Schemas.ResponseProperties.TruncationPayload?
            /// Creates a new `ResponseProperties`.
            ///
            /// - Parameters:
            ///   - previousResponseId:
            ///   - model: Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI
            ///   - reasoning:
            ///   - background:
            ///   - maxToolCalls:
            ///   - text:
            ///   - tools:
            ///   - toolChoice:
            ///   - prompt:
            ///   - truncation:
            public init(
                previousResponseId: Swift.String? = nil,
                model: Components.Schemas.ModelIdsResponses? = nil,
                reasoning: Components.Schemas.Reasoning? = nil,
                background: Swift.Bool? = nil,
                maxToolCalls: Swift.Int? = nil,
                text: Components.Schemas.ResponseTextParam? = nil,
                tools: Components.Schemas.ToolsArray? = nil,
                toolChoice: Components.Schemas.ToolChoiceParam? = nil,
                prompt: Components.Schemas.Prompt? = nil,
                truncation: Components.Schemas.ResponseProperties.TruncationPayload? = nil
            ) {
                self.previousResponseId = previousResponseId
                self.model = model
                self.reasoning = reasoning
                self.background = background
                self.maxToolCalls = maxToolCalls
                self.text = text
                self.tools = tools
                self.toolChoice = toolChoice
                self.prompt = prompt
                self.truncation = truncation
            }
            public enum CodingKeys: String, CodingKey {
                case previousResponseId = "previous_response_id"
                case model
                case reasoning
                case background
                case maxToolCalls = "max_tool_calls"
                case text
                case tools
                case toolChoice = "tool_choice"
                case prompt
                case truncation
            }
        }
        /// Emitted when a response is queued and waiting to be processed.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseQueuedEvent`.
        public struct ResponseQueuedEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always 'response.queued'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseQueuedEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_queued = "response.queued"
            }
            /// The type of the event. Always 'response.queued'.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseQueuedEvent/type`.
            public var _type: Components.Schemas.ResponseQueuedEvent._TypePayload
            /// The full response object that is queued.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseQueuedEvent/response`.
            public var response: Components.Schemas.Response
            /// The sequence number for this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseQueuedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseQueuedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always 'response.queued'.
            ///   - response: The full response object that is queued.
            ///   - sequenceNumber: The sequence number for this event.
            public init(
                _type: Components.Schemas.ResponseQueuedEvent._TypePayload,
                response: Components.Schemas.Response,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.response = response
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case response
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartAddedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
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
            ///   - sequenceNumber: The sequence number of this event.
            ///   - part: The summary part that was added.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryPartAddedEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                part: Components.Schemas.ResponseReasoningSummaryPartAddedEvent.PartPayload
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.sequenceNumber = sequenceNumber
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryPartDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
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
            ///   - sequenceNumber: The sequence number of this event.
            ///   - part: The completed summary part.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryPartDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                sequenceNumber: Swift.Int,
                part: Components.Schemas.ResponseReasoningSummaryPartDoneEvent.PartPayload
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.sequenceNumber = sequenceNumber
                self.part = part
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseReasoningSummaryTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_summary_text.delta`.
            ///   - itemId: The ID of the item this summary text delta is associated with.
            ///   - outputIndex: The index of the output item this summary text delta is associated with.
            ///   - summaryIndex: The index of the summary part within the reasoning summary.
            ///   - delta: The text delta that was added to the summary.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryTextDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                delta: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.delta = delta
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case delta
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningSummaryTextDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseReasoningSummaryTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_summary_text.done`.
            ///   - itemId: The ID of the item this summary text is associated with.
            ///   - outputIndex: The index of the output item this summary text is associated with.
            ///   - summaryIndex: The index of the summary part within the reasoning summary.
            ///   - text: The full text of the completed reasoning summary.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseReasoningSummaryTextDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                summaryIndex: Swift.Int,
                text: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.summaryIndex = summaryIndex
                self.text = text
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case summaryIndex = "summary_index"
                case text
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when a delta is added to a reasoning text.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent`.
        public struct ResponseReasoningTextDeltaEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.reasoning_text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_reasoningText_delta = "response.reasoning_text.delta"
            }
            /// The type of the event. Always `response.reasoning_text.delta`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/type`.
            public var _type: Components.Schemas.ResponseReasoningTextDeltaEvent._TypePayload
            /// The ID of the item this reasoning text delta is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item this reasoning text delta is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the reasoning content part this delta is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The text delta that was added to the reasoning content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/delta`.
            public var delta: Swift.String
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseReasoningTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_text.delta`.
            ///   - itemId: The ID of the item this reasoning text delta is associated with.
            ///   - outputIndex: The index of the output item this reasoning text delta is associated with.
            ///   - contentIndex: The index of the reasoning content part this delta is associated with.
            ///   - delta: The text delta that was added to the reasoning content.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseReasoningTextDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                delta: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.delta = delta
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case delta
                case sequenceNumber = "sequence_number"
            }
        }
        /// Emitted when a reasoning text is completed.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent`.
        public struct ResponseReasoningTextDoneEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `response.reasoning_text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case response_reasoningText_done = "response.reasoning_text.done"
            }
            /// The type of the event. Always `response.reasoning_text.done`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/type`.
            public var _type: Components.Schemas.ResponseReasoningTextDoneEvent._TypePayload
            /// The ID of the item this reasoning text is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/item_id`.
            public var itemId: Swift.String
            /// The index of the output item this reasoning text is associated with.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/output_index`.
            public var outputIndex: Swift.Int
            /// The index of the reasoning content part.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/content_index`.
            public var contentIndex: Swift.Int
            /// The full text of the completed reasoning content.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/text`.
            public var text: Swift.String
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseReasoningTextDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseReasoningTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.reasoning_text.done`.
            ///   - itemId: The ID of the item this reasoning text is associated with.
            ///   - outputIndex: The index of the output item this reasoning text is associated with.
            ///   - contentIndex: The index of the reasoning content part.
            ///   - text: The full text of the completed reasoning content.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseReasoningTextDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                text: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.text = text
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case text
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseRefusalDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.refusal.delta`.
            ///   - itemId: The ID of the output item that the refusal text is added to.
            ///   - outputIndex: The index of the output item that the refusal text is added to.
            ///   - contentIndex: The index of the content part that the refusal text is added to.
            ///   - delta: The refusal text that is added.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseRefusalDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                delta: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.delta = delta
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case delta
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of this event.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseRefusalDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseRefusalDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.refusal.done`.
            ///   - itemId: The ID of the output item that the refusal text is finalized.
            ///   - outputIndex: The index of the output item that the refusal text is finalized.
            ///   - contentIndex: The index of the content part that the refusal text is finalized.
            ///   - refusal: The refusal text that is finalized.
            ///   - sequenceNumber: The sequence number of this event.
            public init(
                _type: Components.Schemas.ResponseRefusalDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                refusal: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.refusal = refusal
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case refusal
                case sequenceNumber = "sequence_number"
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
            public var value29: Components.Schemas.ResponseReasoningTextDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value30`.
            public var value30: Components.Schemas.ResponseReasoningTextDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value31`.
            public var value31: Components.Schemas.ResponseRefusalDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value32`.
            public var value32: Components.Schemas.ResponseRefusalDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value33`.
            public var value33: Components.Schemas.ResponseTextDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value34`.
            public var value34: Components.Schemas.ResponseTextDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value35`.
            public var value35: Components.Schemas.ResponseWebSearchCallCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value36`.
            public var value36: Components.Schemas.ResponseWebSearchCallInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value37`.
            public var value37: Components.Schemas.ResponseWebSearchCallSearchingEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value38`.
            public var value38: Components.Schemas.ResponseImageGenCallCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value39`.
            public var value39: Components.Schemas.ResponseImageGenCallGeneratingEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value40`.
            public var value40: Components.Schemas.ResponseImageGenCallInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value41`.
            public var value41: Components.Schemas.ResponseImageGenCallPartialImageEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value42`.
            public var value42: Components.Schemas.ResponseMCPCallArgumentsDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value43`.
            public var value43: Components.Schemas.ResponseMCPCallArgumentsDoneEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value44`.
            public var value44: Components.Schemas.ResponseMCPCallCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value45`.
            public var value45: Components.Schemas.ResponseMCPCallFailedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value46`.
            public var value46: Components.Schemas.ResponseMCPCallInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value47`.
            public var value47: Components.Schemas.ResponseMCPListToolsCompletedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value48`.
            public var value48: Components.Schemas.ResponseMCPListToolsFailedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value49`.
            public var value49: Components.Schemas.ResponseMCPListToolsInProgressEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value50`.
            public var value50: Components.Schemas.ResponseOutputTextAnnotationAddedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value51`.
            public var value51: Components.Schemas.ResponseQueuedEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value52`.
            public var value52: Components.Schemas.ResponseCustomToolCallInputDeltaEvent?
            /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value53`.
            public var value53: Components.Schemas.ResponseCustomToolCallInputDoneEvent?
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
            ///   - value37:
            ///   - value38:
            ///   - value39:
            ///   - value40:
            ///   - value41:
            ///   - value42:
            ///   - value43:
            ///   - value44:
            ///   - value45:
            ///   - value46:
            ///   - value47:
            ///   - value48:
            ///   - value49:
            ///   - value50:
            ///   - value51:
            ///   - value52:
            ///   - value53:
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
                value29: Components.Schemas.ResponseReasoningTextDeltaEvent? = nil,
                value30: Components.Schemas.ResponseReasoningTextDoneEvent? = nil,
                value31: Components.Schemas.ResponseRefusalDeltaEvent? = nil,
                value32: Components.Schemas.ResponseRefusalDoneEvent? = nil,
                value33: Components.Schemas.ResponseTextDeltaEvent? = nil,
                value34: Components.Schemas.ResponseTextDoneEvent? = nil,
                value35: Components.Schemas.ResponseWebSearchCallCompletedEvent? = nil,
                value36: Components.Schemas.ResponseWebSearchCallInProgressEvent? = nil,
                value37: Components.Schemas.ResponseWebSearchCallSearchingEvent? = nil,
                value38: Components.Schemas.ResponseImageGenCallCompletedEvent? = nil,
                value39: Components.Schemas.ResponseImageGenCallGeneratingEvent? = nil,
                value40: Components.Schemas.ResponseImageGenCallInProgressEvent? = nil,
                value41: Components.Schemas.ResponseImageGenCallPartialImageEvent? = nil,
                value42: Components.Schemas.ResponseMCPCallArgumentsDeltaEvent? = nil,
                value43: Components.Schemas.ResponseMCPCallArgumentsDoneEvent? = nil,
                value44: Components.Schemas.ResponseMCPCallCompletedEvent? = nil,
                value45: Components.Schemas.ResponseMCPCallFailedEvent? = nil,
                value46: Components.Schemas.ResponseMCPCallInProgressEvent? = nil,
                value47: Components.Schemas.ResponseMCPListToolsCompletedEvent? = nil,
                value48: Components.Schemas.ResponseMCPListToolsFailedEvent? = nil,
                value49: Components.Schemas.ResponseMCPListToolsInProgressEvent? = nil,
                value50: Components.Schemas.ResponseOutputTextAnnotationAddedEvent? = nil,
                value51: Components.Schemas.ResponseQueuedEvent? = nil,
                value52: Components.Schemas.ResponseCustomToolCallInputDeltaEvent? = nil,
                value53: Components.Schemas.ResponseCustomToolCallInputDoneEvent? = nil
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
                self.value37 = value37
                self.value38 = value38
                self.value39 = value39
                self.value40 = value40
                self.value41 = value41
                self.value42 = value42
                self.value43 = value43
                self.value44 = value44
                self.value45 = value45
                self.value46 = value46
                self.value47 = value47
                self.value48 = value48
                self.value49 = value49
                self.value50 = value50
                self.value51 = value51
                self.value52 = value52
                self.value53 = value53
            }
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
                do {
                    self.value37 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value38 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value39 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value40 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value41 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value42 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value43 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value44 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value45 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value46 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value47 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value48 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value49 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value50 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value51 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value52 = try .init(from: decoder)
                } catch {
                    errors.append(error)
                }
                do {
                    self.value53 = try .init(from: decoder)
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
                        self.value36,
                        self.value37,
                        self.value38,
                        self.value39,
                        self.value40,
                        self.value41,
                        self.value42,
                        self.value43,
                        self.value44,
                        self.value45,
                        self.value46,
                        self.value47,
                        self.value48,
                        self.value49,
                        self.value50,
                        self.value51,
                        self.value52,
                        self.value53
                    ],
                    type: Self.self,
                    codingPath: decoder.codingPath,
                    errors: errors
                )
            }
            public func encode(to encoder: any Swift.Encoder) throws {
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
                try self.value37?.encode(to: encoder)
                try self.value38?.encode(to: encoder)
                try self.value39?.encode(to: encoder)
                try self.value40?.encode(to: encoder)
                try self.value41?.encode(to: encoder)
                try self.value42?.encode(to: encoder)
                try self.value43?.encode(to: encoder)
                try self.value44?.encode(to: encoder)
                try self.value45?.encode(to: encoder)
                try self.value46?.encode(to: encoder)
                try self.value47?.encode(to: encoder)
                try self.value48?.encode(to: encoder)
                try self.value49?.encode(to: encoder)
                try self.value50?.encode(to: encoder)
                try self.value51?.encode(to: encoder)
                try self.value52?.encode(to: encoder)
                try self.value53?.encode(to: encoder)
            }
        }
        /// Options for streaming responses. Only set this when you set `stream: true`.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseStreamOptions`.
        public struct ResponseStreamOptions: Codable, Hashable, Sendable {
            /// When true, stream obfuscation will be enabled. Stream obfuscation adds
            /// random characters to an `obfuscation` field on streaming delta events to
            /// normalize payload sizes as a mitigation to certain side-channel attacks.
            /// These obfuscation fields are included by default, but add a small amount
            /// of overhead to the data stream. You can set `include_obfuscation` to
            /// false to optimize for bandwidth if you trust the network links between
            /// your application and the OpenAI API.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseStreamOptions/include_obfuscation`.
            public var includeObfuscation: Swift.Bool?
            /// Creates a new `ResponseStreamOptions`.
            ///
            /// - Parameters:
            ///   - includeObfuscation: When true, stream obfuscation will be enabled. Stream obfuscation adds
            public init(includeObfuscation: Swift.Bool? = nil) {
                self.includeObfuscation = includeObfuscation
            }
            public enum CodingKeys: String, CodingKey {
                case includeObfuscation = "include_obfuscation"
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
            /// The sequence number for this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The log probabilities of the tokens in the delta.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDeltaEvent/logprobs`.
            public var logprobs: [Components.Schemas.ResponseLogProb]
            /// Creates a new `ResponseTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_text.delta`.
            ///   - itemId: The ID of the output item that the text delta was added to.
            ///   - outputIndex: The index of the output item that the text delta was added to.
            ///   - contentIndex: The index of the content part that the text delta was added to.
            ///   - delta: The text delta that was added.
            ///   - sequenceNumber: The sequence number for this event.
            ///   - logprobs: The log probabilities of the tokens in the delta.
            public init(
                _type: Components.Schemas.ResponseTextDeltaEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                delta: Swift.String,
                sequenceNumber: Swift.Int,
                logprobs: [Components.Schemas.ResponseLogProb]
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.delta = delta
                self.sequenceNumber = sequenceNumber
                self.logprobs = logprobs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case delta
                case sequenceNumber = "sequence_number"
                case logprobs
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
            /// The sequence number for this event.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// The log probabilities of the tokens in the delta.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseTextDoneEvent/logprobs`.
            public var logprobs: [Components.Schemas.ResponseLogProb]
            /// Creates a new `ResponseTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.output_text.done`.
            ///   - itemId: The ID of the output item that the text content is finalized.
            ///   - outputIndex: The index of the output item that the text content is finalized.
            ///   - contentIndex: The index of the content part that the text content is finalized.
            ///   - text: The text content that is finalized.
            ///   - sequenceNumber: The sequence number for this event.
            ///   - logprobs: The log probabilities of the tokens in the delta.
            public init(
                _type: Components.Schemas.ResponseTextDoneEvent._TypePayload,
                itemId: Swift.String,
                outputIndex: Swift.Int,
                contentIndex: Swift.Int,
                text: Swift.String,
                sequenceNumber: Swift.Int,
                logprobs: [Components.Schemas.ResponseLogProb]
            ) {
                self._type = _type
                self.itemId = itemId
                self.outputIndex = outputIndex
                self.contentIndex = contentIndex
                self.text = text
                self.sequenceNumber = sequenceNumber
                self.logprobs = logprobs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case itemId = "item_id"
                case outputIndex = "output_index"
                case contentIndex = "content_index"
                case text
                case sequenceNumber = "sequence_number"
                case logprobs
            }
        }
        /// Configuration options for a text response from the model. Can be plain
        /// text or structured JSON data. Learn more:
        /// - [Text inputs and outputs](/docs/guides/text)
        /// - [Structured Outputs](/docs/guides/structured-outputs)
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseTextParam`.
        public struct ResponseTextParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ResponseTextParam/format`.
            public var format: Components.Schemas.TextResponseFormatConfiguration?
            /// - Remark: Generated from `#/components/schemas/ResponseTextParam/verbosity`.
            public var verbosity: Components.Schemas.Verbosity?
            /// Creates a new `ResponseTextParam`.
            ///
            /// - Parameters:
            ///   - format:
            ///   - verbosity:
            public init(
                format: Components.Schemas.TextResponseFormatConfiguration? = nil,
                verbosity: Components.Schemas.Verbosity? = nil
            ) {
                self.format = format
                self.verbosity = verbosity
            }
            public enum CodingKeys: String, CodingKey {
                case format
                case verbosity
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
            /// The sequence number of the web search call being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallCompletedEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseWebSearchCallCompletedEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.web_search_call.completed`.
            ///   - outputIndex: The index of the output item that the web search call is associated with.
            ///   - itemId: Unique ID for the output item associated with the web search call.
            ///   - sequenceNumber: The sequence number of the web search call being processed.
            public init(
                _type: Components.Schemas.ResponseWebSearchCallCompletedEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of the web search call being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallInProgressEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseWebSearchCallInProgressEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.web_search_call.in_progress`.
            ///   - outputIndex: The index of the output item that the web search call is associated with.
            ///   - itemId: Unique ID for the output item associated with the web search call.
            ///   - sequenceNumber: The sequence number of the web search call being processed.
            public init(
                _type: Components.Schemas.ResponseWebSearchCallInProgressEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
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
            /// The sequence number of the web search call being processed.
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseWebSearchCallSearchingEvent/sequence_number`.
            public var sequenceNumber: Swift.Int
            /// Creates a new `ResponseWebSearchCallSearchingEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `response.web_search_call.searching`.
            ///   - outputIndex: The index of the output item that the web search call is associated with.
            ///   - itemId: Unique ID for the output item associated with the web search call.
            ///   - sequenceNumber: The sequence number of the web search call being processed.
            public init(
                _type: Components.Schemas.ResponseWebSearchCallSearchingEvent._TypePayload,
                outputIndex: Swift.Int,
                itemId: Swift.String,
                sequenceNumber: Swift.Int
            ) {
                self._type = _type
                self.outputIndex = outputIndex
                self.itemId = itemId
                self.sequenceNumber = sequenceNumber
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case outputIndex = "output_index"
                case itemId = "item_id"
                case sequenceNumber = "sequence_number"
            }
        }
        /// Specifies the processing type used for serving the request.
        ///   - If set to 'auto', then the request will be processed with the service tier configured in the Project settings. Unless otherwise configured, the Project will use 'default'.
        ///   - If set to 'default', then the request will be processed with the standard pricing and performance for the selected model.
        ///   - If set to '[flex](/docs/guides/flex-processing)' or '[priority](https://openai.com/api-priority-processing/)', then the request will be processed with the corresponding service tier.
        ///   - When not set, the default behavior is 'auto'.
        ///
        ///   When the `service_tier` parameter is set, the response body will include the `service_tier` value based on the processing mode actually used to serve the request. This response value may be different from the value set in the parameter.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ServiceTier`.
        @frozen public enum ServiceTier: String, Codable, Hashable, Sendable, CaseIterable {
            case auto = "auto"
            case _default = "default"
            case flex = "flex"
            case scale = "scale"
            case priority = "priority"
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
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
            public func encode(to encoder: any Swift.Encoder) throws {
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
            /// - Remark: Generated from `#/components/schemas/TextResponseFormatJsonSchema/strict`.
            public var strict: Swift.Bool?
            /// Creates a new `TextResponseFormatJsonSchema`.
            ///
            /// - Parameters:
            ///   - _type: The type of response format being defined. Always `json_schema`.
            ///   - description: A description of what the response format is for, used by the model to
            ///   - name: The name of the response format. Must be a-z, A-Z, 0-9, or contain
            ///   - schema:
            ///   - strict:
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
        /// A tool that can be used to generate a response.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Tool`.
        @frozen public enum Tool: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Tool/FunctionTool`.
            case functionTool(Components.Schemas.FunctionTool)
            /// - Remark: Generated from `#/components/schemas/Tool/FileSearchTool`.
            case fileSearchTool(Components.Schemas.FileSearchTool)
            /// - Remark: Generated from `#/components/schemas/Tool/ComputerTool`.
            case computerTool(Components.Schemas.ComputerTool)
            /// - Remark: Generated from `#/components/schemas/Tool/ComputerUsePreviewTool`.
            case computerUsePreviewTool(Components.Schemas.ComputerUsePreviewTool)
            /// - Remark: Generated from `#/components/schemas/Tool/WebSearchTool`.
            case webSearchTool(Components.Schemas.WebSearchTool)
            /// - Remark: Generated from `#/components/schemas/Tool/MCPTool`.
            case mcpTool(Components.Schemas.MCPTool)
            /// - Remark: Generated from `#/components/schemas/Tool/CodeInterpreterTool`.
            case codeInterpreterTool(Components.Schemas.CodeInterpreterTool)
            /// - Remark: Generated from `#/components/schemas/Tool/ImageGenTool`.
            case imageGenTool(Components.Schemas.ImageGenTool)
            /// - Remark: Generated from `#/components/schemas/Tool/LocalShellToolParam`.
            case localShellToolParam(Components.Schemas.LocalShellToolParam)
            /// - Remark: Generated from `#/components/schemas/Tool/FunctionShellToolParam`.
            case functionShellToolParam(Components.Schemas.FunctionShellToolParam)
            /// - Remark: Generated from `#/components/schemas/Tool/CustomToolParam`.
            case customToolParam(Components.Schemas.CustomToolParam)
            /// - Remark: Generated from `#/components/schemas/Tool/NamespaceToolParam`.
            case namespaceToolParam(Components.Schemas.NamespaceToolParam)
            /// - Remark: Generated from `#/components/schemas/Tool/ToolSearchToolParam`.
            case toolSearchToolParam(Components.Schemas.ToolSearchToolParam)
            /// - Remark: Generated from `#/components/schemas/Tool/WebSearchPreviewTool`.
            case webSearchPreviewTool(Components.Schemas.WebSearchPreviewTool)
            /// - Remark: Generated from `#/components/schemas/Tool/ApplyPatchToolParam`.
            case applyPatchToolParam(Components.Schemas.ApplyPatchToolParam)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "FunctionTool", "#/components/schemas/FunctionTool", "function":
                    self = .functionTool(try .init(from: decoder))
                case "FileSearchTool", "#/components/schemas/FileSearchTool", "file_search":
                    self = .fileSearchTool(try .init(from: decoder))
                case "ComputerTool", "#/components/schemas/ComputerTool", "computer":
                    self = .computerTool(try .init(from: decoder))
                case "ComputerUsePreviewTool", "#/components/schemas/ComputerUsePreviewTool", "computer_use_preview":
                    self = .computerUsePreviewTool(try .init(from: decoder))
                case "WebSearchTool", "#/components/schemas/WebSearchTool", "web_search", "web_search_2025_08_26":
                    self = .webSearchTool(try .init(from: decoder))
                case "MCPTool", "#/components/schemas/MCPTool", "mcp":
                    self = .mcpTool(try .init(from: decoder))
                case "CodeInterpreterTool", "#/components/schemas/CodeInterpreterTool", "code_interpreter":
                    self = .codeInterpreterTool(try .init(from: decoder))
                case "ImageGenTool", "#/components/schemas/ImageGenTool", "image_generation":
                    self = .imageGenTool(try .init(from: decoder))
                case "LocalShellToolParam", "#/components/schemas/LocalShellToolParam", "local_shell":
                    self = .localShellToolParam(try .init(from: decoder))
                case "FunctionShellToolParam", "#/components/schemas/FunctionShellToolParam", "shell":
                    self = .functionShellToolParam(try .init(from: decoder))
                case "CustomToolParam", "#/components/schemas/CustomToolParam", "custom":
                    self = .customToolParam(try .init(from: decoder))
                case "NamespaceToolParam", "#/components/schemas/NamespaceToolParam", "namespace":
                    self = .namespaceToolParam(try .init(from: decoder))
                case "ToolSearchToolParam", "#/components/schemas/ToolSearchToolParam", "tool_search":
                    self = .toolSearchToolParam(try .init(from: decoder))
                case "WebSearchPreviewTool", "#/components/schemas/WebSearchPreviewTool", "web_search_preview", "web_search_preview_2025_03_11":
                    self = .webSearchPreviewTool(try .init(from: decoder))
                case "ApplyPatchToolParam", "#/components/schemas/ApplyPatchToolParam", "apply_patch":
                    self = .applyPatchToolParam(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .functionTool(value):
                    try value.encode(to: encoder)
                case let .fileSearchTool(value):
                    try value.encode(to: encoder)
                case let .computerTool(value):
                    try value.encode(to: encoder)
                case let .computerUsePreviewTool(value):
                    try value.encode(to: encoder)
                case let .webSearchTool(value):
                    try value.encode(to: encoder)
                case let .mcpTool(value):
                    try value.encode(to: encoder)
                case let .codeInterpreterTool(value):
                    try value.encode(to: encoder)
                case let .imageGenTool(value):
                    try value.encode(to: encoder)
                case let .localShellToolParam(value):
                    try value.encode(to: encoder)
                case let .functionShellToolParam(value):
                    try value.encode(to: encoder)
                case let .customToolParam(value):
                    try value.encode(to: encoder)
                case let .namespaceToolParam(value):
                    try value.encode(to: encoder)
                case let .toolSearchToolParam(value):
                    try value.encode(to: encoder)
                case let .webSearchPreviewTool(value):
                    try value.encode(to: encoder)
                case let .applyPatchToolParam(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// Constrains the tools available to the model to a pre-defined set.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed`.
        public struct ToolChoiceAllowed: Codable, Hashable, Sendable {
            /// Allowed tool configuration type. Always `allowed_tools`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case allowedTools = "allowed_tools"
            }
            /// Allowed tool configuration type. Always `allowed_tools`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/type`.
            public var _type: Components.Schemas.ToolChoiceAllowed._TypePayload
            /// Constrains the tools available to the model to a pre-defined set.
            ///
            /// `auto` allows the model to pick from among the allowed tools and generate a
            /// message.
            ///
            /// `required` requires the model to call one or more of the allowed tools.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/mode`.
            @frozen public enum ModePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
                case required = "required"
            }
            /// Constrains the tools available to the model to a pre-defined set.
            ///
            /// `auto` allows the model to pick from among the allowed tools and generate a
            /// message.
            ///
            /// `required` requires the model to call one or more of the allowed tools.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/mode`.
            public var mode: Components.Schemas.ToolChoiceAllowed.ModePayload
            /// A tool definition that the model should be allowed to call.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/ToolsPayload`.
            public struct ToolsPayloadPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                public var additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer
                /// Creates a new `ToolsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                public init(additionalProperties: OpenAPIRuntime.OpenAPIObjectContainer = .init()) {
                    self.additionalProperties = additionalProperties
                }
                public init(from decoder: any Swift.Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// A list of tool definitions that the model should be allowed to call.
            ///
            /// For the Responses API, the list of tool definitions might look like:
            /// ```json
            /// [
            ///   { "type": "function", "name": "get_weather" },
            ///   { "type": "mcp", "server_label": "deepwiki" },
            ///   { "type": "image_generation" }
            /// ]
            /// ```
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/tools`.
            public typealias ToolsPayload = [Components.Schemas.ToolChoiceAllowed.ToolsPayloadPayload]
            /// A list of tool definitions that the model should be allowed to call.
            ///
            /// For the Responses API, the list of tool definitions might look like:
            /// ```json
            /// [
            ///   { "type": "function", "name": "get_weather" },
            ///   { "type": "mcp", "server_label": "deepwiki" },
            ///   { "type": "image_generation" }
            /// ]
            /// ```
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceAllowed/tools`.
            public var tools: Components.Schemas.ToolChoiceAllowed.ToolsPayload
            /// Creates a new `ToolChoiceAllowed`.
            ///
            /// - Parameters:
            ///   - _type: Allowed tool configuration type. Always `allowed_tools`.
            ///   - mode: Constrains the tools available to the model to a pre-defined set.
            ///   - tools: A list of tool definitions that the model should be allowed to call.
            public init(
                _type: Components.Schemas.ToolChoiceAllowed._TypePayload,
                mode: Components.Schemas.ToolChoiceAllowed.ModePayload,
                tools: Components.Schemas.ToolChoiceAllowed.ToolsPayload
            ) {
                self._type = _type
                self.mode = mode
                self.tools = tools
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case mode
                case tools
            }
        }
        /// Use this option to force the model to call a specific custom tool.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceCustom`.
        public struct ToolChoiceCustom: Codable, Hashable, Sendable {
            /// For custom tool calling, the type is always `custom`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceCustom/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case custom = "custom"
            }
            /// For custom tool calling, the type is always `custom`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceCustom/type`.
            public var _type: Components.Schemas.ToolChoiceCustom._TypePayload
            /// The name of the custom tool to call.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceCustom/name`.
            public var name: Swift.String
            /// Creates a new `ToolChoiceCustom`.
            ///
            /// - Parameters:
            ///   - _type: For custom tool calling, the type is always `custom`.
            ///   - name: The name of the custom tool to call.
            public init(
                _type: Components.Schemas.ToolChoiceCustom._TypePayload,
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
        /// Use this option to force the model to call a specific tool on a remote MCP server.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceMCP`.
        public struct ToolChoiceMCP: Codable, Hashable, Sendable {
            /// For MCP tools, the type is always `mcp`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceMCP/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case mcp = "mcp"
            }
            /// For MCP tools, the type is always `mcp`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceMCP/type`.
            public var _type: Components.Schemas.ToolChoiceMCP._TypePayload
            /// The label of the MCP server to use.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceMCP/server_label`.
            public var serverLabel: Swift.String
            /// - Remark: Generated from `#/components/schemas/ToolChoiceMCP/name`.
            public var name: Swift.String?
            /// Creates a new `ToolChoiceMCP`.
            ///
            /// - Parameters:
            ///   - _type: For MCP tools, the type is always `mcp`.
            ///   - serverLabel: The label of the MCP server to use.
            ///   - name:
            public init(
                _type: Components.Schemas.ToolChoiceMCP._TypePayload,
                serverLabel: Swift.String,
                name: Swift.String? = nil
            ) {
                self._type = _type
                self.serverLabel = serverLabel
                self.name = name
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case serverLabel = "server_label"
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
        /// How the model should select which tool (or tools) to use when generating
        /// a response. See the `tools` parameter to see how to specify which tools
        /// the model can call.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolChoiceParam`.
        @frozen public enum ToolChoiceParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case1`.
            case ToolChoiceOptions(Components.Schemas.ToolChoiceOptions)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case2`.
            case ToolChoiceAllowed(Components.Schemas.ToolChoiceAllowed)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case3`.
            case ToolChoiceTypes(Components.Schemas.ToolChoiceTypes)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case4`.
            case ToolChoiceFunction(Components.Schemas.ToolChoiceFunction)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case5`.
            case ToolChoiceMCP(Components.Schemas.ToolChoiceMCP)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case6`.
            case ToolChoiceCustom(Components.Schemas.ToolChoiceCustom)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case7`.
            case SpecificApplyPatchParam(Components.Schemas.SpecificApplyPatchParam)
            /// - Remark: Generated from `#/components/schemas/ToolChoiceParam/case8`.
            case SpecificFunctionShellParam(Components.Schemas.SpecificFunctionShellParam)
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
                do {
                    self = .ToolChoiceOptions(try decoder.decodeFromSingleValueContainer())
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .ToolChoiceAllowed(try .init(from: decoder))
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
                do {
                    self = .ToolChoiceMCP(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .ToolChoiceCustom(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .SpecificApplyPatchParam(try .init(from: decoder))
                    return
                } catch {
                    errors.append(error)
                }
                do {
                    self = .SpecificFunctionShellParam(try .init(from: decoder))
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
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .ToolChoiceOptions(value):
                    try encoder.encodeToSingleValueContainer(value)
                case let .ToolChoiceAllowed(value):
                    try value.encode(to: encoder)
                case let .ToolChoiceTypes(value):
                    try value.encode(to: encoder)
                case let .ToolChoiceFunction(value):
                    try value.encode(to: encoder)
                case let .ToolChoiceMCP(value):
                    try value.encode(to: encoder)
                case let .ToolChoiceCustom(value):
                    try value.encode(to: encoder)
                case let .SpecificApplyPatchParam(value):
                    try value.encode(to: encoder)
                case let .SpecificFunctionShellParam(value):
                    try value.encode(to: encoder)
                }
            }
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
            /// - `computer`
            /// - `computer_use_preview`
            /// - `computer_use`
            /// - `code_interpreter`
            /// - `image_generation`
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ToolChoiceTypes/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case fileSearch = "file_search"
                case webSearchPreview = "web_search_preview"
                case computer = "computer"
                case computerUsePreview = "computer_use_preview"
                case computerUse = "computer_use"
                case webSearchPreview20250311 = "web_search_preview_2025_03_11"
                case imageGeneration = "image_generation"
                case codeInterpreter = "code_interpreter"
            }
            /// The type of hosted tool the model should to use. Learn more about
            /// [built-in tools](/docs/guides/tools).
            ///
            /// Allowed values are:
            /// - `file_search`
            /// - `web_search_preview`
            /// - `computer`
            /// - `computer_use_preview`
            /// - `computer_use`
            /// - `code_interpreter`
            /// - `image_generation`
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
        /// An array of tools the model may call while generating a response. You
        /// can specify which tool to use by setting the `tool_choice` parameter.
        ///
        /// We support the following categories of tools:
        /// - **Built-in tools**: Tools that are provided by OpenAI that extend the
        ///   model's capabilities, like [web search](/docs/guides/tools-web-search)
        ///   or [file search](/docs/guides/tools-file-search). Learn more about
        ///   [built-in tools](/docs/guides/tools).
        /// - **MCP Tools**: Integrations with third-party systems via custom MCP servers
        ///   or predefined connectors such as Google Drive and SharePoint. Learn more about
        ///   [MCP Tools](/docs/guides/tools-connectors-mcp).
        /// - **Function calls (custom tools)**: Functions that are defined by you,
        ///   enabling the model to call your own code with strongly typed arguments
        ///   and outputs. Learn more about
        ///   [function calling](/docs/guides/function-calling). You can also use
        ///   custom tools to call your own code.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ToolsArray`.
        public typealias ToolsArray = [Components.Schemas.Tool]
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
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/LogprobsPayload`.
            public struct LogprobsPayloadPayload: Codable, Hashable, Sendable {
                /// The token that was used to generate the log probability.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/LogprobsPayload/token`.
                public var token: Swift.String?
                /// The log probability of the token.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/LogprobsPayload/logprob`.
                public var logprob: Swift.Double?
                /// The bytes that were used to generate the log probability.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/LogprobsPayload/bytes`.
                public var bytes: [Swift.Int]?
                /// Creates a new `LogprobsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - token: The token that was used to generate the log probability.
                ///   - logprob: The log probability of the token.
                ///   - bytes: The bytes that were used to generate the log probability.
                public init(
                    token: Swift.String? = nil,
                    logprob: Swift.Double? = nil,
                    bytes: [Swift.Int]? = nil
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
            /// The log probabilities of the delta. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/logprobs`.
            public typealias LogprobsPayload = [Components.Schemas.TranscriptTextDeltaEvent.LogprobsPayloadPayload]
            /// The log probabilities of the delta. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/logprobs`.
            public var logprobs: Components.Schemas.TranscriptTextDeltaEvent.LogprobsPayload?
            /// Identifier of the diarized segment that this delta belongs to. Only present when using `gpt-4o-transcribe-diarize`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDeltaEvent/segment_id`.
            public var segmentId: Swift.String?
            /// Creates a new `TranscriptTextDeltaEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `transcript.text.delta`.
            ///   - delta: The text delta that was additionally transcribed.
            ///   - logprobs: The log probabilities of the delta. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///   - segmentId: Identifier of the diarized segment that this delta belongs to. Only present when using `gpt-4o-transcribe-diarize`.
            public init(
                _type: Components.Schemas.TranscriptTextDeltaEvent._TypePayload,
                delta: Swift.String,
                logprobs: Components.Schemas.TranscriptTextDeltaEvent.LogprobsPayload? = nil,
                segmentId: Swift.String? = nil
            ) {
                self._type = _type
                self.delta = delta
                self.logprobs = logprobs
                self.segmentId = segmentId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case delta
                case logprobs
                case segmentId = "segment_id"
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
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/LogprobsPayload`.
            public struct LogprobsPayloadPayload: Codable, Hashable, Sendable {
                /// The token that was used to generate the log probability.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/LogprobsPayload/token`.
                public var token: Swift.String?
                /// The log probability of the token.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/LogprobsPayload/logprob`.
                public var logprob: Swift.Double?
                /// The bytes that were used to generate the log probability.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/LogprobsPayload/bytes`.
                public var bytes: [Swift.Int]?
                /// Creates a new `LogprobsPayloadPayload`.
                ///
                /// - Parameters:
                ///   - token: The token that was used to generate the log probability.
                ///   - logprob: The log probability of the token.
                ///   - bytes: The bytes that were used to generate the log probability.
                public init(
                    token: Swift.String? = nil,
                    logprob: Swift.Double? = nil,
                    bytes: [Swift.Int]? = nil
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
            /// The log probabilities of the individual tokens in the transcription. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/logprobs`.
            public typealias LogprobsPayload = [Components.Schemas.TranscriptTextDoneEvent.LogprobsPayloadPayload]
            /// The log probabilities of the individual tokens in the transcription. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/logprobs`.
            public var logprobs: Components.Schemas.TranscriptTextDoneEvent.LogprobsPayload?
            /// - Remark: Generated from `#/components/schemas/TranscriptTextDoneEvent/usage`.
            public var usage: Components.Schemas.TranscriptTextUsageTokens?
            /// Creates a new `TranscriptTextDoneEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `transcript.text.done`.
            ///   - text: The text that was transcribed.
            ///   - logprobs: The log probabilities of the individual tokens in the transcription. Only included if you [create a transcription](/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`.
            ///   - usage:
            public init(
                _type: Components.Schemas.TranscriptTextDoneEvent._TypePayload,
                text: Swift.String,
                logprobs: Components.Schemas.TranscriptTextDoneEvent.LogprobsPayload? = nil,
                usage: Components.Schemas.TranscriptTextUsageTokens? = nil
            ) {
                self._type = _type
                self.text = text
                self.logprobs = logprobs
                self.usage = usage
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
                case logprobs
                case usage
            }
        }
        /// Emitted when a diarized transcription returns a completed segment with speaker information. Only emitted when you [create a transcription](/docs/api-reference/audio/create-transcription) with `stream` set to `true` and `response_format` set to `diarized_json`.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent`.
        public struct TranscriptTextSegmentEvent: Codable, Hashable, Sendable {
            /// The type of the event. Always `transcript.text.segment`.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case transcript_text_segment = "transcript.text.segment"
            }
            /// The type of the event. Always `transcript.text.segment`.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/type`.
            public var _type: Components.Schemas.TranscriptTextSegmentEvent._TypePayload
            /// Unique identifier for the segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/id`.
            public var id: Swift.String
            /// Start timestamp of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/start`.
            public var start: Swift.Double
            /// End timestamp of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/end`.
            public var end: Swift.Double
            /// Transcript text for this segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/text`.
            public var text: Swift.String
            /// Speaker label for this segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextSegmentEvent/speaker`.
            public var speaker: Swift.String
            /// Creates a new `TranscriptTextSegmentEvent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the event. Always `transcript.text.segment`.
            ///   - id: Unique identifier for the segment.
            ///   - start: Start timestamp of the segment in seconds.
            ///   - end: End timestamp of the segment in seconds.
            ///   - text: Transcript text for this segment.
            ///   - speaker: Speaker label for this segment.
            public init(
                _type: Components.Schemas.TranscriptTextSegmentEvent._TypePayload,
                id: Swift.String,
                start: Swift.Double,
                end: Swift.Double,
                text: Swift.String,
                speaker: Swift.String
            ) {
                self._type = _type
                self.id = id
                self.start = start
                self.end = end
                self.text = text
                self.speaker = speaker
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case start
                case end
                case text
                case speaker
            }
        }
        /// Usage statistics for models billed by audio input duration.
        ///
        /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageDuration`.
        public struct TranscriptTextUsageDuration: Codable, Hashable, Sendable {
            /// The type of the usage object. Always `duration` for this variant.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageDuration/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case duration = "duration"
            }
            /// The type of the usage object. Always `duration` for this variant.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageDuration/type`.
            public var _type: Components.Schemas.TranscriptTextUsageDuration._TypePayload
            /// Duration of the input audio in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageDuration/seconds`.
            public var seconds: Swift.Double
            /// Creates a new `TranscriptTextUsageDuration`.
            ///
            /// - Parameters:
            ///   - _type: The type of the usage object. Always `duration` for this variant.
            ///   - seconds: Duration of the input audio in seconds.
            public init(
                _type: Components.Schemas.TranscriptTextUsageDuration._TypePayload,
                seconds: Swift.Double
            ) {
                self._type = _type
                self.seconds = seconds
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case seconds
            }
        }
        /// Usage statistics for models billed by token usage.
        ///
        /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens`.
        public struct TranscriptTextUsageTokens: Codable, Hashable, Sendable {
            /// The type of the usage object. Always `tokens` for this variant.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case tokens = "tokens"
            }
            /// The type of the usage object. Always `tokens` for this variant.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/type`.
            public var _type: Components.Schemas.TranscriptTextUsageTokens._TypePayload
            /// Number of input tokens billed for this request.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/input_tokens`.
            public var inputTokens: Swift.Int
            /// Details about the input tokens billed for this request.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/input_token_details`.
            public struct InputTokenDetailsPayload: Codable, Hashable, Sendable {
                /// Number of text tokens billed for this request.
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/input_token_details/text_tokens`.
                public var textTokens: Swift.Int?
                /// Number of audio tokens billed for this request.
                ///
                /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/input_token_details/audio_tokens`.
                public var audioTokens: Swift.Int?
                /// Creates a new `InputTokenDetailsPayload`.
                ///
                /// - Parameters:
                ///   - textTokens: Number of text tokens billed for this request.
                ///   - audioTokens: Number of audio tokens billed for this request.
                public init(
                    textTokens: Swift.Int? = nil,
                    audioTokens: Swift.Int? = nil
                ) {
                    self.textTokens = textTokens
                    self.audioTokens = audioTokens
                }
                public enum CodingKeys: String, CodingKey {
                    case textTokens = "text_tokens"
                    case audioTokens = "audio_tokens"
                }
            }
            /// Details about the input tokens billed for this request.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/input_token_details`.
            public var inputTokenDetails: Components.Schemas.TranscriptTextUsageTokens.InputTokenDetailsPayload?
            /// Number of output tokens generated.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/output_tokens`.
            public var outputTokens: Swift.Int
            /// Total number of tokens used (input + output).
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptTextUsageTokens/total_tokens`.
            public var totalTokens: Swift.Int
            /// Creates a new `TranscriptTextUsageTokens`.
            ///
            /// - Parameters:
            ///   - _type: The type of the usage object. Always `tokens` for this variant.
            ///   - inputTokens: Number of input tokens billed for this request.
            ///   - inputTokenDetails: Details about the input tokens billed for this request.
            ///   - outputTokens: Number of output tokens generated.
            ///   - totalTokens: Total number of tokens used (input + output).
            public init(
                _type: Components.Schemas.TranscriptTextUsageTokens._TypePayload,
                inputTokens: Swift.Int,
                inputTokenDetails: Components.Schemas.TranscriptTextUsageTokens.InputTokenDetailsPayload? = nil,
                outputTokens: Swift.Int,
                totalTokens: Swift.Int
            ) {
                self._type = _type
                self.inputTokens = inputTokens
                self.inputTokenDetails = inputTokenDetails
                self.outputTokens = outputTokens
                self.totalTokens = totalTokens
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case inputTokens = "input_tokens"
                case inputTokenDetails = "input_token_details"
                case outputTokens = "output_tokens"
                case totalTokens = "total_tokens"
            }
        }
        /// A segment of diarized transcript text with speaker metadata.
        ///
        /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment`.
        public struct TranscriptionDiarizedSegment: Codable, Hashable, Sendable {
            /// The type of the segment. Always `transcript.text.segment`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case transcript_text_segment = "transcript.text.segment"
            }
            /// The type of the segment. Always `transcript.text.segment`.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/type`.
            public var _type: Components.Schemas.TranscriptionDiarizedSegment._TypePayload
            /// Unique identifier for the segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/id`.
            public var id: Swift.String
            /// Start timestamp of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/start`.
            public var start: Swift.Double
            /// End timestamp of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/end`.
            public var end: Swift.Double
            /// Transcript text for this segment.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/text`.
            public var text: Swift.String
            /// Speaker label for this segment. When known speakers are provided, the label matches `known_speaker_names[]`. Otherwise speakers are labeled sequentially using capital letters (`A`, `B`, ...).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionDiarizedSegment/speaker`.
            public var speaker: Swift.String
            /// Creates a new `TranscriptionDiarizedSegment`.
            ///
            /// - Parameters:
            ///   - _type: The type of the segment. Always `transcript.text.segment`.
            ///   - id: Unique identifier for the segment.
            ///   - start: Start timestamp of the segment in seconds.
            ///   - end: End timestamp of the segment in seconds.
            ///   - text: Transcript text for this segment.
            ///   - speaker: Speaker label for this segment. When known speakers are provided, the label matches `known_speaker_names[]`. Otherwise speakers are labeled sequentially using capital letters (`A`, `B`, ...).
            public init(
                _type: Components.Schemas.TranscriptionDiarizedSegment._TypePayload,
                id: Swift.String,
                start: Swift.Double,
                end: Swift.Double,
                text: Swift.String,
                speaker: Swift.String
            ) {
                self._type = _type
                self.id = id
                self.start = start
                self.end = end
                self.text = text
                self.speaker = speaker
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case start
                case end
                case text
                case speaker
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
            public var start: Swift.Double
            /// End time of the segment in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionSegment/end`.
            public var end: Swift.Double
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
                start: Swift.Double,
                end: Swift.Double,
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
            public var start: Swift.Double
            /// End time of the word in seconds.
            ///
            /// - Remark: Generated from `#/components/schemas/TranscriptionWord/end`.
            public var end: Swift.Double
            /// Creates a new `TranscriptionWord`.
            ///
            /// - Parameters:
            ///   - word: The text content of the word.
            ///   - start: Start time of the word in seconds.
            ///   - end: End time of the word in seconds.
            public init(
                word: Swift.String,
                start: Swift.Double,
                end: Swift.Double
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
        /// - Remark: Generated from `#/components/schemas/VadConfig`.
        public struct VadConfig: Codable, Hashable, Sendable {
            /// Must be set to `server_vad` to enable manual chunking using server side VAD.
            ///
            /// - Remark: Generated from `#/components/schemas/VadConfig/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case serverVad = "server_vad"
            }
            /// Must be set to `server_vad` to enable manual chunking using server side VAD.
            ///
            /// - Remark: Generated from `#/components/schemas/VadConfig/type`.
            public var _type: Components.Schemas.VadConfig._TypePayload
            /// Amount of audio to include before the VAD detected speech (in 
            /// milliseconds).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/VadConfig/prefix_padding_ms`.
            public var prefixPaddingMs: Swift.Int?
            /// Duration of silence to detect speech stop (in milliseconds).
            /// With shorter values the model will respond more quickly, 
            /// but may jump in on short pauses from the user.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/VadConfig/silence_duration_ms`.
            public var silenceDurationMs: Swift.Int?
            /// Sensitivity threshold (0.0 to 1.0) for voice activity detection. A 
            /// higher threshold will require louder audio to activate the model, and 
            /// thus might perform better in noisy environments.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/VadConfig/threshold`.
            public var threshold: Swift.Double?
            /// Creates a new `VadConfig`.
            ///
            /// - Parameters:
            ///   - _type: Must be set to `server_vad` to enable manual chunking using server side VAD.
            ///   - prefixPaddingMs: Amount of audio to include before the VAD detected speech (in 
            ///   - silenceDurationMs: Duration of silence to detect speech stop (in milliseconds).
            ///   - threshold: Sensitivity threshold (0.0 to 1.0) for voice activity detection. A 
            public init(
                _type: Components.Schemas.VadConfig._TypePayload,
                prefixPaddingMs: Swift.Int? = nil,
                silenceDurationMs: Swift.Int? = nil,
                threshold: Swift.Double? = nil
            ) {
                self._type = _type
                self.prefixPaddingMs = prefixPaddingMs
                self.silenceDurationMs = silenceDurationMs
                self.threshold = threshold
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case prefixPaddingMs = "prefix_padding_ms"
                case silenceDurationMs = "silence_duration_ms"
                case threshold
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self._type = try container.decode(
                    Components.Schemas.VadConfig._TypePayload.self,
                    forKey: ._type
                )
                self.prefixPaddingMs = try container.decodeIfPresent(
                    Swift.Int.self,
                    forKey: .prefixPaddingMs
                )
                self.silenceDurationMs = try container.decodeIfPresent(
                    Swift.Int.self,
                    forKey: .silenceDurationMs
                )
                self.threshold = try container.decodeIfPresent(
                    Swift.Double.self,
                    forKey: .threshold
                )
                try decoder.ensureNoAdditionalProperties(knownKeys: [
                    "type",
                    "prefix_padding_ms",
                    "silence_duration_ms",
                    "threshold"
                ])
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
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
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
            public init(from decoder: any Swift.Decoder) throws {
                additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                try encoder.encodeAdditionalProperties(additionalProperties)
            }
        }
        /// Constrains the verbosity of the model's response. Lower values will result in
        /// more concise responses, while higher values will result in more verbose responses.
        /// Currently supported values are `low`, `medium`, and `high`.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/Verbosity`.
        @frozen public enum Verbosity: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case medium = "medium"
            case high = "high"
        }
        /// Action type "find_in_page": Searches for a pattern within a loaded page.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchActionFind`.
        public struct WebSearchActionFind: Codable, Hashable, Sendable {
            /// The action type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionFind/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case findInPage = "find_in_page"
            }
            /// The action type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionFind/type`.
            public var _type: Components.Schemas.WebSearchActionFind._TypePayload
            /// The URL of the page searched for the pattern.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionFind/url`.
            public var url: Swift.String
            /// The pattern or text to search for within the page.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionFind/pattern`.
            public var pattern: Swift.String
            /// Creates a new `WebSearchActionFind`.
            ///
            /// - Parameters:
            ///   - _type: The action type.
            ///   - url: The URL of the page searched for the pattern.
            ///   - pattern: The pattern or text to search for within the page.
            public init(
                _type: Components.Schemas.WebSearchActionFind._TypePayload,
                url: Swift.String,
                pattern: Swift.String
            ) {
                self._type = _type
                self.url = url
                self.pattern = pattern
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case url
                case pattern
            }
        }
        /// Action type "open_page" - Opens a specific URL from search results.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchActionOpenPage`.
        public struct WebSearchActionOpenPage: Codable, Hashable, Sendable {
            /// The action type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionOpenPage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case openPage = "open_page"
            }
            /// The action type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionOpenPage/type`.
            public var _type: Components.Schemas.WebSearchActionOpenPage._TypePayload
            /// The URL opened by the model.
            ///
            /// The URL opened by the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionOpenPage/url`.
            public var url: Swift.String?
            /// Creates a new `WebSearchActionOpenPage`.
            ///
            /// - Parameters:
            ///   - _type: The action type.
            ///   - url: The URL opened by the model.
            public init(
                _type: Components.Schemas.WebSearchActionOpenPage._TypePayload,
                url: Swift.String? = nil
            ) {
                self._type = _type
                self.url = url
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case url
            }
        }
        /// Action type "search" - Performs a web search query.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch`.
        public struct WebSearchActionSearch: Codable, Hashable, Sendable {
            /// The action type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case search = "search"
            }
            /// The action type.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/type`.
            public var _type: Components.Schemas.WebSearchActionSearch._TypePayload
            /// [DEPRECATED] The search query.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/query`.
            public var query: Swift.String
            /// The search queries.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/queries`.
            public var queries: [Swift.String]?
            /// A source used in the search.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/SourcesPayload`.
            public struct SourcesPayloadPayload: Codable, Hashable, Sendable {
                /// The type of source. Always `url`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/SourcesPayload/type`.
                @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                    case url = "url"
                }
                /// The type of source. Always `url`.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/SourcesPayload/type`.
                public var _type: Components.Schemas.WebSearchActionSearch.SourcesPayloadPayload._TypePayload
                /// The URL of the source.
                ///
                ///
                /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/SourcesPayload/url`.
                public var url: Swift.String
                /// Creates a new `SourcesPayloadPayload`.
                ///
                /// - Parameters:
                ///   - _type: The type of source. Always `url`.
                ///   - url: The URL of the source.
                public init(
                    _type: Components.Schemas.WebSearchActionSearch.SourcesPayloadPayload._TypePayload,
                    url: Swift.String
                ) {
                    self._type = _type
                    self.url = url
                }
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                    case url
                }
            }
            /// The sources used in the search.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/sources`.
            public typealias SourcesPayload = [Components.Schemas.WebSearchActionSearch.SourcesPayloadPayload]
            /// The sources used in the search.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchActionSearch/sources`.
            public var sources: Components.Schemas.WebSearchActionSearch.SourcesPayload?
            /// Creates a new `WebSearchActionSearch`.
            ///
            /// - Parameters:
            ///   - _type: The action type.
            ///   - query: [DEPRECATED] The search query.
            ///   - queries: The search queries.
            ///   - sources: The sources used in the search.
            public init(
                _type: Components.Schemas.WebSearchActionSearch._TypePayload,
                query: Swift.String,
                queries: [Swift.String]? = nil,
                sources: Components.Schemas.WebSearchActionSearch.SourcesPayload? = nil
            ) {
                self._type = _type
                self.query = query
                self.queries = queries
                self.sources = sources
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case query
                case queries
                case sources
            }
        }
        /// The approximate location of the user.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation`.
        public struct WebSearchApproximateLocation: Codable, Hashable, Sendable {
            /// The type of location approximation. Always `approximate`.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case approximate = "approximate"
            }
            /// The type of location approximation. Always `approximate`.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation/type`.
            public var _type: Components.Schemas.WebSearchApproximateLocation._TypePayload?
            /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation/country`.
            public var country: Swift.String?
            /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation/region`.
            public var region: Swift.String?
            /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation/city`.
            public var city: Swift.String?
            /// - Remark: Generated from `#/components/schemas/WebSearchApproximateLocation/timezone`.
            public var timezone: Swift.String?
            /// Creates a new `WebSearchApproximateLocation`.
            ///
            /// - Parameters:
            ///   - _type: The type of location approximation. Always `approximate`.
            ///   - country:
            ///   - region:
            ///   - city:
            ///   - timezone:
            public init(
                _type: Components.Schemas.WebSearchApproximateLocation._TypePayload? = nil,
                country: Swift.String? = nil,
                region: Swift.String? = nil,
                city: Swift.String? = nil,
                timezone: Swift.String? = nil
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
        /// Search the Internet for sources related to the prompt. Learn more about the
        /// [web search tool](/docs/guides/tools-web-search).
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/WebSearchTool`.
        public struct WebSearchTool: Codable, Hashable, Sendable {
            /// The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case webSearch = "web_search"
                case webSearch20250826 = "web_search_2025_08_26"
            }
            /// The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/type`.
            public var _type: Components.Schemas.WebSearchTool._TypePayload
            /// Filters for the search.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/filters`.
            public struct FiltersPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/WebSearchTool/filters/allowed_domains`.
                public var allowedDomains: [Swift.String]?
                /// Creates a new `FiltersPayload`.
                ///
                /// - Parameters:
                ///   - allowedDomains:
                public init(allowedDomains: [Swift.String]? = nil) {
                    self.allowedDomains = allowedDomains
                }
                public enum CodingKeys: String, CodingKey {
                    case allowedDomains = "allowed_domains"
                }
            }
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/filters`.
            public var filters: Components.Schemas.WebSearchTool.FiltersPayload?
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/user_location`.
            public var userLocation: Components.Schemas.WebSearchApproximateLocation?
            /// High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/search_context_size`.
            @frozen public enum SearchContextSizePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case low = "low"
                case medium = "medium"
                case high = "high"
            }
            /// High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchTool/search_context_size`.
            public var searchContextSize: Components.Schemas.WebSearchTool.SearchContextSizePayload?
            /// Creates a new `WebSearchTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
            ///   - filters:
            ///   - userLocation:
            ///   - searchContextSize: High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            public init(
                _type: Components.Schemas.WebSearchTool._TypePayload,
                filters: Components.Schemas.WebSearchTool.FiltersPayload? = nil,
                userLocation: Components.Schemas.WebSearchApproximateLocation? = nil,
                searchContextSize: Components.Schemas.WebSearchTool.SearchContextSizePayload? = nil
            ) {
                self._type = _type
                self.filters = filters
                self.userLocation = userLocation
                self.searchContextSize = searchContextSize
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case filters
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
            /// An object describing the specific action taken in this web search call.
            /// Includes details on how the model used the web (search, open_page, find_in_page).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/action`.
            @frozen public enum ActionPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/action/WebSearchActionSearch`.
                case webSearchActionSearch(Components.Schemas.WebSearchActionSearch)
                /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/action/WebSearchActionOpenPage`.
                case webSearchActionOpenPage(Components.Schemas.WebSearchActionOpenPage)
                /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/action/WebSearchActionFind`.
                case webSearchActionFind(Components.Schemas.WebSearchActionFind)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "WebSearchActionSearch", "#/components/schemas/WebSearchActionSearch", "search":
                        self = .webSearchActionSearch(try .init(from: decoder))
                    case "WebSearchActionOpenPage", "#/components/schemas/WebSearchActionOpenPage", "open_page":
                        self = .webSearchActionOpenPage(try .init(from: decoder))
                    case "WebSearchActionFind", "#/components/schemas/WebSearchActionFind", "find_in_page":
                        self = .webSearchActionFind(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .webSearchActionSearch(value):
                        try value.encode(to: encoder)
                    case let .webSearchActionOpenPage(value):
                        try value.encode(to: encoder)
                    case let .webSearchActionFind(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// An object describing the specific action taken in this web search call.
            /// Includes details on how the model used the web (search, open_page, find_in_page).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchToolCall/action`.
            public var action: Components.Schemas.WebSearchToolCall.ActionPayload
            /// Creates a new `WebSearchToolCall`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the web search tool call.
            ///   - _type: The type of the web search tool call. Always `web_search_call`.
            ///   - status: The status of the web search tool call.
            ///   - action: An object describing the specific action taken in this web search call.
            public init(
                id: Swift.String,
                _type: Components.Schemas.WebSearchToolCall._TypePayload,
                status: Components.Schemas.WebSearchToolCall.StatusPayload,
                action: Components.Schemas.WebSearchToolCall.ActionPayload
            ) {
                self.id = id
                self._type = _type
                self.status = status
                self.action = action
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case status
                case action
            }
        }
        /// - Remark: Generated from `#/components/schemas/SkillReferenceParam`.
        public struct SkillReferenceParam: Codable, Hashable, Sendable {
            /// References a skill created with the /v1/skills endpoint.
            ///
            /// - Remark: Generated from `#/components/schemas/SkillReferenceParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case skillReference = "skill_reference"
            }
            /// References a skill created with the /v1/skills endpoint.
            ///
            /// - Remark: Generated from `#/components/schemas/SkillReferenceParam/type`.
            public var _type: Components.Schemas.SkillReferenceParam._TypePayload
            /// The ID of the referenced skill.
            ///
            /// - Remark: Generated from `#/components/schemas/SkillReferenceParam/skill_id`.
            public var skillId: Swift.String
            /// Optional skill version. Use a positive integer or 'latest'. Omit for default.
            ///
            /// - Remark: Generated from `#/components/schemas/SkillReferenceParam/version`.
            public var version: Swift.String?
            /// Creates a new `SkillReferenceParam`.
            ///
            /// - Parameters:
            ///   - _type: References a skill created with the /v1/skills endpoint.
            ///   - skillId: The ID of the referenced skill.
            ///   - version: Optional skill version. Use a positive integer or 'latest'. Omit for default.
            public init(
                _type: Components.Schemas.SkillReferenceParam._TypePayload,
                skillId: Swift.String,
                version: Swift.String? = nil
            ) {
                self._type = _type
                self.skillId = skillId
                self.version = version
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case skillId = "skill_id"
                case version
            }
        }
        /// Inline skill payload
        ///
        /// - Remark: Generated from `#/components/schemas/InlineSkillSourceParam`.
        public struct InlineSkillSourceParam: Codable, Hashable, Sendable {
            /// The type of the inline skill source. Must be `base64`.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillSourceParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case base64 = "base64"
            }
            /// The type of the inline skill source. Must be `base64`.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillSourceParam/type`.
            public var _type: Components.Schemas.InlineSkillSourceParam._TypePayload
            /// The media type of the inline skill payload. Must be `application/zip`.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillSourceParam/media_type`.
            @frozen public enum MediaTypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applicationZip = "application/zip"
            }
            /// The media type of the inline skill payload. Must be `application/zip`.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillSourceParam/media_type`.
            public var mediaType: Components.Schemas.InlineSkillSourceParam.MediaTypePayload
            /// Base64-encoded skill zip bundle.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillSourceParam/data`.
            public var data: Swift.String
            /// Creates a new `InlineSkillSourceParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the inline skill source. Must be `base64`.
            ///   - mediaType: The media type of the inline skill payload. Must be `application/zip`.
            ///   - data: Base64-encoded skill zip bundle.
            public init(
                _type: Components.Schemas.InlineSkillSourceParam._TypePayload,
                mediaType: Components.Schemas.InlineSkillSourceParam.MediaTypePayload,
                data: Swift.String
            ) {
                self._type = _type
                self.mediaType = mediaType
                self.data = data
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case mediaType = "media_type"
                case data
            }
        }
        /// - Remark: Generated from `#/components/schemas/InlineSkillParam`.
        public struct InlineSkillParam: Codable, Hashable, Sendable {
            /// Defines an inline skill for this request.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inline = "inline"
            }
            /// Defines an inline skill for this request.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillParam/type`.
            public var _type: Components.Schemas.InlineSkillParam._TypePayload
            /// The name of the skill.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillParam/name`.
            public var name: Swift.String
            /// The description of the skill.
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillParam/description`.
            public var description: Swift.String
            /// Inline skill payload
            ///
            /// - Remark: Generated from `#/components/schemas/InlineSkillParam/source`.
            public var source: Components.Schemas.InlineSkillSourceParam
            /// Creates a new `InlineSkillParam`.
            ///
            /// - Parameters:
            ///   - _type: Defines an inline skill for this request.
            ///   - name: The name of the skill.
            ///   - description: The description of the skill.
            ///   - source: Inline skill payload
            public init(
                _type: Components.Schemas.InlineSkillParam._TypePayload,
                name: Swift.String,
                description: Swift.String,
                source: Components.Schemas.InlineSkillSourceParam
            ) {
                self._type = _type
                self.name = name
                self.description = description
                self.source = source
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case name
                case description
                case source
            }
        }
        /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDisabledParam`.
        public struct ContainerNetworkPolicyDisabledParam: Codable, Hashable, Sendable {
            /// Disable outbound network access. Always `disabled`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDisabledParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case disabled = "disabled"
            }
            /// Disable outbound network access. Always `disabled`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDisabledParam/type`.
            public var _type: Components.Schemas.ContainerNetworkPolicyDisabledParam._TypePayload
            /// Creates a new `ContainerNetworkPolicyDisabledParam`.
            ///
            /// - Parameters:
            ///   - _type: Disable outbound network access. Always `disabled`.
            public init(_type: Components.Schemas.ContainerNetworkPolicyDisabledParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDomainSecretParam`.
        public struct ContainerNetworkPolicyDomainSecretParam: Codable, Hashable, Sendable {
            /// The domain associated with the secret.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDomainSecretParam/domain`.
            public var domain: Swift.String
            /// The name of the secret to inject for the domain.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDomainSecretParam/name`.
            public var name: Swift.String
            /// The secret value to inject for the domain.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyDomainSecretParam/value`.
            public var value: Swift.String
            /// Creates a new `ContainerNetworkPolicyDomainSecretParam`.
            ///
            /// - Parameters:
            ///   - domain: The domain associated with the secret.
            ///   - name: The name of the secret to inject for the domain.
            ///   - value: The secret value to inject for the domain.
            public init(
                domain: Swift.String,
                name: Swift.String,
                value: Swift.String
            ) {
                self.domain = domain
                self.name = name
                self.value = value
            }
            public enum CodingKeys: String, CodingKey {
                case domain
                case name
                case value
            }
        }
        /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyAllowlistParam`.
        public struct ContainerNetworkPolicyAllowlistParam: Codable, Hashable, Sendable {
            /// Allow outbound network access only to specified domains. Always `allowlist`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyAllowlistParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case allowlist = "allowlist"
            }
            /// Allow outbound network access only to specified domains. Always `allowlist`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyAllowlistParam/type`.
            public var _type: Components.Schemas.ContainerNetworkPolicyAllowlistParam._TypePayload
            /// A list of allowed domains when type is `allowlist`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyAllowlistParam/allowed_domains`.
            public var allowedDomains: [Swift.String]
            /// Optional domain-scoped secrets for allowlisted domains.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerNetworkPolicyAllowlistParam/domain_secrets`.
            public var domainSecrets: [Components.Schemas.ContainerNetworkPolicyDomainSecretParam]?
            /// Creates a new `ContainerNetworkPolicyAllowlistParam`.
            ///
            /// - Parameters:
            ///   - _type: Allow outbound network access only to specified domains. Always `allowlist`.
            ///   - allowedDomains: A list of allowed domains when type is `allowlist`.
            ///   - domainSecrets: Optional domain-scoped secrets for allowlisted domains.
            public init(
                _type: Components.Schemas.ContainerNetworkPolicyAllowlistParam._TypePayload,
                allowedDomains: [Swift.String],
                domainSecrets: [Components.Schemas.ContainerNetworkPolicyDomainSecretParam]? = nil
            ) {
                self._type = _type
                self.allowedDomains = allowedDomains
                self.domainSecrets = domainSecrets
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case allowedDomains = "allowed_domains"
                case domainSecrets = "domain_secrets"
            }
        }
        /// Specify additional output data to include in the model response. Currently supported values are:
        /// - `web_search_call.results`: Include the search results of the web search tool call.
        /// - `web_search_call.action.sources`: Include the sources of the web search tool call.
        /// - `code_interpreter_call.outputs`: Includes the outputs of python code execution in code interpreter tool call items.
        /// - `computer_call_output.output.image_url`: Include image urls from the computer call output.
        /// - `file_search_call.results`: Include the search results of the file search tool call.
        /// - `message.input_image.image_url`: Include image urls from the input message.
        /// - `message.output_text.logprobs`: Include logprobs with assistant messages.
        /// - `reasoning.encrypted_content`: Includes an encrypted version of reasoning tokens in reasoning item outputs. This enables reasoning items to be used in multi-turn conversations when using the Responses API statelessly (like when the `store` parameter is set to `false`, or when an organization is enrolled in the zero data retention program).
        ///
        /// - Remark: Generated from `#/components/schemas/IncludeEnum`.
        @frozen public enum IncludeEnum: String, Codable, Hashable, Sendable, CaseIterable {
            case fileSearchCall_results = "file_search_call.results"
            case webSearchCall_results = "web_search_call.results"
            case webSearchCall_action_sources = "web_search_call.action.sources"
            case message_inputImage_imageUrl = "message.input_image.image_url"
            case computerCallOutput_output_imageUrl = "computer_call_output.output.image_url"
            case codeInterpreterCall_outputs = "code_interpreter_call.outputs"
            case reasoning_encryptedContent = "reasoning.encrypted_content"
            case message_outputText_logprobs = "message.output_text.logprobs"
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
            /// The filename of the file cited.
            ///
            /// - Remark: Generated from `#/components/schemas/FileCitationBody/filename`.
            public var filename: Swift.String
            /// Creates a new `FileCitationBody`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file citation. Always `file_citation`.
            ///   - fileId: The ID of the file.
            ///   - index: The index of the file in the list of files.
            ///   - filename: The filename of the file cited.
            public init(
                _type: Components.Schemas.FileCitationBody._TypePayload,
                fileId: Swift.String,
                index: Swift.Int,
                filename: Swift.String
            ) {
                self._type = _type
                self.fileId = fileId
                self.index = index
                self.filename = filename
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileId = "file_id"
                case index
                case filename
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
        /// A citation for a container file used to generate a model response.
        ///
        /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody`.
        public struct ContainerFileCitationBody: Codable, Hashable, Sendable {
            /// The type of the container file citation. Always `container_file_citation`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case containerFileCitation = "container_file_citation"
            }
            /// The type of the container file citation. Always `container_file_citation`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/type`.
            public var _type: Components.Schemas.ContainerFileCitationBody._TypePayload
            /// The ID of the container file.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/container_id`.
            public var containerId: Swift.String
            /// The ID of the file.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/file_id`.
            public var fileId: Swift.String
            /// The index of the first character of the container file citation in the message.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/start_index`.
            public var startIndex: Swift.Int
            /// The index of the last character of the container file citation in the message.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/end_index`.
            public var endIndex: Swift.Int
            /// The filename of the container file cited.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerFileCitationBody/filename`.
            public var filename: Swift.String
            /// Creates a new `ContainerFileCitationBody`.
            ///
            /// - Parameters:
            ///   - _type: The type of the container file citation. Always `container_file_citation`.
            ///   - containerId: The ID of the container file.
            ///   - fileId: The ID of the file.
            ///   - startIndex: The index of the first character of the container file citation in the message.
            ///   - endIndex: The index of the last character of the container file citation in the message.
            ///   - filename: The filename of the container file cited.
            public init(
                _type: Components.Schemas.ContainerFileCitationBody._TypePayload,
                containerId: Swift.String,
                fileId: Swift.String,
                startIndex: Swift.Int,
                endIndex: Swift.Int,
                filename: Swift.String
            ) {
                self._type = _type
                self.containerId = containerId
                self.fileId = fileId
                self.startIndex = startIndex
                self.endIndex = endIndex
                self.filename = filename
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case containerId = "container_id"
                case fileId = "file_id"
                case startIndex = "start_index"
                case endIndex = "end_index"
                case filename
            }
        }
        /// An annotation that applies to a span of output text.
        ///
        /// - Remark: Generated from `#/components/schemas/Annotation`.
        @frozen public enum Annotation: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/Annotation/FileCitationBody`.
            case fileCitationBody(Components.Schemas.FileCitationBody)
            /// - Remark: Generated from `#/components/schemas/Annotation/UrlCitationBody`.
            case urlCitationBody(Components.Schemas.UrlCitationBody)
            /// - Remark: Generated from `#/components/schemas/Annotation/ContainerFileCitationBody`.
            case containerFileCitationBody(Components.Schemas.ContainerFileCitationBody)
            /// - Remark: Generated from `#/components/schemas/Annotation/FilePath`.
            case filePath(Components.Schemas.FilePath)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "FileCitationBody", "#/components/schemas/FileCitationBody", "file_citation":
                    self = .fileCitationBody(try .init(from: decoder))
                case "UrlCitationBody", "#/components/schemas/UrlCitationBody", "url_citation":
                    self = .urlCitationBody(try .init(from: decoder))
                case "ContainerFileCitationBody", "#/components/schemas/ContainerFileCitationBody", "container_file_citation":
                    self = .containerFileCitationBody(try .init(from: decoder))
                case "FilePath", "#/components/schemas/FilePath", "file_path":
                    self = .filePath(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .fileCitationBody(value):
                    try value.encode(to: encoder)
                case let .urlCitationBody(value):
                    try value.encode(to: encoder)
                case let .containerFileCitationBody(value):
                    try value.encode(to: encoder)
                case let .filePath(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// The top log probability of a token.
        ///
        /// - Remark: Generated from `#/components/schemas/TopLogProb`.
        public struct TopLogProb: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/TopLogProb/token`.
            public var token: Swift.String
            /// - Remark: Generated from `#/components/schemas/TopLogProb/logprob`.
            public var logprob: Swift.Double
            /// - Remark: Generated from `#/components/schemas/TopLogProb/bytes`.
            public var bytes: [Swift.Int]
            /// Creates a new `TopLogProb`.
            ///
            /// - Parameters:
            ///   - token:
            ///   - logprob:
            ///   - bytes:
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
        /// The log probability of a token.
        ///
        /// - Remark: Generated from `#/components/schemas/LogProb`.
        public struct LogProb: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/LogProb/token`.
            public var token: Swift.String
            /// - Remark: Generated from `#/components/schemas/LogProb/logprob`.
            public var logprob: Swift.Double
            /// - Remark: Generated from `#/components/schemas/LogProb/bytes`.
            public var bytes: [Swift.Int]
            /// - Remark: Generated from `#/components/schemas/LogProb/top_logprobs`.
            public var topLogprobs: [Components.Schemas.TopLogProb]
            /// Creates a new `LogProb`.
            ///
            /// - Parameters:
            ///   - token:
            ///   - logprob:
            ///   - bytes:
            ///   - topLogprobs:
            public init(
                token: Swift.String,
                logprob: Swift.Double,
                bytes: [Swift.Int],
                topLogprobs: [Components.Schemas.TopLogProb]
            ) {
                self.token = token
                self.logprob = logprob
                self.bytes = bytes
                self.topLogprobs = topLogprobs
            }
            public enum CodingKeys: String, CodingKey {
                case token
                case logprob
                case bytes
                case topLogprobs = "top_logprobs"
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
            /// - Remark: Generated from `#/components/schemas/OutputTextContent/logprobs`.
            public var logprobs: [Components.Schemas.LogProb]
            /// Creates a new `OutputTextContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the output text. Always `output_text`.
            ///   - text: The text output from the model.
            ///   - annotations: The annotations of the text output.
            ///   - logprobs:
            public init(
                _type: Components.Schemas.OutputTextContent._TypePayload,
                text: Swift.String,
                annotations: [Components.Schemas.Annotation],
                logprobs: [Components.Schemas.LogProb]
            ) {
                self._type = _type
                self.text = text
                self.annotations = annotations
                self.logprobs = logprobs
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case text
                case annotations
                case logprobs
            }
        }
        /// A summary text from the model.
        ///
        /// - Remark: Generated from `#/components/schemas/SummaryTextContent`.
        public struct SummaryTextContent: Codable, Hashable, Sendable {
            /// The type of the object. Always `summary_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/SummaryTextContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case summaryText = "summary_text"
            }
            /// The type of the object. Always `summary_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/SummaryTextContent/type`.
            public var _type: Components.Schemas.SummaryTextContent._TypePayload
            /// A summary of the reasoning output from the model so far.
            ///
            /// - Remark: Generated from `#/components/schemas/SummaryTextContent/text`.
            public var text: Swift.String
            /// Creates a new `SummaryTextContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the object. Always `summary_text`.
            ///   - text: A summary of the reasoning output from the model so far.
            public init(
                _type: Components.Schemas.SummaryTextContent._TypePayload,
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
        /// Reasoning text from the model.
        ///
        /// - Remark: Generated from `#/components/schemas/ReasoningTextContent`.
        public struct ReasoningTextContent: Codable, Hashable, Sendable {
            /// The type of the reasoning text. Always `reasoning_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningTextContent/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case reasoningText = "reasoning_text"
            }
            /// The type of the reasoning text. Always `reasoning_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningTextContent/type`.
            public var _type: Components.Schemas.ReasoningTextContent._TypePayload
            /// The reasoning text from the model.
            ///
            /// - Remark: Generated from `#/components/schemas/ReasoningTextContent/text`.
            public var text: Swift.String
            /// Creates a new `ReasoningTextContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the reasoning text. Always `reasoning_text`.
            ///   - text: The reasoning text from the model.
            public init(
                _type: Components.Schemas.ReasoningTextContent._TypePayload,
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
            /// The refusal explanation from the model.
            ///
            /// - Remark: Generated from `#/components/schemas/RefusalContent/refusal`.
            public var refusal: Swift.String
            /// Creates a new `RefusalContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the refusal. Always `refusal`.
            ///   - refusal: The refusal explanation from the model.
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
        /// - Remark: Generated from `#/components/schemas/ImageDetail`.
        @frozen public enum ImageDetail: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case high = "high"
            case auto = "auto"
            case original = "original"
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
            public var imageUrl: Swift.String?
            /// - Remark: Generated from `#/components/schemas/InputImageContent/file_id`.
            public var fileId: Swift.String?
            /// The detail level of the image to be sent to the model. One of `high`, `low`, `auto`, or `original`. Defaults to `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContent/detail`.
            public var detail: Components.Schemas.ImageDetail
            /// Creates a new `InputImageContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_image`.
            ///   - imageUrl:
            ///   - fileId:
            ///   - detail: The detail level of the image to be sent to the model. One of `high`, `low`, `auto`, or `original`. Defaults to `auto`.
            public init(
                _type: Components.Schemas.InputImageContent._TypePayload,
                imageUrl: Swift.String? = nil,
                fileId: Swift.String? = nil,
                detail: Components.Schemas.ImageDetail
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
        /// - Remark: Generated from `#/components/schemas/FileInputDetail`.
        @frozen public enum FileInputDetail: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case high = "high"
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
            public var fileId: Swift.String?
            /// The name of the file to be sent to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/filename`.
            public var filename: Swift.String?
            /// The content of the file to be sent to the model.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/file_data`.
            public var fileData: Swift.String?
            /// The URL of the file to be sent to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/file_url`.
            public var fileUrl: Swift.String?
            /// The detail level of the file to be sent to the model. Use `low` for the default rendering behavior, or `high` to render the file at higher quality. Defaults to `low`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContent/detail`.
            public var detail: Components.Schemas.FileInputDetail?
            /// Creates a new `InputFileContent`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_file`.
            ///   - fileId:
            ///   - filename: The name of the file to be sent to the model.
            ///   - fileData: The content of the file to be sent to the model.
            ///   - fileUrl: The URL of the file to be sent to the model.
            ///   - detail: The detail level of the file to be sent to the model. Use `low` for the default rendering behavior, or `high` to render the file at higher quality. Defaults to `low`.
            public init(
                _type: Components.Schemas.InputFileContent._TypePayload,
                fileId: Swift.String? = nil,
                filename: Swift.String? = nil,
                fileData: Swift.String? = nil,
                fileUrl: Swift.String? = nil,
                detail: Components.Schemas.FileInputDetail? = nil
            ) {
                self._type = _type
                self.fileId = fileId
                self.filename = filename
                self.fileData = fileData
                self.fileUrl = fileUrl
                self.detail = detail
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileId = "file_id"
                case filename
                case fileData = "file_data"
                case fileUrl = "file_url"
                case detail
            }
        }
        /// - Remark: Generated from `#/components/schemas/FunctionCallStatus`.
        @frozen public enum FunctionCallStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
        }
        /// - Remark: Generated from `#/components/schemas/FunctionCallOutputStatusEnum`.
        @frozen public enum FunctionCallOutputStatusEnum: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
        }
        /// - Remark: Generated from `#/components/schemas/ClickButtonType`.
        @frozen public enum ClickButtonType: String, Codable, Hashable, Sendable, CaseIterable {
            case left = "left"
            case right = "right"
            case wheel = "wheel"
            case back = "back"
            case forward = "forward"
        }
        /// A click action.
        ///
        /// - Remark: Generated from `#/components/schemas/ClickParam`.
        public struct ClickParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a click action, this property is always `click`.
            ///
            /// - Remark: Generated from `#/components/schemas/ClickParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case click = "click"
            }
            /// Specifies the event type. For a click action, this property is always `click`.
            ///
            /// - Remark: Generated from `#/components/schemas/ClickParam/type`.
            public var _type: Components.Schemas.ClickParam._TypePayload
            /// Indicates which mouse button was pressed during the click. One of `left`, `right`, `wheel`, `back`, or `forward`.
            ///
            /// - Remark: Generated from `#/components/schemas/ClickParam/button`.
            public var button: Components.Schemas.ClickButtonType
            /// The x-coordinate where the click occurred.
            ///
            /// - Remark: Generated from `#/components/schemas/ClickParam/x`.
            public var x: Swift.Int
            /// The y-coordinate where the click occurred.
            ///
            /// - Remark: Generated from `#/components/schemas/ClickParam/y`.
            public var y: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ClickParam/keys`.
            public var keys: [Swift.String]?
            /// Creates a new `ClickParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a click action, this property is always `click`.
            ///   - button: Indicates which mouse button was pressed during the click. One of `left`, `right`, `wheel`, `back`, or `forward`.
            ///   - x: The x-coordinate where the click occurred.
            ///   - y: The y-coordinate where the click occurred.
            ///   - keys:
            public init(
                _type: Components.Schemas.ClickParam._TypePayload,
                button: Components.Schemas.ClickButtonType,
                x: Swift.Int,
                y: Swift.Int,
                keys: [Swift.String]? = nil
            ) {
                self._type = _type
                self.button = button
                self.x = x
                self.y = y
                self.keys = keys
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case button
                case x
                case y
                case keys
            }
        }
        /// A double click action.
        ///
        /// - Remark: Generated from `#/components/schemas/DoubleClickAction`.
        public struct DoubleClickAction: Codable, Hashable, Sendable {
            /// Specifies the event type. For a double click action, this property is always set to `double_click`.
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClickAction/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case doubleClick = "double_click"
            }
            /// Specifies the event type. For a double click action, this property is always set to `double_click`.
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClickAction/type`.
            public var _type: Components.Schemas.DoubleClickAction._TypePayload
            /// The x-coordinate where the double click occurred.
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClickAction/x`.
            public var x: Swift.Int
            /// The y-coordinate where the double click occurred.
            ///
            /// - Remark: Generated from `#/components/schemas/DoubleClickAction/y`.
            public var y: Swift.Int
            /// - Remark: Generated from `#/components/schemas/DoubleClickAction/keys`.
            public var keys: [Swift.String]?
            /// Creates a new `DoubleClickAction`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a double click action, this property is always set to `double_click`.
            ///   - x: The x-coordinate where the double click occurred.
            ///   - y: The y-coordinate where the double click occurred.
            ///   - keys:
            public init(
                _type: Components.Schemas.DoubleClickAction._TypePayload,
                x: Swift.Int,
                y: Swift.Int,
                keys: [Swift.String]? = nil
            ) {
                self._type = _type
                self.x = x
                self.y = y
                self.keys = keys
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case x
                case y
                case keys
            }
        }
        /// An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`.
        ///
        /// - Remark: Generated from `#/components/schemas/CoordParam`.
        public struct CoordParam: Codable, Hashable, Sendable {
            /// The x-coordinate.
            ///
            /// - Remark: Generated from `#/components/schemas/CoordParam/x`.
            public var x: Swift.Int
            /// The y-coordinate.
            ///
            /// - Remark: Generated from `#/components/schemas/CoordParam/y`.
            public var y: Swift.Int
            /// Creates a new `CoordParam`.
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
        /// A drag action.
        ///
        /// - Remark: Generated from `#/components/schemas/DragParam`.
        public struct DragParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a drag action, this property is always set to `drag`.
            ///
            /// - Remark: Generated from `#/components/schemas/DragParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case drag = "drag"
            }
            /// Specifies the event type. For a drag action, this property is always set to `drag`.
            ///
            /// - Remark: Generated from `#/components/schemas/DragParam/type`.
            public var _type: Components.Schemas.DragParam._TypePayload
            /// An array of coordinates representing the path of the drag action. Coordinates will appear as an array of objects, eg
            /// ```
            /// [
            ///   { x: 100, y: 200 },
            ///   { x: 200, y: 300 }
            /// ]
            /// ```
            ///
            /// - Remark: Generated from `#/components/schemas/DragParam/path`.
            public var path: [Components.Schemas.CoordParam]
            /// - Remark: Generated from `#/components/schemas/DragParam/keys`.
            public var keys: [Swift.String]?
            /// Creates a new `DragParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a drag action, this property is always set to `drag`.
            ///   - path: An array of coordinates representing the path of the drag action. Coordinates will appear as an array of objects, eg
            ///   - keys:
            public init(
                _type: Components.Schemas.DragParam._TypePayload,
                path: [Components.Schemas.CoordParam],
                keys: [Swift.String]? = nil
            ) {
                self._type = _type
                self.path = path
                self.keys = keys
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
                case keys
            }
        }
        /// A collection of keypresses the model would like to perform.
        ///
        /// - Remark: Generated from `#/components/schemas/KeyPressAction`.
        public struct KeyPressAction: Codable, Hashable, Sendable {
            /// Specifies the event type. For a keypress action, this property is always set to `keypress`.
            ///
            /// - Remark: Generated from `#/components/schemas/KeyPressAction/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case keypress = "keypress"
            }
            /// Specifies the event type. For a keypress action, this property is always set to `keypress`.
            ///
            /// - Remark: Generated from `#/components/schemas/KeyPressAction/type`.
            public var _type: Components.Schemas.KeyPressAction._TypePayload
            /// The combination of keys the model is requesting to be pressed. This is an array of strings, each representing a key.
            ///
            /// - Remark: Generated from `#/components/schemas/KeyPressAction/keys`.
            public var keys: [Swift.String]
            /// Creates a new `KeyPressAction`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a keypress action, this property is always set to `keypress`.
            ///   - keys: The combination of keys the model is requesting to be pressed. This is an array of strings, each representing a key.
            public init(
                _type: Components.Schemas.KeyPressAction._TypePayload,
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
        /// A mouse move action.
        ///
        /// - Remark: Generated from `#/components/schemas/MoveParam`.
        public struct MoveParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a move action, this property is always set to `move`.
            ///
            /// - Remark: Generated from `#/components/schemas/MoveParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case move = "move"
            }
            /// Specifies the event type. For a move action, this property is always set to `move`.
            ///
            /// - Remark: Generated from `#/components/schemas/MoveParam/type`.
            public var _type: Components.Schemas.MoveParam._TypePayload
            /// The x-coordinate to move to.
            ///
            /// - Remark: Generated from `#/components/schemas/MoveParam/x`.
            public var x: Swift.Int
            /// The y-coordinate to move to.
            ///
            /// - Remark: Generated from `#/components/schemas/MoveParam/y`.
            public var y: Swift.Int
            /// - Remark: Generated from `#/components/schemas/MoveParam/keys`.
            public var keys: [Swift.String]?
            /// Creates a new `MoveParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a move action, this property is always set to `move`.
            ///   - x: The x-coordinate to move to.
            ///   - y: The y-coordinate to move to.
            ///   - keys:
            public init(
                _type: Components.Schemas.MoveParam._TypePayload,
                x: Swift.Int,
                y: Swift.Int,
                keys: [Swift.String]? = nil
            ) {
                self._type = _type
                self.x = x
                self.y = y
                self.keys = keys
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case x
                case y
                case keys
            }
        }
        /// A screenshot action.
        ///
        /// - Remark: Generated from `#/components/schemas/ScreenshotParam`.
        public struct ScreenshotParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a screenshot action, this property is always set to `screenshot`.
            ///
            /// - Remark: Generated from `#/components/schemas/ScreenshotParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case screenshot = "screenshot"
            }
            /// Specifies the event type. For a screenshot action, this property is always set to `screenshot`.
            ///
            /// - Remark: Generated from `#/components/schemas/ScreenshotParam/type`.
            public var _type: Components.Schemas.ScreenshotParam._TypePayload
            /// Creates a new `ScreenshotParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a screenshot action, this property is always set to `screenshot`.
            public init(_type: Components.Schemas.ScreenshotParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// A scroll action.
        ///
        /// - Remark: Generated from `#/components/schemas/ScrollParam`.
        public struct ScrollParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a scroll action, this property is always set to `scroll`.
            ///
            /// - Remark: Generated from `#/components/schemas/ScrollParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case scroll = "scroll"
            }
            /// Specifies the event type. For a scroll action, this property is always set to `scroll`.
            ///
            /// - Remark: Generated from `#/components/schemas/ScrollParam/type`.
            public var _type: Components.Schemas.ScrollParam._TypePayload
            /// The x-coordinate where the scroll occurred.
            ///
            /// - Remark: Generated from `#/components/schemas/ScrollParam/x`.
            public var x: Swift.Int
            /// The y-coordinate where the scroll occurred.
            ///
            /// - Remark: Generated from `#/components/schemas/ScrollParam/y`.
            public var y: Swift.Int
            /// The horizontal scroll distance.
            ///
            /// - Remark: Generated from `#/components/schemas/ScrollParam/scroll_x`.
            public var scrollX: Swift.Int
            /// The vertical scroll distance.
            ///
            /// - Remark: Generated from `#/components/schemas/ScrollParam/scroll_y`.
            public var scrollY: Swift.Int
            /// - Remark: Generated from `#/components/schemas/ScrollParam/keys`.
            public var keys: [Swift.String]?
            /// Creates a new `ScrollParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a scroll action, this property is always set to `scroll`.
            ///   - x: The x-coordinate where the scroll occurred.
            ///   - y: The y-coordinate where the scroll occurred.
            ///   - scrollX: The horizontal scroll distance.
            ///   - scrollY: The vertical scroll distance.
            ///   - keys:
            public init(
                _type: Components.Schemas.ScrollParam._TypePayload,
                x: Swift.Int,
                y: Swift.Int,
                scrollX: Swift.Int,
                scrollY: Swift.Int,
                keys: [Swift.String]? = nil
            ) {
                self._type = _type
                self.x = x
                self.y = y
                self.scrollX = scrollX
                self.scrollY = scrollY
                self.keys = keys
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case x
                case y
                case scrollX = "scroll_x"
                case scrollY = "scroll_y"
                case keys
            }
        }
        /// An action to type in text.
        ///
        /// - Remark: Generated from `#/components/schemas/TypeParam`.
        public struct TypeParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a type action, this property is always set to `type`.
            ///
            /// - Remark: Generated from `#/components/schemas/TypeParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case _type = "type"
            }
            /// Specifies the event type. For a type action, this property is always set to `type`.
            ///
            /// - Remark: Generated from `#/components/schemas/TypeParam/type`.
            public var _type: Components.Schemas.TypeParam._TypePayload
            /// The text to type.
            ///
            /// - Remark: Generated from `#/components/schemas/TypeParam/text`.
            public var text: Swift.String
            /// Creates a new `TypeParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a type action, this property is always set to `type`.
            ///   - text: The text to type.
            public init(
                _type: Components.Schemas.TypeParam._TypePayload,
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
        /// A wait action.
        ///
        /// - Remark: Generated from `#/components/schemas/WaitParam`.
        public struct WaitParam: Codable, Hashable, Sendable {
            /// Specifies the event type. For a wait action, this property is always set to `wait`.
            ///
            /// - Remark: Generated from `#/components/schemas/WaitParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case wait = "wait"
            }
            /// Specifies the event type. For a wait action, this property is always set to `wait`.
            ///
            /// - Remark: Generated from `#/components/schemas/WaitParam/type`.
            public var _type: Components.Schemas.WaitParam._TypePayload
            /// Creates a new `WaitParam`.
            ///
            /// - Parameters:
            ///   - _type: Specifies the event type. For a wait action, this property is always set to `wait`.
            public init(_type: Components.Schemas.WaitParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
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
            public var code: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam/message`.
            public var message: Swift.String?
            /// Creates a new `ComputerCallSafetyCheckParam`.
            ///
            /// - Parameters:
            ///   - id: The ID of the pending safety check.
            ///   - code:
            ///   - message:
            public init(
                id: Swift.String,
                code: Swift.String? = nil,
                message: Swift.String? = nil
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
        /// - Remark: Generated from `#/components/schemas/ComputerCallOutputStatus`.
        @frozen public enum ComputerCallOutputStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case completed = "completed"
            case incomplete = "incomplete"
            case failed = "failed"
        }
        /// - Remark: Generated from `#/components/schemas/ToolSearchExecutionType`.
        @frozen public enum ToolSearchExecutionType: String, Codable, Hashable, Sendable, CaseIterable {
            case server = "server"
            case client = "client"
        }
        /// - Remark: Generated from `#/components/schemas/ToolSearchCall`.
        public struct ToolSearchCall: Codable, Hashable, Sendable {
            /// The type of the item. Always `tool_search_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case toolSearchCall = "tool_search_call"
            }
            /// The type of the item. Always `tool_search_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/type`.
            public var _type: Components.Schemas.ToolSearchCall._TypePayload
            /// The unique ID of the tool search call item.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/id`.
            public var id: Swift.String
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/call_id`.
            public var callId: Swift.String?
            /// Whether tool search was executed by the server or by the client.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/execution`.
            public var execution: Components.Schemas.ToolSearchExecutionType
            /// Arguments used for the tool search call.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/arguments`.
            public var arguments: OpenAPIRuntime.OpenAPIValueContainer
            /// The status of the tool search call item that was recorded.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/status`.
            public var status: Components.Schemas.FunctionCallStatus
            /// The identifier of the actor that created the item.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCall/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `ToolSearchCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `tool_search_call`.
            ///   - id: The unique ID of the tool search call item.
            ///   - callId:
            ///   - execution: Whether tool search was executed by the server or by the client.
            ///   - arguments: Arguments used for the tool search call.
            ///   - status: The status of the tool search call item that was recorded.
            ///   - createdBy: The identifier of the actor that created the item.
            public init(
                _type: Components.Schemas.ToolSearchCall._TypePayload,
                id: Swift.String,
                callId: Swift.String? = nil,
                execution: Components.Schemas.ToolSearchExecutionType,
                arguments: OpenAPIRuntime.OpenAPIValueContainer,
                status: Components.Schemas.FunctionCallStatus,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.execution = execution
                self.arguments = arguments
                self.status = status
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case execution
                case arguments
                case status
                case createdBy = "created_by"
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
            public var description: Swift.String?
            /// A JSON schema object describing the parameters of the function.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters`.
            public struct ParametersPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                public var additionalProperties: [String: OpenAPIRuntime.OpenAPIValueContainer]
                /// Creates a new `ParametersPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                public init(additionalProperties: [String: OpenAPIRuntime.OpenAPIValueContainer] = .init()) {
                    self.additionalProperties = additionalProperties
                }
                public init(from decoder: any Swift.Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionTool/parameters`.
            public var parameters: Components.Schemas.FunctionTool.ParametersPayload?
            /// - Remark: Generated from `#/components/schemas/FunctionTool/strict`.
            public var strict: Swift.Bool?
            /// Whether this function is deferred and loaded via tool search.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionTool/defer_loading`.
            public var deferLoading: Swift.Bool?
            /// Creates a new `FunctionTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the function tool. Always `function`.
            ///   - name: The name of the function to call.
            ///   - description:
            ///   - parameters:
            ///   - strict:
            ///   - deferLoading: Whether this function is deferred and loaded via tool search.
            public init(
                _type: Components.Schemas.FunctionTool._TypePayload,
                name: Swift.String,
                description: Swift.String? = nil,
                parameters: Components.Schemas.FunctionTool.ParametersPayload? = nil,
                strict: Swift.Bool? = nil,
                deferLoading: Swift.Bool? = nil
            ) {
                self._type = _type
                self.name = name
                self.description = description
                self.parameters = parameters
                self.strict = strict
                self.deferLoading = deferLoading
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case name
                case description
                case parameters
                case strict
                case deferLoading = "defer_loading"
            }
        }
        /// - Remark: Generated from `#/components/schemas/RankerVersionType`.
        @frozen public enum RankerVersionType: String, Codable, Hashable, Sendable, CaseIterable {
            case auto = "auto"
            case default20241115 = "default-2024-11-15"
        }
        /// - Remark: Generated from `#/components/schemas/HybridSearchOptions`.
        public struct HybridSearchOptions: Codable, Hashable, Sendable {
            /// The weight of the embedding in the reciprocal ranking fusion.
            ///
            /// - Remark: Generated from `#/components/schemas/HybridSearchOptions/embedding_weight`.
            public var embeddingWeight: Swift.Double
            /// The weight of the text in the reciprocal ranking fusion.
            ///
            /// - Remark: Generated from `#/components/schemas/HybridSearchOptions/text_weight`.
            public var textWeight: Swift.Double
            /// Creates a new `HybridSearchOptions`.
            ///
            /// - Parameters:
            ///   - embeddingWeight: The weight of the embedding in the reciprocal ranking fusion.
            ///   - textWeight: The weight of the text in the reciprocal ranking fusion.
            public init(
                embeddingWeight: Swift.Double,
                textWeight: Swift.Double
            ) {
                self.embeddingWeight = embeddingWeight
                self.textWeight = textWeight
            }
            public enum CodingKeys: String, CodingKey {
                case embeddingWeight = "embedding_weight"
                case textWeight = "text_weight"
            }
        }
        /// - Remark: Generated from `#/components/schemas/RankingOptions`.
        public struct RankingOptions: Codable, Hashable, Sendable {
            /// The ranker to use for the file search.
            ///
            /// - Remark: Generated from `#/components/schemas/RankingOptions/ranker`.
            public var ranker: Components.Schemas.RankerVersionType?
            /// The score threshold for the file search, a number between 0 and 1. Numbers closer to 1 will attempt to return only the most relevant results, but may return fewer results.
            ///
            /// - Remark: Generated from `#/components/schemas/RankingOptions/score_threshold`.
            public var scoreThreshold: Swift.Double?
            /// Weights that control how reciprocal rank fusion balances semantic embedding matches versus sparse keyword matches when hybrid search is enabled.
            ///
            /// - Remark: Generated from `#/components/schemas/RankingOptions/hybrid_search`.
            public var hybridSearch: Components.Schemas.HybridSearchOptions?
            /// Creates a new `RankingOptions`.
            ///
            /// - Parameters:
            ///   - ranker: The ranker to use for the file search.
            ///   - scoreThreshold: The score threshold for the file search, a number between 0 and 1. Numbers closer to 1 will attempt to return only the most relevant results, but may return fewer results.
            ///   - hybridSearch: Weights that control how reciprocal rank fusion balances semantic embedding matches versus sparse keyword matches when hybrid search is enabled.
            public init(
                ranker: Components.Schemas.RankerVersionType? = nil,
                scoreThreshold: Swift.Double? = nil,
                hybridSearch: Components.Schemas.HybridSearchOptions? = nil
            ) {
                self.ranker = ranker
                self.scoreThreshold = scoreThreshold
                self.hybridSearch = hybridSearch
            }
            public enum CodingKeys: String, CodingKey {
                case ranker
                case scoreThreshold = "score_threshold"
                case hybridSearch = "hybrid_search"
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
            public init(from decoder: any Swift.Decoder) throws {
                var errors: [any Swift.Error] = []
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
            public func encode(to encoder: any Swift.Encoder) throws {
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
            /// Ranking options for search.
            ///
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/ranking_options`.
            public var rankingOptions: Components.Schemas.RankingOptions?
            /// - Remark: Generated from `#/components/schemas/Filters`.
            public typealias Filters = Components.Schemas.Filters
            /// - Remark: Generated from `#/components/schemas/FileSearchTool/filters`.
            public var filters: Components.Schemas.Filters?
            /// Creates a new `FileSearchTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the file search tool. Always `file_search`.
            ///   - vectorStoreIds: The IDs of the vector stores to search.
            ///   - maxNumResults: The maximum number of results to return. This number should be between 1 and 50 inclusive.
            ///   - rankingOptions: Ranking options for search.
            ///   - filters:
            public init(
                _type: Components.Schemas.FileSearchTool._TypePayload,
                vectorStoreIds: [Swift.String],
                maxNumResults: Swift.Int? = nil,
                rankingOptions: Components.Schemas.RankingOptions? = nil,
                filters: Components.Schemas.Filters? = nil
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
        /// A tool that controls a virtual computer. Learn more about the [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerTool`.
        public struct ComputerTool: Codable, Hashable, Sendable {
            /// The type of the computer tool. Always `computer`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case computer = "computer"
            }
            /// The type of the computer tool. Always `computer`.
            ///
            /// - Remark: Generated from `#/components/schemas/ComputerTool/type`.
            public var _type: Components.Schemas.ComputerTool._TypePayload
            /// Creates a new `ComputerTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the computer tool. Always `computer`.
            public init(_type: Components.Schemas.ComputerTool._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ComputerEnvironment`.
        @frozen public enum ComputerEnvironment: String, Codable, Hashable, Sendable, CaseIterable {
            case windows = "windows"
            case mac = "mac"
            case linux = "linux"
            case ubuntu = "ubuntu"
            case browser = "browser"
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
            public var environment: Components.Schemas.ComputerEnvironment
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
                environment: Components.Schemas.ComputerEnvironment,
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
        /// - Remark: Generated from `#/components/schemas/ContainerMemoryLimit`.
        @frozen public enum ContainerMemoryLimit: String, Codable, Hashable, Sendable, CaseIterable {
            case _1g = "1g"
            case _4g = "4g"
            case _16g = "16g"
            case _64g = "64g"
        }
        /// Configuration for a code interpreter container. Optionally specify the IDs of the files to run the code on.
        ///
        /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam`.
        public struct AutoCodeInterpreterToolParam: Codable, Hashable, Sendable {
            /// Always `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case auto = "auto"
            }
            /// Always `auto`.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/type`.
            public var _type: Components.Schemas.AutoCodeInterpreterToolParam._TypePayload
            /// An optional list of uploaded files to make available to your code.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/file_ids`.
            public var fileIds: [Swift.String]?
            /// - Remark: Generated from `#/components/schemas/ContainerMemoryLimit`.
            public typealias ContainerMemoryLimit = Components.Schemas.ContainerMemoryLimit
            /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/memory_limit`.
            public var memoryLimit: Components.Schemas.ContainerMemoryLimit?
            /// Network access policy for the container.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/network_policy`.
            @frozen public enum NetworkPolicyPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/network_policy/ContainerNetworkPolicyDisabledParam`.
                case containerNetworkPolicyDisabledParam(Components.Schemas.ContainerNetworkPolicyDisabledParam)
                /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/network_policy/ContainerNetworkPolicyAllowlistParam`.
                case containerNetworkPolicyAllowlistParam(Components.Schemas.ContainerNetworkPolicyAllowlistParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "ContainerNetworkPolicyDisabledParam", "#/components/schemas/ContainerNetworkPolicyDisabledParam", "disabled":
                        self = .containerNetworkPolicyDisabledParam(try .init(from: decoder))
                    case "ContainerNetworkPolicyAllowlistParam", "#/components/schemas/ContainerNetworkPolicyAllowlistParam", "allowlist":
                        self = .containerNetworkPolicyAllowlistParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .containerNetworkPolicyDisabledParam(value):
                        try value.encode(to: encoder)
                    case let .containerNetworkPolicyAllowlistParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// Network access policy for the container.
            ///
            /// - Remark: Generated from `#/components/schemas/AutoCodeInterpreterToolParam/network_policy`.
            public var networkPolicy: Components.Schemas.AutoCodeInterpreterToolParam.NetworkPolicyPayload?
            /// Creates a new `AutoCodeInterpreterToolParam`.
            ///
            /// - Parameters:
            ///   - _type: Always `auto`.
            ///   - fileIds: An optional list of uploaded files to make available to your code.
            ///   - memoryLimit:
            ///   - networkPolicy: Network access policy for the container.
            public init(
                _type: Components.Schemas.AutoCodeInterpreterToolParam._TypePayload,
                fileIds: [Swift.String]? = nil,
                memoryLimit: Components.Schemas.ContainerMemoryLimit? = nil,
                networkPolicy: Components.Schemas.AutoCodeInterpreterToolParam.NetworkPolicyPayload? = nil
            ) {
                self._type = _type
                self.fileIds = fileIds
                self.memoryLimit = memoryLimit
                self.networkPolicy = networkPolicy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileIds = "file_ids"
                case memoryLimit = "memory_limit"
                case networkPolicy = "network_policy"
            }
        }
        /// Control how much effort the model will exert to match the style and features, especially facial features, of input images. This parameter is only supported for `gpt-image-1` and `gpt-image-1.5` and later models, unsupported for `gpt-image-1-mini`. Supports `high` and `low`. Defaults to `low`.
        ///
        /// - Remark: Generated from `#/components/schemas/InputFidelity`.
        @frozen public enum InputFidelity: String, Codable, Hashable, Sendable, CaseIterable {
            case high = "high"
            case low = "low"
        }
        /// - Remark: Generated from `#/components/schemas/ImageGenActionEnum`.
        @frozen public enum ImageGenActionEnum: String, Codable, Hashable, Sendable, CaseIterable {
            case generate = "generate"
            case edit = "edit"
            case auto = "auto"
        }
        /// A tool that allows the model to execute shell commands in a local environment.
        ///
        /// - Remark: Generated from `#/components/schemas/LocalShellToolParam`.
        public struct LocalShellToolParam: Codable, Hashable, Sendable {
            /// The type of the local shell tool. Always `local_shell`.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case localShell = "local_shell"
            }
            /// The type of the local shell tool. Always `local_shell`.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellToolParam/type`.
            public var _type: Components.Schemas.LocalShellToolParam._TypePayload
            /// Creates a new `LocalShellToolParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the local shell tool. Always `local_shell`.
            public init(_type: Components.Schemas.LocalShellToolParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ContainerAutoParam`.
        public struct ContainerAutoParam: Codable, Hashable, Sendable {
            /// Automatically creates a container for this request
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case containerAuto = "container_auto"
            }
            /// Automatically creates a container for this request
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/type`.
            public var _type: Components.Schemas.ContainerAutoParam._TypePayload
            /// An optional list of uploaded files to make available to your code.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/file_ids`.
            public var fileIds: [Swift.String]?
            /// - Remark: Generated from `#/components/schemas/ContainerMemoryLimit`.
            public typealias ContainerMemoryLimit = Components.Schemas.ContainerMemoryLimit
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/memory_limit`.
            public var memoryLimit: Components.Schemas.ContainerMemoryLimit?
            /// Network access policy for the container.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/network_policy`.
            @frozen public enum NetworkPolicyPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/network_policy/ContainerNetworkPolicyDisabledParam`.
                case containerNetworkPolicyDisabledParam(Components.Schemas.ContainerNetworkPolicyDisabledParam)
                /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/network_policy/ContainerNetworkPolicyAllowlistParam`.
                case containerNetworkPolicyAllowlistParam(Components.Schemas.ContainerNetworkPolicyAllowlistParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "ContainerNetworkPolicyDisabledParam", "#/components/schemas/ContainerNetworkPolicyDisabledParam", "disabled":
                        self = .containerNetworkPolicyDisabledParam(try .init(from: decoder))
                    case "ContainerNetworkPolicyAllowlistParam", "#/components/schemas/ContainerNetworkPolicyAllowlistParam", "allowlist":
                        self = .containerNetworkPolicyAllowlistParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .containerNetworkPolicyDisabledParam(value):
                        try value.encode(to: encoder)
                    case let .containerNetworkPolicyAllowlistParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// Network access policy for the container.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/network_policy`.
            public var networkPolicy: Components.Schemas.ContainerAutoParam.NetworkPolicyPayload?
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/SkillsPayload`.
            @frozen public enum SkillsPayloadPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/SkillsPayload/SkillReferenceParam`.
                case skillReferenceParam(Components.Schemas.SkillReferenceParam)
                /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/SkillsPayload/InlineSkillParam`.
                case inlineSkillParam(Components.Schemas.InlineSkillParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "SkillReferenceParam", "#/components/schemas/SkillReferenceParam", "skill_reference":
                        self = .skillReferenceParam(try .init(from: decoder))
                    case "InlineSkillParam", "#/components/schemas/InlineSkillParam", "inline":
                        self = .inlineSkillParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .skillReferenceParam(value):
                        try value.encode(to: encoder)
                    case let .inlineSkillParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// An optional list of skills referenced by id or inline data.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/skills`.
            public typealias SkillsPayload = [Components.Schemas.ContainerAutoParam.SkillsPayloadPayload]
            /// An optional list of skills referenced by id or inline data.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerAutoParam/skills`.
            public var skills: Components.Schemas.ContainerAutoParam.SkillsPayload?
            /// Creates a new `ContainerAutoParam`.
            ///
            /// - Parameters:
            ///   - _type: Automatically creates a container for this request
            ///   - fileIds: An optional list of uploaded files to make available to your code.
            ///   - memoryLimit:
            ///   - networkPolicy: Network access policy for the container.
            ///   - skills: An optional list of skills referenced by id or inline data.
            public init(
                _type: Components.Schemas.ContainerAutoParam._TypePayload,
                fileIds: [Swift.String]? = nil,
                memoryLimit: Components.Schemas.ContainerMemoryLimit? = nil,
                networkPolicy: Components.Schemas.ContainerAutoParam.NetworkPolicyPayload? = nil,
                skills: Components.Schemas.ContainerAutoParam.SkillsPayload? = nil
            ) {
                self._type = _type
                self.fileIds = fileIds
                self.memoryLimit = memoryLimit
                self.networkPolicy = networkPolicy
                self.skills = skills
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileIds = "file_ids"
                case memoryLimit = "memory_limit"
                case networkPolicy = "network_policy"
                case skills
            }
        }
        /// - Remark: Generated from `#/components/schemas/LocalSkillParam`.
        public struct LocalSkillParam: Codable, Hashable, Sendable {
            /// The name of the skill.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalSkillParam/name`.
            public var name: Swift.String
            /// The description of the skill.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalSkillParam/description`.
            public var description: Swift.String
            /// The path to the directory containing the skill.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalSkillParam/path`.
            public var path: Swift.String
            /// Creates a new `LocalSkillParam`.
            ///
            /// - Parameters:
            ///   - name: The name of the skill.
            ///   - description: The description of the skill.
            ///   - path: The path to the directory containing the skill.
            public init(
                name: Swift.String,
                description: Swift.String,
                path: Swift.String
            ) {
                self.name = name
                self.description = description
                self.path = path
            }
            public enum CodingKeys: String, CodingKey {
                case name
                case description
                case path
            }
        }
        /// - Remark: Generated from `#/components/schemas/LocalEnvironmentParam`.
        public struct LocalEnvironmentParam: Codable, Hashable, Sendable {
            /// Use a local computer environment.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalEnvironmentParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case local = "local"
            }
            /// Use a local computer environment.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalEnvironmentParam/type`.
            public var _type: Components.Schemas.LocalEnvironmentParam._TypePayload
            /// An optional list of skills.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalEnvironmentParam/skills`.
            public var skills: [Components.Schemas.LocalSkillParam]?
            /// Creates a new `LocalEnvironmentParam`.
            ///
            /// - Parameters:
            ///   - _type: Use a local computer environment.
            ///   - skills: An optional list of skills.
            public init(
                _type: Components.Schemas.LocalEnvironmentParam._TypePayload,
                skills: [Components.Schemas.LocalSkillParam]? = nil
            ) {
                self._type = _type
                self.skills = skills
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case skills
            }
        }
        /// - Remark: Generated from `#/components/schemas/ContainerReferenceParam`.
        public struct ContainerReferenceParam: Codable, Hashable, Sendable {
            /// References a container created with the /v1/containers endpoint
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerReferenceParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case containerReference = "container_reference"
            }
            /// References a container created with the /v1/containers endpoint
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerReferenceParam/type`.
            public var _type: Components.Schemas.ContainerReferenceParam._TypePayload
            /// The ID of the referenced container.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerReferenceParam/container_id`.
            public var containerId: Swift.String
            /// Creates a new `ContainerReferenceParam`.
            ///
            /// - Parameters:
            ///   - _type: References a container created with the /v1/containers endpoint
            ///   - containerId: The ID of the referenced container.
            public init(
                _type: Components.Schemas.ContainerReferenceParam._TypePayload,
                containerId: Swift.String
            ) {
                self._type = _type
                self.containerId = containerId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case containerId = "container_id"
            }
        }
        /// A tool that allows the model to execute shell commands.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam`.
        public struct FunctionShellToolParam: Codable, Hashable, Sendable {
            /// The type of the shell tool. Always `shell`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case shell = "shell"
            }
            /// The type of the shell tool. Always `shell`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/type`.
            public var _type: Components.Schemas.FunctionShellToolParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/environment`.
            @frozen public enum EnvironmentPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/environment/ContainerAutoParam`.
                case containerAutoParam(Components.Schemas.ContainerAutoParam)
                /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/environment/LocalEnvironmentParam`.
                case localEnvironmentParam(Components.Schemas.LocalEnvironmentParam)
                /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/environment/ContainerReferenceParam`.
                case containerReferenceParam(Components.Schemas.ContainerReferenceParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "ContainerAutoParam", "#/components/schemas/ContainerAutoParam", "container_auto":
                        self = .containerAutoParam(try .init(from: decoder))
                    case "LocalEnvironmentParam", "#/components/schemas/LocalEnvironmentParam", "local":
                        self = .localEnvironmentParam(try .init(from: decoder))
                    case "ContainerReferenceParam", "#/components/schemas/ContainerReferenceParam", "container_reference":
                        self = .containerReferenceParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .containerAutoParam(value):
                        try value.encode(to: encoder)
                    case let .localEnvironmentParam(value):
                        try value.encode(to: encoder)
                    case let .containerReferenceParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionShellToolParam/environment`.
            public var environment: Components.Schemas.FunctionShellToolParam.EnvironmentPayload?
            /// Creates a new `FunctionShellToolParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the shell tool. Always `shell`.
            ///   - environment:
            public init(
                _type: Components.Schemas.FunctionShellToolParam._TypePayload,
                environment: Components.Schemas.FunctionShellToolParam.EnvironmentPayload? = nil
            ) {
                self._type = _type
                self.environment = environment
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case environment
            }
        }
        /// Unconstrained free-form text.
        ///
        /// - Remark: Generated from `#/components/schemas/CustomTextFormatParam`.
        public struct CustomTextFormatParam: Codable, Hashable, Sendable {
            /// Unconstrained text format. Always `text`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomTextFormatParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case text = "text"
            }
            /// Unconstrained text format. Always `text`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomTextFormatParam/type`.
            public var _type: Components.Schemas.CustomTextFormatParam._TypePayload
            /// Creates a new `CustomTextFormatParam`.
            ///
            /// - Parameters:
            ///   - _type: Unconstrained text format. Always `text`.
            public init(_type: Components.Schemas.CustomTextFormatParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// - Remark: Generated from `#/components/schemas/GrammarSyntax1`.
        @frozen public enum GrammarSyntax1: String, Codable, Hashable, Sendable, CaseIterable {
            case lark = "lark"
            case regex = "regex"
        }
        /// A grammar defined by the user.
        ///
        /// - Remark: Generated from `#/components/schemas/CustomGrammarFormatParam`.
        public struct CustomGrammarFormatParam: Codable, Hashable, Sendable {
            /// Grammar format. Always `grammar`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomGrammarFormatParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case grammar = "grammar"
            }
            /// Grammar format. Always `grammar`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomGrammarFormatParam/type`.
            public var _type: Components.Schemas.CustomGrammarFormatParam._TypePayload
            /// The syntax of the grammar definition. One of `lark` or `regex`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomGrammarFormatParam/syntax`.
            public var syntax: Components.Schemas.GrammarSyntax1
            /// The grammar definition.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomGrammarFormatParam/definition`.
            public var definition: Swift.String
            /// Creates a new `CustomGrammarFormatParam`.
            ///
            /// - Parameters:
            ///   - _type: Grammar format. Always `grammar`.
            ///   - syntax: The syntax of the grammar definition. One of `lark` or `regex`.
            ///   - definition: The grammar definition.
            public init(
                _type: Components.Schemas.CustomGrammarFormatParam._TypePayload,
                syntax: Components.Schemas.GrammarSyntax1,
                definition: Swift.String
            ) {
                self._type = _type
                self.syntax = syntax
                self.definition = definition
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case syntax
                case definition
            }
        }
        /// A custom tool that processes input using a specified format. Learn more about   [custom tools](/docs/guides/function-calling#custom-tools)
        ///
        /// - Remark: Generated from `#/components/schemas/CustomToolParam`.
        public struct CustomToolParam: Codable, Hashable, Sendable {
            /// The type of the custom tool. Always `custom`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case custom = "custom"
            }
            /// The type of the custom tool. Always `custom`.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/type`.
            public var _type: Components.Schemas.CustomToolParam._TypePayload
            /// The name of the custom tool, used to identify it in tool calls.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/name`.
            public var name: Swift.String
            /// Optional description of the custom tool, used to provide more context.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/description`.
            public var description: Swift.String?
            /// The input format for the custom tool. Default is unconstrained text.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/format`.
            @frozen public enum FormatPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/CustomToolParam/format/CustomTextFormatParam`.
                case customTextFormatParam(Components.Schemas.CustomTextFormatParam)
                /// - Remark: Generated from `#/components/schemas/CustomToolParam/format/CustomGrammarFormatParam`.
                case customGrammarFormatParam(Components.Schemas.CustomGrammarFormatParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "CustomTextFormatParam", "#/components/schemas/CustomTextFormatParam", "text":
                        self = .customTextFormatParam(try .init(from: decoder))
                    case "CustomGrammarFormatParam", "#/components/schemas/CustomGrammarFormatParam", "grammar":
                        self = .customGrammarFormatParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .customTextFormatParam(value):
                        try value.encode(to: encoder)
                    case let .customGrammarFormatParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// The input format for the custom tool. Default is unconstrained text.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/format`.
            public var format: Components.Schemas.CustomToolParam.FormatPayload?
            /// Whether this tool should be deferred and discovered via tool search.
            ///
            /// - Remark: Generated from `#/components/schemas/CustomToolParam/defer_loading`.
            public var deferLoading: Swift.Bool?
            /// Creates a new `CustomToolParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the custom tool. Always `custom`.
            ///   - name: The name of the custom tool, used to identify it in tool calls.
            ///   - description: Optional description of the custom tool, used to provide more context.
            ///   - format: The input format for the custom tool. Default is unconstrained text.
            ///   - deferLoading: Whether this tool should be deferred and discovered via tool search.
            public init(
                _type: Components.Schemas.CustomToolParam._TypePayload,
                name: Swift.String,
                description: Swift.String? = nil,
                format: Components.Schemas.CustomToolParam.FormatPayload? = nil,
                deferLoading: Swift.Bool? = nil
            ) {
                self._type = _type
                self.name = name
                self.description = description
                self.format = format
                self.deferLoading = deferLoading
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case name
                case description
                case format
                case deferLoading = "defer_loading"
            }
        }
        /// - Remark: Generated from `#/components/schemas/EmptyModelParam`.
        public typealias EmptyModelParam = OpenAPIRuntime.OpenAPIObjectContainer
        /// - Remark: Generated from `#/components/schemas/FunctionToolParam`.
        public struct FunctionToolParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/name`.
            public var name: Swift.String
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/description`.
            public var description: Swift.String?
            /// - Remark: Generated from `#/components/schemas/EmptyModelParam`.
            public typealias EmptyModelParam = Components.Schemas.EmptyModelParam
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/parameters`.
            public var parameters: Components.Schemas.EmptyModelParam?
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/strict`.
            public var strict: Swift.Bool?
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case function = "function"
            }
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/type`.
            public var _type: Components.Schemas.FunctionToolParam._TypePayload
            /// Whether this function should be deferred and discovered via tool search.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionToolParam/defer_loading`.
            public var deferLoading: Swift.Bool?
            /// Creates a new `FunctionToolParam`.
            ///
            /// - Parameters:
            ///   - name:
            ///   - description:
            ///   - parameters:
            ///   - strict:
            ///   - _type:
            ///   - deferLoading: Whether this function should be deferred and discovered via tool search.
            public init(
                name: Swift.String,
                description: Swift.String? = nil,
                parameters: Components.Schemas.EmptyModelParam? = nil,
                strict: Swift.Bool? = nil,
                _type: Components.Schemas.FunctionToolParam._TypePayload,
                deferLoading: Swift.Bool? = nil
            ) {
                self.name = name
                self.description = description
                self.parameters = parameters
                self.strict = strict
                self._type = _type
                self.deferLoading = deferLoading
            }
            public enum CodingKeys: String, CodingKey {
                case name
                case description
                case parameters
                case strict
                case _type = "type"
                case deferLoading = "defer_loading"
            }
        }
        /// Groups function/custom tools under a shared namespace.
        ///
        /// - Remark: Generated from `#/components/schemas/NamespaceToolParam`.
        public struct NamespaceToolParam: Codable, Hashable, Sendable {
            /// The type of the tool. Always `namespace`.
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case namespace = "namespace"
            }
            /// The type of the tool. Always `namespace`.
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/type`.
            public var _type: Components.Schemas.NamespaceToolParam._TypePayload
            /// The namespace name used in tool calls (for example, `crm`).
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/name`.
            public var name: Swift.String
            /// A description of the namespace shown to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/description`.
            public var description: Swift.String
            /// A function or custom tool that belongs to a namespace.
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/ToolsPayload`.
            @frozen public enum ToolsPayloadPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/ToolsPayload/FunctionToolParam`.
                case functionToolParam(Components.Schemas.FunctionToolParam)
                /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/ToolsPayload/CustomToolParam`.
                case customToolParam(Components.Schemas.CustomToolParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "FunctionToolParam", "#/components/schemas/FunctionToolParam", "function":
                        self = .functionToolParam(try .init(from: decoder))
                    case "CustomToolParam", "#/components/schemas/CustomToolParam", "custom":
                        self = .customToolParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .functionToolParam(value):
                        try value.encode(to: encoder)
                    case let .customToolParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// The function/custom tools available inside this namespace.
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/tools`.
            public typealias ToolsPayload = [Components.Schemas.NamespaceToolParam.ToolsPayloadPayload]
            /// The function/custom tools available inside this namespace.
            ///
            /// - Remark: Generated from `#/components/schemas/NamespaceToolParam/tools`.
            public var tools: Components.Schemas.NamespaceToolParam.ToolsPayload
            /// Creates a new `NamespaceToolParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the tool. Always `namespace`.
            ///   - name: The namespace name used in tool calls (for example, `crm`).
            ///   - description: A description of the namespace shown to the model.
            ///   - tools: The function/custom tools available inside this namespace.
            public init(
                _type: Components.Schemas.NamespaceToolParam._TypePayload,
                name: Swift.String,
                description: Swift.String,
                tools: Components.Schemas.NamespaceToolParam.ToolsPayload
            ) {
                self._type = _type
                self.name = name
                self.description = description
                self.tools = tools
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case name
                case description
                case tools
            }
        }
        /// Hosted or BYOT tool search configuration for deferred tools.
        ///
        /// - Remark: Generated from `#/components/schemas/ToolSearchToolParam`.
        public struct ToolSearchToolParam: Codable, Hashable, Sendable {
            /// The type of the tool. Always `tool_search`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case toolSearch = "tool_search"
            }
            /// The type of the tool. Always `tool_search`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchToolParam/type`.
            public var _type: Components.Schemas.ToolSearchToolParam._TypePayload
            /// Whether tool search is executed by the server or by the client.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchToolParam/execution`.
            public var execution: Components.Schemas.ToolSearchExecutionType?
            /// - Remark: Generated from `#/components/schemas/ToolSearchToolParam/description`.
            public var description: Swift.String?
            /// - Remark: Generated from `#/components/schemas/EmptyModelParam`.
            public typealias EmptyModelParam = Components.Schemas.EmptyModelParam
            /// - Remark: Generated from `#/components/schemas/ToolSearchToolParam/parameters`.
            public var parameters: Components.Schemas.EmptyModelParam?
            /// Creates a new `ToolSearchToolParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the tool. Always `tool_search`.
            ///   - execution: Whether tool search is executed by the server or by the client.
            ///   - description:
            ///   - parameters:
            public init(
                _type: Components.Schemas.ToolSearchToolParam._TypePayload,
                execution: Components.Schemas.ToolSearchExecutionType? = nil,
                description: Swift.String? = nil,
                parameters: Components.Schemas.EmptyModelParam? = nil
            ) {
                self._type = _type
                self.execution = execution
                self.description = description
                self.parameters = parameters
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case execution
                case description
                case parameters
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
            public var country: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/region`.
            public var region: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/city`.
            public var city: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation/timezone`.
            public var timezone: Swift.String?
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
                country: Swift.String? = nil,
                region: Swift.String? = nil,
                city: Swift.String? = nil,
                timezone: Swift.String? = nil
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
        /// - Remark: Generated from `#/components/schemas/SearchContextSize`.
        @frozen public enum SearchContextSize: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case medium = "medium"
            case high = "high"
        }
        /// - Remark: Generated from `#/components/schemas/SearchContentType`.
        @frozen public enum SearchContentType: String, Codable, Hashable, Sendable, CaseIterable {
            case text = "text"
            case image = "image"
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
            /// - Remark: Generated from `#/components/schemas/ApproximateLocation`.
            public typealias ApproximateLocation = Components.Schemas.ApproximateLocation
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/user_location`.
            public var userLocation: Components.Schemas.ApproximateLocation?
            /// High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            ///
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/search_context_size`.
            public var searchContextSize: Components.Schemas.SearchContextSize?
            /// - Remark: Generated from `#/components/schemas/WebSearchPreviewTool/search_content_types`.
            public var searchContentTypes: [Components.Schemas.SearchContentType]?
            /// Creates a new `WebSearchPreviewTool`.
            ///
            /// - Parameters:
            ///   - _type: The type of the web search tool. One of `web_search_preview` or `web_search_preview_2025_03_11`.
            ///   - userLocation:
            ///   - searchContextSize: High level guidance for the amount of context window space to use for the search. One of `low`, `medium`, or `high`. `medium` is the default.
            ///   - searchContentTypes:
            public init(
                _type: Components.Schemas.WebSearchPreviewTool._TypePayload,
                userLocation: Components.Schemas.ApproximateLocation? = nil,
                searchContextSize: Components.Schemas.SearchContextSize? = nil,
                searchContentTypes: [Components.Schemas.SearchContentType]? = nil
            ) {
                self._type = _type
                self.userLocation = userLocation
                self.searchContextSize = searchContextSize
                self.searchContentTypes = searchContentTypes
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case userLocation = "user_location"
                case searchContextSize = "search_context_size"
                case searchContentTypes = "search_content_types"
            }
        }
        /// Allows the assistant to create, delete, or update files using unified diffs.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchToolParam`.
        public struct ApplyPatchToolParam: Codable, Hashable, Sendable {
            /// The type of the tool. Always `apply_patch`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applyPatch = "apply_patch"
            }
            /// The type of the tool. Always `apply_patch`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolParam/type`.
            public var _type: Components.Schemas.ApplyPatchToolParam._TypePayload
            /// Creates a new `ApplyPatchToolParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the tool. Always `apply_patch`.
            public init(_type: Components.Schemas.ApplyPatchToolParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ToolSearchOutput`.
        public struct ToolSearchOutput: Codable, Hashable, Sendable {
            /// The type of the item. Always `tool_search_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case toolSearchOutput = "tool_search_output"
            }
            /// The type of the item. Always `tool_search_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/type`.
            public var _type: Components.Schemas.ToolSearchOutput._TypePayload
            /// The unique ID of the tool search output item.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/id`.
            public var id: Swift.String
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/call_id`.
            public var callId: Swift.String?
            /// Whether tool search was executed by the server or by the client.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/execution`.
            public var execution: Components.Schemas.ToolSearchExecutionType
            /// The loaded tool definitions returned by tool search.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/tools`.
            public var tools: [Components.Schemas.Tool]
            /// The status of the tool search output item that was recorded.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/status`.
            public var status: Components.Schemas.FunctionCallOutputStatusEnum
            /// The identifier of the actor that created the item.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutput/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `ToolSearchOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `tool_search_output`.
            ///   - id: The unique ID of the tool search output item.
            ///   - callId:
            ///   - execution: Whether tool search was executed by the server or by the client.
            ///   - tools: The loaded tool definitions returned by tool search.
            ///   - status: The status of the tool search output item that was recorded.
            ///   - createdBy: The identifier of the actor that created the item.
            public init(
                _type: Components.Schemas.ToolSearchOutput._TypePayload,
                id: Swift.String,
                callId: Swift.String? = nil,
                execution: Components.Schemas.ToolSearchExecutionType,
                tools: [Components.Schemas.Tool],
                status: Components.Schemas.FunctionCallOutputStatusEnum,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.execution = execution
                self.tools = tools
                self.status = status
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case execution
                case tools
                case status
                case createdBy = "created_by"
            }
        }
        /// A compaction item generated by the [`v1/responses/compact` API](/docs/api-reference/responses/compact).
        ///
        /// - Remark: Generated from `#/components/schemas/CompactionBody`.
        public struct CompactionBody: Codable, Hashable, Sendable {
            /// The type of the item. Always `compaction`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionBody/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case compaction = "compaction"
            }
            /// The type of the item. Always `compaction`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionBody/type`.
            public var _type: Components.Schemas.CompactionBody._TypePayload
            /// The unique ID of the compaction item.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionBody/id`.
            public var id: Swift.String
            /// The encrypted content that was produced by compaction.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionBody/encrypted_content`.
            public var encryptedContent: Swift.String
            /// The identifier of the actor that created the item.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionBody/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `CompactionBody`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `compaction`.
            ///   - id: The unique ID of the compaction item.
            ///   - encryptedContent: The encrypted content that was produced by compaction.
            ///   - createdBy: The identifier of the actor that created the item.
            public init(
                _type: Components.Schemas.CompactionBody._TypePayload,
                id: Swift.String,
                encryptedContent: Swift.String,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.encryptedContent = encryptedContent
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case encryptedContent = "encrypted_content"
                case createdBy = "created_by"
            }
        }
        /// The logs output from the code interpreter.
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputLogs`.
        public struct CodeInterpreterOutputLogs: Codable, Hashable, Sendable {
            /// The type of the output. Always `logs`.
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputLogs/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case logs = "logs"
            }
            /// The type of the output. Always `logs`.
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputLogs/type`.
            public var _type: Components.Schemas.CodeInterpreterOutputLogs._TypePayload
            /// The logs output from the code interpreter.
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputLogs/logs`.
            public var logs: Swift.String
            /// Creates a new `CodeInterpreterOutputLogs`.
            ///
            /// - Parameters:
            ///   - _type: The type of the output. Always `logs`.
            ///   - logs: The logs output from the code interpreter.
            public init(
                _type: Components.Schemas.CodeInterpreterOutputLogs._TypePayload,
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
        /// The image output from the code interpreter.
        ///
        /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputImage`.
        public struct CodeInterpreterOutputImage: Codable, Hashable, Sendable {
            /// The type of the output. Always `image`.
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputImage/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case image = "image"
            }
            /// The type of the output. Always `image`.
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputImage/type`.
            public var _type: Components.Schemas.CodeInterpreterOutputImage._TypePayload
            /// The URL of the image output from the code interpreter.
            ///
            /// - Remark: Generated from `#/components/schemas/CodeInterpreterOutputImage/url`.
            public var url: Swift.String
            /// Creates a new `CodeInterpreterOutputImage`.
            ///
            /// - Parameters:
            ///   - _type: The type of the output. Always `image`.
            ///   - url: The URL of the image output from the code interpreter.
            public init(
                _type: Components.Schemas.CodeInterpreterOutputImage._TypePayload,
                url: Swift.String
            ) {
                self._type = _type
                self.url = url
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case url
            }
        }
        /// Execute a shell command on the server.
        ///
        /// - Remark: Generated from `#/components/schemas/LocalShellExecAction`.
        public struct LocalShellExecAction: Codable, Hashable, Sendable {
            /// The type of the local shell action. Always `exec`.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case exec = "exec"
            }
            /// The type of the local shell action. Always `exec`.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/type`.
            public var _type: Components.Schemas.LocalShellExecAction._TypePayload
            /// The command to run.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/command`.
            public var command: [Swift.String]
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/timeout_ms`.
            public var timeoutMs: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/working_directory`.
            public var workingDirectory: Swift.String?
            /// Environment variables to set for the command.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/env`.
            public struct EnvPayload: Codable, Hashable, Sendable {
                /// A container of undocumented properties.
                public var additionalProperties: [String: Swift.String]
                /// Creates a new `EnvPayload`.
                ///
                /// - Parameters:
                ///   - additionalProperties: A container of undocumented properties.
                public init(additionalProperties: [String: Swift.String] = .init()) {
                    self.additionalProperties = additionalProperties
                }
                public init(from decoder: any Swift.Decoder) throws {
                    additionalProperties = try decoder.decodeAdditionalProperties(knownKeys: [])
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    try encoder.encodeAdditionalProperties(additionalProperties)
                }
            }
            /// Environment variables to set for the command.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/env`.
            public var env: Components.Schemas.LocalShellExecAction.EnvPayload
            /// - Remark: Generated from `#/components/schemas/LocalShellExecAction/user`.
            public var user: Swift.String?
            /// Creates a new `LocalShellExecAction`.
            ///
            /// - Parameters:
            ///   - _type: The type of the local shell action. Always `exec`.
            ///   - command: The command to run.
            ///   - timeoutMs:
            ///   - workingDirectory:
            ///   - env: Environment variables to set for the command.
            ///   - user:
            public init(
                _type: Components.Schemas.LocalShellExecAction._TypePayload,
                command: [Swift.String],
                timeoutMs: Swift.Int? = nil,
                workingDirectory: Swift.String? = nil,
                env: Components.Schemas.LocalShellExecAction.EnvPayload,
                user: Swift.String? = nil
            ) {
                self._type = _type
                self.command = command
                self.timeoutMs = timeoutMs
                self.workingDirectory = workingDirectory
                self.env = env
                self.user = user
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case command
                case timeoutMs = "timeout_ms"
                case workingDirectory = "working_directory"
                case env
                case user
            }
        }
        /// Execute a shell command.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellAction`.
        public struct FunctionShellAction: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionShellAction/commands`.
            public var commands: [Swift.String]
            /// - Remark: Generated from `#/components/schemas/FunctionShellAction/timeout_ms`.
            public var timeoutMs: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/FunctionShellAction/max_output_length`.
            public var maxOutputLength: Swift.Int?
            /// Creates a new `FunctionShellAction`.
            ///
            /// - Parameters:
            ///   - commands:
            ///   - timeoutMs:
            ///   - maxOutputLength:
            public init(
                commands: [Swift.String],
                timeoutMs: Swift.Int? = nil,
                maxOutputLength: Swift.Int? = nil
            ) {
                self.commands = commands
                self.timeoutMs = timeoutMs
                self.maxOutputLength = maxOutputLength
            }
            public enum CodingKeys: String, CodingKey {
                case commands
                case timeoutMs = "timeout_ms"
                case maxOutputLength = "max_output_length"
            }
        }
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallStatus`.
        @frozen public enum FunctionShellCallStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
        }
        /// Represents the use of a local environment to perform shell actions.
        ///
        /// - Remark: Generated from `#/components/schemas/LocalEnvironmentResource`.
        public struct LocalEnvironmentResource: Codable, Hashable, Sendable {
            /// The environment type. Always `local`.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalEnvironmentResource/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case local = "local"
            }
            /// The environment type. Always `local`.
            ///
            /// - Remark: Generated from `#/components/schemas/LocalEnvironmentResource/type`.
            public var _type: Components.Schemas.LocalEnvironmentResource._TypePayload
            /// Creates a new `LocalEnvironmentResource`.
            ///
            /// - Parameters:
            ///   - _type: The environment type. Always `local`.
            public init(_type: Components.Schemas.LocalEnvironmentResource._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Represents a container created with /v1/containers.
        ///
        /// - Remark: Generated from `#/components/schemas/ContainerReferenceResource`.
        public struct ContainerReferenceResource: Codable, Hashable, Sendable {
            /// The environment type. Always `container_reference`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerReferenceResource/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case containerReference = "container_reference"
            }
            /// The environment type. Always `container_reference`.
            ///
            /// - Remark: Generated from `#/components/schemas/ContainerReferenceResource/type`.
            public var _type: Components.Schemas.ContainerReferenceResource._TypePayload
            /// - Remark: Generated from `#/components/schemas/ContainerReferenceResource/container_id`.
            public var containerId: Swift.String
            /// Creates a new `ContainerReferenceResource`.
            ///
            /// - Parameters:
            ///   - _type: The environment type. Always `container_reference`.
            ///   - containerId:
            public init(
                _type: Components.Schemas.ContainerReferenceResource._TypePayload,
                containerId: Swift.String
            ) {
                self._type = _type
                self.containerId = containerId
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case containerId = "container_id"
            }
        }
        /// A tool call that executes one or more shell commands in a managed environment.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCall`.
        public struct FunctionShellCall: Codable, Hashable, Sendable {
            /// The type of the item. Always `shell_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case shellCall = "shell_call"
            }
            /// The type of the item. Always `shell_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/type`.
            public var _type: Components.Schemas.FunctionShellCall._TypePayload
            /// The unique ID of the shell tool call. Populated when this item is returned via API.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/id`.
            public var id: Swift.String
            /// The unique ID of the shell tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/call_id`.
            public var callId: Swift.String
            /// The shell commands and limits that describe how to run the tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/action`.
            public var action: Components.Schemas.FunctionShellAction
            /// The status of the shell call. One of `in_progress`, `completed`, or `incomplete`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/status`.
            public var status: Components.Schemas.FunctionShellCallStatus
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/environment`.
            @frozen public enum EnvironmentPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/FunctionShellCall/environment/LocalEnvironmentResource`.
                case localEnvironmentResource(Components.Schemas.LocalEnvironmentResource)
                /// - Remark: Generated from `#/components/schemas/FunctionShellCall/environment/ContainerReferenceResource`.
                case containerReferenceResource(Components.Schemas.ContainerReferenceResource)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "LocalEnvironmentResource", "#/components/schemas/LocalEnvironmentResource", "local":
                        self = .localEnvironmentResource(try .init(from: decoder))
                    case "ContainerReferenceResource", "#/components/schemas/ContainerReferenceResource", "container_reference":
                        self = .containerReferenceResource(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .localEnvironmentResource(value):
                        try value.encode(to: encoder)
                    case let .containerReferenceResource(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/environment`.
            public var environment: Components.Schemas.FunctionShellCall.EnvironmentPayload?
            /// The ID of the entity that created this tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCall/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `FunctionShellCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `shell_call`.
            ///   - id: The unique ID of the shell tool call. Populated when this item is returned via API.
            ///   - callId: The unique ID of the shell tool call generated by the model.
            ///   - action: The shell commands and limits that describe how to run the tool call.
            ///   - status: The status of the shell call. One of `in_progress`, `completed`, or `incomplete`.
            ///   - environment:
            ///   - createdBy: The ID of the entity that created this tool call.
            public init(
                _type: Components.Schemas.FunctionShellCall._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                action: Components.Schemas.FunctionShellAction,
                status: Components.Schemas.FunctionShellCallStatus,
                environment: Components.Schemas.FunctionShellCall.EnvironmentPayload? = nil,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.action = action
                self.status = status
                self.environment = environment
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case action
                case status
                case environment
                case createdBy = "created_by"
            }
        }
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputStatusEnum`.
        @frozen public enum FunctionShellCallOutputStatusEnum: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
        }
        /// Indicates that the shell call exceeded its configured time limit.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputTimeoutOutcome`.
        public struct FunctionShellCallOutputTimeoutOutcome: Codable, Hashable, Sendable {
            /// The outcome type. Always `timeout`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputTimeoutOutcome/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case timeout = "timeout"
            }
            /// The outcome type. Always `timeout`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputTimeoutOutcome/type`.
            public var _type: Components.Schemas.FunctionShellCallOutputTimeoutOutcome._TypePayload
            /// Creates a new `FunctionShellCallOutputTimeoutOutcome`.
            ///
            /// - Parameters:
            ///   - _type: The outcome type. Always `timeout`.
            public init(_type: Components.Schemas.FunctionShellCallOutputTimeoutOutcome._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Indicates that the shell commands finished and returned an exit code.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcome`.
        public struct FunctionShellCallOutputExitOutcome: Codable, Hashable, Sendable {
            /// The outcome type. Always `exit`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcome/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case exit = "exit"
            }
            /// The outcome type. Always `exit`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcome/type`.
            public var _type: Components.Schemas.FunctionShellCallOutputExitOutcome._TypePayload
            /// Exit code from the shell process.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcome/exit_code`.
            public var exitCode: Swift.Int
            /// Creates a new `FunctionShellCallOutputExitOutcome`.
            ///
            /// - Parameters:
            ///   - _type: The outcome type. Always `exit`.
            ///   - exitCode: Exit code from the shell process.
            public init(
                _type: Components.Schemas.FunctionShellCallOutputExitOutcome._TypePayload,
                exitCode: Swift.Int
            ) {
                self._type = _type
                self.exitCode = exitCode
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case exitCode = "exit_code"
            }
        }
        /// The content of a shell tool call output that was emitted.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent`.
        public struct FunctionShellCallOutputContent: Codable, Hashable, Sendable {
            /// The standard output that was captured.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/stdout`.
            public var stdout: Swift.String
            /// The standard error output that was captured.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/stderr`.
            public var stderr: Swift.String
            /// Represents either an exit outcome (with an exit code) or a timeout outcome for a shell call output chunk.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/outcome`.
            @frozen public enum OutcomePayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/outcome/FunctionShellCallOutputTimeoutOutcome`.
                case functionShellCallOutputTimeoutOutcome(Components.Schemas.FunctionShellCallOutputTimeoutOutcome)
                /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/outcome/FunctionShellCallOutputExitOutcome`.
                case functionShellCallOutputExitOutcome(Components.Schemas.FunctionShellCallOutputExitOutcome)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "FunctionShellCallOutputTimeoutOutcome", "#/components/schemas/FunctionShellCallOutputTimeoutOutcome", "timeout":
                        self = .functionShellCallOutputTimeoutOutcome(try .init(from: decoder))
                    case "FunctionShellCallOutputExitOutcome", "#/components/schemas/FunctionShellCallOutputExitOutcome", "exit":
                        self = .functionShellCallOutputExitOutcome(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .functionShellCallOutputTimeoutOutcome(value):
                        try value.encode(to: encoder)
                    case let .functionShellCallOutputExitOutcome(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// Represents either an exit outcome (with an exit code) or a timeout outcome for a shell call output chunk.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/outcome`.
            public var outcome: Components.Schemas.FunctionShellCallOutputContent.OutcomePayload
            /// The identifier of the actor that created the item.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContent/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `FunctionShellCallOutputContent`.
            ///
            /// - Parameters:
            ///   - stdout: The standard output that was captured.
            ///   - stderr: The standard error output that was captured.
            ///   - outcome: Represents either an exit outcome (with an exit code) or a timeout outcome for a shell call output chunk.
            ///   - createdBy: The identifier of the actor that created the item.
            public init(
                stdout: Swift.String,
                stderr: Swift.String,
                outcome: Components.Schemas.FunctionShellCallOutputContent.OutcomePayload,
                createdBy: Swift.String? = nil
            ) {
                self.stdout = stdout
                self.stderr = stderr
                self.outcome = outcome
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case stdout
                case stderr
                case outcome
                case createdBy = "created_by"
            }
        }
        /// The output of a shell tool call that was emitted.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput`.
        public struct FunctionShellCallOutput: Codable, Hashable, Sendable {
            /// The type of the shell call output. Always `shell_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case shellCallOutput = "shell_call_output"
            }
            /// The type of the shell call output. Always `shell_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/type`.
            public var _type: Components.Schemas.FunctionShellCallOutput._TypePayload
            /// The unique ID of the shell call output. Populated when this item is returned via API.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/id`.
            public var id: Swift.String
            /// The unique ID of the shell tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/call_id`.
            public var callId: Swift.String
            /// The status of the shell call output. One of `in_progress`, `completed`, or `incomplete`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/status`.
            public var status: Components.Schemas.FunctionShellCallOutputStatusEnum
            /// An array of shell call output contents
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/output`.
            public var output: [Components.Schemas.FunctionShellCallOutputContent]
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/max_output_length`.
            public var maxOutputLength: Swift.Int?
            /// The identifier of the actor that created the item.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutput/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `FunctionShellCallOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the shell call output. Always `shell_call_output`.
            ///   - id: The unique ID of the shell call output. Populated when this item is returned via API.
            ///   - callId: The unique ID of the shell tool call generated by the model.
            ///   - status: The status of the shell call output. One of `in_progress`, `completed`, or `incomplete`.
            ///   - output: An array of shell call output contents
            ///   - maxOutputLength:
            ///   - createdBy: The identifier of the actor that created the item.
            public init(
                _type: Components.Schemas.FunctionShellCallOutput._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                status: Components.Schemas.FunctionShellCallOutputStatusEnum,
                output: [Components.Schemas.FunctionShellCallOutputContent],
                maxOutputLength: Swift.Int? = nil,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.status = status
                self.output = output
                self.maxOutputLength = maxOutputLength
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case status
                case output
                case maxOutputLength = "max_output_length"
                case createdBy = "created_by"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ApplyPatchCallStatus`.
        @frozen public enum ApplyPatchCallStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
        }
        /// Instruction describing how to create a file via the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperation`.
        public struct ApplyPatchCreateFileOperation: Codable, Hashable, Sendable {
            /// Create a new file with the provided diff.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case createFile = "create_file"
            }
            /// Create a new file with the provided diff.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperation/type`.
            public var _type: Components.Schemas.ApplyPatchCreateFileOperation._TypePayload
            /// Path of the file to create.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperation/path`.
            public var path: Swift.String
            /// Diff to apply.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperation/diff`.
            public var diff: Swift.String
            /// Creates a new `ApplyPatchCreateFileOperation`.
            ///
            /// - Parameters:
            ///   - _type: Create a new file with the provided diff.
            ///   - path: Path of the file to create.
            ///   - diff: Diff to apply.
            public init(
                _type: Components.Schemas.ApplyPatchCreateFileOperation._TypePayload,
                path: Swift.String,
                diff: Swift.String
            ) {
                self._type = _type
                self.path = path
                self.diff = diff
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
                case diff
            }
        }
        /// Instruction describing how to delete a file via the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperation`.
        public struct ApplyPatchDeleteFileOperation: Codable, Hashable, Sendable {
            /// Delete the specified file.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case deleteFile = "delete_file"
            }
            /// Delete the specified file.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperation/type`.
            public var _type: Components.Schemas.ApplyPatchDeleteFileOperation._TypePayload
            /// Path of the file to delete.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperation/path`.
            public var path: Swift.String
            /// Creates a new `ApplyPatchDeleteFileOperation`.
            ///
            /// - Parameters:
            ///   - _type: Delete the specified file.
            ///   - path: Path of the file to delete.
            public init(
                _type: Components.Schemas.ApplyPatchDeleteFileOperation._TypePayload,
                path: Swift.String
            ) {
                self._type = _type
                self.path = path
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
            }
        }
        /// Instruction describing how to update a file via the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperation`.
        public struct ApplyPatchUpdateFileOperation: Codable, Hashable, Sendable {
            /// Update an existing file with the provided diff.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperation/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case updateFile = "update_file"
            }
            /// Update an existing file with the provided diff.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperation/type`.
            public var _type: Components.Schemas.ApplyPatchUpdateFileOperation._TypePayload
            /// Path of the file to update.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperation/path`.
            public var path: Swift.String
            /// Diff to apply.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperation/diff`.
            public var diff: Swift.String
            /// Creates a new `ApplyPatchUpdateFileOperation`.
            ///
            /// - Parameters:
            ///   - _type: Update an existing file with the provided diff.
            ///   - path: Path of the file to update.
            ///   - diff: Diff to apply.
            public init(
                _type: Components.Schemas.ApplyPatchUpdateFileOperation._TypePayload,
                path: Swift.String,
                diff: Swift.String
            ) {
                self._type = _type
                self.path = path
                self.diff = diff
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
                case diff
            }
        }
        /// A tool call that applies file diffs by creating, deleting, or updating files.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall`.
        public struct ApplyPatchToolCall: Codable, Hashable, Sendable {
            /// The type of the item. Always `apply_patch_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applyPatchCall = "apply_patch_call"
            }
            /// The type of the item. Always `apply_patch_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/type`.
            public var _type: Components.Schemas.ApplyPatchToolCall._TypePayload
            /// The unique ID of the apply patch tool call. Populated when this item is returned via API.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/id`.
            public var id: Swift.String
            /// The unique ID of the apply patch tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/call_id`.
            public var callId: Swift.String
            /// The status of the apply patch tool call. One of `in_progress` or `completed`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/status`.
            public var status: Components.Schemas.ApplyPatchCallStatus
            /// One of the create_file, delete_file, or update_file operations applied via apply_patch.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/operation`.
            @frozen public enum OperationPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/operation/ApplyPatchCreateFileOperation`.
                case applyPatchCreateFileOperation(Components.Schemas.ApplyPatchCreateFileOperation)
                /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/operation/ApplyPatchDeleteFileOperation`.
                case applyPatchDeleteFileOperation(Components.Schemas.ApplyPatchDeleteFileOperation)
                /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/operation/ApplyPatchUpdateFileOperation`.
                case applyPatchUpdateFileOperation(Components.Schemas.ApplyPatchUpdateFileOperation)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "ApplyPatchCreateFileOperation", "#/components/schemas/ApplyPatchCreateFileOperation", "create_file":
                        self = .applyPatchCreateFileOperation(try .init(from: decoder))
                    case "ApplyPatchDeleteFileOperation", "#/components/schemas/ApplyPatchDeleteFileOperation", "delete_file":
                        self = .applyPatchDeleteFileOperation(try .init(from: decoder))
                    case "ApplyPatchUpdateFileOperation", "#/components/schemas/ApplyPatchUpdateFileOperation", "update_file":
                        self = .applyPatchUpdateFileOperation(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .applyPatchCreateFileOperation(value):
                        try value.encode(to: encoder)
                    case let .applyPatchDeleteFileOperation(value):
                        try value.encode(to: encoder)
                    case let .applyPatchUpdateFileOperation(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// One of the create_file, delete_file, or update_file operations applied via apply_patch.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/operation`.
            public var operation: Components.Schemas.ApplyPatchToolCall.OperationPayload
            /// The ID of the entity that created this tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCall/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `ApplyPatchToolCall`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `apply_patch_call`.
            ///   - id: The unique ID of the apply patch tool call. Populated when this item is returned via API.
            ///   - callId: The unique ID of the apply patch tool call generated by the model.
            ///   - status: The status of the apply patch tool call. One of `in_progress` or `completed`.
            ///   - operation: One of the create_file, delete_file, or update_file operations applied via apply_patch.
            ///   - createdBy: The ID of the entity that created this tool call.
            public init(
                _type: Components.Schemas.ApplyPatchToolCall._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                status: Components.Schemas.ApplyPatchCallStatus,
                operation: Components.Schemas.ApplyPatchToolCall.OperationPayload,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.status = status
                self.operation = operation
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case status
                case operation
                case createdBy = "created_by"
            }
        }
        /// - Remark: Generated from `#/components/schemas/ApplyPatchCallOutputStatus`.
        @frozen public enum ApplyPatchCallOutputStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case completed = "completed"
            case failed = "failed"
        }
        /// The output emitted by an apply patch tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput`.
        public struct ApplyPatchToolCallOutput: Codable, Hashable, Sendable {
            /// The type of the item. Always `apply_patch_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applyPatchCallOutput = "apply_patch_call_output"
            }
            /// The type of the item. Always `apply_patch_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/type`.
            public var _type: Components.Schemas.ApplyPatchToolCallOutput._TypePayload
            /// The unique ID of the apply patch tool call output. Populated when this item is returned via API.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/id`.
            public var id: Swift.String
            /// The unique ID of the apply patch tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/call_id`.
            public var callId: Swift.String
            /// The status of the apply patch tool call output. One of `completed` or `failed`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/status`.
            public var status: Components.Schemas.ApplyPatchCallOutputStatus
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/output`.
            public var output: Swift.String?
            /// The ID of the entity that created this tool call output.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutput/created_by`.
            public var createdBy: Swift.String?
            /// Creates a new `ApplyPatchToolCallOutput`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `apply_patch_call_output`.
            ///   - id: The unique ID of the apply patch tool call output. Populated when this item is returned via API.
            ///   - callId: The unique ID of the apply patch tool call generated by the model.
            ///   - status: The status of the apply patch tool call output. One of `completed` or `failed`.
            ///   - output:
            ///   - createdBy: The ID of the entity that created this tool call output.
            public init(
                _type: Components.Schemas.ApplyPatchToolCallOutput._TypePayload,
                id: Swift.String,
                callId: Swift.String,
                status: Components.Schemas.ApplyPatchCallOutputStatus,
                output: Swift.String? = nil,
                createdBy: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.status = status
                self.output = output
                self.createdBy = createdBy
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case status
                case output
                case createdBy = "created_by"
            }
        }
        /// - Remark: Generated from `#/components/schemas/MCPToolCallStatus`.
        @frozen public enum MCPToolCallStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
            case calling = "calling"
            case failed = "failed"
        }
        /// - Remark: Generated from `#/components/schemas/DetailEnum`.
        @frozen public enum DetailEnum: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case high = "high"
            case auto = "auto"
            case original = "original"
        }
        /// - Remark: Generated from `#/components/schemas/FunctionCallItemStatus`.
        @frozen public enum FunctionCallItemStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
        }
        /// The output of a computer tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam`.
        public struct ComputerCallOutputItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/id`.
            public var id: Swift.String?
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
            /// - Remark: Generated from `#/components/schemas/ComputerCallSafetyCheckParam`.
            public typealias ComputerCallSafetyCheckParam = [Components.Schemas.ComputerCallSafetyCheckParam]
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/acknowledged_safety_checks`.
            public var acknowledgedSafetyChecks: [Components.Schemas.ComputerCallSafetyCheckParam]?
            /// - Remark: Generated from `#/components/schemas/FunctionCallItemStatus`.
            public typealias FunctionCallItemStatus = Components.Schemas.FunctionCallItemStatus
            /// - Remark: Generated from `#/components/schemas/ComputerCallOutputItemParam/status`.
            public var status: Components.Schemas.FunctionCallItemStatus?
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
                id: Swift.String? = nil,
                callId: Swift.String,
                _type: Components.Schemas.ComputerCallOutputItemParam._TypePayload,
                output: Components.Schemas.ComputerScreenshotImage,
                acknowledgedSafetyChecks: [Components.Schemas.ComputerCallSafetyCheckParam]? = nil,
                status: Components.Schemas.FunctionCallItemStatus? = nil
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
        /// A text input to the model.
        ///
        /// - Remark: Generated from `#/components/schemas/InputTextContentParam`.
        public struct InputTextContentParam: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputTextContentParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputText = "input_text"
            }
            /// The type of the input item. Always `input_text`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputTextContentParam/type`.
            public var _type: Components.Schemas.InputTextContentParam._TypePayload
            /// The text input to the model.
            ///
            /// - Remark: Generated from `#/components/schemas/InputTextContentParam/text`.
            public var text: Swift.String
            /// Creates a new `InputTextContentParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_text`.
            ///   - text: The text input to the model.
            public init(
                _type: Components.Schemas.InputTextContentParam._TypePayload,
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
        /// An image input to the model. Learn about [image inputs](/docs/guides/vision)
        ///
        /// - Remark: Generated from `#/components/schemas/InputImageContentParamAutoParam`.
        public struct InputImageContentParamAutoParam: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_image`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContentParamAutoParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputImage = "input_image"
            }
            /// The type of the input item. Always `input_image`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputImageContentParamAutoParam/type`.
            public var _type: Components.Schemas.InputImageContentParamAutoParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/InputImageContentParamAutoParam/image_url`.
            public var imageUrl: Swift.String?
            /// - Remark: Generated from `#/components/schemas/InputImageContentParamAutoParam/file_id`.
            public var fileId: Swift.String?
            /// - Remark: Generated from `#/components/schemas/DetailEnum`.
            public typealias DetailEnum = Components.Schemas.DetailEnum
            /// - Remark: Generated from `#/components/schemas/InputImageContentParamAutoParam/detail`.
            public var detail: Components.Schemas.DetailEnum?
            /// Creates a new `InputImageContentParamAutoParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_image`.
            ///   - imageUrl:
            ///   - fileId:
            ///   - detail:
            public init(
                _type: Components.Schemas.InputImageContentParamAutoParam._TypePayload,
                imageUrl: Swift.String? = nil,
                fileId: Swift.String? = nil,
                detail: Components.Schemas.DetailEnum? = nil
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
        /// - Remark: Generated from `#/components/schemas/FileDetailEnum`.
        @frozen public enum FileDetailEnum: String, Codable, Hashable, Sendable, CaseIterable {
            case low = "low"
            case high = "high"
        }
        /// A file input to the model.
        ///
        /// - Remark: Generated from `#/components/schemas/InputFileContentParam`.
        public struct InputFileContentParam: Codable, Hashable, Sendable {
            /// The type of the input item. Always `input_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case inputFile = "input_file"
            }
            /// The type of the input item. Always `input_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/type`.
            public var _type: Components.Schemas.InputFileContentParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/file_id`.
            public var fileId: Swift.String?
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/filename`.
            public var filename: Swift.String?
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/file_data`.
            public var fileData: Swift.String?
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/file_url`.
            public var fileUrl: Swift.String?
            /// The detail level of the file to be sent to the model. Use `low` for the default rendering behavior, or `high` to render the file at higher quality. Defaults to `low`.
            ///
            /// - Remark: Generated from `#/components/schemas/InputFileContentParam/detail`.
            public var detail: Components.Schemas.FileDetailEnum?
            /// Creates a new `InputFileContentParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the input item. Always `input_file`.
            ///   - fileId:
            ///   - filename:
            ///   - fileData:
            ///   - fileUrl:
            ///   - detail: The detail level of the file to be sent to the model. Use `low` for the default rendering behavior, or `high` to render the file at higher quality. Defaults to `low`.
            public init(
                _type: Components.Schemas.InputFileContentParam._TypePayload,
                fileId: Swift.String? = nil,
                filename: Swift.String? = nil,
                fileData: Swift.String? = nil,
                fileUrl: Swift.String? = nil,
                detail: Components.Schemas.FileDetailEnum? = nil
            ) {
                self._type = _type
                self.fileId = fileId
                self.filename = filename
                self.fileData = fileData
                self.fileUrl = fileUrl
                self.detail = detail
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case fileId = "file_id"
                case filename
                case fileData = "file_data"
                case fileUrl = "file_url"
                case detail
            }
        }
        /// The output of a function tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam`.
        public struct FunctionCallOutputItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/id`.
            public var id: Swift.String?
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
            /// Text, image, or file output of the function tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output`.
            @frozen public enum OutputPayload: Codable, Hashable, Sendable {
                /// A JSON string of the output of the function tool call.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/case1`.
                case case1(Swift.String)
                /// A piece of message content, such as text, an image, or a file.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/Case2Payload`.
                @frozen public enum Case2PayloadPayload: Codable, Hashable, Sendable {
                    /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/Case2Payload/InputTextContentParam`.
                    case inputTextContentParam(Components.Schemas.InputTextContentParam)
                    /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/Case2Payload/InputImageContentParamAutoParam`.
                    case inputImageContentParamAutoParam(Components.Schemas.InputImageContentParamAutoParam)
                    /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/Case2Payload/InputFileContentParam`.
                    case inputFileContentParam(Components.Schemas.InputFileContentParam)
                    public enum CodingKeys: String, CodingKey {
                        case _type = "type"
                    }
                    public init(from decoder: any Swift.Decoder) throws {
                        let container = try decoder.container(keyedBy: CodingKeys.self)
                        let discriminator = try container.decode(
                            Swift.String.self,
                            forKey: ._type
                        )
                        switch discriminator {
                        case "InputTextContentParam", "#/components/schemas/InputTextContentParam", "input_text":
                            self = .inputTextContentParam(try .init(from: decoder))
                        case "InputImageContentParamAutoParam", "#/components/schemas/InputImageContentParamAutoParam", "input_image":
                            self = .inputImageContentParamAutoParam(try .init(from: decoder))
                        case "InputFileContentParam", "#/components/schemas/InputFileContentParam", "input_file":
                            self = .inputFileContentParam(try .init(from: decoder))
                        default:
                            throw Swift.DecodingError.unknownOneOfDiscriminator(
                                discriminatorKey: CodingKeys._type,
                                discriminatorValue: discriminator,
                                codingPath: decoder.codingPath
                            )
                        }
                    }
                    public func encode(to encoder: any Swift.Encoder) throws {
                        switch self {
                        case let .inputTextContentParam(value):
                            try value.encode(to: encoder)
                        case let .inputImageContentParamAutoParam(value):
                            try value.encode(to: encoder)
                        case let .inputFileContentParam(value):
                            try value.encode(to: encoder)
                        }
                    }
                }
                /// An array of content outputs (text, image, file) for the function tool call.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/case2`.
                public typealias Case2Payload = [Components.Schemas.FunctionCallOutputItemParam.OutputPayload.Case2PayloadPayload]
                /// An array of content outputs (text, image, file) for the function tool call.
                ///
                /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output/case2`.
                case case2(Components.Schemas.FunctionCallOutputItemParam.OutputPayload.Case2Payload)
                public init(from decoder: any Swift.Decoder) throws {
                    var errors: [any Swift.Error] = []
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
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .case1(value):
                        try encoder.encodeToSingleValueContainer(value)
                    case let .case2(value):
                        try encoder.encodeToSingleValueContainer(value)
                    }
                }
            }
            /// Text, image, or file output of the function tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/output`.
            public var output: Components.Schemas.FunctionCallOutputItemParam.OutputPayload
            /// - Remark: Generated from `#/components/schemas/FunctionCallItemStatus`.
            public typealias FunctionCallItemStatus = Components.Schemas.FunctionCallItemStatus
            /// - Remark: Generated from `#/components/schemas/FunctionCallOutputItemParam/status`.
            public var status: Components.Schemas.FunctionCallItemStatus?
            /// Creates a new `FunctionCallOutputItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId: The unique ID of the function tool call generated by the model.
            ///   - _type: The type of the function tool call output. Always `function_call_output`.
            ///   - output: Text, image, or file output of the function tool call.
            ///   - status:
            public init(
                id: Swift.String? = nil,
                callId: Swift.String,
                _type: Components.Schemas.FunctionCallOutputItemParam._TypePayload,
                output: Components.Schemas.FunctionCallOutputItemParam.OutputPayload,
                status: Components.Schemas.FunctionCallItemStatus? = nil
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
        /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam`.
        public struct ToolSearchCallItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/id`.
            public var id: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/call_id`.
            public var callId: Swift.String?
            /// The item type. Always `tool_search_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case toolSearchCall = "tool_search_call"
            }
            /// The item type. Always `tool_search_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/type`.
            public var _type: Components.Schemas.ToolSearchCallItemParam._TypePayload
            /// Whether tool search was executed by the server or by the client.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/execution`.
            public var execution: Components.Schemas.ToolSearchExecutionType?
            /// The arguments supplied to the tool search call.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/arguments`.
            public var arguments: Components.Schemas.EmptyModelParam
            /// - Remark: Generated from `#/components/schemas/FunctionCallItemStatus`.
            public typealias FunctionCallItemStatus = Components.Schemas.FunctionCallItemStatus
            /// - Remark: Generated from `#/components/schemas/ToolSearchCallItemParam/status`.
            public var status: Components.Schemas.FunctionCallItemStatus?
            /// Creates a new `ToolSearchCallItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId:
            ///   - _type: The item type. Always `tool_search_call`.
            ///   - execution: Whether tool search was executed by the server or by the client.
            ///   - arguments: The arguments supplied to the tool search call.
            ///   - status:
            public init(
                id: Swift.String? = nil,
                callId: Swift.String? = nil,
                _type: Components.Schemas.ToolSearchCallItemParam._TypePayload,
                execution: Components.Schemas.ToolSearchExecutionType? = nil,
                arguments: Components.Schemas.EmptyModelParam,
                status: Components.Schemas.FunctionCallItemStatus? = nil
            ) {
                self.id = id
                self.callId = callId
                self._type = _type
                self.execution = execution
                self.arguments = arguments
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case callId = "call_id"
                case _type = "type"
                case execution
                case arguments
                case status
            }
        }
        /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam`.
        public struct ToolSearchOutputItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/id`.
            public var id: Swift.String?
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/call_id`.
            public var callId: Swift.String?
            /// The item type. Always `tool_search_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case toolSearchOutput = "tool_search_output"
            }
            /// The item type. Always `tool_search_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/type`.
            public var _type: Components.Schemas.ToolSearchOutputItemParam._TypePayload
            /// Whether tool search was executed by the server or by the client.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/execution`.
            public var execution: Components.Schemas.ToolSearchExecutionType?
            /// The loaded tool definitions returned by the tool search output.
            ///
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/tools`.
            public var tools: [Components.Schemas.Tool]
            /// - Remark: Generated from `#/components/schemas/FunctionCallItemStatus`.
            public typealias FunctionCallItemStatus = Components.Schemas.FunctionCallItemStatus
            /// - Remark: Generated from `#/components/schemas/ToolSearchOutputItemParam/status`.
            public var status: Components.Schemas.FunctionCallItemStatus?
            /// Creates a new `ToolSearchOutputItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId:
            ///   - _type: The item type. Always `tool_search_output`.
            ///   - execution: Whether tool search was executed by the server or by the client.
            ///   - tools: The loaded tool definitions returned by the tool search output.
            ///   - status:
            public init(
                id: Swift.String? = nil,
                callId: Swift.String? = nil,
                _type: Components.Schemas.ToolSearchOutputItemParam._TypePayload,
                execution: Components.Schemas.ToolSearchExecutionType? = nil,
                tools: [Components.Schemas.Tool],
                status: Components.Schemas.FunctionCallItemStatus? = nil
            ) {
                self.id = id
                self.callId = callId
                self._type = _type
                self.execution = execution
                self.tools = tools
                self.status = status
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case callId = "call_id"
                case _type = "type"
                case execution
                case tools
                case status
            }
        }
        /// A compaction item generated by the [`v1/responses/compact` API](/docs/api-reference/responses/compact).
        ///
        /// - Remark: Generated from `#/components/schemas/CompactionSummaryItemParam`.
        public struct CompactionSummaryItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/CompactionSummaryItemParam/id`.
            public var id: Swift.String?
            /// The type of the item. Always `compaction`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionSummaryItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case compaction = "compaction"
            }
            /// The type of the item. Always `compaction`.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionSummaryItemParam/type`.
            public var _type: Components.Schemas.CompactionSummaryItemParam._TypePayload
            /// The encrypted content of the compaction summary.
            ///
            /// - Remark: Generated from `#/components/schemas/CompactionSummaryItemParam/encrypted_content`.
            public var encryptedContent: Swift.String
            /// Creates a new `CompactionSummaryItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - _type: The type of the item. Always `compaction`.
            ///   - encryptedContent: The encrypted content of the compaction summary.
            public init(
                id: Swift.String? = nil,
                _type: Components.Schemas.CompactionSummaryItemParam._TypePayload,
                encryptedContent: Swift.String
            ) {
                self.id = id
                self._type = _type
                self.encryptedContent = encryptedContent
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case _type = "type"
                case encryptedContent = "encrypted_content"
            }
        }
        /// Commands and limits describing how to run the shell tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellActionParam`.
        public struct FunctionShellActionParam: Codable, Hashable, Sendable {
            /// Ordered shell commands for the execution environment to run.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellActionParam/commands`.
            public var commands: [Swift.String]
            /// - Remark: Generated from `#/components/schemas/FunctionShellActionParam/timeout_ms`.
            public var timeoutMs: Swift.Int?
            /// - Remark: Generated from `#/components/schemas/FunctionShellActionParam/max_output_length`.
            public var maxOutputLength: Swift.Int?
            /// Creates a new `FunctionShellActionParam`.
            ///
            /// - Parameters:
            ///   - commands: Ordered shell commands for the execution environment to run.
            ///   - timeoutMs:
            ///   - maxOutputLength:
            public init(
                commands: [Swift.String],
                timeoutMs: Swift.Int? = nil,
                maxOutputLength: Swift.Int? = nil
            ) {
                self.commands = commands
                self.timeoutMs = timeoutMs
                self.maxOutputLength = maxOutputLength
            }
            public enum CodingKeys: String, CodingKey {
                case commands
                case timeoutMs = "timeout_ms"
                case maxOutputLength = "max_output_length"
            }
        }
        /// Status values reported for shell tool calls.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemStatus`.
        @frozen public enum FunctionShellCallItemStatus: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
            case incomplete = "incomplete"
        }
        /// A tool representing a request to execute one or more shell commands.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam`.
        public struct FunctionShellCallItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/id`.
            public var id: Swift.String?
            /// The unique ID of the shell tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/call_id`.
            public var callId: Swift.String
            /// The type of the item. Always `shell_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case shellCall = "shell_call"
            }
            /// The type of the item. Always `shell_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/type`.
            public var _type: Components.Schemas.FunctionShellCallItemParam._TypePayload
            /// The shell commands and limits that describe how to run the tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/action`.
            public var action: Components.Schemas.FunctionShellActionParam
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemStatus`.
            public typealias FunctionShellCallItemStatus = Components.Schemas.FunctionShellCallItemStatus
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/status`.
            public var status: Components.Schemas.FunctionShellCallItemStatus?
            /// The environment to execute the shell commands in.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/environment`.
            @frozen public enum EnvironmentPayload: Codable, Hashable, Sendable {
                /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/environment/LocalEnvironmentParam`.
                case localEnvironmentParam(Components.Schemas.LocalEnvironmentParam)
                /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/environment/ContainerReferenceParam`.
                case containerReferenceParam(Components.Schemas.ContainerReferenceParam)
                public enum CodingKeys: String, CodingKey {
                    case _type = "type"
                }
                public init(from decoder: any Swift.Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    let discriminator = try container.decode(
                        Swift.String.self,
                        forKey: ._type
                    )
                    switch discriminator {
                    case "LocalEnvironmentParam", "#/components/schemas/LocalEnvironmentParam", "local":
                        self = .localEnvironmentParam(try .init(from: decoder))
                    case "ContainerReferenceParam", "#/components/schemas/ContainerReferenceParam", "container_reference":
                        self = .containerReferenceParam(try .init(from: decoder))
                    default:
                        throw Swift.DecodingError.unknownOneOfDiscriminator(
                            discriminatorKey: CodingKeys._type,
                            discriminatorValue: discriminator,
                            codingPath: decoder.codingPath
                        )
                    }
                }
                public func encode(to encoder: any Swift.Encoder) throws {
                    switch self {
                    case let .localEnvironmentParam(value):
                        try value.encode(to: encoder)
                    case let .containerReferenceParam(value):
                        try value.encode(to: encoder)
                    }
                }
            }
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemParam/environment`.
            public var environment: Components.Schemas.FunctionShellCallItemParam.EnvironmentPayload?
            /// Creates a new `FunctionShellCallItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId: The unique ID of the shell tool call generated by the model.
            ///   - _type: The type of the item. Always `shell_call`.
            ///   - action: The shell commands and limits that describe how to run the tool call.
            ///   - status:
            ///   - environment:
            public init(
                id: Swift.String? = nil,
                callId: Swift.String,
                _type: Components.Schemas.FunctionShellCallItemParam._TypePayload,
                action: Components.Schemas.FunctionShellActionParam,
                status: Components.Schemas.FunctionShellCallItemStatus? = nil,
                environment: Components.Schemas.FunctionShellCallItemParam.EnvironmentPayload? = nil
            ) {
                self.id = id
                self.callId = callId
                self._type = _type
                self.action = action
                self.status = status
                self.environment = environment
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case callId = "call_id"
                case _type = "type"
                case action
                case status
                case environment
            }
        }
        /// Indicates that the shell call exceeded its configured time limit.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputTimeoutOutcomeParam`.
        public struct FunctionShellCallOutputTimeoutOutcomeParam: Codable, Hashable, Sendable {
            /// The outcome type. Always `timeout`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputTimeoutOutcomeParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case timeout = "timeout"
            }
            /// The outcome type. Always `timeout`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputTimeoutOutcomeParam/type`.
            public var _type: Components.Schemas.FunctionShellCallOutputTimeoutOutcomeParam._TypePayload
            /// Creates a new `FunctionShellCallOutputTimeoutOutcomeParam`.
            ///
            /// - Parameters:
            ///   - _type: The outcome type. Always `timeout`.
            public init(_type: Components.Schemas.FunctionShellCallOutputTimeoutOutcomeParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Indicates that the shell commands finished and returned an exit code.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcomeParam`.
        public struct FunctionShellCallOutputExitOutcomeParam: Codable, Hashable, Sendable {
            /// The outcome type. Always `exit`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcomeParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case exit = "exit"
            }
            /// The outcome type. Always `exit`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcomeParam/type`.
            public var _type: Components.Schemas.FunctionShellCallOutputExitOutcomeParam._TypePayload
            /// The exit code returned by the shell process.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputExitOutcomeParam/exit_code`.
            public var exitCode: Swift.Int
            /// Creates a new `FunctionShellCallOutputExitOutcomeParam`.
            ///
            /// - Parameters:
            ///   - _type: The outcome type. Always `exit`.
            ///   - exitCode: The exit code returned by the shell process.
            public init(
                _type: Components.Schemas.FunctionShellCallOutputExitOutcomeParam._TypePayload,
                exitCode: Swift.Int
            ) {
                self._type = _type
                self.exitCode = exitCode
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case exitCode = "exit_code"
            }
        }
        /// The exit or timeout outcome associated with this shell call.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputOutcomeParam`.
        @frozen public enum FunctionShellCallOutputOutcomeParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputOutcomeParam/FunctionShellCallOutputTimeoutOutcomeParam`.
            case functionShellCallOutputTimeoutOutcomeParam(Components.Schemas.FunctionShellCallOutputTimeoutOutcomeParam)
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputOutcomeParam/FunctionShellCallOutputExitOutcomeParam`.
            case functionShellCallOutputExitOutcomeParam(Components.Schemas.FunctionShellCallOutputExitOutcomeParam)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "FunctionShellCallOutputTimeoutOutcomeParam", "#/components/schemas/FunctionShellCallOutputTimeoutOutcomeParam", "timeout":
                    self = .functionShellCallOutputTimeoutOutcomeParam(try .init(from: decoder))
                case "FunctionShellCallOutputExitOutcomeParam", "#/components/schemas/FunctionShellCallOutputExitOutcomeParam", "exit":
                    self = .functionShellCallOutputExitOutcomeParam(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .functionShellCallOutputTimeoutOutcomeParam(value):
                    try value.encode(to: encoder)
                case let .functionShellCallOutputExitOutcomeParam(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// Captured stdout and stderr for a portion of a shell tool call output.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContentParam`.
        public struct FunctionShellCallOutputContentParam: Codable, Hashable, Sendable {
            /// Captured stdout output for the shell call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContentParam/stdout`.
            public var stdout: Swift.String
            /// Captured stderr output for the shell call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContentParam/stderr`.
            public var stderr: Swift.String
            /// The exit or timeout outcome associated with this shell call.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputContentParam/outcome`.
            public var outcome: Components.Schemas.FunctionShellCallOutputOutcomeParam
            /// Creates a new `FunctionShellCallOutputContentParam`.
            ///
            /// - Parameters:
            ///   - stdout: Captured stdout output for the shell call.
            ///   - stderr: Captured stderr output for the shell call.
            ///   - outcome: The exit or timeout outcome associated with this shell call.
            public init(
                stdout: Swift.String,
                stderr: Swift.String,
                outcome: Components.Schemas.FunctionShellCallOutputOutcomeParam
            ) {
                self.stdout = stdout
                self.stderr = stderr
                self.outcome = outcome
            }
            public enum CodingKeys: String, CodingKey {
                case stdout
                case stderr
                case outcome
            }
        }
        /// The streamed output items emitted by a shell tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam`.
        public struct FunctionShellCallOutputItemParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/id`.
            public var id: Swift.String?
            /// The unique ID of the shell tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/call_id`.
            public var callId: Swift.String
            /// The type of the item. Always `shell_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case shellCallOutput = "shell_call_output"
            }
            /// The type of the item. Always `shell_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/type`.
            public var _type: Components.Schemas.FunctionShellCallOutputItemParam._TypePayload
            /// Captured chunks of stdout and stderr output, along with their associated outcomes.
            ///
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/output`.
            public var output: [Components.Schemas.FunctionShellCallOutputContentParam]
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallItemStatus`.
            public typealias FunctionShellCallItemStatus = Components.Schemas.FunctionShellCallItemStatus
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/status`.
            public var status: Components.Schemas.FunctionShellCallItemStatus?
            /// - Remark: Generated from `#/components/schemas/FunctionShellCallOutputItemParam/max_output_length`.
            public var maxOutputLength: Swift.Int?
            /// Creates a new `FunctionShellCallOutputItemParam`.
            ///
            /// - Parameters:
            ///   - id:
            ///   - callId: The unique ID of the shell tool call generated by the model.
            ///   - _type: The type of the item. Always `shell_call_output`.
            ///   - output: Captured chunks of stdout and stderr output, along with their associated outcomes.
            ///   - status:
            ///   - maxOutputLength:
            public init(
                id: Swift.String? = nil,
                callId: Swift.String,
                _type: Components.Schemas.FunctionShellCallOutputItemParam._TypePayload,
                output: [Components.Schemas.FunctionShellCallOutputContentParam],
                status: Components.Schemas.FunctionShellCallItemStatus? = nil,
                maxOutputLength: Swift.Int? = nil
            ) {
                self.id = id
                self.callId = callId
                self._type = _type
                self.output = output
                self.status = status
                self.maxOutputLength = maxOutputLength
            }
            public enum CodingKeys: String, CodingKey {
                case id
                case callId = "call_id"
                case _type = "type"
                case output
                case status
                case maxOutputLength = "max_output_length"
            }
        }
        /// Status values reported for apply_patch tool calls.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchCallStatusParam`.
        @frozen public enum ApplyPatchCallStatusParam: String, Codable, Hashable, Sendable, CaseIterable {
            case inProgress = "in_progress"
            case completed = "completed"
        }
        /// Instruction for creating a new file via the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperationParam`.
        public struct ApplyPatchCreateFileOperationParam: Codable, Hashable, Sendable {
            /// The operation type. Always `create_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperationParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case createFile = "create_file"
            }
            /// The operation type. Always `create_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperationParam/type`.
            public var _type: Components.Schemas.ApplyPatchCreateFileOperationParam._TypePayload
            /// Path of the file to create relative to the workspace root.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperationParam/path`.
            public var path: Swift.String
            /// Unified diff content to apply when creating the file.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchCreateFileOperationParam/diff`.
            public var diff: Swift.String
            /// Creates a new `ApplyPatchCreateFileOperationParam`.
            ///
            /// - Parameters:
            ///   - _type: The operation type. Always `create_file`.
            ///   - path: Path of the file to create relative to the workspace root.
            ///   - diff: Unified diff content to apply when creating the file.
            public init(
                _type: Components.Schemas.ApplyPatchCreateFileOperationParam._TypePayload,
                path: Swift.String,
                diff: Swift.String
            ) {
                self._type = _type
                self.path = path
                self.diff = diff
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
                case diff
            }
        }
        /// Instruction for deleting an existing file via the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperationParam`.
        public struct ApplyPatchDeleteFileOperationParam: Codable, Hashable, Sendable {
            /// The operation type. Always `delete_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperationParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case deleteFile = "delete_file"
            }
            /// The operation type. Always `delete_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperationParam/type`.
            public var _type: Components.Schemas.ApplyPatchDeleteFileOperationParam._TypePayload
            /// Path of the file to delete relative to the workspace root.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchDeleteFileOperationParam/path`.
            public var path: Swift.String
            /// Creates a new `ApplyPatchDeleteFileOperationParam`.
            ///
            /// - Parameters:
            ///   - _type: The operation type. Always `delete_file`.
            ///   - path: Path of the file to delete relative to the workspace root.
            public init(
                _type: Components.Schemas.ApplyPatchDeleteFileOperationParam._TypePayload,
                path: Swift.String
            ) {
                self._type = _type
                self.path = path
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
            }
        }
        /// Instruction for updating an existing file via the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperationParam`.
        public struct ApplyPatchUpdateFileOperationParam: Codable, Hashable, Sendable {
            /// The operation type. Always `update_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperationParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case updateFile = "update_file"
            }
            /// The operation type. Always `update_file`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperationParam/type`.
            public var _type: Components.Schemas.ApplyPatchUpdateFileOperationParam._TypePayload
            /// Path of the file to update relative to the workspace root.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperationParam/path`.
            public var path: Swift.String
            /// Unified diff content to apply to the existing file.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchUpdateFileOperationParam/diff`.
            public var diff: Swift.String
            /// Creates a new `ApplyPatchUpdateFileOperationParam`.
            ///
            /// - Parameters:
            ///   - _type: The operation type. Always `update_file`.
            ///   - path: Path of the file to update relative to the workspace root.
            ///   - diff: Unified diff content to apply to the existing file.
            public init(
                _type: Components.Schemas.ApplyPatchUpdateFileOperationParam._TypePayload,
                path: Swift.String,
                diff: Swift.String
            ) {
                self._type = _type
                self.path = path
                self.diff = diff
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case path
                case diff
            }
        }
        /// One of the create_file, delete_file, or update_file operations supplied to the apply_patch tool.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchOperationParam`.
        @frozen public enum ApplyPatchOperationParam: Codable, Hashable, Sendable {
            /// - Remark: Generated from `#/components/schemas/ApplyPatchOperationParam/ApplyPatchCreateFileOperationParam`.
            case applyPatchCreateFileOperationParam(Components.Schemas.ApplyPatchCreateFileOperationParam)
            /// - Remark: Generated from `#/components/schemas/ApplyPatchOperationParam/ApplyPatchDeleteFileOperationParam`.
            case applyPatchDeleteFileOperationParam(Components.Schemas.ApplyPatchDeleteFileOperationParam)
            /// - Remark: Generated from `#/components/schemas/ApplyPatchOperationParam/ApplyPatchUpdateFileOperationParam`.
            case applyPatchUpdateFileOperationParam(Components.Schemas.ApplyPatchUpdateFileOperationParam)
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
            public init(from decoder: any Swift.Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                let discriminator = try container.decode(
                    Swift.String.self,
                    forKey: ._type
                )
                switch discriminator {
                case "ApplyPatchCreateFileOperationParam", "#/components/schemas/ApplyPatchCreateFileOperationParam", "create_file":
                    self = .applyPatchCreateFileOperationParam(try .init(from: decoder))
                case "ApplyPatchDeleteFileOperationParam", "#/components/schemas/ApplyPatchDeleteFileOperationParam", "delete_file":
                    self = .applyPatchDeleteFileOperationParam(try .init(from: decoder))
                case "ApplyPatchUpdateFileOperationParam", "#/components/schemas/ApplyPatchUpdateFileOperationParam", "update_file":
                    self = .applyPatchUpdateFileOperationParam(try .init(from: decoder))
                default:
                    throw Swift.DecodingError.unknownOneOfDiscriminator(
                        discriminatorKey: CodingKeys._type,
                        discriminatorValue: discriminator,
                        codingPath: decoder.codingPath
                    )
                }
            }
            public func encode(to encoder: any Swift.Encoder) throws {
                switch self {
                case let .applyPatchCreateFileOperationParam(value):
                    try value.encode(to: encoder)
                case let .applyPatchDeleteFileOperationParam(value):
                    try value.encode(to: encoder)
                case let .applyPatchUpdateFileOperationParam(value):
                    try value.encode(to: encoder)
                }
            }
        }
        /// A tool call representing a request to create, delete, or update files using diff patches.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam`.
        public struct ApplyPatchToolCallItemParam: Codable, Hashable, Sendable {
            /// The type of the item. Always `apply_patch_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applyPatchCall = "apply_patch_call"
            }
            /// The type of the item. Always `apply_patch_call`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam/type`.
            public var _type: Components.Schemas.ApplyPatchToolCallItemParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam/id`.
            public var id: Swift.String?
            /// The unique ID of the apply patch tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam/call_id`.
            public var callId: Swift.String
            /// The status of the apply patch tool call. One of `in_progress` or `completed`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam/status`.
            public var status: Components.Schemas.ApplyPatchCallStatusParam
            /// The specific create, delete, or update instruction for the apply_patch tool call.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallItemParam/operation`.
            public var operation: Components.Schemas.ApplyPatchOperationParam
            /// Creates a new `ApplyPatchToolCallItemParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `apply_patch_call`.
            ///   - id:
            ///   - callId: The unique ID of the apply patch tool call generated by the model.
            ///   - status: The status of the apply patch tool call. One of `in_progress` or `completed`.
            ///   - operation: The specific create, delete, or update instruction for the apply_patch tool call.
            public init(
                _type: Components.Schemas.ApplyPatchToolCallItemParam._TypePayload,
                id: Swift.String? = nil,
                callId: Swift.String,
                status: Components.Schemas.ApplyPatchCallStatusParam,
                operation: Components.Schemas.ApplyPatchOperationParam
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.status = status
                self.operation = operation
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case status
                case operation
            }
        }
        /// Outcome values reported for apply_patch tool call outputs.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchCallOutputStatusParam`.
        @frozen public enum ApplyPatchCallOutputStatusParam: String, Codable, Hashable, Sendable, CaseIterable {
            case completed = "completed"
            case failed = "failed"
        }
        /// The streamed output emitted by an apply patch tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam`.
        public struct ApplyPatchToolCallOutputItemParam: Codable, Hashable, Sendable {
            /// The type of the item. Always `apply_patch_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applyPatchCallOutput = "apply_patch_call_output"
            }
            /// The type of the item. Always `apply_patch_call_output`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam/type`.
            public var _type: Components.Schemas.ApplyPatchToolCallOutputItemParam._TypePayload
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam/id`.
            public var id: Swift.String?
            /// The unique ID of the apply patch tool call generated by the model.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam/call_id`.
            public var callId: Swift.String
            /// The status of the apply patch tool call output. One of `completed` or `failed`.
            ///
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam/status`.
            public var status: Components.Schemas.ApplyPatchCallOutputStatusParam
            /// - Remark: Generated from `#/components/schemas/ApplyPatchToolCallOutputItemParam/output`.
            public var output: Swift.String?
            /// Creates a new `ApplyPatchToolCallOutputItemParam`.
            ///
            /// - Parameters:
            ///   - _type: The type of the item. Always `apply_patch_call_output`.
            ///   - id:
            ///   - callId: The unique ID of the apply patch tool call generated by the model.
            ///   - status: The status of the apply patch tool call output. One of `completed` or `failed`.
            ///   - output:
            public init(
                _type: Components.Schemas.ApplyPatchToolCallOutputItemParam._TypePayload,
                id: Swift.String? = nil,
                callId: Swift.String,
                status: Components.Schemas.ApplyPatchCallOutputStatusParam,
                output: Swift.String? = nil
            ) {
                self._type = _type
                self.id = id
                self.callId = callId
                self.status = status
                self.output = output
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case id
                case callId = "call_id"
                case status
                case output
            }
        }
        /// An internal identifier for an item to reference.
        ///
        /// - Remark: Generated from `#/components/schemas/ItemReferenceParam`.
        public struct ItemReferenceParam: Codable, Hashable, Sendable {
            /// The type of item to reference. Always `item_reference`.
            ///
            /// - Remark: Generated from `#/components/schemas/ItemReferenceParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case itemReference = "item_reference"
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
        /// Forces the model to call the apply_patch tool when executing a tool call.
        ///
        /// - Remark: Generated from `#/components/schemas/SpecificApplyPatchParam`.
        public struct SpecificApplyPatchParam: Codable, Hashable, Sendable {
            /// The tool to call. Always `apply_patch`.
            ///
            /// - Remark: Generated from `#/components/schemas/SpecificApplyPatchParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case applyPatch = "apply_patch"
            }
            /// The tool to call. Always `apply_patch`.
            ///
            /// - Remark: Generated from `#/components/schemas/SpecificApplyPatchParam/type`.
            public var _type: Components.Schemas.SpecificApplyPatchParam._TypePayload
            /// Creates a new `SpecificApplyPatchParam`.
            ///
            /// - Parameters:
            ///   - _type: The tool to call. Always `apply_patch`.
            public init(_type: Components.Schemas.SpecificApplyPatchParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// Forces the model to call the shell tool when a tool call is required.
        ///
        /// - Remark: Generated from `#/components/schemas/SpecificFunctionShellParam`.
        public struct SpecificFunctionShellParam: Codable, Hashable, Sendable {
            /// The tool to call. Always `shell`.
            ///
            /// - Remark: Generated from `#/components/schemas/SpecificFunctionShellParam/type`.
            @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
                case shell = "shell"
            }
            /// The tool to call. Always `shell`.
            ///
            /// - Remark: Generated from `#/components/schemas/SpecificFunctionShellParam/type`.
            public var _type: Components.Schemas.SpecificFunctionShellParam._TypePayload
            /// Creates a new `SpecificFunctionShellParam`.
            ///
            /// - Parameters:
            ///   - _type: The tool to call. Always `shell`.
            public init(_type: Components.Schemas.SpecificFunctionShellParam._TypePayload) {
                self._type = _type
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
            }
        }
        /// The conversation that this response belongs to.
        ///
        /// - Remark: Generated from `#/components/schemas/ConversationParam-2`.
        public struct ConversationParam2: Codable, Hashable, Sendable {
            /// The unique ID of the conversation.
            ///
            /// - Remark: Generated from `#/components/schemas/ConversationParam-2/id`.
            public var id: Swift.String
            /// Creates a new `ConversationParam2`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the conversation.
            public init(id: Swift.String) {
                self.id = id
            }
            public enum CodingKeys: String, CodingKey {
                case id
            }
        }
        /// - Remark: Generated from `#/components/schemas/ContextManagementParam`.
        public struct ContextManagementParam: Codable, Hashable, Sendable {
            /// The context management entry type. Currently only 'compaction' is supported.
            ///
            /// - Remark: Generated from `#/components/schemas/ContextManagementParam/type`.
            public var _type: Swift.String
            /// - Remark: Generated from `#/components/schemas/ContextManagementParam/compact_threshold`.
            public var compactThreshold: Swift.Int?
            /// Creates a new `ContextManagementParam`.
            ///
            /// - Parameters:
            ///   - _type: The context management entry type. Currently only 'compaction' is supported.
            ///   - compactThreshold:
            public init(
                _type: Swift.String,
                compactThreshold: Swift.Int? = nil
            ) {
                self._type = _type
                self.compactThreshold = compactThreshold
            }
            public enum CodingKeys: String, CodingKey {
                case _type = "type"
                case compactThreshold = "compact_threshold"
            }
        }
        /// The conversation that this response belonged to. Input items and output items from this response were automatically added to this conversation.
        ///
        /// - Remark: Generated from `#/components/schemas/Conversation-2`.
        public struct Conversation2: Codable, Hashable, Sendable {
            /// The unique ID of the conversation that this response was associated with.
            ///
            /// - Remark: Generated from `#/components/schemas/Conversation-2/id`.
            public var id: Swift.String
            /// Creates a new `Conversation2`.
            ///
            /// - Parameters:
            ///   - id: The unique ID of the conversation that this response was associated with.
            public init(id: Swift.String) {
                self.id = id
            }
            public enum CodingKeys: String, CodingKey {
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

