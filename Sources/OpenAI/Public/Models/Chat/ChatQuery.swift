//
//  ChatQuery.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public enum ToolChoice: String, Codable {
    case auto
    case none
}

public struct ChatQuery: Equatable, Codable, Streamable {
    /// ID of the model to use. Currently, only gpt-3.5-turbo and gpt-3.5-turbo-0301 are supported.
    public let model: Model
    /// An object specifying the format that the model must output.
    public let responseFormat: ResponseFormat?
    /// The messages to generate chat completions for
    public let messages: [Message]
    /// A list of functions the model may generate JSON inputs for.
    public let functions: [ChatFunctionDeclaration]?
    
    public let tools: [ChatTool]?
    
    /// Controls how the model responds to function calls. "none" means the model does not call a function, and responds to the end-user. "auto" means the model can pick between and end-user or calling a function. Specifying a particular function via `{"name": "my_function"}` forces the model to call that function. "none" is the default when no functions are present. "auto" is the default if functions are present.
    public let functionCall: FunctionCall?
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and  We generally recommend altering this or top_p but not both.
    public let temperature: Double?
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    public let topP: Double?
    /// How many chat completion choices to generate for each input message.
    public let n: Int?
    /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
    public let stop: [String]?
    /// The maximum number of tokens to generate in the completion.
    public let maxTokens: Int?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    public let presencePenalty: Double?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    public let frequencyPenalty: Double?
    /// Modify the likelihood of specified tokens appearing in the completion.
    public let logitBias: [String:Int]?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    public let user: String?
    
    /// Controls which (if any) function is called by the model. 
    /// `none` means the model will not call a function and instead generates a message.
    /// `auto` means the model can pick between generating a message or calling a function
    ///
    /// Specifying a particular function via ``Tool.ToolValue`` forces the model to call that function.
    ///
    /// `none` is default when no functions are present
    /// `auto` is default if functions are present
    public let toolChoice: EnumOrCodable<ToolChoice, ChatTool.ToolValue>?
    
    var stream: Bool = false

    
    enum CodingKeys: String, CodingKey {
        case model
        case messages
        case functions
        case functionCall = "function_call"
        case temperature
        case topP = "top_p"
        case n
        case stream
        case stop
        case maxTokens = "max_tokens"
        case presencePenalty = "presence_penalty"
        case frequencyPenalty = "frequency_penalty"
        case logitBias = "logit_bias"
        case user
        case responseFormat = "response_format"
        case tools
        case toolChoice = "tool_choice"
    }
    
    public init(
        model: Model,
        messages: [Message],
        responseFormat: ResponseFormat? = nil,
        tools: [ChatTool]? = nil,
        toolChoice: EnumOrCodable<ToolChoice, ChatTool.ToolValue>? = nil,
        functions: [ChatFunctionDeclaration]? = nil,
        functionCall: FunctionCall? = nil,
        temperature: Double? = nil,
        topP: Double? = nil,
        n: Int? = nil,
        stop: [String]? = nil,
        maxTokens: Int? = nil,
        presencePenalty: Double? = nil,
        frequencyPenalty: Double? = nil,
        logitBias: [String : Int]? = nil,
        user: String? = nil,
        stream: Bool = false
    ) {
        self.model = model
        self.messages = messages
        self.tools = tools
        self.toolChoice = toolChoice
        self.functions = functions
        self.functionCall = functionCall
        self.temperature = temperature
        self.topP = topP
        self.n = n
        self.responseFormat = responseFormat
        self.stop = stop
        self.maxTokens = maxTokens
        self.presencePenalty = presencePenalty
        self.frequencyPenalty = frequencyPenalty
        self.logitBias = logitBias
        self.user = user
        self.stream = stream
    }
}

