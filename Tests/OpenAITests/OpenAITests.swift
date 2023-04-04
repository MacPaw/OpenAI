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
            .init(text: "42 is the answer to everything", index: 0)
        ])
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
    
    func testImagesError() async throws {
        let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.images(query: query) }
        XCTAssertEqual(inError, apiError)
    }

    func testImages() async throws {
        let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")
        let imagesResult = ImagesResult(created: 100, data: [
            .init(url: "http://foo.bar")
        ])
        try self.stub(result: imagesResult)
        let result = try await openAI.images(query: query)
        XCTAssertEqual(result, imagesResult)
    }
    
    func testChats() async throws {
       let query = ChatQuery(model: .gpt4, messages: [
           .init(role: .system, content: "You are Librarian-GPT. You know everything about the books."),
           .init(role: .user, content: "Who wrote Harry Potter?")
       ])
       let chatResult = ChatResult(id: "id-12312", object: "foo", created: 100, model: .gpt3_5Turbo, choices: [
           .init(index: 0, message: .init(role: "foo", content: "bar"), finishReason: "baz"),
           .init(index: 0, message: .init(role: "foo1", content: "bar1"), finishReason: "baz1"),
           .init(index: 0, message: .init(role: "foo2", content: "bar2"), finishReason: "baz2")
        ], usage: .init(promptTokens: 100, completionTokens: 200, totalTokens: 300))
       try self.stub(result: chatResult)
        
       let result = try await openAI.chats(query: query)
       XCTAssertEqual(result, chatResult)
   }
    
    func testChatsError() async throws {
        let query = ChatQuery(model: .gpt4, messages: [
            .init(role: .system, content: "You are Librarian-GPT. You know everything about the books."),
            .init(role: .user, content: "Who wrote Harry Potter?")
        ])
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.chats(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testEmbeddings() async throws {
        let query = EmbeddingsQuery(model: .textSearchBabbadgeDoc, input: "The food was delicious and the waiter...")
        let embeddingsResult = EmbeddingsResult(data: [
            .init(object: "id-sdasd", embedding: [0.1, 0.2, 0.3, 0.4], index: 0),
            .init(object: "id-sdasd1", embedding: [0.4, 0.1, 0.7, 0.1], index: 1),
            .init(object: "id-sdasd2", embedding: [0.8, 0.1, 0.2, 0.8], index: 2)
        ])
        try self.stub(result: embeddingsResult)
        
        let result = try await openAI.embeddings(query: query)
        XCTAssertEqual(result, embeddingsResult)
    }
    
    func testEmbeddingsError() async throws {
        let query = EmbeddingsQuery(model: .textSearchBabbadgeDoc, input: "The food was delicious and the waiter...")
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)

        let apiError: APIError = try await XCTExpectError { try await openAI.embeddings(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testAudioTransriptions() async throws {
        let data = Data()
        let query = AudioTranscriptionQuery(file: data, fileName: "audio.m4a", model: .whisper_1)
        let transcriptionResult = AudioTranscriptionResult(text: "Hello, world!")
        try self.stub(result: transcriptionResult)
        
        let result = try await openAI.audioTranscriptions(query: query)
        XCTAssertEqual(result, transcriptionResult)
    }
    
    func testAudioTranscriptionsError() async throws {
        let data = Data()
        let query = AudioTranscriptionQuery(file: data, fileName: "audio.m4a", model: .whisper_1)
        let inError = APIError(message: "foo", type: "bar", param: "baz", code: "100")
        self.stub(error: inError)
        
        let apiError: APIError = try await XCTExpectError { try await openAI.audioTranscriptions(query: query) }
        XCTAssertEqual(inError, apiError)
    }
    
    func testAudioTranslations() async throws {
        let data = Data()
        let query = AudioTranslationQuery(file: data, fileName: "audio.m4a", model: .whisper_1)
        let transcriptionResult = AudioTranslationResult(text: "Hello, world!")
        try self.stub(result: transcriptionResult)
        
        let result = try await openAI.audioTranslations(query: query)
        XCTAssertEqual(result, transcriptionResult)
    }
    
    func testAudioTranslationsError() async throws {
        let data = Data()
        let query = AudioTranslationQuery(file: data, fileName: "audio.m4a", model: .whisper_1)
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
    
    func testJSONReqestCreation() throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let completionQuery = CompletionsQuery(model: .whisper_1, prompt: "how are you?")
        let jsonRequest = JSONRequest<CompletionsResult>(body: completionQuery, url: URL(string: "http://google.com")!)
        let urlRequest = try jsonRequest.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)
        
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(configuration.token)")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Content-Type"), "application/json")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "OpenAI-Organization"), configuration.organizationIdentifier)
        XCTAssertEqual(urlRequest.timeoutInterval, configuration.timeoutInterval)
    }
    
    func testMultipartReqestCreation() throws {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let completionQuery = AudioTranslationQuery(file: Data(), fileName: "foo", model: .whisper_1)
        let jsonRequest = MultipartFormDataRequest<CompletionsResult>(body: completionQuery, url: URL(string: "http://google.com")!)
        let urlRequest = try jsonRequest.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)
        
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(configuration.token)")
        XCTAssertEqual(urlRequest.value(forHTTPHeaderField: "OpenAI-Organization"), configuration.organizationIdentifier)
        XCTAssertEqual(urlRequest.timeoutInterval, configuration.timeoutInterval)
    }
    
    func testDefaultHostURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let completionsURL = openAI.buildURL(path: .completions)
        XCTAssertEqual(completionsURL, URL(string: "https://api.openai.com/v1/completions"))
    }
    
    func testCustomURLBuilt() {
        let configuration = OpenAI.Configuration(token: "foo", organizationIdentifier: "bar", host: "my.host.com", timeoutInterval: 14)
        let openAI = OpenAI(configuration: configuration, session: self.urlSession)
        let completionsURL = openAI.buildURL(path: .completions)
        XCTAssertEqual(completionsURL, URL(string: "https://my.host.com/v1/completions"))
    }
}

@available(tvOS 13.0, *)
@available(iOS 13.0, *)
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
