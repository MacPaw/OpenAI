//
//  FunctionTool.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.04.2025.
//

/// Defines a function in your own code the model can choose to call. Learn more
/// about [function calling](/docs/guides/function-calling).
public struct FunctionTool: Codable, Hashable, Sendable {
    /// The type of the function tool. Always `function`.
    public let type: String
    /// The name of the function to call.
    public let name: String
    /// A description of the function. Used by the model to determine whether
    /// or not to call the function.
    public let description: String?
    /// A JSON schema object describing the parameters of the function.
    public let parameters: AnyJSONSchema
    /// Whether to enforce strict parameter validation. Default `true`.
    ///
    /// From [Function Calling Guide](https://platform.openai.com/docs/guides/function-calling#strict-mode):
    ///
    /// Under the hood, strict mode works by leveraging our structured outputs feature and therefore introduces a couple requirements:
    /// - `additionalProperties` must be set to `false` for each object in the `parameters`.
    /// - All fields in `properties` must be marked as `required`.
    ///
    /// You can denote optional fields by adding `null` as a `type`
    public let strict: Bool
    /// Creates a new `FunctionTool`.
    ///
    /// - Parameters:
    ///   - type: The type of the function tool. Always `function`.
    ///   - name: The name of the function to call.
    ///   - description: A description of the function. Used by the model to determine whether
    ///   - parameters: A JSON schema object describing the parameters of the function.
    ///   - strict: Whether to enforce strict parameter validation. Default `true`.
    public init(
        type: String = "function",
        name: String,
        description: String? = nil,
        parameters: AnyJSONSchema,
        strict: Bool
    ) {
        self.type = type
        self.name = name
        self.description = description
        self.parameters = parameters
        self.strict = strict
    }
    
    public enum CodingKeys: String, CodingKey {
        case type
        case name
        case description
        case parameters
        case strict
    }
}
