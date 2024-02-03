//
//  OpenAITests.swift
//
//
//  Created by Sergii Kryvoblotskyi on 18/01/2023.
//

import XCTest
@testable import OpenAI

@available(iOS 13.0, *)
@available(watchOS 6.0, *)
@available(tvOS 13.0, *)
class OpenAITests: XCTestCase {

    var openAI: OpenAIProtocol!
    var urlSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        self.urlSession = URLSessionMock()
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        self.openAI = OpenAI(configuration: configuration, session: self.urlSession)
    }

    func testImages() async throws {
        let query = ImageGenerateParams(prompt: "White cat with heterochromia sitting on the kitchen table", model: .dall_e_2, n: 1, size: ._1024)
        let imagesResult = ImagesResponse(created: 100, data: [
            .init(b64_json: nil, revised_prompt: nil, url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.images(query: query)
        XCTAssertEqual(result, imagesResult)
    }

    func testImagesError() async throws {
        let query = ImageGenerateParams(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: ._1024)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.images(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testImageEdit() async throws {
        let query = ImageEditParams(image: Data(), prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", mask: Data(), n: 1, size: ._1024)
        let imagesResult = ImagesResponse(created: 100, data: [
            .init(b64_json: nil, revised_prompt: nil, url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.imageEdits(query: query)
        XCTAssertEqual(result, imagesResult)
    }

    func testImageEditError() async throws {
        let query = ImageEditParams(image: Data(), prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", mask: Data(), n: 1, size: ._1024)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.imageEdits(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testImageVariation() async throws {
        let query = ImageCreateVariationParams(image: Data(), n: 1, size: "1024x1024")
        let imagesResult = ImagesResponse(created: 100, data: [
            .init(b64_json: nil, revised_prompt: nil, url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.imageVariations(query: query)
        XCTAssertEqual(result, imagesResult)
    }

    func testImageVariationError() async throws {
        let query = ImageCreateVariationParams(image: Data(), n: 1, size: "1024x1024")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.imageVariations(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testChats() async throws {
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

       let result = try await openAI.chats(query: query)
       XCTAssertEqual(result, chatResult)
    }

    func testChatsFunction() async throws {
        let query = ChatCompletionCreateParams(messages: [
            .system(.init(content: "You are Weather-GPT. You know everything about the weather.")),
            .user(.init(content: .string("What's the weather like in Boston?"))),
        ], model: .gpt_3_5_turbo, tool_choice: .auto, tools: [
            .init(function: .init(name: "get_current_weather", description: "Get the current weather in a given location", parameters: .init(type: .object, properties: [
                "location": .init(type: .string, description: "The city and state, e.g. San Francisco, CA"),
                "unit": .init(type: .string, enum: ["celsius", "fahrenheit"])
            ], required: ["location"])))
        ])

        let chatResult = ChatCompletion(id: "id-12312", choices: [
         .init(finish_reason: "baz", index: 0, logprobs: nil, message: .system(.init(content: "bar"))),
         .init(finish_reason: "baz1", index: 0, logprobs: nil, message: .user(.init(content: .string("bar1")))),
         .init(finish_reason: "baz2", index: 0, logprobs: nil, message: .assistant(.init(content: "bar2")))
         ], created: 100, model: ChatModel.gpt_3_5_turbo.rawValue, object: "foo", system_fingerprint: nil, usage: .init(completion_tokens: 200, prompt_tokens: 100, total_tokens: 300))
        try self.stub(result: chatResult)
        let result = try await openAI.chats(query: query)
        XCTAssertEqual(result, chatResult)
    }

    func testChatsError() async throws {
        let query = ChatCompletionCreateParams(messages: [
            .system(.init(content: "You are Librarian-GPT. You know everything about the books.")),
            .user(.init(content: .string("Who wrote Harry Potter?")))
        ], model: .gpt_3_5_turbo)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.chats(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testEmbeddings() async throws {
        let query = EmbeddingCreateParams(
            input: .string("The food was delicious and the waiter..."),
            model: .text_embedding_ada_002)
        let embeddingsResult = EmbeddingResponse(
            data: [
                .init(embedding: [0.1, 0.2, 0.3, 0.4], index: 0, object: "id-sdasd"),
                .init(embedding: [0.4, 0.1, 0.7, 0.1], index: 1, object: "id-sdasd1"),
                .init(embedding: [0.8, 0.1, 0.2, 0.8], index: 2, object: "id-sdasd2")
            ],
            model: EmbeddingsModel.text_embedding_ada_002.rawValue,
            object: "embeddings",
            usage: .init(prompt_tokens: 10, total_tokens: 10))
        try self.stub(result: embeddingsResult)

        let result = try await openAI.embeddings(query: query)
        XCTAssertEqual(result, embeddingsResult)
    }

    func testEmbeddingsError() async throws {
        let query = EmbeddingCreateParams(input: .string("The food was delicious and the waiter..."), model: .text_embedding_ada_002)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.embeddings(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testQueryString() throws {
        let pathParameter = APIPath.chats
        let result = APIPath.models.withPath(pathParameter)
        XCTAssertEqual(result, APIPath.models + "/" + pathParameter)
    }

    func testRetrieveModel() async throws {
        let query = ModelCreateParams(model: ChatModel.gpt_3_5_turbo.rawValue)
        let modelResult = Model(id: ChatModel.gpt_3_5_turbo.rawValue, created: 999, object: "model", owned_by: "openai")
        try self.stub(result: modelResult)

        let result = try await openAI.model(query: query)
        XCTAssertEqual(result, modelResult)
    }

    func testRetrieveModelError() async throws {
        let query = ModelCreateParams(model: ChatModel.gpt_3_5_turbo.rawValue)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.model(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testListModels() async throws {
        let listModelsResult = ModelsResponse(data: [
            .init(id: "model-id-0", created: 7777, object: "model", owned_by: "organization-owner"),
            .init(id: "model-id-1", created: 7777, object: "model", owned_by: "organization-owner"),
            .init(id: "model-id-2", created: 7777, object: "model", owned_by: "openai")
        ], object: "list")
        try self.stub(result: listModelsResult)

        let result = try await openAI.models()
        XCTAssertEqual(result, listModelsResult)
    }

    func testListModelsError() async throws {
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        let apiError: APIError = try await XCTExpectError { try await openAI.models() }
        XCTAssertEqual(inError, apiError)
    }

    func testModerations() async throws {
        let query = ModerationCreateParams(input: .string("Hello, world!"))
        let moderationsResult = ModerationCreateResponse(id: "foo", model: ModerationsModel.textModerationLatest.rawValue, results: [
            .init(
                categories: .init(harassment: false, harassment_threatening: false, hate: false, hate_threatening: false, self_harm: false, self_harm_intent: false, self_harm_instructions: false, sexual: false, sexual_minors: false, violence: false, violence_graphic: false),
                category_scores: .init(harassment: 0.1, harassment_threatening: 0.1, hate: 0.1, hate_threatening: 0.1, self_harm: 0.1, self_harm_intent: 0.1, self_harm_instructions: 0.1, sexual: 0.1, sexual_minors: 0.1, violence: 0.1, violence_graphic: 0.1),
                flagged: false)
        ])
        try self.stub(result: moderationsResult)

        let result = try await openAI.moderations(query: query)
        XCTAssertEqual(result, moderationsResult)
    }

    func testModerationsError() async throws {
        let query = ModerationCreateParams(input: .string("Hello, world!"))
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.moderations(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testAudioSpeechError() async throws {
        let query = SpeechCreateParams(input: "Hello, world!", model: .tts_1, voice: .alloy, response_format: .mp3, speed: 1.0)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.audioCreateSpeech(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testAudioTranscriptions() async throws {
        let data = Data()
        let query = TranscriptionCreateParams(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = Transcription(text: "Hello, world!")
        try self.stub(result: transcriptionResult)

        let result = try await openAI.audioTranscriptions(query: query)
        XCTAssertEqual(result, transcriptionResult)
    }

    func testAudioTranscriptionsError() async throws {
        let data = Data()
        let query = TranscriptionCreateParams(file: data, fileType: .m4a, model: .whisper_1)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.audioTranscriptions(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testAudioTranslations() async throws {
        let data = Data()
        let query = TranslationCreateParams(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = Translation(text: "Hello, world!")
        try self.stub(result: transcriptionResult)

        let result = try await openAI.audioTranslations(query: query)
        XCTAssertEqual(result, transcriptionResult)
    }

    func testAudioTranslationsError() async throws {
        let data = Data()
        let query = TranslationCreateParams(file: data, fileType: .m4a, model: .whisper_1)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.audioTranslations(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testSimilarity_Similar() {
        let vector1 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
        let vector2 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
        let similarity = Vector.cosineSimilarity(a: vector1, b: vector2)
        XCTAssertEqual(similarity, 1.0, accuracy: 0.000001)
    }

    func testSimilarity_NotSimilar() {
        let vector1 = [0.213123, 0.3214124, 0.421412, 0.3214521251, 0.412412, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.4214214, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
        let vector2 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.511515, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3213213]
        let similarity = Vector.cosineSimilarity(a: vector1, b: vector2)
        XCTAssertEqual(similarity, 0.9510201910206734, accuracy: 0.000001)
    }

    func testJSONRequestCreation() throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let completionQuery = ChatCompletionCreateParams(messages: [.user(.init(content: .string("how are you?")))], model: .gpt_3_5_turbo_1106)
        let jsonRequest = JSONRequest<ChatCompletion>(body: completionQuery, url: URL(string: "http://google.com")!)
        let urlRequest = try jsonRequest.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)

        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(configuration.token)")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "OpenAI-Organization"), configuration.organizationIdentifier)
        XCTAssertEqual(urlRequest.timeoutInterval, configuration.timeoutInterval)
    }

    func testMultipartRequestCreation() throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let completionQuery = TranslationCreateParams(file: Data(), fileType: .mp3, model: .whisper_1)
        let jsonRequest = MultipartFormDataRequest<ChatCompletion>(body: completionQuery, url: URL(string: "http://google.com")!)
        let urlRequest = try jsonRequest.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)

        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(configuration.token)")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "OpenAI-Organization"), configuration.organizationIdentifier)
        XCTAssertEqual(urlRequest.timeoutInterval, configuration.timeoutInterval)
    }

    func testDefaultHostURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let chatsURL = openAI.buildURL(path: .chats)
        XCTAssertEqual(chatsURL, URL(string: "https://api.openai.com/v1/chat/completions"))
    }

    func testCustomURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", host: "my.host.com", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let chatsURL = openAI.buildURL(path: .chats)
        XCTAssertEqual(chatsURL, URL(string: "https://my.host.com/v1/chat/completions"))
    }
}

@available(tvOS 13.0, *)
@available(iOS 13.0, *)
@available(watchOS 6.0, *)
extension OpenAITests {

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

@available(tvOS 13.0, *)
@available(iOS 13.0, *)
@available(watchOS 6.0, *)
extension OpenAITests {

    enum TypeError: Error {
        case unexpectedResult(String)
        case typeMismatch(String)
    }

    func XCTExpectError<ErrorType: Error>(execute: () async throws -> Any) async throws -> ErrorType {
        do {
            let result = try await execute()
            throw TypeError.unexpectedResult("Error expected, but result is returned \(result)")
        } catch {
            guard let apiError = error as? ErrorType else {
                throw TypeError.typeMismatch("Expected APIError, got instead: \(error)")
            }
            return apiError
        }
    }
}
