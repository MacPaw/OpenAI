//
//  OpenAIAsync.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public protocol OpenAIAsync {
    func images(query: ImagesQuery) async throws -> ImagesResult
    func imageEdits(query: ImageEditsQuery) async throws -> ImagesResult
    func imageVariations(query: ImageVariationsQuery) async throws -> ImagesResult
    func embeddings(query: EmbeddingsQuery) async throws -> EmbeddingsResult
    func chats(query: ChatQuery) async throws -> ChatResult
    func chatsStream(query: ChatQuery) -> AsyncThrowingStream<ChatStreamResult, Error>
    func model(query: ModelQuery) async throws -> ModelResult
    func models() async throws -> ModelsResult
    func moderations(query: ModerationsQuery) async throws -> ModerationsResult
    func audioCreateSpeech(query: AudioSpeechQuery) async throws -> AudioSpeechResult
    func audioTranscriptions(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionResult
    func audioTranslations(query: AudioTranslationQuery) async throws -> AudioTranslationResult
    func assistants() async throws -> AssistantsResult
    func assistants(after: String?) async throws -> AssistantsResult
    func assistantCreate(query: AssistantsQuery) async throws -> AssistantResult
    func assistantModify(query: AssistantsQuery, assistantId: String) async throws -> AssistantResult
    func threads(query: ThreadsQuery) async throws -> ThreadsResult
    func threadRun(query: ThreadRunQuery) async throws -> RunResult
    func runs(threadId: String, query: RunsQuery) async throws -> RunResult
    func runRetrieve(threadId: String, runId: String) async throws -> RunResult
    func runRetrieveSteps(threadId: String, runId: String) async throws -> RunRetrieveStepsResult
    func runRetrieveSteps(threadId: String, runId: String, before: String?) async throws -> RunRetrieveStepsResult
    func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) async throws -> RunResult
    func threadsMessages(threadId: String) async throws -> ThreadsMessagesResult
    func threadsMessages(threadId: String, before: String?) async throws -> ThreadsMessagesResult
    func threadsAddMessage(threadId: String, query: MessageQuery) async throws -> ThreadAddMessageResult
    func files(query: FilesQuery) async throws -> FilesResult
}
