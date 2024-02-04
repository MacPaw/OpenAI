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

    func images(query: ImageGenerateParams) -> AnyPublisher<ImagesResponse, Error> {
        Future<ImagesResponse, Error> {
            images_generate(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func imageEdits(query: ImageEditParams) -> AnyPublisher<ImagesResponse, Error> {
        Future<ImagesResponse, Error> {
            images_edit(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func imageVariations(query: ImageCreateVariationParams) -> AnyPublisher<ImagesResponse, Error> {
        Future<ImagesResponse, Error> {
            images_create_variation(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func embeddings(query: EmbeddingCreateParams) -> AnyPublisher<EmbeddingResponse, Error> {
        Future<EmbeddingResponse, Error> {
            embeddings_create(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func chats(query: ChatCompletionCreateParams) -> AnyPublisher<ChatCompletion, Error> {
        Future<ChatCompletion, Error> {
            chat_completions(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func chatsStream(query: ChatCompletionCreateParams) -> AnyPublisher<Result<ChatCompletionChunk, Error>, Error> {
        let progress = PassthroughSubject<Result<ChatCompletionChunk, Error>, Error>()
        chat_with_streaming_response_completions(query: query) { result in
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

    func model(query: ModelCreateParams) -> AnyPublisher<Model, Error> {
        Future<Model, Error> {
            models_retreive(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func deleteModel(query: ModelCreateParams) -> AnyPublisher<ModelDeleted, Error> {
        Future<ModelDeleted, Error> {
            models_delete(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func models() -> AnyPublisher<ModelsResponse, Error> {
        Future<ModelsResponse, Error> {
            models_list(completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func moderations(query: ModerationCreateParams) -> AnyPublisher<ModerationCreateResponse, Error> {
        Future<ModerationCreateResponse, Error> {
            moderations_create(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func audioTranscriptions(query: TranscriptionCreateParams) -> AnyPublisher<Transcription, Error> {
        Future<Transcription, Error> {
            audio_transcriptions_create(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }

    func audioTranslations(query: TranslationCreateParams) -> AnyPublisher<Translation, Error> {
        Future<Translation, Error> {
            audio_translations_create(query: query, completion: $0)
        }
        .eraseToAnyPublisher()
    }
}

#endif
