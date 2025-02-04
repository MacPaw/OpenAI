//
//  OpenAI+OpenAICombine.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

#if canImport(Combine)
import Combine
import Foundation

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
extension OpenAI: OpenAICombine {
    public func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, any Error> {
        performRequestCombine(request: makeImagesRequest(query: query))
    }
    
    public func imageEdits(query: ImageEditsQuery) -> AnyPublisher<ImagesResult, Error> {
        performRequestCombine(
            request: makeImageEditsRequest(query: query)
        )
    }
    
    public func imageVariations(query: ImageVariationsQuery) -> AnyPublisher<ImagesResult, Error> {
        performRequestCombine(
            request: makeImageVariationsRequest(query: query)
        )
    }
    
    public func embeddings(query: EmbeddingsQuery) -> AnyPublisher<EmbeddingsResult, Error> {
        performRequestCombine(
            request: makeEmbeddingsRequest(query: query)
        )
    }
    
    public func chats(query: ChatQuery) -> AnyPublisher<ChatResult, Error> {
        performRequestCombine(
            request: makeChatsRequest(query: query)
        )
    }
    
    public func chatsStream(query: ChatQuery) -> AnyPublisher<Result<ChatStreamResult, Error>, Error> {
        let progress = PassthroughSubject<Result<ChatStreamResult, Error>, Error>()
        let cancellable = chatsStream(query: query) { result in
            progress.send(result)
        } completion: { error in
            if let error {
                progress.send(completion: .failure(error))
            } else {
                progress.send(completion: .finished)
            }
        }
        return progress
            .handleEvents(receiveCancel: {
                cancellable.cancelRequest()
            })
            .eraseToAnyPublisher()
    }
    
    public func model(query: ModelQuery) -> AnyPublisher<ModelResult, Error> {
        performRequestCombine(
            request: makeModelRequest(query: query)
        )
    }
    
    public func models() -> AnyPublisher<ModelsResult, Error> {
        performRequestCombine(
            request: makeModelsRequest()
        )
    }
    
    public func moderations(query: ModerationsQuery) -> AnyPublisher<ModerationsResult, Error> {
        performRequestCombine(
            request: makeModerationsRequest(query: query)
        )
    }
    
    public func audioCreateSpeech(query: AudioSpeechQuery) -> AnyPublisher<AudioSpeechResult, Error> {
        performRequestCombine(
            request: makeAudioCreateSpeechRequest(query: query)
        )
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery) -> AnyPublisher<AudioTranscriptionResult, Error> {
        performRequestCombine(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    public func audioTranslations(query: AudioTranslationQuery) -> AnyPublisher<AudioTranslationResult, Error> {
        performRequestCombine(
            request: makeAudioTranslationsRequest(query: query)
        )
    }
    
    public func assistants() -> AnyPublisher<AssistantsResult, Error> {
        assistants(after: nil)
    }
    
    public func assistants(after: String?) -> AnyPublisher<AssistantsResult, Error> {
        performRequestCombine(
            request: makeAssistantsRequest(after)
        )
    }
    
    public func assistantCreate(query: AssistantsQuery) -> AnyPublisher<AssistantResult, Error> {
        performRequestCombine(
            request: makeAssistantCreateRequest(query)
        )
    }
    
    public func assistantModify(query: AssistantsQuery, assistantId: String) -> AnyPublisher<AssistantResult, Error> {
        performRequestCombine(
            request: makeAssistantModifyRequest(assistantId, query)
        )
    }
    
    public func threads(query: ThreadsQuery) -> AnyPublisher<ThreadsResult, Error> {
        performRequestCombine(
            request: makeThreadsRequest(query)
        )
    }
    
    public func threadRun(query: ThreadRunQuery) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeThreadRunRequest(query)
        )
    }
    
    public func runs(threadId: String, query: RunsQuery) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeRunsRequest(threadId, query)
        )
    }
    
    public func runRetrieve(threadId: String, runId: String) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeRunRetrieveRequest(threadId, runId)
        )
    }
    
    public func runRetrieveSteps(threadId: String, runId: String) -> AnyPublisher<RunRetrieveStepsResult, Error> {
        runRetrieveSteps(threadId: threadId, runId: runId, before: nil)
    }
    
    public func runRetrieveSteps(threadId: String, runId: String, before: String?) -> AnyPublisher<RunRetrieveStepsResult, Error> {
        performRequestCombine(
            request: makeRunRetrieveStepsRequest(threadId, runId, before)
        )
    }
    
    public func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeRunSubmitToolOutputsRequest(threadId, runId, query)
        )
    }
    
    public func threadsMessages(threadId: String) -> AnyPublisher<ThreadsMessagesResult, any Error> {
        threadsMessages(threadId: threadId, before: nil)
    }
    
    public func threadsMessages(threadId: String, before: String?) -> AnyPublisher<ThreadsMessagesResult, Error> {
        performRequestCombine(
            request: makeThreadsMessagesRequest(threadId, before: before)
        )
    }
    
    public func threadsAddMessage(threadId: String, query: MessageQuery) -> AnyPublisher<ThreadAddMessageResult, Error> {
        performRequestCombine(
            request: makeThreadsAddMessageRequest(threadId, query)
        )
    }
    
    public func files(query: FilesQuery) -> AnyPublisher<FilesResult, Error> {
        performRequestCombine(
            request: makeFilesRequest(query: query)
        )
    }
    
    func performRequestCombine<ResultType: Codable>(request: any URLRequestBuildable) -> AnyPublisher<ResultType, Error> {
        do {
            let request = try request.build(token: configuration.token,
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
            return session
                .dataTaskPublisher(for: request)
                .tryMap { (data, response) in
                    let decoder = JSONDecoder()
                    do {
                        return try decoder.decode(ResultType.self, from: data)
                    } catch {
                        throw (try? decoder.decode(APIErrorResponse.self, from: data)) ?? error
                    }
                }.eraseToAnyPublisher()
        } catch {
            return Fail(outputType: ResultType.self, failure: error)
                .eraseToAnyPublisher()
        }
    }
}
#endif
