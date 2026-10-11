import Combine
import Foundation
import Testing
import ExyteChat
@testable import DemoChat
@testable import OpenAI

@Test @MainActor
func replyFunctionCallSendsOnlyTheOutputItem() async throws {
    let endpoint = RecordingResponsesEndpoint()
    let store = ResponsesStore(client: endpoint)

    try await store.send(
        message: .init(
            text: "Weather in Kyiv?",
            medias: [],
            giphyMedia: nil,
            recording: nil,
            replyMessage: nil,
            createdAt: Date(timeIntervalSince1970: 0)
        ),
        model: .gpt4_1,
        stream: false,
        webSearchEnabled: false,
        functionCallingEnabled: true
    )
    try await store.replyFunctionCall(
        result: "66",
        model: .gpt4_1,
        stream: false,
        webSearchEnabled: false,
        functionCallingEnabled: true
    )

    let reply = try #require(endpoint.queries.last)
    #expect(reply.previousResponseId == "resp_weather")
    guard case .inputItemList(let items) = reply.input else {
        Issue.record("Expected an input item list")
        return
    }
    #expect(items.count == 1)
    guard case .item(.functionCallOutputItemParam(let output)) = items.first else {
        Issue.record("Expected a function call output item")
        return
    }
    #expect(output.callId == "call_weather")
    #expect(output.output == .case1("66"))
}

private final class RecordingResponsesEndpoint: ResponsesEndpointProtocol, @unchecked Sendable {
    private(set) var queries: [CreateModelResponseQuery] = []

    func createResponse(query: CreateModelResponseQuery) async throws -> ResponseObject {
        queries.append(query)
        return ResponseObject(
            background: nil, completedAt: nil, conversation: nil, createdAt: 0, error: nil,
            id: "resp_weather", incompleteDetails: nil, instructions: nil, maxOutputTokens: nil,
            maxToolCalls: nil, metadata: nil, model: "gpt-4.1", moderation: nil, object: "response",
            output: [
                .functionToolCall(.init(
                    id: "fc_weather",
                    _type: .functionCall,
                    callId: "call_weather",
                    name: "get_current_weather",
                    arguments: #"{"location":"Kyiv","unit":"celsius"}"#,
                    status: .completed
                ))
            ],
            outputText: nil, parallelToolCalls: false, previousResponseId: nil, prompt: nil,
            promptCacheDiagnostics: nil, promptCacheKey: nil, promptCacheOptions: nil,
            promptCacheRetention: nil, reasoning: nil, safetyIdentifier: nil, serviceTier: nil,
            status: .completed, temperature: nil, text: .init(format: nil),
            toolChoice: .ToolChoiceOptions(.auto), tools: [], topLogprobs: nil, topP: nil,
            truncation: nil, usage: nil, user: nil
        )
    }

    func createResponseStreaming(query: CreateModelResponseQuery) -> AsyncThrowingStream<ResponseStreamEvent, Error> { fatalError() }
    func retrieveResponse(query: RetrieveModelResponseQuery) async throws -> ResponseObject { fatalError() }
    func cancelResponse(id: String) async throws -> ResponseObject { fatalError() }
    func createResponse(query: CreateModelResponseQuery) -> AnyPublisher<ResponseObject, Error> { fatalError() }
    func createResponseStreaming(query: CreateModelResponseQuery) -> AnyPublisher<Result<ResponseStreamEvent, Error>, Error> { fatalError() }
    func retrieveResponse(query: RetrieveModelResponseQuery) -> AnyPublisher<ResponseObject, Error> { fatalError() }
    func cancelResponse(id: String) -> AnyPublisher<ResponseObject, Error> { fatalError() }
    func createResponse(query: CreateModelResponseQuery, completion: @escaping @Sendable (Result<ResponseObject, Error>) -> Void) -> CancellableRequest { fatalError() }
    func createResponseStreaming(query: CreateModelResponseQuery, onResult: @escaping @Sendable (Result<ResponseStreamEvent, Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest { fatalError() }
    func retrieveResponse(query: RetrieveModelResponseQuery, completion: @escaping @Sendable (Result<ResponseObject, Error>) -> Void) -> CancellableRequest { fatalError() }
    func cancelResponse(id: String, completion: @escaping @Sendable (Result<ResponseObject, Error>) -> Void) -> CancellableRequest { fatalError() }
}
