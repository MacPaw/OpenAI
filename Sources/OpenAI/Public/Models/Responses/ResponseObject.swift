//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 27.03.2025.
//

import Foundation
import OpenAPIRuntime

/// Represents a model for querying the OpenAI API.
public struct CreateModelResponseResult: Codable, Equatable, Sendable {
    public typealias Schemas = Components.Schemas
    public typealias ResponseProperties = Schemas.ResponseProperties
    public typealias IncompleteDetails = Schemas.Response.Value3Payload.IncompleteDetailsPayload?
    
    /// Unix timestamp (in seconds) of when this Response was created.
    public let createdAt: Int
    
    /// An error object returned when the model fails to generate a Response.
    public let error: Schemas.ResponseError?
    
    /// Unique identifier for this Response.
    public let id: String
    
    /// Details about why the response is incomplete.
    public let incompleteDetails: IncompleteDetails?
    
    /// Inserts a system (or developer) message as the first item in the model's context.
    ///
    /// When using along with `previous_response_id`, the instructions from a previous response will not be carried over to the next response. This makes it simple to swap out system (or developer) messages in new responses.
    public let instructions: String?
    
    /// An upper bound for the number of tokens that can be generated for a response, including visible output tokens and [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
    public let maxOutputTokens: Int?
    
    /// Set of 16 key-value pairs that can be attached to an object. This can be useful for storing additional information about the object in a structured format, and querying for objects via API or the dashboard.
    ///
    /// Keys are strings with a maximum length of 64 characters. Values are strings with a maximum length of 512 characters.
    public let metadata: [String: String]
    
    /// Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a wide range of models with different capabilities, performance characteristics, and price points. Refer to the [model guide](https://platform.openai.com/docs/models) to browse and compare available models.
    public let model: String
    
    /// The object type of this resource - always set to `response`.
    public let object: String
    
    /// An array of content items generated by the model.
    /// * The length and order of items in the `output` array is dependent on the model's response.
    /// * Rather than accessing the first item in the `output` array and assuming it's an `assistant` message with the content generated by the model, you might consider using the `output_text` property where supported in SDKs.
    public let output: [Schemas.OutputItem]
    
    /// Whether to allow the model to run tool calls in parallel.
    public let parallelToolCalls: Bool
    
    /// The unique ID of the previous response to the model. Use this to create multi-turn conversations. Learn more about [conversation state](https://platform.openai.com/docs/guides/conversation-state).
    public let previousResponseId: String?
    
    /// **o-series models only**
    ///
    /// Configuration options for [reasoning models](https://platform.openai.com/docs/guides/reasoning).
    public let reasoning: Schemas.Reasoning?
    
    /// The status of the response generation. One of `completed`, `failed`, `in_progress`, or `incomplete`.
    public let status: String
    
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or `top_p` but not both.
    public let temperature: Double?
    
    /// Configuration options for a text response from the model. Can be plain text or structured JSON data. Learn more:
    /// - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
    /// - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
    public let text: ResponseProperties.TextPayload
    
    /// How the model should select which tool (or tools) to use when generating a response. See the `tools` parameter to see how to specify which tools the model can call.
    public let toolChoice: ResponseProperties.ToolChoicePayload
    
    /// An array of tools the model may call while generating a response. You can specify which tool to use by setting the `tool_choice` parameter.
    ///
    /// The two categories of tools you can provide the model are:
    /// - **Built-in tools:** Tools that are provided by OpenAI that extend the model's capabilities, like [web search](https://platform.openai.com/docs/guides/tools-web-search) or [file search](https://platform.openai.com/docs/guides/tools-file-search). Learn more about [built-in tools](https://platform.openai.com/docs/guides/tools).
    /// - **Function calls (custom tools):** Functions that are defined by you, enabling the model to call your own code. Learn more about [function calling](https://platform.openai.com/docs/guides/function-calling).
    public let tools: [Schemas.Tool]
    
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    ///
    /// We generally recommend altering this or `temperature` but not both.
    public let topP: Double?
    
    /// The truncation strategy to use for the model response.
    ///
    /// - `auto`: If the context of this response and previous ones exceeds the model's context window size, the model will truncate the response to fit the context window by dropping input items in the middle of the conversation.
    /// - `disabled (default)`: If a model response will exceed the context window size for a model, the request will fail with a 400 error.
    public let truncation: String?
    
    /// Represents token usage details including input tokens, output tokens, a breakdown of output tokens, and the total tokens used.
    public let usage: Schemas.ResponseUsage
    
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
    public let user: String

    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case error
        case id
        case incompleteDetails = "incomplete_details"
        case instructions
        case maxOutputTokens = "max_output_tokens"
        case metadata
        case model
        case object
        case output
        case parallelToolCalls = "parallel_tool_calls"
        case previousResponseId = "previous_response_id"
        case reasoning
        case status
        case temperature
        case text
        case toolChoice = "tool_choice"
        case tools
        case topP = "top_p"
        case truncation
        case usage
        case user
    }
}
