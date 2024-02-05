//
//  ChatQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

// See more https://platform.openai.com/docs/guides/text-generation/json-mode
public struct ResponseFormat: Codable, Equatable {
    public static let jsonObject = ResponseFormat(type: .jsonObject)
    public static let text = ResponseFormat(type: .text)
    
    public let type: Self.ResponseFormatType
    
    public enum ResponseFormatType: String, Codable, Equatable {
        case jsonObject = "json_object"
        case text
    }
}

public struct Chat: Codable, Equatable {
    public let role: Role
    /// The contents of the message. `content` is required for all messages except assistant messages with function calls.
    public let content: String?
    /// The name of the author of this message. `name` is required if role is `function`, and it should be the name of the function whose response is in the `content`. May contain a-z, A-Z, 0-9, and underscores, with a maximum length of 64 characters.
    public let name: String?
    public let function_call: ChatFunctionCall?
    
    public enum Role: String, Codable, Equatable {
        case system
        case assistant
        case user
        case function
    }

    public init(role: Role, content: String? = nil, name: String? = nil, function_call: ChatFunctionCall? = nil) {
        self.role = role
        self.content = content
        self.name = name
        self.function_call = function_call
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(role, forKey: .role)

        if let name = name {
            try container.encode(name, forKey: .name)
        }

        if let function_call = function_call {
            try container.encode(function_call, forKey: .function_call)
        }

        // Should add 'nil' to 'content' property for function calling response
        // See https://openai.com/blog/function-calling-and-other-api-updates
        if content != nil || (role == .assistant && function_call != nil) {
            try container.encode(content, forKey: .content)
        }
    }
}

public struct ChatFunctionCall: Codable, Equatable {
    /// The name of the function to call.
    public let name: String?
    /// The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function.
    public let arguments: String?

    public init(name: String?, arguments: String?) {
        self.name = name
        self.arguments = arguments
    }
}


/// See the [guide](/docs/guides/gpt/function-calling) for examples, and the [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for documentation about the format.
public struct JSONSchema: Codable, Equatable {
    public let type: JSONType
    public let properties: [String: Property]?
    public let required: [String]?
    public let pattern: String?
    public let const: String?
    public let `enum`: [String]?
    public let multiple_of: Int?
    public let minimum: Int?
    public let maximum: Int?
    
    public struct Property: Codable, Equatable {
        public let type: JSONType
        public let description: String?
        public let format: String?
        public let items: Items?
        public let required: [String]?
        public let pattern: String?
        public let const: String?
        public let `enum`: [String]?
        public let multiple_of: Int?
        public let minimum: Double?
        public let maximum: Double?
        public let min_items: Int?
        public let max_items: Int?
        public let unique_items: Bool?

        public init(type: JSONType, description: String? = nil, format: String? = nil, items: Items? = nil, required: [String]? = nil, pattern: String? = nil, const: String? = nil, `enum`: [String]? = nil, multiple_of: Int? = nil, minimum: Double? = nil, maximum: Double? = nil, min_items: Int? = nil, max_items: Int? = nil, unique_items: Bool? = nil) {
            self.type = type
            self.description = description
            self.format = format
            self.items = items
            self.required = required
            self.pattern = pattern
            self.const = const
            self.`enum` = `enum`
            self.multiple_of = multiple_of
            self.minimum = minimum
            self.maximum = maximum
            self.min_items = min_items
            self.max_items = max_items
            self.unique_items = unique_items
        }
    }

    public enum JSONType: String, Codable {
        case integer
        case string
        case boolean
        case array
        case object
        case number
        case null
    }

    public struct Items: Codable, Equatable {
        public let type: JSONType
        public let properties: [String: Property]?
        public let pattern: String?
        public let const: String?
        public let `enum`: [String]?
        public let multiple_of: Int?
        public let minimum: Double?
        public let maximum: Double?
        public let min_items: Int?
        public let max_items: Int?
        public let unique_items: Bool?

        public init(type: JSONType, properties: [String : Property]? = nil, pattern: String? = nil, const: String? = nil, `enum`: [String]? = nil, multiple_of: Int? = nil, minimum: Double? = nil, maximum: Double? = nil, min_items: Int? = nil, max_items: Int? = nil, unique_items: Bool? = nil) {
            self.type = type
            self.properties = properties
            self.pattern = pattern
            self.const = const
            self.`enum` = `enum`
            self.multiple_of = multiple_of
            self.minimum = minimum
            self.maximum = maximum
            self.min_items = min_items
            self.max_items = max_items
            self.unique_items = unique_items
        }
    }
    
    public init(type: JSONType, properties: [String : Property]? = nil, required: [String]? = nil, pattern: String? = nil, const: String? = nil, `enum`: [String]? = nil, multiple_of: Int? = nil, minimum: Int? = nil, maximum: Int? = nil) {
        self.type = type
        self.properties = properties
        self.required = required
        self.pattern = pattern
        self.const = const
        self.`enum` = `enum`
        self.multiple_of = multiple_of
        self.minimum = minimum
        self.maximum = maximum
    }
}

public struct ChatFunctionDeclaration: Codable, Equatable {
    /// The name of the function to be called. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64.
    public let name: String
    
    /// The description of what the function does.
    public let description: String
    
    /// The parameters the functions accepts, described as a JSON Schema object.
    public let parameters: JSONSchema
  
    public init(name: String, description: String, parameters: JSONSchema) {
      self.name = name
      self.description = description
      self.parameters = parameters
    }
}

public struct ChatQueryFunctionCall: Codable, Equatable {
    /// The name of the function to call.
    public let name: String?
    /// The arguments to call the function with, as generated by the model in JSON format. Note that the model does not always generate valid JSON, and may hallucinate parameters not defined by your function schema. Validate the arguments in your code before calling your function.
    public let arguments: String?
}

public struct ChatQuery: Equatable, Codable, Streamable {
    /// ID of the model to use. Currently, only gpt-3.5-turbo and gpt-3.5-turbo-0301 are supported.
    public let model: Model
    /// An object specifying the format that the model must output.
    public let response_format: ResponseFormat?
    /// The messages to generate chat completions for
    public let messages: [Chat]
    /// A list of functions the model may generate JSON inputs for.
    public let functions: [ChatFunctionDeclaration]?
    /// Controls how the model responds to function calls. "none" means the model does not call a function, and responds to the end-user. "auto" means the model can pick between and end-user or calling a function. Specifying a particular function via `{"name": "my_function"}` forces the model to call that function. "none" is the default when no functions are present. "auto" is the default if functions are present.
    public let function_call: FunctionCall?
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and  We generally recommend altering this or top_p but not both.
    public let temperature: Double?
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    public let top_p: Double?
    /// How many chat completion choices to generate for each input message.
    public let n: Int?
    /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
    public let stop: [String]?
    /// The maximum number of tokens to generate in the completion.
    public let max_tokens: Int?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    public let presence_penalty: Double?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    public let frequency_penalty: Double?
    /// Modify the likelihood of specified tokens appearing in the completion.
    public let logit_bias: [String:Int]?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    public let user: String?
    
    var stream: Bool = false

    public enum FunctionCall: Codable, Equatable {
        case none
        case auto
        case function(String)
        
        enum CodingKeys: String, CodingKey {
            case none = "none"
            case auto = "auto"
            case function = "name"
        }
        
        public func encode(to encoder: Encoder) throws {
            switch self {
            case .none:
                var container = encoder.singleValueContainer()
                try container.encode(CodingKeys.none.rawValue)
            case .auto:
                var container = encoder.singleValueContainer()
                try container.encode(CodingKeys.auto.rawValue)
            case .function(let name):
                var container = encoder.container(keyedBy: CodingKeys.self)
                try container.encode(name, forKey: .function)
            }
        }
    }

    public init(model: Model, messages: [Chat], response_format: ResponseFormat? = nil, functions: [ChatFunctionDeclaration]? = nil, function_call: FunctionCall? = nil, temperature: Double? = nil, top_p: Double? = nil, n: Int? = nil, stop: [String]? = nil, max_tokens: Int? = nil, presence_penalty: Double? = nil, frequency_penalty: Double? = nil, logit_bias: [String : Int]? = nil, user: String? = nil, stream: Bool = false) {
        self.model = model
        self.messages = messages
        self.functions = functions
        self.function_call = function_call
        self.temperature = temperature
        self.top_p = top_p
        self.n = n
        self.response_format = response_format
        self.stop = stop
        self.max_tokens = max_tokens
        self.presence_penalty = presence_penalty
        self.frequency_penalty = frequency_penalty
        self.logit_bias = logit_bias
        self.user = user
        self.stream = stream
    }
}
