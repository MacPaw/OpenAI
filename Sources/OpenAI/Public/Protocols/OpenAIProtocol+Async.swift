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
    func completions(
        query: CompletionsQuery
    ) async throws -> CompletionsResult {
        try await withCheckedThrowingContinuation { continuation in
            completions(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }
    
    func completionsStream(
        query: CompletionsQuery,
        control: StreamControl = StreamControl()
    ) -> AsyncThrowingStream<CompletionsResult, Error> {
        return AsyncThrowingStream { continuation in
            completionsStream(query: query, control: control) { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
            
            continuation.onTermination = { @Sendable termination in
                control.cancel()
            }
        }
    }

    func images(
        query: ImagesQuery
    ) async throws -> ImagesResult {
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
        query: ImageEditsQuery
    ) async throws -> ImagesResult {
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
        query: ImageVariationsQuery
    ) async throws -> ImagesResult {
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
        query: EmbeddingsQuery
    ) async throws -> EmbeddingsResult {
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
        query: ChatQuery
    ) async throws -> ChatResult {
        try await withCheckedThrowingContinuation { continuation in
            chats(query: query) { result in
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
        query: ChatQuery,
        control: StreamControl = StreamControl()
    ) -> AsyncThrowingStream<ChatStreamResult, Error> {
        return AsyncThrowingStream { continuation in
            chatsStream(query: query, control: control)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
            
            continuation.onTermination = { @Sendable termination in
                control.cancel()
            }
        }
    }
    
    func chatsStream(
        query: ChatQuery,
        url: URL,
        control: StreamControl = StreamControl()
    ) -> AsyncThrowingStream<ChatStreamResult, Error> {
        return AsyncThrowingStream { continuation in
            chatsStream(query: query, url: url, control: control)  { result in
                continuation.yield(with: result)
            } completion: { error in
                continuation.finish(throwing: error)
            }
            
            continuation.onTermination = { @Sendable termination in
                control.cancel()
            }
        }
    }
    
    func edits(
        query: EditsQuery
    ) async throws -> EditsResult {
        try await withCheckedThrowingContinuation { continuation in
            edits(query: query) { result in
                switch result {
                case let .success(success):
                    return continuation.resume(returning: success)
                case let .failure(failure):
                    return continuation.resume(throwing: failure)
                }
            }
        }
    }
    
    func model(
        query: ModelQuery
    ) async throws -> ModelResult {
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
    
    func models() async throws -> ModelsResult {
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
        query: ModerationsQuery
    ) async throws -> ModerationsResult {
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
        query: AudioSpeechQuery
    ) async throws -> AudioSpeechResult {
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
        query: AudioTranscriptionQuery
    ) async throws -> AudioTranscriptionResult {
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
        query: AudioTranslationQuery
    ) async throws -> AudioTranslationResult {
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
