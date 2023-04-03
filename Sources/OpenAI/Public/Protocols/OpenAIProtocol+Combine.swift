//
//  File.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 03/04/2023.
//

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

    func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, Error> {
        Future<ImagesResult, Error> {
            images(query: query, completion: $0)
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
}
