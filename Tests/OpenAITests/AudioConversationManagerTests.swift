//
//  AudioConversationManagerTests.swift
//  OpenAI
//
//  Created by OpenAI SDK Contributors.
//

import XCTest
@testable import OpenAI
#if canImport(Combine)
import Combine
#endif

@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
final class AudioConversationManagerTests: XCTestCase {

    func testInitializationWithSystemPrompt() async {
        let systemPrompt = "You are a helpful assistant"
        let manager = AudioConversationManager(
            openAI: MockOpenAI(),
            systemPrompt: systemPrompt
        )

        let messageCount = await manager.getMessageCount()
        XCTAssertEqual(messageCount, 1, "Should have system message")

        let transcript = await manager.getTranscript()
        XCTAssertTrue(transcript.contains(systemPrompt))
    }

    func testInitializationWithoutSystemPrompt() async {
        let manager = AudioConversationManager(openAI: MockOpenAI())
        let messageCount = await manager.getMessageCount()
        XCTAssertEqual(messageCount, 0, "Should have no messages")
    }

    func testSendAudio() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(openAI: mockOpenAI)

        let audioData = Data("test audio".utf8)
        let (responseAudio, transcript) = try await manager.sendAudio(audioData)

        XCTAssertFalse(responseAudio.isEmpty)
        XCTAssertEqual(transcript, "Mock response")

        let messageCount = await manager.getMessageCount()
        XCTAssertEqual(messageCount, 2, "Should have user message and assistant response")
    }

    func testSendText() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(openAI: mockOpenAI)

        let (responseAudio, transcript) = try await manager.sendText("Hello")

        XCTAssertFalse(responseAudio.isEmpty)
        XCTAssertEqual(transcript, "Mock response")

        let messageCount = await manager.getMessageCount()
        XCTAssertEqual(messageCount, 2, "Should have user message and assistant response")
    }

    func testConversationHistory() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(
            openAI: mockOpenAI,
            systemPrompt: "You are helpful"
        )

        _ = try await manager.sendText("First message")
        _ = try await manager.sendText("Second message")

        let transcript = await manager.getTranscript()
        XCTAssertTrue(transcript.contains("First message"))
        XCTAssertTrue(transcript.contains("Second message"))
        XCTAssertTrue(transcript.contains("Mock response"))

        let messageCount = await manager.getMessageCount()
        XCTAssertEqual(messageCount, 5, "System + 2 user messages + 2 assistant responses")
    }

    func testReset() async throws {
        let mockOpenAI = MockOpenAI()
        let systemPrompt = "You are helpful"
        let manager = AudioConversationManager(
            openAI: mockOpenAI,
            systemPrompt: systemPrompt
        )

        _ = try await manager.sendText("Test message")

        var messageCount = await manager.getMessageCount()
        XCTAssertGreaterThan(messageCount, 1)

        await manager.reset()

        messageCount = await manager.getMessageCount()
        XCTAssertEqual(messageCount, 1, "Should only have system message after reset")

        let transcript = await manager.getTranscript()
        XCTAssertTrue(transcript.contains(systemPrompt))
        XCTAssertFalse(transcript.contains("Test message"))
    }

    func testHistoryPruning() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(
            openAI: mockOpenAI,
            systemPrompt: "System",
            maxHistoryTurns: 2
        )

        // Send 5 messages (exceeds maxHistoryTurns of 2)
        for i in 1...5 {
            _ = try await manager.sendText("Message \(i)")
        }

        let transcript = await manager.getTranscript()

        // Should keep system message + last 2 turns (4 messages)
        XCTAssertTrue(transcript.contains("System"))
        XCTAssertFalse(transcript.contains("Message 1"))
        XCTAssertFalse(transcript.contains("Message 2"))
        XCTAssertFalse(transcript.contains("Message 3"))
        XCTAssertTrue(transcript.contains("Message 4"))
        XCTAssertTrue(transcript.contains("Message 5"))
    }

    func testDifferentVoices() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(openAI: mockOpenAI)

        let voices: [AudioChatQuery.AudioConfig.Voice] = [.alloy, .echo, .fable, .onyx, .nova, .shimmer]

        for voice in voices {
            _ = try await manager.sendText("Test", voice: voice)
            // Verify it doesn't throw
        }
    }

    func testDifferentResponseFormats() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(openAI: mockOpenAI)

        let formats: [AudioFormat] = [.wav, .mp3, .flac, .opus, .pcm16]

        for format in formats {
            _ = try await manager.sendText("Test", responseFormat: format)
            // Verify it doesn't throw
        }
    }

    func testGetTranscriptWithAudioMessage() async throws {
        let mockOpenAI = MockOpenAI()
        let manager = AudioConversationManager(openAI: mockOpenAI)

        let audioData = Data("audio".utf8)
        _ = try await manager.sendAudio(audioData)

        let transcript = await manager.getTranscript()
        XCTAssertTrue(transcript.contains("[audio]"), "Should indicate audio message")
    }

    func testErrorPropagation() async {
        let mockOpenAI = MockOpenAI()
        mockOpenAI.shouldThrowError = true
        let manager = AudioConversationManager(openAI: mockOpenAI)

        do {
            _ = try await manager.sendText("Test")
            XCTFail("Should throw error")
        } catch {
            // Expected error
        }
    }
}

// MARK: - Mock OpenAI

@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
private class MockOpenAI: OpenAIProtocol {
    var shouldThrowError = false

    func audioChats(query: AudioChatQuery, completion: @escaping @Sendable (Result<AudioChatResult, any Error>) -> Void) -> any CancellableRequest {
        if shouldThrowError {
            completion(.failure(NSError(domain: "test", code: -1)))
        } else {
            let mockResult = AudioChatResult(
                id: "test-id",
                object: "chat.completion",
                created: 0,
                model: "gpt-4o-audio-preview",
                choices: [
                    .init(
                        index: 0,
                        message: .init(
                            role: "assistant",
                            content: "Mock response",
                            audio: .init(
                                id: "audio-id",
                                data: Data("mock audio".utf8).base64EncodedString(),
                                transcript: "Mock response",
                                expiresAt: 0
                            )
                        ),
                        finishReason: "stop"
                    )
                ],
                usage: nil,
                serviceTier: nil,
                systemFingerprint: nil
            )
            completion(.success(mockResult))
        }
        return MockCancellableRequest()
    }

    func audioChatsStream(query: AudioChatQuery, onResult: @escaping @Sendable (Result<AudioChatStreamResult, any Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> any CancellableRequest {
        MockCancellableRequest()
    }

    // Implement other required protocol methods with minimal implementations
    var responses: ResponsesEndpointProtocol { fatalError("Not implemented") }
    func images(query: ImagesQuery, completion: @escaping @Sendable (Result<ImagesResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func imageEdits(query: ImageEditsQuery, completion: @escaping @Sendable (Result<ImagesResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func imageVariations(query: ImageVariationsQuery, completion: @escaping @Sendable (Result<ImagesResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func embeddings(query: EmbeddingsQuery, completion: @escaping @Sendable (Result<EmbeddingsResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func chats(query: ChatQuery, completion: @escaping @Sendable (Result<ChatResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func chatsStream(query: ChatQuery, onResult: @escaping @Sendable (Result<ChatStreamResult, any Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> any CancellableRequest { MockCancellableRequest() }
    func model(query: ModelQuery, completion: @escaping @Sendable (Result<ModelResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func models(completion: @escaping @Sendable (Result<ModelsResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func moderations(query: ModerationsQuery, completion: @escaping @Sendable (Result<ModerationsResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func audioCreateSpeech(query: AudioSpeechQuery, completion: @escaping @Sendable (Result<AudioSpeechResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func audioCreateSpeechStream(query: AudioSpeechQuery, onResult: @escaping @Sendable (Result<AudioSpeechResult, any Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> any CancellableRequest { MockCancellableRequest() }
    func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping @Sendable (Result<AudioTranscriptionResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func audioTranscriptionsVerbose(query: AudioTranscriptionQuery, completion: @escaping @Sendable (Result<AudioTranscriptionVerboseResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func audioTranscriptionStream(query: AudioTranscriptionQuery, onResult: @escaping @Sendable (Result<AudioTranscriptionStreamResult, any Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> any CancellableRequest { MockCancellableRequest() }
    func audioTranslations(query: AudioTranslationQuery, completion: @escaping @Sendable (Result<AudioTranslationResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func assistants(after: String?, completion: @escaping @Sendable (Result<AssistantsResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func assistantCreate(query: AssistantsQuery, completion: @escaping @Sendable (Result<AssistantResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func assistantModify(query: AssistantsQuery, assistantId: String, completion: @escaping @Sendable (Result<AssistantResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func threads(query: ThreadsQuery, completion: @escaping @Sendable (Result<ThreadsResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func threadRun(query: ThreadRunQuery, completion: @escaping @Sendable (Result<RunResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func runs(threadId: String, query: RunsQuery, completion: @escaping @Sendable (Result<RunResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func runRetrieve(threadId: String, runId: String, completion: @escaping @Sendable (Result<RunResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func runRetrieveSteps(threadId: String, runId: String, before: String?, completion: @escaping @Sendable (Result<RunRetrieveStepsResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery, completion: @escaping @Sendable (Result<RunResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func threadsMessages(threadId: String, before: String?, completion: @escaping @Sendable (Result<ThreadsMessagesResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func threadsAddMessage(threadId: String, query: MessageQuery, completion: @escaping @Sendable (Result<ThreadAddMessageResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }
    func files(query: FilesQuery, completion: @escaping @Sendable (Result<FilesResult, any Error>) -> Void) -> any CancellableRequest { MockCancellableRequest() }

    // OpenAIAsync protocol requirements
    func images(query: ImagesQuery) async throws -> ImagesResult { fatalError() }
    func imageEdits(query: ImageEditsQuery) async throws -> ImagesResult { fatalError() }
    func imageVariations(query: ImageVariationsQuery) async throws -> ImagesResult { fatalError() }
    func embeddings(query: EmbeddingsQuery) async throws -> EmbeddingsResult { fatalError() }
    func chats(query: ChatQuery) async throws -> ChatResult { fatalError() }
    func chatsStream(query: ChatQuery) -> AsyncThrowingStream<ChatStreamResult, Error> { fatalError() }
    func model(query: ModelQuery) async throws -> ModelResult { fatalError() }
    func models() async throws -> ModelsResult { fatalError() }
    func moderations(query: ModerationsQuery) async throws -> ModerationsResult { fatalError() }
    func audioCreateSpeech(query: AudioSpeechQuery) async throws -> AudioSpeechResult { fatalError() }
    func audioTranscriptions(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionResult { fatalError() }
    func audioTranscriptionsVerbose(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionVerboseResult { fatalError() }
    func audioTranscriptionStream(query: AudioTranscriptionQuery) -> AsyncThrowingStream<AudioTranscriptionStreamResult, Error> { fatalError() }
    func audioTranslations(query: AudioTranslationQuery) async throws -> AudioTranslationResult { fatalError() }
    func audioChats(query: AudioChatQuery) async throws -> AudioChatResult {
        try await withCheckedThrowingContinuation { continuation in
            _ = audioChats(query: query) { result in
                continuation.resume(with: result)
            }
        }
    }
    func audioChatsStream(query: AudioChatQuery) -> AsyncThrowingStream<AudioChatStreamResult, Error> { fatalError() }
    func assistants() async throws -> AssistantsResult { fatalError() }
    func assistants(after: String?) async throws -> AssistantsResult { fatalError() }
    func assistantCreate(query: AssistantsQuery) async throws -> AssistantResult { fatalError() }
    func assistantModify(query: AssistantsQuery, assistantId: String) async throws -> AssistantResult { fatalError() }
    func threads(query: ThreadsQuery) async throws -> ThreadsResult { fatalError() }
    func threadRun(query: ThreadRunQuery) async throws -> RunResult { fatalError() }
    func runs(threadId: String, query: RunsQuery) async throws -> RunResult { fatalError() }
    func runRetrieve(threadId: String, runId: String) async throws -> RunResult { fatalError() }
    func runRetrieveSteps(threadId: String, runId: String) async throws -> RunRetrieveStepsResult { fatalError() }
    func runRetrieveSteps(threadId: String, runId: String, before: String?) async throws -> RunRetrieveStepsResult { fatalError() }
    func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) async throws -> RunResult { fatalError() }
    func threadsMessages(threadId: String) async throws -> ThreadsMessagesResult { fatalError() }
    func threadsMessages(threadId: String, before: String?) async throws -> ThreadsMessagesResult { fatalError() }
    func threadsAddMessage(threadId: String, query: MessageQuery) async throws -> ThreadAddMessageResult { fatalError() }
    func files(query: FilesQuery) async throws -> FilesResult { fatalError() }

    #if canImport(Combine)
    // OpenAICombine protocol requirements
    func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, Error> { fatalError() }
    func imageEdits(query: ImageEditsQuery) -> AnyPublisher<ImagesResult, Error> { fatalError() }
    func imageVariations(query: ImageVariationsQuery) -> AnyPublisher<ImagesResult, Error> { fatalError() }
    func embeddings(query: EmbeddingsQuery) -> AnyPublisher<EmbeddingsResult, Error> { fatalError() }
    func chats(query: ChatQuery) -> AnyPublisher<ChatResult, Error> { fatalError() }
    func chatsStream(query: ChatQuery) -> AnyPublisher<Result<ChatStreamResult, Error>, Error> { fatalError() }
    func model(query: ModelQuery) -> AnyPublisher<ModelResult, Error> { fatalError() }
    func models() -> AnyPublisher<ModelsResult, Error> { fatalError() }
    func moderations(query: ModerationsQuery) -> AnyPublisher<ModerationsResult, Error> { fatalError() }
    func audioCreateSpeech(query: AudioSpeechQuery) -> AnyPublisher<AudioSpeechResult, Error> { fatalError() }
    func audioTranscriptions(query: AudioTranscriptionQuery) -> AnyPublisher<AudioTranscriptionResult, Error> { fatalError() }
    func audioTranslations(query: AudioTranslationQuery) -> AnyPublisher<AudioTranslationResult, Error> { fatalError() }
    func audioChats(query: AudioChatQuery) -> AnyPublisher<AudioChatResult, Error> { fatalError() }
    func audioChatsStream(query: AudioChatQuery) -> AnyPublisher<Result<AudioChatStreamResult, Error>, Error> { fatalError() }
    func assistants() -> AnyPublisher<AssistantsResult, Error> { fatalError() }
    func assistants(after: String?) -> AnyPublisher<AssistantsResult, Error> { fatalError() }
    func assistantCreate(query: AssistantsQuery) -> AnyPublisher<AssistantResult, Error> { fatalError() }
    func assistantModify(query: AssistantsQuery, assistantId: String) -> AnyPublisher<AssistantResult, Error> { fatalError() }
    func threads(query: ThreadsQuery) -> AnyPublisher<ThreadsResult, Error> { fatalError() }
    func threadRun(query: ThreadRunQuery) -> AnyPublisher<RunResult, Error> { fatalError() }
    func runs(threadId: String, query: RunsQuery) -> AnyPublisher<RunResult, Error> { fatalError() }
    func runRetrieve(threadId: String, runId: String) -> AnyPublisher<RunResult, Error> { fatalError() }
    func runRetrieveSteps(threadId: String, runId: String) -> AnyPublisher<RunRetrieveStepsResult, Error> { fatalError() }
    func runRetrieveSteps(threadId: String, runId: String, before: String?) -> AnyPublisher<RunRetrieveStepsResult, Error> { fatalError() }
    func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) -> AnyPublisher<RunResult, Error> { fatalError() }
    func threadsMessages(threadId: String) -> AnyPublisher<ThreadsMessagesResult, Error> { fatalError() }
    func threadsMessages(threadId: String, before: String?) -> AnyPublisher<ThreadsMessagesResult, Error> { fatalError() }
    func threadsAddMessage(threadId: String, query: MessageQuery) -> AnyPublisher<ThreadAddMessageResult, Error> { fatalError() }
    func files(query: FilesQuery) -> AnyPublisher<FilesResult, Error> { fatalError() }
    #endif
}

@available(iOS 15.0, macOS 12.0, watchOS 8.0, *)
private final class MockCancellableRequest: CancellableRequest {
    func cancelRequest() {}
}
