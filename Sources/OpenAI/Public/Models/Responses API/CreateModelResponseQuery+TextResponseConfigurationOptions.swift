//
//  CreateModelResponseQuery+TextResponseConfigurationOptions.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 01.07.2025.
//


extension CreateModelResponseQuery {
    public struct TextResponseConfigurationOptions: Codable, Hashable, Sendable {
        /// An object specifying the format that the model must output.
        ///
        /// Configuring `{ "type": "json_schema" }` enables Structured Outputs, which ensures the model will match your supplied JSON schema. Learn more in the [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        ///
        /// The default format is `{ "type": "text" }` with no additional options.
        ///
        /// **Not recommended for gpt-4o and newer models:**
        ///
        /// Setting to `{ "type": "json_object" }` enables the older JSON mode, which ensures the message the model generates is valid JSON. Using `json_schema` is preferred for models that support it.
        let format: OutputFormat?

        /// Controls the verbosity of the model's text output.
        ///
        /// Possible values: "low", "medium", "high"
        let verbosity: Verbosity?

        public static let text = TextResponseConfigurationOptions(format: .text)
        public static let jsonObject = TextResponseConfigurationOptions(format: .jsonObject)
        public static func jsonSchema(_ config: OutputFormat.StructuredOutputsConfig) -> TextResponseConfigurationOptions {
            .init(format: .jsonSchema(config))
        }

        public init(format: OutputFormat?, verbosity: Verbosity? = nil) {
            self.format = format
            self.verbosity = verbosity
        }
        
        public enum OutputFormat: Codable, Hashable, Sendable {
            /// Default response format. Used to generate text responses.
            case text
            /// JSON Schema response format. Used to generate structured JSON responses. Learn more about [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs).
            case jsonSchema(StructuredOutputsConfig)
            /// JSON object response format. An older method of generating JSON responses. Using `json_schema` is recommended for models that support it. Note that the model will not generate JSON without a system or user message instructing it to do so.
            case jsonObject

            public init(from decoder: any Decoder) throws {
                let container = try decoder.singleValueContainer()

                // Try to decode as ResponseFormatText
                if let _ = try? container.decode(Schemas.ResponseFormatText.self) {
                    self = .text
                    return
                }

                // Try to decode as StructuredOutputsConfig (json_schema)
                if let config = try? container.decode(StructuredOutputsConfig.self) {
                    self = .jsonSchema(config)
                    return
                }

                // Try to decode as ResponseFormatJsonObject
                if let _ = try? container.decode(Schemas.ResponseFormatJsonObject.self) {
                    self = .jsonObject
                    return
                }

                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription: "Unable to decode OutputFormat"
                    )
                )
            }

            public func encode(to encoder: any Encoder) throws {
                var container = encoder.singleValueContainer()
                switch self {
                case .text:
                    try container.encode(Schemas.ResponseFormatText(_type: .text))
                case .jsonSchema(let a0):
                    try container.encode(a0)
                case .jsonObject:
                    try container.encode(Schemas.ResponseFormatJsonObject(_type: .jsonObject))
                }
            }
            
            public struct StructuredOutputsConfig: Codable, Hashable, Sendable {
                /// The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
                public let name: String
                /// The schema for the response format, described as a JSON Schema object. Learn how to build JSON schemas [here](https://json-schema.org/).
                public let schema: JSONSchemaDefinition
                /// The type of response format being defined. Always `json_schema`.
                public let type: String
                /// A description of what the response format is for, used by the model to determine how to respond in the format.
                public let description: String?
                /// Whether to enable strict schema adherence when generating the output. If set to true, the model will always follow the exact schema defined in the `schema` field. Only a subset of JSON Schema is supported when `strict` is `true`. To learn more, read the [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
                public let strict: Bool?
                
                public init(name: String, schema: JSONSchemaDefinition, type: String = "json_schema", description: String?, strict: Bool?) {
                    self.name = name
                    self.schema = schema
                    self.type = type
                    self.description = description
                    self.strict = strict
                }
            }
        }

        public enum Verbosity: String, Codable, Hashable, Sendable {
            case low
            case medium
            case high
        }
    }
}
