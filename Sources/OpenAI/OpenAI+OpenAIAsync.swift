//
//  OpenAI+OpenAIAsync.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

extension OpenAI: OpenAIAsync {
    public func images(query: ImagesQuery) async throws -> ImagesResult {
        try await performRequestAsync(
            request: makeImagesRequest(query: query)
        )
    }
    
    public func imageEdits(query: ImageEditsQuery) async throws -> ImagesResult {
        try await performRequestAsync(
            request: makeImageEditsRequest(query: query)
        )
    }
    
    public func imageVariations(query: ImageVariationsQuery) async throws -> ImagesResult {
        try await performRequestAsync(
            request: makeImageVariationsRequest(query: query)
        )
    }
    
    public func embeddings(query: EmbeddingsQuery) async throws -> EmbeddingsResult {
        try await performRequestAsync(
            request: makeEmbeddingsRequest(query: query)
        )
    }
    
    public func chats(query: ChatQuery) async throws -> ChatResult {
        try await performRequestAsync(
            request: makeChatsRequest(query: query)
        )
    }
    
    public func chatsStream(query: ChatQuery) -> AsyncThrowingStream<ChatStreamResult, Error> {
        makeAsyncStream { onResult, completion in
            chatsStream(query: query, onResult: onResult, completion: completion)
        }
    }
    
    public func model(query: ModelQuery) async throws -> ModelResult {
        try await performRequestAsync(
            request: makeModelRequest(query: query)
        )
    }
    
    public func models() async throws -> ModelsResult {
        try await performRequestAsync(
            request: makeModelsRequest()
        )
    }
    
    public func moderations(query: ModerationsQuery) async throws -> ModerationsResult {
        try await performRequestAsync(
            request: makeModerationsRequest(query: query)
        )
    }
    
    public func audioCreateSpeech(query: AudioSpeechQuery) async throws -> AudioSpeechResult {
        try await performSpeechRequestAsync(
            request: makeAudioCreateSpeechRequest(query: query)
        )
    }
    
    public func audioCreateSpeechStream(
        query: AudioSpeechQuery
    ) -> AsyncThrowingStream<AudioSpeechResult, Error> {
        makeAsyncStream { onResult, completion in
            audioCreateSpeechStream(query: query, onResult: onResult, completion: completion)
        }
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionResult {
        try await performRequestAsync(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    public func audioTranscriptionsVerbose(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionVerboseResult {
        guard query.responseFormat == .verboseJson else {
            throw AudioTranscriptionError.invalidQuery(expectedResponseFormat: .verboseJson)
        }
        
        return try await performRequestAsync(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    public func audioTranscriptionStream(
        query: AudioTranscriptionQuery
    ) -> AsyncThrowingStream<AudioTranscriptionStreamResult, Error> {
        makeAsyncStream { onResult, completion in
            audioTranscriptionStream(query: query, onResult: onResult, completion: completion)
        }
    }
    
    public func audioTranslations(query: AudioTranslationQuery) async throws -> AudioTranslationResult {
        try await performRequestAsync(
            request: makeAudioTranslationsRequest(query: query)
        )
    }
    
    public func assistants() async throws -> AssistantsResult {
        try await assistants(after: nil)
    }
    
    public func assistants(after: String?) async throws -> AssistantsResult {
        try await performRequestAsync(
            request: makeAssistantsRequest(after)
        )
    }
    
    public func assistantCreate(query: AssistantsQuery) async throws -> AssistantResult {
        try await performRequestAsync(
            request: makeAssistantCreateRequest(query)
        )
    }
    
    public func assistantModify(query: AssistantsQuery, assistantId: String) async throws -> AssistantResult {
        try await performRequestAsync(
            request: makeAssistantModifyRequest(assistantId, query)
        )
    }
    
    public func threads(query: ThreadsQuery) async throws -> ThreadsResult {
        try await performRequestAsync(
            request: makeThreadsRequest(query)
        )
    }
    
    public func threadRun(query: ThreadRunQuery) async throws -> RunResult {
        try await performRequestAsync(
            request: makeThreadRunRequest(query)
        )
    }
    
    public func runs(threadId: String,query: RunsQuery) async throws -> RunResult {
        try await performRequestAsync(
            request: makeRunsRequest(threadId, query)
        )
    }
    
    public func runRetrieve(threadId: String, runId: String) async throws -> RunResult {
        try await performRequestAsync(
            request: makeRunRetrieveRequest(threadId, runId)
        )
    }
    
    public func runRetrieveSteps(threadId: String, runId: String) async throws -> RunRetrieveStepsResult {
        try await runRetrieveSteps(threadId: threadId, runId: runId, before: nil)
    }
    
    public func runRetrieveSteps(threadId: String, runId: String, before: String?) async throws -> RunRetrieveStepsResult {
        try await performRequestAsync(
            request: makeRunRetrieveStepsRequest(threadId, runId, before)
        )
    }
    
    public func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) async throws -> RunResult {
        try await performRequestAsync(
            request: makeRunSubmitToolOutputsRequest(threadId, runId, query)
        )
    }
    
    public func threadsMessages(threadId: String) async throws -> ThreadsMessagesResult {
        try await performRequestAsync(
            request: makeThreadsMessagesRequest(threadId, before: nil)
        )
    }
    
    public func threadsMessages(threadId: String, before: String?) async throws -> ThreadsMessagesResult {
        try await performRequestAsync(
            request: makeThreadsMessagesRequest(threadId, before: before)
        )
    }
    
    public func threadsAddMessage(threadId: String, query: MessageQuery) async throws -> ThreadAddMessageResult {
        try await performRequestAsync(
            request: makeThreadsAddMessageRequest(threadId, query)
        )
    }
    
    public func files(query: FilesQuery) async throws -> FilesResult {
        try await performRequestAsync(
            request: makeFilesRequest(query: query)
        )
    }
    
    func performRequestAsync<ResultType: Codable & Sendable>(request: any URLRequestBuildable) async throws -> ResultType {
        try await asyncClient.performRequest(request: request)
    }
    
    func performSpeechRequestAsync(request: any URLRequestBuildable) async throws -> AudioSpeechResult {
        try await asyncClient.performSpeechRequest(request: request)
    }
    
    func makeAsyncStream<ResultType: Codable & Sendable>(
        byWrapping call: (_ onResult: @escaping @Sendable (Result<ResultType, Error>) -> Void, _ completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest
    ) -> AsyncThrowingStream<ResultType, Error> {
        return AsyncThrowingStream { continuation in

            let resultClosure: @Sendable (Result<ResultType, Error>) -> Void = {
                continuation.yield(with: $0)
            }
            
            let completionClosure: @Sendable (Error?) -> Void = {
                continuation.finish(throwing: $0)
            }
            
            let cancellableRequest = call(resultClosure, completionClosure)
            
            continuation.onTermination = { termination in
                switch termination {
                case .cancelled:
                    cancellableRequest.cancelRequest()
                case .finished:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
}
