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
    
    func testCompletions() async throws {
        let query = CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
        let expectedResult = CompletionsResult(id: "foo", object: "bar", created: 100500, model: .babbage, choices: [
            .init(text: "42 is the answer to everything", index: 0, finishReason: nil)
        ], usage: .init(promptTokens: 10, completionTokens: 10, totalTokens: 20))
        try self.stub(result: expectedResult)
        
        let result = try await openAI.completions(query: query)
        XCTAssertEqual(result, expectedResult)
    }

    func testCompletionsAPIError() async throws {
        let query = CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.completions(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testImages() async throws {
        let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", model: .dall_e_2, n: 1, size: ._1024)
        let imagesResult = ImagesResult(created: 100, data: [
            .init(b64Json: nil, revisedPrompt: nil, url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.images(query: query)
        XCTAssertEqual(result, imagesResult)
    }
    
    func testImagesError() async throws {
        let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: ._1024)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.images(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testImageEdit() async throws {
        let query = ImageEditsQuery(image: Data(), prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", mask: Data(), n: 1, size: ._1024)
        let imagesResult = ImagesResult(created: 100, data: [
            .init(b64Json: nil, revisedPrompt: nil, url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.imageEdits(query: query)
        XCTAssertEqual(result, imagesResult)
    }
    
    func testImageEditError() async throws {
        let query = ImageEditsQuery(image: Data(), prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", mask: Data(), n: 1, size: ._1024)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.imageEdits(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testImageVariation() async throws {
        let query = ImageVariationsQuery(image: Data(), n: 1, size: "1024x1024")
        let imagesResult = ImagesResult(created: 100, data: [
            .init(b64Json: nil, revisedPrompt: nil, url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.imageVariations(query: query)
        XCTAssertEqual(result, imagesResult)
    }
    
    func testImageVariationError() async throws {
        let query = ImageVariationsQuery(image: Data(), n: 1, size: "1024x1024")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.imageVariations(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testChats() async throws {
       let query = ChatQuery(messages: [
           .system(.init(content: "You are Librarian-GPT. You know everything about the books.")),
           .user(.init(content: .string("Who wrote Harry Potter?")))
       ], model: .gpt3_5Turbo)
        let chatResult = ChatResult(id: "id-12312", object: "foo", created: 100, model: .gpt3_5Turbo, choices: [
            .init(index: 0, logprobs: nil, message: .system(.init(content: "bar")), finishReason: "baz"),
            .init(index: 0, logprobs: nil, message: .user(.init(content: .string("bar1"))), finishReason: "baz1"),
            .init(index: 0, logprobs: nil, message: .assistant(.init(content: "bar2")), finishReason: "baz2")
        ], usage: .init(completionTokens: 200, promptTokens: 100, totalTokens: 300), systemFingerprint: nil)
       try self.stub(result: chatResult)
        
       let result = try await openAI.chats(query: query)
       XCTAssertEqual(result, chatResult)
    }

    func testChatsFunction() async throws {
        let query = ChatQuery(messages: [
            .system(.init(content: "You are Weather-GPT. You know everything about the weather.")),
            .user(.init(content: .string("What's the weather like in Boston?"))),
        ], model: .gpt3_5Turbo, toolChoice: .auto, tools: [
            .init(function: .init(name: "get_current_weather", description: "Get the current weather in a given location", parameters: .init(type: .object, properties: [
                "location": .init(type: .string, description: "The city and state, e.g. San Francisco, CA"),
                "unit": .init(type: .string, enum: ["celsius", "fahrenheit"])
            ], required: ["location"])))
        ])

        let chatResult = ChatResult(id: "id-12312", object: "foo", created: 100, model: .gpt3_5Turbo, choices: [
         .init(index: 0, logprobs: nil, message: .system(.init(content: "bar")), finishReason: "baz"),
         .init(index: 0, logprobs: nil, message: .user(.init(content: .string("bar1"))), finishReason: "baz1"),
         .init(index: 0, logprobs: nil, message: .assistant(.init(content: "bar2")), finishReason: "baz2")
         ], usage: .init(completionTokens: 200, promptTokens: 100, totalTokens: 300), systemFingerprint: nil)
        try self.stub(result: chatResult)
        
        let result = try await openAI.chats(query: query)
        XCTAssertEqual(result, chatResult)
    }
    
    func testChatsError() async throws {
        let query = ChatQuery(messages: [
            .system(.init(content: "You are Librarian-GPT. You know everything about the books.")),
            .user(.init(content: .string("Who wrote Harry Potter?")))
        ], model: .gpt3_5Turbo)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.chats(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testEdits() async throws {
        let query = EditsQuery(model: .gpt4, input: "What day of the wek is it?", instruction: "Fix the spelling mistakes")
        let editsResult = EditsResult(object: "edit", created: 1589478378, choices: [
            .init(text: "What day of the week is it?", index: 0)
        ], usage: .init(promptTokens: 25, completionTokens: 32, totalTokens: 57))
        try self.stub(result: editsResult)
        
        let result = try await openAI.edits(query: query)
        XCTAssertEqual(result, editsResult)
    }
    
    func testEditsError() async throws {
        let query = EditsQuery(model: .gpt4, input: "What day of the wek is it?", instruction: "Fix the spelling mistakes")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.edits(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testEmbeddings() async throws {
        let query = EmbeddingsQuery(
            input: .string("The food was delicious and the waiter..."),
            model: .textEmbeddingAda)
        let embeddingsResult = EmbeddingsResult(
            data: [
                .init(object: "id-sdasd", embedding: [0.1, 0.2, 0.3, 0.4], index: 0),
                .init(object: "id-sdasd1", embedding: [0.4, 0.1, 0.7, 0.1], index: 1),
                .init(object: "id-sdasd2", embedding: [0.8, 0.1, 0.2, 0.8], index: 2)
            ],
            model: .textEmbeddingAda,
            usage: .init(promptTokens: 10, totalTokens: 10),
            object: "embeddings")
        try self.stub(result: embeddingsResult)
        
        let result = try await openAI.embeddings(query: query)
        XCTAssertEqual(result, embeddingsResult)
    }
    
    func testEmbeddingsError() async throws {
        let query = EmbeddingsQuery(input: .string("The food was delicious and the waiter..."), model: .textEmbeddingAda)
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
        let query = ModelQuery(model: .gpt3_5Turbo)
        let modelResult = ModelResult(id: .gpt3_5Turbo, created: 999, object: "model", ownedBy: "openai")
        try self.stub(result: modelResult)
        
        let result = try await openAI.model(query: query)
        XCTAssertEqual(result, modelResult)
    }
    
    func testRetrieveModelError() async throws {
        let query = ModelQuery(model: .gpt3_5Turbo)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.model(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testListModels() async throws {
        let listModelsResult = ModelsResult(data: [
            .init(id: "model-id-0", created: 7777, object: "model", ownedBy: "organization-owner"),
            .init(id: "model-id-1", created: 7777, object: "model", ownedBy: "organization-owner"),
            .init(id: "model-id-2", created: 7777, object: "model", ownedBy: "openai")
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
        let query = ModerationsQuery(input: "Hello, world!")
        let moderationsResult = ModerationsResult(id: "foo", model: .moderation, results: [
            .init(categories: .init(harassment: false, harassmentThreatening: false, hate: false, hateThreatening: false, selfHarm: false, selfHarmIntent: false, selfHarmInstructions: false, sexual: false, sexualMinors: false, violence: false, violenceGraphic: false),
                  categoryScores: .init(harassment: 0.1, harassmentThreatening: 0.1, hate: 0.1, hateThreatening: 0.1, selfHarm: 0.1, selfHarmIntent: 0.1, selfHarmInstructions: 0.1, sexual: 0.1, sexualMinors: 0.1, violence: 0.1, violenceGraphic: 0.1),
                  flagged: false)
        ])
        try self.stub(result: moderationsResult)
        
        let result = try await openAI.moderations(query: query)
        XCTAssertEqual(result, moderationsResult)
    }

    @available(iOS 16.0, *)
    func testModerationsIterable() {
        let categories = ModerationsResult.Moderation.Categories(harassment: false, harassmentThreatening: false, hate: false, hateThreatening: false, selfHarm: false, selfHarmIntent: false, selfHarmInstructions: false, sexual: false, sexualMinors: false, violence: false, violenceGraphic: false)
        Mirror(reflecting: categories).children.enumerated().forEach { index, element in
            let label = ModerationsResult.Moderation.Categories.CodingKeys.allCases[index].stringValue.replacing(try! Regex("[/-]"), with: { _ in "" })
            XCTAssertEqual(label, element.label!.lowercased())
        }

        let categoryScores = ModerationsResult.Moderation.CategoryScores(harassment: 0.1, harassmentThreatening: 0.1, hate: 0.1, hateThreatening: 0.1, selfHarm: 0.1, selfHarmIntent: 0.1, selfHarmInstructions: 0.1, sexual: 0.1, sexualMinors: 0.1, violence: 0.1, violenceGraphic: 0.1)
        Mirror(reflecting: categoryScores).children.enumerated().forEach { index, element in
            let label = ModerationsResult.Moderation.CategoryScores.CodingKeys.allCases[index].stringValue.replacing(try! Regex("[/-]"), with: { _ in "" })
            XCTAssertEqual(label, element.label!.lowercased())
        }
    }

    func testModerationsError() async throws {
        let query = ModerationsQuery(input: "Hello, world!")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.moderations(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testAudioSpeechDoesNotNormalize() async throws {
        let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 2.0)

        XCTAssertEqual(query.speed, "\(2.0)")
    }

    func testAudioSpeechNormalizeNil() async throws {
        let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: nil)

        XCTAssertEqual(query.speed, "\(1.0)")
    }

    func testAudioSpeechNormalizeLow() async throws {
        let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 0.0)

        XCTAssertEqual(query.speed, "\(0.25)")
    }

    func testAudioSpeechNormalizeHigh() async throws {
        let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 10.0)

        XCTAssertEqual(query.speed, "\(4.0)")
    }

    func testAudioSpeechError() async throws {
        let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 1.0)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.audioCreateSpeech(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testAudioTranscriptions() async throws {
        let data = Data()
        let query = AudioTranscriptionQuery(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = AudioTranscriptionResult(text: "Hello, world!")
        try self.stub(result: transcriptionResult)
        
        let result = try await openAI.audioTranscriptions(query: query)
        XCTAssertEqual(result, transcriptionResult)
    }
    
    func testAudioTranscriptionsError() async throws {
        let data = Data()
        let query = AudioTranscriptionQuery(file: data, fileType: .m4a, model: .whisper_1)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.audioTranscriptions(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testAudioTranslations() async throws {
        let data = Data()
        let query = AudioTranslationQuery(file: data, fileType: .m4a, model: .whisper_1)
        let transcriptionResult = AudioTranslationResult(text: "Hello, world!")
        try self.stub(result: transcriptionResult)
        
        let result = try await openAI.audioTranslations(query: query)
        XCTAssertEqual(result, transcriptionResult)
    }
    
    func testAudioTranslationsError() async throws {
        let data = Data()
        let query = AudioTranslationQuery(file: data, fileType: .m4a, model: .whisper_1)
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
        let completionQuery = ChatQuery(messages: [.user(.init(content: .string("how are you?")))], model: .gpt3_5Turbo_16k)
        let jsonRequest = JSONRequest<ChatResult>(body: completionQuery, url: URL(string: "http://google.com")!)
        let urlRequest = try jsonRequest.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)
        
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(configuration.token)")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "OpenAI-Organization"), configuration.organizationIdentifier)
        XCTAssertEqual(urlRequest.timeoutInterval, configuration.timeoutInterval)
    }
    
    func testMultipartRequestCreation() throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let completionQuery = AudioTranslationQuery(file: Data(), fileType: .mp3, model: .whisper_1)
        let jsonRequest = MultipartFormDataRequest<ChatResult>(body: completionQuery, url: URL(string: "http://google.com")!)
        let urlRequest = try jsonRequest.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)
        
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(configuration.token)")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "OpenAI-Organization"), configuration.organizationIdentifier)
        XCTAssertEqual(urlRequest.timeoutInterval, configuration.timeoutInterval)
    }
    
    func testDefaultHostURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let chatsURL = openAI.buildURL(path: .chats)
        XCTAssertEqual(chatsURL, URL(string: "https://api.openai.com:443/v1/chat/completions"))
    }
    
    func testCustomURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", host: "my.host.com", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let chatsURL = openAI.buildURL(path: .chats)
        XCTAssertEqual(chatsURL, URL(string: "https://my.host.com:443/v1/chat/completions"))
    }

    // 1106
    func testAssistantCreateQuery() async throws {
        let query = AssistantsQuery(model: .gpt4_1106_preview, name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: [])
        let expectedResult = AssistantResult(id: "asst_9876", name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: nil, fileIds: nil)
        try self.stub(result: expectedResult)

        let result = try await openAI.assistantCreate(query: query)
        XCTAssertEqual(result, expectedResult)
    }

    func testAssistantCreateQueryError() async throws {
        let query = AssistantsQuery(model: .gpt4_1106_preview, name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: [])

        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.assistantCreate(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testListAssistantQuery() async throws {
        let expectedAssistant = AssistantResult(id: "asst_9876", name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: nil, fileIds: nil)
        let expectedResult = AssistantsResult(data: [expectedAssistant], firstId: expectedAssistant.id, lastId: expectedAssistant.id, hasMore: false)
        try self.stub(result: expectedResult)

        let result = try await openAI.assistants()
        XCTAssertEqual(result, expectedResult)
    }

    func testListAssistantQueryError() async throws {
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.assistants() }
        XCTAssertEqual(inError, apiError)
    }
    
    func testAssistantModifyQuery() async throws {
        let query = AssistantsQuery(model: .gpt4_1106_preview, name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: [])
        let expectedResult = AssistantResult(id: "asst_9876", name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: nil, fileIds: nil)
        try self.stub(result: expectedResult)
        
        let result = try await openAI.assistantModify(query: query, assistantId: "asst_9876")
        XCTAssertEqual(result, expectedResult)
    }
    
    func testAssistantModifyQueryError() async throws {
        let query = AssistantsQuery(model: .gpt4_1106_preview, name: "My New Assistant", description: "Assistant Description", instructions: "You are a helpful assistant.", tools: [])
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.assistantModify(query: query, assistantId: "asst_9876") }
        XCTAssertEqual(inError, apiError)
    }

    func testThreadsQuery() async throws {
        let query = ThreadsQuery(messages: [ChatQuery.ChatCompletionMessageParam(role: .user, content: "Hello, What is AI?")!])
        let expectedResult = ThreadsResult(id: "thread_1234")
        try self.stub(result: expectedResult)

        let result = try await openAI.threads(query: query)
        XCTAssertEqual(result, expectedResult)
    }

    func testThreadsQueryError() async throws {
        let query = ThreadsQuery(messages: [ChatQuery.ChatCompletionMessageParam(role: .user, content: "Hello, What is AI?")!])

        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.threads(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testThreadRunQuery() async throws {
        let query = ThreadRunQuery(assistantId: "asst_7654321", thread: .init(messages: [ChatQuery.ChatCompletionMessageParam(role: .user, content: "Hello, What is AI?")!]))
        let expectedResult = RunResult(id: "run_1234", threadId: "thread_1234", status: .completed, requiredAction: nil)
        try self.stub(result: expectedResult)
        
        let result = try await openAI.threadRun(query: query)
        XCTAssertEqual(result, expectedResult)
    }

    func testThreadRunQueryError() async throws {
        let query = ThreadRunQuery(assistantId: "asst_7654321", thread: .init(messages: [ChatQuery.ChatCompletionMessageParam(role: .user, content: "Hello, What is AI?")!]))
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.threadRun(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testRunsQuery() async throws {
        let query = RunsQuery(assistantId: "asst_7654321")
        let expectedResult = RunResult(id: "run_1234", threadId: "thread_1234", status: .completed, requiredAction: nil)
        try self.stub(result: expectedResult)

        let result = try await openAI.runs(threadId: "thread_1234", query: query)
        XCTAssertEqual(result, expectedResult)
    }

    func testRunsQueryError() async throws {
        let query = RunsQuery(assistantId: "asst_7654321")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.runs(threadId: "thread_1234", query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testRunRetrieveQuery() async throws {
        let expectedResult = RunResult(id: "run_1234", threadId: "thread_1234", status: .inProgress, requiredAction: nil)
        try self.stub(result: expectedResult)

        let result = try await openAI.runRetrieve(threadId: "thread_1234", runId: "run_1234")
        XCTAssertEqual(result, expectedResult)
    }

    func testRunRetrieveQueryError() async throws {
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.runRetrieve(threadId: "thread_1234", runId: "run_1234") }
        XCTAssertEqual(inError, apiError)
    }
    
    func testRunRetrieveStepsQuery() async throws {
        let expectedResult = RunRetrieveStepsResult(data: [.init(id: "step_1234", stepDetails: .init(toolCalls: [.init(id: "tool_456", type: .retrieval, codeInterpreter: nil, function: nil)]))])
        try self.stub(result: expectedResult)
        
        let result = try await openAI.runRetrieveSteps(threadId: "thread_1234", runId: "run_1234")
        XCTAssertEqual(result, expectedResult)
    }
    
    func testRunRetreiveStepsQueryError() async throws {
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.runRetrieveSteps(threadId: "thread_1234", runId: "run_1234") }
        XCTAssertEqual(inError, apiError)
    }
    
    func testRunSubmitToolOutputsQuery() async throws {
        let query = RunToolOutputsQuery(toolOutputs: [.init(toolCallId: "call_123", output: "Success")])
        let expectedResult = RunResult(id: "run_123", threadId: "thread_456", status: .inProgress, requiredAction: nil)
        try self.stub(result: expectedResult)
        
        let result = try await openAI.runSubmitToolOutputs(threadId: "thread_456", runId: "run_123", query: query)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testRunSubmitToolOutputsQueryError() async throws {
        let query = RunToolOutputsQuery(toolOutputs: [.init(toolCallId: "call_123", output: "Success")])
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.runSubmitToolOutputs(threadId: "thread_456", runId: "run_123", query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testThreadAddMessageQuery() async throws {
        let query = MessageQuery(role: .user, content: "Hello, What is AI?", fileIds: ["file_123"])
        let expectedResult = ThreadAddMessageResult(id: "message_1234")
        try self.stub(result: expectedResult)
        
        let result = try await openAI.threadsAddMessage(threadId: "thread_1234", query: query)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testThreadAddMessageQueryError() async throws {
        let query = MessageQuery(role: .user, content: "Hello, What is AI?", fileIds: ["file_123"])
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.threadsAddMessage(threadId: "thread_1234", query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testThreadsMessageQuery() async throws {
        let expectedResult = ThreadsMessagesResult(data: [ThreadsMessagesResult.ThreadsMessage(id: "thread_1234", role: ChatQuery.ChatCompletionMessageParam.Role.user, content: [ThreadsMessagesResult.ThreadsMessage.ThreadsMessageContent(type: .text, text: ThreadsMessagesResult.ThreadsMessage.ThreadsMessageContent.ThreadsMessageContentText(value: "Hello, What is AI?"), imageFile: nil)])])
        try self.stub(result: expectedResult)

        let result = try await openAI.threadsMessages(threadId: "thread_1234")
        XCTAssertEqual(result, expectedResult)
    }

    func testThreadsMessageQueryError() async throws {
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.threadsMessages(threadId: "thread_1234") }
        XCTAssertEqual(inError, apiError)
    }

    func testFilesQuery() async throws {
        let data = try XCTUnwrap("{\"test\":\"data\"}".data(using: .utf8))
        let query = FilesQuery(purpose: "assistant", file: data, fileName: "test.json", contentType: "application/json")
        let expectedResult = FilesResult(id: "file_1234", name: "test.json")
        try self.stub(result: expectedResult)
        
        let result = try await openAI.files(query: query)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFilesQueryError() async throws {
        let data = try XCTUnwrap("{\"test\":\"data\"}".data(using: .utf8))
        let query = FilesQuery(purpose: "assistant", file: data, fileName: "test.json", contentType: "application/json")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.files(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testCustomRunsURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", host: "my.host.com", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let completionsURL = openAI.buildRunsURL(path: .runs, threadId: "thread_4321")
        XCTAssertEqual(completionsURL, URL(string: "https://my.host.com/v1/threads/thread_4321/runs"))
    }

    func testCustomRunsRetrieveURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", host: "my.host.com", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let completionsURL = openAI.buildRunRetrieveURL(path: .runRetrieve, threadId: "thread_4321", runId: "run_1234")
        XCTAssertEqual(completionsURL, URL(string: "https://my.host.com/v1/threads/thread_4321/runs/run_1234"))
    }

    func testCustomRunRetrieveStepsURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", host: "my.host.com", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let completionsURL = openAI.buildRunRetrieveURL(path: .runRetrieveSteps, threadId: "thread_4321", runId: "run_1234")
        XCTAssertEqual(completionsURL, URL(string: "https://my.host.com/v1/threads/thread_4321/runs/run_1234/steps"))
    }
    // 1106 end
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
