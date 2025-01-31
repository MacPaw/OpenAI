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
    func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, any Error> {
        performRequestCombine(request: makeImagesRequest(query: query))
    }
    
    func imageEdits(query: ImageEditsQuery) -> AnyPublisher<ImagesResult, Error> {
        performRequestCombine(
            request: makeImageEditsRequest(query: query)
        )
    }
    
    func imageVariations(query: ImageVariationsQuery) -> AnyPublisher<ImagesResult, Error> {
        performRequestCombine(
            request: makeImageVariationsRequest(query: query)
        )
    }
    
    func embeddings(query: EmbeddingsQuery) -> AnyPublisher<EmbeddingsResult, Error> {
        performRequestCombine(
            request: makeEmbeddingsRequest(query: query)
        )
    }
    
    func chats(query: ChatQuery) -> AnyPublisher<ChatResult, Error> {
        performRequestCombine(
            request: makeChatsRequest(query: query)
        )
    }
    
    func chatsStream(query: ChatQuery) -> AnyPublisher<Result<ChatStreamResult, Error>, Error> {
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
    
    func model(query: ModelQuery) -> AnyPublisher<ModelResult, Error> {
        performRequestCombine(
            request: makeModelRequest(query: query)
        )
    }
    
    func models() -> AnyPublisher<ModelsResult, Error> {
        performRequestCombine(
            request: makeModelsRequest()
        )
    }
    
    func moderations(query: ModerationsQuery) -> AnyPublisher<ModerationsResult, Error> {
        performRequestCombine(
            request: makeModerationsRequest(query: query)
        )
    }
    
    func audioCreateSpeech(query: AudioSpeechQuery) -> AnyPublisher<AudioSpeechResult, Error> {
        performRequestCombine(
            request: makeAudioCreateSpeechRequest(query: query)
        )
    }
    
    func audioTranscriptions(query: AudioTranscriptionQuery) -> AnyPublisher<AudioTranscriptionResult, Error> {
        performRequestCombine(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    func audioTranslations(query: AudioTranslationQuery) -> AnyPublisher<AudioTranslationResult, Error> {
        performRequestCombine(
            request: makeAudioTranslationsRequest(query: query)
        )
    }
    
    // TODO: Remove and use default arguments values if decide to remove OpenAI protocols
    func assistants() -> AnyPublisher<AssistantsResult, Error> {
        assistants(after: nil)
    }
    
    func assistants(after: String?) -> AnyPublisher<AssistantsResult, Error> {
        performRequestCombine(
            request: makeAssistantsRequest(after)
        )
    }
    
    func assistantCreate(query: AssistantsQuery) -> AnyPublisher<AssistantResult, Error> {
        performRequestCombine(
            request: makeAssistantCreateRequest(query)
        )
    }
    
    func assistantModify(query: AssistantsQuery, assistantId: String) -> AnyPublisher<AssistantResult, Error> {
        performRequestCombine(
            request: makeAssistantModifyRequest(assistantId, query)
        )
    }
    
    func threads(query: ThreadsQuery) -> AnyPublisher<ThreadsResult, Error> {
        performRequestCombine(
            request: makeThreadsRequest(query)
        )
    }
    
    func threadRun(query: ThreadRunQuery) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeThreadRunRequest(query)
        )
    }
    
    func runs(threadId: String, query: RunsQuery) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeRunsRequest(threadId, query)
        )
    }
    
    func runRetrieve(threadId: String, runId: String) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeRunRetrieveRequest(threadId, runId)
        )
    }
    
    // TODO: Remove and use default arguments values if decide to remove OpenAI protocols
    func runRetrieveSteps(threadId: String, runId: String) -> AnyPublisher<RunRetrieveStepsResult, Error> {
        runRetrieveSteps(threadId: threadId, runId: runId, before: nil)
    }
    
    func runRetrieveSteps(threadId: String, runId: String, before: String?) -> AnyPublisher<RunRetrieveStepsResult, Error> {
        performRequestCombine(
            request: makeRunRetrieveStepsRequest(threadId, runId, before)
        )
    }
    
    func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) -> AnyPublisher<RunResult, Error> {
        performRequestCombine(
            request: makeRunSubmitToolOutputsRequest(threadId, runId, query)
        )
    }
    
    func threadsMessages(threadId: String, before: String?) -> AnyPublisher<ThreadsMessagesResult, Error> {
        performRequestCombine(
            request: makeThreadsMessagesRequest(threadId, before: before)
        )
    }
    
    func threadsAddMessage(threadId: String, query: MessageQuery) -> AnyPublisher<ThreadAddMessageResult, Error> {
        performRequestCombine(
            request: makeThreadsAddMessageRequest(threadId, query)
        )
    }
    
    func files(query: FilesQuery) -> AnyPublisher<FilesResult, Error> {
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
