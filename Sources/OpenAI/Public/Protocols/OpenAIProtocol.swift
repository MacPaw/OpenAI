//
//  OpenAIProvider.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public protocol OpenAIProtocol {
    
    func completions(query: CompletionsQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<CompletionsResult, Error>) -> Void)
    func images(query: ImagesQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<ImagesResult, Error>) -> Void)
    func embeddings(query: EmbeddingsQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void)
    func chats(query: ChatQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<ChatResult, Error>) -> Void)
}
