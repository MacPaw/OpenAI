//
//  OpenAI+OpenAIAsync.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
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
        return AsyncThrowingStream { continuation in
            let cancellableRequest = chatsStream(query: query)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
            
            continuation.onTermination = { termination in
                cancellableRequest.cancelRequest()
            }
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
        try await performRequestAsync(
            request: makeAudioCreateSpeechRequest(query: query)
        )
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionResult {
        try await performRequestAsync(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    public func audioTranslations(query: AudioTranslationQuery) async throws -> AudioTranslationResult {
        try await performRequestAsync(
            request: makeAudioTranslationsRequest(query: query)
        )
    }
    
    // TODO: Remove and use default arguments values if decide to remove OpenAI protocols
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
    
    // TODO: Remove and use default arguments values if decide to remove OpenAI protocols
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
    
    // TODO: Remove this method and use the one with default arguments if decided to remove OpenAI protocols
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
    
    func performRequestAsync<ResultType: Codable>(request: any URLRequestBuildable) async throws -> ResultType {
        let urlRequest = try request.build(token: configuration.token,
                                        organizationIdentifier: configuration.organizationIdentifier,
                                        timeoutInterval: configuration.timeoutInterval)
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            let (data, _) = try await session.data(for: urlRequest, delegate: nil)
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(ResultType.self, from: data)
            } catch {
                throw (try? decoder.decode(APIErrorResponse.self, from: data)) ?? error
            }
        } else {
            let dataTaskStore = URLSessionDataTaskStore()
            return try await withTaskCancellationHandler {
                return try await withCheckedThrowingContinuation { continuation in
                    let dataTask = self.makeDataTask(forRequest: urlRequest) { (result: Result<ResultType, Error>) in
                        continuation.resume(with: result)
                    }
                    
                    dataTask.resume()
                    
                    Task {
                        await dataTaskStore.setDataTask(dataTask)
                    }
                }
            } onCancel: {
                Task {
                    await dataTaskStore.getDataTask()?.cancel()
                }
            }
        }
    }
}
