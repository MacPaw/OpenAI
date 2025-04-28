//
//  CreateModelResponseQuery.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 26.03.2025.
//

import Foundation

public struct CreateModelResponseQuery: Codable, Equatable, Sendable {
    public typealias Schemas = Components.Schemas
    public typealias ResponseProperties = Schemas.ResponseProperties
    
    /// Text, image, or file inputs to the model, used to generate a response.
    ///
    /// Learn more:
    /// [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
    /// [Image inputs](https://platform.openai.com/docs/guides/images)
    /// [File inputs](https://platform.openai.com/docs/guides/pdf-files)
    /// [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
    /// [Function calling](https://platform.openai.com/docs/guides/function-calling)
    public let input: Input
    
    /// Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a wide range of models with different capabilities, performance characteristics, and price points.
    /// Refer to the [model guide](https://platform.openai.com/docs/models) to browse and compare available models.
    public let model: String
    
    /// Specify additional output data to include in the model response. Currently supported values are:
    /// * `file_search_call.results`: Include the search results of the file search tool call.
    /// * `message.input_image.image_url`: Include image urls from the input message.
    /// * `computer_call_output.output.image_url`: Include image urls from the computer call output.
    public let include: [Schemas.Includable]?
    
    /// Inserts a system (or developer) message as the first item in the model's context.
    ///
    /// When using along with `previousResponseId`, the instructions from a previous response will not be carried over to the next response.
    /// This makes it simple to swap out system (or developer) messages in new responses.
    public let instructions: String?
    
    /// An upper bound for the number of tokens that can be generated for a response, including visible output tokens and [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
    public let maxOutputTokens: Int?
    
    /// Set of 16 key-value pairs that can be attached to an object.
    /// This can be useful for storing additional information about the object in a structured format, and querying for objects via API or the dashboard.
    ///
    /// Keys are strings with a maximum length of 64 characters.
    /// Values are strings with a maximum length of 512 characters.
    public let metadata: Schemas.Metadata?
    
    /// Whether to allow the model to run tool calls in parallel.
    public let parallelToolCalls: Bool?
    
    /// The unique ID of the previous response to the model. Use this to create multi-turn conversations.
    /// Learn more about [conversation state](https://platform.openai.com/docs/guides/conversation-state).
    public let previousResponseId: String?
    
    /// **o-series models only**
    ///
    /// Configuration options for [reasoning models](https://platform.openai.com/docs/guides/reasoning).
    public let reasoning: Schemas.Reasoning?
    
    /// Whether to store the generated model response for later retrieval via API.
    public let store: Bool?
    
    /// If set to true, the model response data will be streamed to the client as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
    /// See the [Streaming section](https://platform.openai.com/docs/api-reference/responses-streaming) below for more information.
    public let stream: Bool?
    
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
    ///
    /// We generally recommend altering this or `topP` but not both.
    public let temperature: Double?
    
    /// Configuration options for a text response from the model. Can be plain text or structured JSON data.
    /// Learn more:
    /// * [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
    /// * [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
    public let text: ResponseProperties.TextPayload?
    
    /// How the model should select which tool (or tools) to use when generating a response.
    /// See the `tools` parameter to see how to specify which tools the model can call.
    public let toolChoice: ResponseProperties.ToolChoicePayload?
    
    /// An array of tools the model may call while generating a response. You can specify which tool to use by setting the `toolChoice` parameter.
    ///
    /// The two categories of tools you can provide the model are:
    /// - **Built-in tools**: Tools that are provided by OpenAI that extend the model's capabilities, like [web search](https://platform.openai.com/docs/guides/tools-web-search) or [file search](https://platform.openai.com/docs/guides/tools-file-search).
    /// - **Function calls (custom tools):** Functions that are defined by you, enabling the model to call your own code.
    /// Learn more about [function calling](https://platform.openai.com/docs/guides/function-calling).
    public let tools: [Tool]?
    
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with topP probability mass.
    /// So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    ///
    /// We generally recommend altering this or `temperature` but not both.
    public let topP: Double?
    
    /// The truncation strategy to use for the model response.
    /// - `auto`: If the context of this response and previous ones exceeds the model's context window size, the model will truncate the response to fit the context window by dropping input items in the middle of the conversation.
    /// - `disabled` (default): If a model response will exceed the context window size for a model, the request will fail with a 400 error.
    public let truncation: String?
    
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    /// [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
    public let user: String?
    
    public init(
        input: Input,
        model: String,
        include: [Schemas.Includable]? = nil,
        instructions: String? = nil,
        maxOutputTokens: Int? = nil,
        metadata: Schemas.Metadata? = nil,
        parallelToolCalls: Bool? = nil,
        previousResponseId: String? = nil,
        reasoning: Schemas.Reasoning? = nil,
        store: Bool? = nil,
        stream: Bool? = nil,
        temperature: Double? = nil,
        text: ResponseProperties.TextPayload? = nil,
        toolChoice: ResponseProperties.ToolChoicePayload? = nil,
        tools: [Tool]? = nil,
        topP: Double? = nil,
        truncation: String? = nil,
        user: String? = nil
    ) {
        self.input = input
        self.model = model
        self.include = include
        self.instructions = instructions
        self.maxOutputTokens = maxOutputTokens
        self.metadata = metadata
        self.parallelToolCalls = parallelToolCalls
        self.previousResponseId = previousResponseId
        self.reasoning = reasoning
        self.store = store
        self.stream = stream
        self.temperature = temperature
        self.text = text
        self.toolChoice = toolChoice
        self.tools = tools
        self.topP = topP
        self.truncation = truncation
        self.user = user
    }
    
    private enum CodingKeys: String, CodingKey {
        case input
        case model
        case include
        case instructions
        case maxOutputTokens = "max_output_tokens"
        case metadata
        case parallelToolCalls = "parallel_tool_calls"
        case previousResponseId = "previous_response_id"
        case reasoning
        case store
        case stream
        case temperature
        case text
        case toolChoice = "tool_choice"
        case tools
        case topP = "top_p"
        case truncation
        case user
    }
}
