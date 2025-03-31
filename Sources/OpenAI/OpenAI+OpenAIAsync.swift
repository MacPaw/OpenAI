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
        return AsyncThrowingStream { continuation in
            let cancellableRequest = audioCreateSpeechStream(query: query)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
            
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
        let urlRequest = try request.build(configuration: configuration)
        let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
            middleware.intercept(request: current)
        }

        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            let (data, response) = try await session.data(for: interceptedRequest, delegate: nil)
            let (_, interceptedData) = self.middlewares.reduce((response, data)) { current, middleware in
                middleware.intercept(response: current.response, request: urlRequest, data: current.data)
            }
            let decoder = JSONDecoder()
            decoder.userInfo[.parsingOptions] = configuration.parsingOptions
            do {
                return try decoder.decode(ResultType.self, from: interceptedData ?? data)
            } catch {
                if let decoded = JSONResponseErrorDecoder(decoder: decoder).decodeErrorResponse(data: interceptedData ?? data) {
                    throw decoded
                } else {
                    throw error
                }
            }
        } else {
            let dataTaskStore = URLSessionDataTaskStore()
            return try await withTaskCancellationHandler {
                return try await withCheckedThrowingContinuation { continuation in
                    let dataTask = self.makeDataTask(forRequest: interceptedRequest) { (result: Result<ResultType, Error>) in
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
    
    func performSpeechRequestAsync(request: any URLRequestBuildable) async throws -> AudioSpeechResult {
        let urlRequest = try request.build(configuration: configuration)
        let interceptedRequest = middlewares.reduce(urlRequest) { current, middleware in
            middleware.intercept(request: current)
        }
        if #available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *) {
            let (data, response) = try await session.data(for: interceptedRequest, delegate: nil)
            let (_, interceptedData) = self.middlewares.reduce((response, data)) { current, middleware in
                middleware.intercept(response: current.response, request: urlRequest, data: current.data)
            }
            return .init(audio: interceptedData ?? data)
        } else {
            let dataTaskStore = URLSessionDataTaskStore()
            return try await withTaskCancellationHandler {
                return try await withCheckedThrowingContinuation { continuation in
                    let dataTask = self.makeRawResponseDataTask(forRequest: interceptedRequest) { result in
                        switch result {
                        case .success(let success):
                            continuation.resume(returning: .init(audio: success))
                        case .failure(let failure):
                            continuation.resume(throwing: failure)
                        }
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
