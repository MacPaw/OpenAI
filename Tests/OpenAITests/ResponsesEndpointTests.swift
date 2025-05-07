//
//  ResponsesEndpointTests.swift
//  OpenAI
//
//  Tests for ResponsesEndpoint.createResponse (async)
//

import XCTest
@testable import OpenAI

class ResponsesEndpointTests: XCTestCase {
    private var openAI: OpenAIProtocol!
    private let urlSession = URLSessionMock()

    override func setUp() async throws {
        let configuration = OpenAI.Configuration(token: "test-token", organizationIdentifier: nil, timeoutInterval: 10)
        openAI = OpenAI(
            configuration: configuration,
            session: urlSession,
            streamingSessionFactory: MockStreamingSessionFactory()
        )
    }

    /// Replace the next dataTask on urlSession with a successful stub containing the encoded `result`.
    private func stub<ResultType: Codable & Equatable>(_ result: ResultType) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(result)
        let task = DataTaskMock.successful(with: data)
        urlSession.dataTask = task
    }
    
    func testCreateResponse() async throws {
        // Build the query
        let query = CreateModelResponseQuery(
            input: .textInput("Hello"),
            model: "test-model"
        )

        // Dummy response object
        let dummy = ResponseObject(
            createdAt: 123,
            error: nil,
            id: "resp-1",
            incompleteDetails: nil,
            instructions: nil,
            maxOutputTokens: nil,
            metadata: [:],
            model: "test-model",
            object: "response",
            output: [],
            parallelToolCalls: false,
            previousResponseId: nil,
            reasoning: nil,
            status: "completed",
            temperature: nil,
            text: .init(format: nil),
            toolChoice: .ToolChoiceOptions(.auto),
            tools: [],
            topP: nil,
            truncation: nil,
            usage: nil,
            user: nil
        )
        try stub(dummy)

        let result = try await openAI.responses.createResponse(query: query)
        XCTAssertEqual(dummy, result)
    }

    func testCreateResponseWithFunctionTool() async throws {
        // Build a simple JSON schema: { "type":"object", "properties":{ "foo":{ "type":"string" } }, "required":["foo"] }
        let propSchema = AnyJSONSchema(fields: [
            JSONSchemaField.type(.string)
        ])
        let schema = AnyJSONSchema(fields: [
            JSONSchemaField.type(.object),
            JSONSchemaField.properties(["foo": propSchema]),
            JSONSchemaField.required(["foo"])
        ])
        // Create the function tool wrapper
        let functionTool = FunctionTool(
            type: "function",
            name: "my_function",
            description: "A test function",
            parameters: schema,
            strict: true
        )
        let tool = Tool.functionTool(functionTool)

        // Build the query
        let query = CreateModelResponseQuery(
            input: .textInput("Hello"),
            model: "test-model",
            tools: [tool]
        )

        // Dummy response object
        let dummy = ResponseObject(
            createdAt: 123,
            error: nil,
            id: "resp-1",
            incompleteDetails: nil,
            instructions: nil,
            maxOutputTokens: nil,
            metadata: [:],
            model: "test-model",
            object: "response",
            output: [],
            parallelToolCalls: false,
            previousResponseId: nil,
            reasoning: nil,
            status: "completed",
            temperature: nil,
            text: .init(format: nil),
            toolChoice: .ToolChoiceOptions(.auto),
            tools: [tool],
            topP: nil,
            truncation: nil,
            usage: nil,
            user: nil
        )
        try stub(dummy)

        let result = try await openAI.responses.createResponse(query: query)
        switch result.tools[0] {
        case .functionTool(let responseTool):
            guard let jsonSchemaObject = responseTool.parameters.value as? JSONSchemaObject else {
                XCTFail("Expected function.parameters to be object")
                return
            }
            
            let type = (jsonSchemaObject["type"]?.value as? String)
            XCTAssertEqual(type, "object")
            
            let properties = try XCTUnwrap(jsonSchemaObject["properties"]?.value as? JSONObject)
            let fooProperty = try XCTUnwrap(properties["foo"]?.value as? JSONObject)
            XCTAssertEqual(fooProperty["type"]?.value as? String, "string")
            
            let required = try XCTUnwrap(jsonSchemaObject["required"]?.value as? [AnyJSONDocument])
            XCTAssertEqual(required.compactMap({ $0.value as? String }), ["foo"])
        default:
            XCTFail("Expected tool in response to be a function")
        }
    }
}
