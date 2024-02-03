//
//  OpenAITestsCombine.swift
//
//
//  Created by Sergii Kryvoblotskyi on 04/04/2023.
//

#if canImport(Combine)

import XCTest
@testable import OpenAI

@available(iOS 13.0, *)
@available(watchOS 6.0, *)
@available(tvOS 13.0, *)
final class OpenAITestsCombine: XCTestCase {

    var openAI: OpenAIProtocol!
    var urlSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        self.urlSession = URLSessionMock()
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(configuration: configuration, session: self.urlSession)
    }

    func testChats() throws {
        let query = ChatCompletionCreateParams(messages: [
            .system(.init(content: "You are Librarian-GPT. You know everything about the books.")),
            .user(.init(content: .string("Who wrote Harry Potter?")))
       ], model: .gpt_3_5_turbo)
        let chatResult = ChatCompletion(id: "id-12312", choices: [
            .init(finish_reason: "baz", index: 0, logprobs: nil, message: .system(.init(content: "bar"))),
            .init(finish_reason: "baz1", index: 0, logprobs: nil, message: .user(.init(content: .string("bar1")))),
            .init(finish_reason: "baz2", index: 0, logprobs: nil, message: .assistant(.init(content: "bar2")))
        ], created: 100, model: ChatModel.gpt_3_5_turbo.rawValue, object: "foo", system_fingerprint: nil, usage: .init(completion_tokens: 200, prompt_tokens: 100, total_tokens: 300))
       try self.stub(result: chatResult)
       let result = try awaitPublisher(openAI.chats(query: query))
       XCTAssertEqual(result, chatResult)
    }

    func testEmbeddings() throws {
        let query = EmbeddingCreateParams(input: .string("The food was delicious and the waiter..."), model: .text_embedding_ada_002)
        let embeddingsResult = EmbeddingResponse(data: [
            .init(embedding: [0.1, 0.2, 0.3, 0.4], index: 0, object: "id-sdasd"),
            .init(embedding: [0.4, 0.1, 0.7, 0.1], index: 1, object: "id-sdasd1"),
            .init(embedding: [0.8, 0.1, 0.2, 0.8], index: 2, object: "id-sdasd2")
        ], model: EmbeddingsModel.text_embedding_ada_002.rawValue, object: "embeddings", usage: .init(prompt_tokens: 10, total_tokens: 10))
        try self.stub(result: embeddingsResult)

        let result = try awaitPublisher(openAI.embeddings(query: query))
        XCTAssertEqual(result, embeddingsResult)
    }

    func testRetrieveModel() throws {
        let query = ModelCreateParams(model: ChatModel.gpt_3_5_turbo_1106.rawValue)
        let modelResult = Model(id: ChatModel.gpt_3_5_turbo_1106.rawValue, created: 200000000, object: "model", owned_by: "organization-owner")
        try self.stub(result: modelResult)

        let result = try awaitPublisher(openAI.model(query: query))
        XCTAssertEqual(result, modelResult)
    }

    func testListModels() throws {
        let listModelsResult = ModelsResponse(data: [], object: "model")
        try self.stub(result: listModelsResult)

        let result = try awaitPublisher(openAI.models())
        XCTAssertEqual(result, listModelsResult)
    }

    func testModerations() throws {
        let query = ModerationCreateParams(input: .string("Hello, world!"))
        let moderationsResult = ModerationCreateResponse(id: "foo", model: ModerationsModel.textModerationLatest.rawValue, results: [
            .init(categories: .init(harassment: false, harassment_threatening: false, hate: false, hate_threatening: false, self_harm: false, self_harm_intent: false, self_harm_instructions: false, sexual: false, sexual_minors: false, violence: false, violence_graphic: false),
                  category_scores: .init(harassment: 0.1, harassment_threatening: 0.1, hate: 0.1, hate_threatening: 0.1, self_harm: 0.1, self_harm_intent: 0.1, self_harm_instructions: 0.1, sexual: 0.1, sexual_minors: 0.1, violence: 0.1,   violence_graphic: 0.1),
                  flagged: false)
        ])
        try self.stub(result: moderationsResult)

        let result = try awaitPublisher(openAI.moderations(query: query))
        XCTAssertEqual(result, moderationsResult)
    }

    func testAudioTranscriptions() throws {
        let data = Data()
        let query = TranscriptionCreateParams(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = Transcription(text: "Hello, world!")
        try self.stub(result: transcriptionResult)

        let result = try awaitPublisher(openAI.audioTranscriptions(query: query))
        XCTAssertEqual(result, transcriptionResult)
    }

    func testAudioTranslations() throws {
        let data = Data()
        let query = TranslationCreateParams(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = Translation(text: "Hello, world!")
        try self.stub(result: transcriptionResult)

        let result = try awaitPublisher(openAI.audioTranslations(query: query))
        XCTAssertEqual(result, transcriptionResult)
    }
}

@available(tvOS 13.0, *)
@available(iOS 13.0, *)
@available(watchOS 6.0, *)
extension OpenAITestsCombine {

    func stub(error: Error) {
        let error = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        let task = DataTaskMock.failed(with: error)
        self.urlSession.dataTask = task
    }

    func stub(result: Codable) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(result)
        let task = DataTaskMock.successful(with: data)
        self.urlSession.dataTask = task
    }
}

#endif
