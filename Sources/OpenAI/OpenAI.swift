//
//  OpenAI.swift
//  Oasis
//
//  Created by Sergii Kryvoblotskyi on 9/18/22.
//

import Foundation

final class OpenAI {

    enum OpenAIError: Error {
        case invalidURL
        case emptyData
    }

    enum Model: String, Codable {
        case textDavinci_003 = "text-davinci-003"
        case textDavinci_002 = "text-davinci-002"
        case textDavinci_001 = "text-davinci-001"
        case curie = "text-curie-001"
        case babbage = "text-babbage-001"
        case ada = "text-ada-001"
    }

    struct Query: Codable {
        let model: Model
        let prompt: String
        let temperature: Int
        let max_tokens: Int
        let top_p: Int
        let frequency_penalty: Int
        let presence_penalty: Int
        let stop: [String]
    }

    struct Completion: Codable {
        struct Choice: Codable {
            let text: String
            let index: Int
        }

        let id: String
        let object: String
        let created: TimeInterval
        let model: Model
        let choices: [Choice]
    }

    private let apiToken: String
    private let session = URLSession.shared

    init(apiToken: String) {
        self.apiToken = apiToken
    }

    func fetchCompletion(query: Query, completion: @escaping (Result<Completion, Error>) -> Void) {
        do {
            let request = try makeRequest(query: query)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(OpenAIError.emptyData))
                    return
                }
                do {
                    let decoded = try JSONDecoder().decode(Completion.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
            return
        }
    }
}

private extension OpenAI {

    func makeRequest(query: Query) throws -> URLRequest {
        guard let url = URL(string: "https://api.openai.com/v1/completions") else {
            throw OpenAIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(query)
        return request
    }
}
