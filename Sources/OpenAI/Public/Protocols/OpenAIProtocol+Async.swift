//
//  OpenAIProtocol+Async.swift
//
//
//  Created by Maxime Maheo on 10/02/2023.
//

import Foundation

@available(iOS 13.0, *)
@available(macOS 10.15, *)
@available(tvOS 13.0, *)
@available(watchOS 6.0, *)
public extension OpenAIProtocol {

    func images(
        query: ImageGenerateParams
    ) async throws -> ImagesResponse {
        try await withCheckedThrowingContinuation { continuation in
            images(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func imageEdits(
        query: ImageEditParams
    ) async throws -> ImagesResponse {
        try await withCheckedThrowingContinuation { continuation in
            imageEdits(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func imageVariations(
        query: ImageCreateVariationParams
    ) async throws -> ImagesResponse {
        try await withCheckedThrowingContinuation { continuation in
            imageVariations(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func embeddings(
        query: EmbeddingCreateParams
    ) async throws -> EmbeddingResponse {
        try await withCheckedThrowingContinuation { continuation in
            embeddings(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func chats(
        query: ChatCompletionCreateParams
    ) async throws -> ChatCompletion {
        try await withCheckedThrowingContinuation { continuation in
            chats(query: query) { result in
//                do {
//                    print("ChatCompletion", "SUCCESS", try result.get())
//                    print("ChatCompletion", "SUCCESS", try JSONEncoder.encode(try result.get()))
//                } catch {
//                    print("ChatCompletion", error.localizedDescription)
//                }
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func chatsStream(
        query: ChatCompletionCreateParams
    ) -> AsyncThrowingStream<ChatCompletionChunk, Error> {
        return AsyncThrowingStream { continuation in
            return chatsStream(query: query)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
        }
    }

    func model(
        query: ModelCreateParams
    ) async throws -> Model {
        try await withCheckedThrowingContinuation { continuation in
            model(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func deleteModel(
        query: ModelCreateParams
    ) async throws -> ModelDeleted {
        try await withCheckedThrowingContinuation { continuation in
            deleteModel(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func models() async throws -> ModelsResponse {
        try await withCheckedThrowingContinuation { continuation in
            models() { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func moderations(
        query: ModerationCreateParams
    ) async throws -> ModerationCreateResponse {
        try await withCheckedThrowingContinuation { continuation in
            moderations(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func audioCreateSpeech(
        query: SpeechCreateParams
    ) async throws -> Speech {
        try await withCheckedThrowingContinuation { continuation in
            audioCreateSpeech(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func audioTranscriptions(
        query: TranscriptionCreateParams
    ) async throws -> Transcription {
        try await withCheckedThrowingContinuation { continuation in
            audioTranscriptions(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }

    func audioTranslations(
        query: TranslationCreateParams
    ) async throws -> Translation {
        try await withCheckedThrowingContinuation { continuation in
            audioTranslations(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }
}
