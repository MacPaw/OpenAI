//
//  OpenAITestsCombine.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 04/04/2023.
//

#if canImport(Combine)

import XCTest
@testable import OpenAI
import Combine

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
@MainActor final class OpenAITestsCombine: XCTestCase {
    
    private var openAI: OpenAIProtocol!
    private let urlSession: URLSessionMockCombine = URLSessionMockCombine()
    private let streamingSessionFactory = MockStreamingSessionFactory()
    private let cancellablesFactory = MockCancellablesFactory()
    
    override func setUp() async throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(
            configuration: configuration,
            session: self.urlSession,
            streamingSessionFactory: streamingSessionFactory,
            cancellablesFactory: cancellablesFactory
        )
    }
    
    func testChats() throws {
        let query = makeChatsQuery()
        let chatResult = makeChatsResult()
       try self.stub(result: chatResult)
       let result = try awaitPublisher(openAI.chats(query: query))
       XCTAssertEqual(result, chatResult)
    }
    
    func testEmbeddings() throws {
        let query = EmbeddingsQuery(input: .string("The food was delicious and the waiter..."), model: .textEmbeddingAda)
        let embeddingsResult = EmbeddingsResult(data: [
            .init(object: "id-sdasd", embedding: [0.1, 0.2, 0.3, 0.4], index: 0),
            .init(object: "id-sdasd1", embedding: [0.4, 0.1, 0.7, 0.1], index: 1),
            .init(object: "id-sdasd2", embedding: [0.8, 0.1, 0.2, 0.8], index: 2)
        ], model: .textSearchBabbageDoc, usage: .init(promptTokens: 10, totalTokens: 10), object: "list")
        try self.stub(result: embeddingsResult)
        
        let result = try awaitPublisher(openAI.embeddings(query: query))
        XCTAssertEqual(result, embeddingsResult)
    }
    
    func testRetrieveModel() throws {
        let query = ModelQuery(model: .gpt3_5Turbo_0125)
        let modelResult = ModelResult(id: .gpt3_5Turbo_0125, created: 200000000, object: "model", ownedBy: "organization-owner")
        try self.stub(result: modelResult)
        
        let result = try awaitPublisher(openAI.model(query: query))
        XCTAssertEqual(result, modelResult)
    }
    
    func testListModels() throws {
        let listModelsResult = ModelsResult(data: [], object: "model")
        try self.stub(result: listModelsResult)
        
        let result = try awaitPublisher(openAI.models())
        XCTAssertEqual(result, listModelsResult)
    }
    
    func testModerations() throws {
        let query = ModerationsQuery(input: "Hello, world!")
        let moderationsResult = ModerationsResult(id: "foo", model: .moderation, results: [
            .init(categories: .init(harassment: false, harassmentThreatening: false, hate: false, hateThreatening: false, selfHarm: false, selfHarmIntent: false, selfHarmInstructions: false, sexual: false, sexualMinors: false, violence: false, violenceGraphic: false),
                  categoryScores: .init(harassment: 0.1, harassmentThreatening: 0.1, hate: 0.1, hateThreatening: 0.1, selfHarm: 0.1, selfHarmIntent: 0.1, selfHarmInstructions: 0.1, sexual: 0.1, sexualMinors: 0.1, violence: 0.1, violenceGraphic: 0.1),
                  flagged: false)
        ])
        try self.stub(result: moderationsResult)
        
        let result = try awaitPublisher(openAI.moderations(query: query))
        XCTAssertEqual(result, moderationsResult)
    }
    
    func testAudioCreateSpeech() throws {
        let query = AudioSpeechQuery.mock
        let data = Data(repeating: 10, count: 10)
        urlSession.dataTask = .successful(with: data)
        let response = try awaitPublisher(openAI.audioCreateSpeech(query: query), timeout: 1)
        XCTAssertEqual(data, response.audio)
    }
    
    func testAudioTranscriptions() throws {
        let data = Data()
        let query = AudioTranscriptionQuery(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = AudioTranscriptionResult(text: "Hello, world!")
        try self.stub(result: transcriptionResult)
        
        let result = try awaitPublisher(openAI.audioTranscriptions(query: query))
        XCTAssertEqual(result, transcriptionResult)
    }
    
    func testAudioTranslations() throws {
        let data = Data()
        let query = AudioTranslationQuery(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = AudioTranslationResult(text: "Hello, world!")
        try self.stub(result: transcriptionResult)
        
        let result = try awaitPublisher(openAI.audioTranslations(query: query))
        XCTAssertEqual(result, transcriptionResult)
    }
    
    func testAssistantsQuery() throws {
        let expectedAssistant = AssistantResult.makeMock()
        let expectedResult = AssistantsResult(data: [expectedAssistant], firstId: expectedAssistant.id, lastId: expectedAssistant.id, hasMore: false)
        try self.stub(result: expectedResult)
        
        let result = try awaitPublisher(openAI.assistants())
        XCTAssertEqual(result, expectedResult)
    }

    func testAssistantCreateQuery() throws {
        let query = AssistantsQuery.makeMock()
        let expectedResult = AssistantResult.makeMock()
        try self.stub(result: expectedResult)

        let result = try awaitPublisher(openAI.assistantCreate(query: query))
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAssistantModifyQuery() throws {
        let query = AssistantsQuery.makeMock()
        let expectedResult = AssistantResult.makeMock()
        try self.stub(result: expectedResult)
        
        let result = try awaitPublisher(openAI.assistantModify(query: query, assistantId: "asst_9876"))
        XCTAssertEqual(result, expectedResult)
    }

    func testThreadsQuery() throws {
        let query = ThreadsQuery(messages: [ ChatQuery.ChatCompletionMessageParam(role: .user, content: "Hello, What is AI?")!])
        let expectedResult = ThreadsResult(id: "thread_1234")

        try self.stub(result: expectedResult)
        let result = try awaitPublisher(openAI.threads(query: query))

        XCTAssertEqual(result, expectedResult)
    }
    
    func testThreadRunQuery() throws {
        let query = ThreadRunQuery(assistantId: "asst_7654321", thread: .init(messages: [.init(role: .user, content: "Hello, What is AI?")!]))
        let expectedResult = RunResult(id: "run_1234", threadId: "thread_1234", status: .completed, requiredAction: nil)
        try self.stub(result: expectedResult)
        
        let result = try awaitPublisher(openAI.threadRun(query: query))
        XCTAssertEqual(result, expectedResult)
    }

    func testRunsQuery() throws {
        let query = RunsQuery(assistantId: "asst_7654321")
        let expectedResult = RunResult(id: "run_1234", threadId: "thread_1234", status: .inProgress, requiredAction: nil)

        try self.stub(result: expectedResult)
        let result = try awaitPublisher(openAI.runs(threadId: "thread_1234", query: query))
        
        XCTAssertEqual(result, expectedResult)
    }

    func testRunRetrieveQuery() throws {
        let expectedResult = RunResult(id: "run_1234", threadId: "thread_1234", status: .inProgress, requiredAction: nil)
        try self.stub(result: expectedResult)

        let result = try awaitPublisher(openAI.runRetrieve(threadId: "thread_1234", runId: "run_1234"))

        XCTAssertEqual(result, expectedResult)
    }
    
    func testRunRetrieveStepsQuery() throws {
        let expectedResult = RunRetrieveStepsResult(data: [.init(id: "step_1234", stepDetails: .init(toolCalls: [.init(id: "tool_456", type: .fileSearch, codeInterpreter: nil, function: nil)]))])
        try self.stub(result: expectedResult)
        
        let result = try awaitPublisher(openAI.runRetrieveSteps(threadId: "thread_1234", runId: "run_1234"))
        XCTAssertEqual(result, expectedResult)
    }

    func testRunSubmitToolOutputsQuery() throws {
        let query = RunToolOutputsQuery(toolOutputs: [.init(toolCallId: "call_123", output: "Success")])
        let expectedResult = RunResult(id: "run_123", threadId: "thread_456", status: .inProgress, requiredAction: nil)
        try self.stub(result: expectedResult)
        
        let result = try awaitPublisher(openAI.runSubmitToolOutputs(threadId: "thread_456", runId: "run_123", query: query))
        XCTAssertEqual(result, expectedResult)
    }
    
    func testThreadAddMessageQuery() throws {
        let query = MessageQuery(role: .user, content: "Hello, What is AI?", fileIds: ["file_123"])
        let expectedResult = ThreadAddMessageResult(id: "message_1234")
        try self.stub(result: expectedResult)
        
        let result = try awaitPublisher(openAI.threadsAddMessage(threadId: "thread_1234", query: query))
        XCTAssertEqual(result, expectedResult)
    }
    
    func testThreadsMessageQuery() throws {
        let expectedResult = ThreadsMessagesResult(data: [ThreadsMessagesResult.ThreadsMessage(id: "thread_1234", role: ChatQuery.ChatCompletionMessageParam.Role.user, content: [ThreadsMessagesResult.ThreadsMessage.ThreadsMessageContent(type: .text, text: ThreadsMessagesResult.ThreadsMessage.ThreadsMessageContent.ThreadsMessageContentText(value: "Hello, What is AI?"), imageFile: nil)])])
        try self.stub(result: expectedResult)

        let result = try awaitPublisher(openAI.threadsMessages(threadId: "thread_1234", before: nil))

        XCTAssertEqual(result, expectedResult)
    }

   func testFilesQuery() throws {
      let data = try XCTUnwrap("{\"test\":\"data\"}".data(using: .utf8))
      let query = FilesQuery(purpose: "assistant", file: data, fileName: "test.json", contentType: "application/json")
      let expectedResult = FilesResult(id: "file_1234", name: "test.json")
      try self.stub(result: expectedResult)

      let result = try awaitPublisher(openAI.files(query: query))
      XCTAssertEqual(result, expectedResult)
   }
    
    func testCancelRequest() {
        let query = makeChatsQuery()
        
        let publisher = MockDataTaskPublisher()
        urlSession.dataTaskPublisher = publisher.eraseToAnyPublisher()
        let subscription: AnyCancellable = openAI.chats(query: query).sink(receiveCompletion: { _ in }, receiveValue: { _ in })
        subscription.cancel()
        XCTAssertEqual(publisher.subscription?.cancelCallCount, 1)
    }
    
    func testCancelStreamingRequest() throws {
        let query = makeChatsQuery()
        let sessionCanceller = MockSessionCanceller()
        cancellablesFactory.sessionCanceller = sessionCanceller
        try stub(result: makeChatsResult())
        let subscription = openAI.chatsStream(query: query).sink { _ in } receiveValue: { _ in }
        subscription.cancel()
        XCTAssertEqual(sessionCanceller.cancelCallCount, 1)
    }
    
    private func makeChatsQuery() -> ChatQuery {
        .init(messages: [
            .system(.init(content: "You are Librarian-GPT. You know everything about the books.")),
            .user(.init(content: .string("Who wrote Harry Potter?")))
       ], model: .gpt3_5Turbo)
    }
    
    private func makeChatsResult() -> ChatResult {
        .mock
    }
}

@available(tvOS 13.0, *)
@available(iOS 13.0, *)
@available(watchOS 6.0, *)
extension OpenAITestsCombine {
    
    func stub(error: URLError) {
        let task = DataTaskMock.failed(with: error)
        self.urlSession.dataTask = task
        self.streamingSessionFactory.urlSessionFactory.urlSession.dataTask = task
    }
    
    func stub(result: Codable) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(result)
        let task = DataTaskMock.successful(with: data)
        self.urlSession.dataTask = task
        self.streamingSessionFactory.urlSessionFactory.urlSession.dataTask = task
    }
}

#endif
