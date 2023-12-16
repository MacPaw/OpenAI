//
//  OpenAIProtocol+Combine.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 03/04/2023.
//

#if canImport(Combine)

import Combine

@available(iOS 13.0, *)
@available(tvOS 13.0, *)
@available(macOS 10.15, *)
@available(watchOS 6.0, *)
public extension OpenAIProtocol {

    func completions(query: CompletionsQuery) -> AnyPublisher<CompletionsResult, Error> {
        Future<CompletionsResult, Error> {
            completions(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func completionsStream(query: CompletionsQuery) -> AnyPublisher<Result<CompletionsResult, Error>, Error> {
        let progress = PassthroughSubject<Result<CompletionsResult, Error>, Error>()
        completionsStream(query: query) { result in
            progress.send(result)
        } completion: { error in
            if let error {
                progress.send(completion: .failure(error))
            } else {
                progress.send(completion: .finished)
            }
        }
        return progress.eraseToAnyPublisher()
    }

    func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, Error> {
        Future<ImagesResult, Error> {
            images(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func imageEdits(query: ImageEditsQuery) -> AnyPublisher<ImagesResult, Error> {
        Future<ImagesResult, Error> {
            imageEdits(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func imageVariations(query: ImageVariationsQuery) -> AnyPublisher<ImagesResult, Error> {
        Future<ImagesResult, Error> {
            imageVariations(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func embeddings(query: EmbeddingsQuery) -> AnyPublisher<EmbeddingsResult, Error> {
        Future<EmbeddingsResult, Error> {
            embeddings(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func chats(query: ChatQuery) -> AnyPublisher<ChatResult, Error> {
        Future<ChatResult, Error> {
            chats(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func chatsStream(query: ChatQuery) -> AnyPublisher<Result<ChatStreamResult, Error>, Error> {
        let progress = PassthroughSubject<Result<ChatStreamResult, Error>, Error>()
        chatsStream(query: query) { result in
            progress.send(result)
        } completion: { error in
            if let error {
                progress.send(completion: .failure(error))
            } else {
                progress.send(completion: .finished)
            }
        }
        return progress.eraseToAnyPublisher()
    }
    
    func edits(query: EditsQuery) -> AnyPublisher<EditsResult, Error> {
        Future<EditsResult, Error> {
            edits(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func model(query: ModelQuery) -> AnyPublisher<ModelResult, Error> {
        Future<ModelResult, Error> {
            model(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func models() -> AnyPublisher<ModelsResult, Error> {
        Future<ModelsResult, Error> {
            models(completion: $0)
        }
        .eraseToAnyPublisher()
    }
    
    func moderations(query: ModerationsQuery) -> AnyPublisher<ModerationsResult, Error> {
        Future<ModerationsResult, Error> {
            moderations(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func audioTranscriptions(query: AudioTranscriptionQuery) -> AnyPublisher<AudioTranscriptionResult, Error> {
        Future<AudioTranscriptionResult, Error> {
            audioTranscriptions(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func audioTranslations(query: AudioTranslationQuery) -> AnyPublisher<AudioTranslationResult, Error> {
        Future<AudioTranslationResult, Error> {
            audioTranslations(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    // 1106
    func assistants(query: AssistantsQuery?, method: String, after: String?) -> AnyPublisher<AssistantsResult, Error> {
        Future<AssistantsResult, Error> {
            assistants(query: query, method: method, after: after, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func threads(query: ThreadsQuery) -> AnyPublisher<ThreadsResult, Error> {
        Future<ThreadsResult, Error> {
            threads(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func runs(threadId: String, query: RunsQuery) -> AnyPublisher<RunsResult, Error> {
        Future<RunsResult, Error> {
            runs(threadId: threadId, query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func runRetrieve(threadId: String, runId: String) -> AnyPublisher<RunRetreiveResult, Error> {
        Future<RunRetreiveResult, Error> {

            runRetrieve(threadId: threadId, runId: runId, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func threadsMessages(threadId: String, before: String?) -> AnyPublisher<ThreadsMessagesResult, Error> {
        Future<ThreadsMessagesResult, Error> {
            threadsMessages(threadId: threadId, before: before, completion: $0)
        }
        .eraseToAnyPublisher()
    }
    // 1106 end
}

#endif
