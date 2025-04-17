//
//  Schemas+Response.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 17.04.2025.
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

extension Components.Schemas {
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
        /// Creates a new `ModelResponseProperties`.
        ///
        /// - Parameters:
        ///   - metadata:
        ///   - temperature: What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
        ///   - topP: An alternative to sampling with temperature, called nucleus sampling,
        ///   - user: A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](/docs/guides/safety-best-practices#end-user-ids).
        public init(
            metadata: Components.Schemas.Metadata? = nil,
            temperature: Swift.Double? = nil,
            topP: Swift.Double? = nil,
            user: Swift.String? = nil
        ) {
            self.metadata = metadata
            self.temperature = temperature
            self.topP = topP
            self.user = user
        }
        public enum CodingKeys: String, CodingKey {
            case metadata
            case temperature
            case topP = "top_p"
            case user
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
    /// JSON Schema response format. Used to generate structured JSON responses.
    /// Learn more about [Structured Outputs](/docs/guides/structured-outputs).
    ///
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema`.
    public struct ResponseFormatJsonSchema: Codable, Hashable, Sendable {
        /// The type of response format being defined. Always `json_schema`.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/type`.
        @frozen public enum _TypePayload: String, Codable, Hashable, Sendable, CaseIterable {
            case jsonSchema = "json_schema"
        }
        /// The type of response format being defined. Always `json_schema`.
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/type`.
        public var _type: Components.Schemas.ResponseFormatJsonSchema._TypePayload
        /// Structured Outputs configuration options, including a JSON Schema.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/json_schema`.
        public struct JsonSchemaPayload: Codable, Hashable, Sendable {
            /// A description of what the response format is for, used by the model to
            /// determine how to respond in the format.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/json_schema/description`.
            public var description: Swift.String?
            /// The name of the response format. Must be a-z, A-Z, 0-9, or contain
            /// underscores and dashes, with a maximum length of 64.
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/json_schema/name`.
            public var name: Swift.String
            /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/json_schema/schema`.
            public var schema: Components.Schemas.ResponseFormatJsonSchemaSchema?
            /// Whether to enable strict schema adherence when generating the output.
            /// If set to true, the model will always follow the exact schema defined
            /// in the `schema` field. Only a subset of JSON Schema is supported when
            /// `strict` is `true`. To learn more, read the [Structured Outputs
            /// guide](/docs/guides/structured-outputs).
            ///
            ///
            /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/json_schema/strict`.
            public var strict: Swift.Bool?
            /// Creates a new `JsonSchemaPayload`.
            ///
            /// - Parameters:
            ///   - description: A description of what the response format is for, used by the model to
            ///   - name: The name of the response format. Must be a-z, A-Z, 0-9, or contain
            ///   - schema:
            ///   - strict: Whether to enable strict schema adherence when generating the output.
            public init(
                description: Swift.String? = nil,
                name: Swift.String,
                schema: Components.Schemas.ResponseFormatJsonSchemaSchema? = nil,
                strict: Swift.Bool? = nil
            ) {
                self.description = description
                self.name = name
                self.schema = schema
                self.strict = strict
            }
            public enum CodingKeys: String, CodingKey {
                case description
                case name
                case schema
                case strict
            }
        }
        /// Structured Outputs configuration options, including a JSON Schema.
        ///
        ///
        /// - Remark: Generated from `#/components/schemas/ResponseFormatJsonSchema/json_schema`.
        public var jsonSchema: Components.Schemas.ResponseFormatJsonSchema.JsonSchemaPayload
        /// Creates a new `ResponseFormatJsonSchema`.
        ///
        /// - Parameters:
        ///   - _type: The type of response format being defined. Always `json_schema`.
        ///   - jsonSchema: Structured Outputs configuration options, including a JSON Schema.
        public init(
            _type: Components.Schemas.ResponseFormatJsonSchema._TypePayload,
            jsonSchema: Components.Schemas.ResponseFormatJsonSchema.JsonSchemaPayload
        ) {
            self._type = _type
            self.jsonSchema = jsonSchema
        }
        public enum CodingKeys: String, CodingKey {
            case _type = "type"
            case jsonSchema = "json_schema"
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
    /// - Remark: Generated from `#/components/schemas/ResponseModalities`.
    @frozen public enum ResponseModalitiesPayload: String, Codable, Hashable, Sendable, CaseIterable {
        case text = "text"
        case audio = "audio"
    }
    /// Output types that you would like the model to generate.
    /// Most models are capable of generating text, which is the default:
    ///
    /// `["text"]`
    ///
    /// The `gpt-4o-audio-preview` model can also be used to
    /// [generate audio](/docs/guides/audio). To request that this model generate
    /// both text and audio responses, you can use:
    ///
    /// `["text", "audio"]`
    ///
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseModalities`.
    public typealias ResponseModalities = [Components.Schemas.ResponseModalitiesPayload]
    /// - Remark: Generated from `#/components/schemas/ResponseModalitiesTextOnly`.
    @frozen public enum ResponseModalitiesTextOnlyPayload: String, Codable, Hashable, Sendable, CaseIterable {
        case text = "text"
    }
    /// Output types that you would like the model to generate.
    /// Most models are capable of generating text, which is the default:
    ///
    /// `["text"]`
    ///
    /// This API will soon support other output modalities, including audio and images.
    ///
    ///
    /// - Remark: Generated from `#/components/schemas/ResponseModalitiesTextOnly`.
    public typealias ResponseModalitiesTextOnly = [Components.Schemas.ResponseModalitiesTextOnlyPayload]
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
        /// response will be not be carried over to the next response. This makes it simple
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
        public var value25: Components.Schemas.ResponseRefusalDeltaEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value26`.
        public var value26: Components.Schemas.ResponseRefusalDoneEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value27`.
        public var value27: Components.Schemas.ResponseTextAnnotationDeltaEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value28`.
        public var value28: Components.Schemas.ResponseTextDeltaEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value29`.
        public var value29: Components.Schemas.ResponseTextDoneEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value30`.
        public var value30: Components.Schemas.ResponseWebSearchCallCompletedEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value31`.
        public var value31: Components.Schemas.ResponseWebSearchCallInProgressEvent?
        /// - Remark: Generated from `#/components/schemas/ResponseStreamEvent/value32`.
        public var value32: Components.Schemas.ResponseWebSearchCallSearchingEvent?
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
            value25: Components.Schemas.ResponseRefusalDeltaEvent? = nil,
            value26: Components.Schemas.ResponseRefusalDoneEvent? = nil,
            value27: Components.Schemas.ResponseTextAnnotationDeltaEvent? = nil,
            value28: Components.Schemas.ResponseTextDeltaEvent? = nil,
            value29: Components.Schemas.ResponseTextDoneEvent? = nil,
            value30: Components.Schemas.ResponseWebSearchCallCompletedEvent? = nil,
            value31: Components.Schemas.ResponseWebSearchCallInProgressEvent? = nil,
            value32: Components.Schemas.ResponseWebSearchCallSearchingEvent? = nil
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
                    self.value32
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
}
