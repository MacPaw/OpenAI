//
//  OpenAI.swift
//
//
//  Created by Sergii Kryvoblotskyi on 9/18/22.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final public class OpenAI: OpenAIProtocol {

    public struct Configuration {
        
        /// OpenAI API token. See https://platform.openai.com/docs/api-reference/authentication
        public var token: String
        
        /// Optional OpenAI organization identifier. See https://platform.openai.com/docs/api-reference/authentication
        public var organizationIdentifier: String?
        
        /// API host. Set this property if you use some kind of proxy or your own server. Default is api.openai.com
        public var host: String
        
        /// Default request timeout
        public var timeoutInterval: TimeInterval

        public var routeVersion: String
        
        public init(token: String, organizationIdentifier: String? = nil, host: String = "api.openai.com", timeoutInterval: TimeInterval = 60.0, routeVersion: String = "/v1") {
            self.token = token
            self.organizationIdentifier = organizationIdentifier
            self.host = host
            self.timeoutInterval = timeoutInterval
            self.routeVersion = routeVersion
        }
    }
    
    private let session: URLSessionProtocol
    private var streamingSessions: [NSObject] = []
    
    public var configuration: Configuration

    public convenience init(apiToken: String) {
        self.init(configuration: Configuration(token: apiToken), session: URLSession.shared)
    }
    
    public convenience init(configuration: Configuration) {
        self.init(configuration: configuration, session: URLSession.shared)
    }

    init(configuration: Configuration, session: URLSessionProtocol) {
        self.configuration = configuration
        self.session = session
    }

    public convenience init(configuration: Configuration, session: URLSession = URLSession.shared) {
        self.init(configuration: configuration, session: session as URLSessionProtocol)
    }
    
    public func completions(query: CompletionsQuery, completion: @escaping (Result<CompletionsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<CompletionsResult>(body: query, url: buildURL(path: .completions)), completion: completion)
    }
    
    public func completionsStream(query: CompletionsQuery, onResult: @escaping (Result<CompletionsResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performSteamingRequest(request: JSONRequest<CompletionsResult>(body: query.makeStreamable(), url: buildURL(path: .completions)), onResult: onResult, completion: completion)
    }
    
    public func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ImagesResult>(body: query, url: buildURL(path: .images)), completion: completion)
    }
    
    public func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<EmbeddingsResult>(body: query, url: buildURL(path: .embeddings)), completion: completion)
    }
    
    public func chats(query: ChatQuery, completion: @escaping (Result<ChatResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ChatResult>(body: query, url: buildURL(path: .chats)), completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performSteamingRequest(request: JSONRequest<ChatResult>(body: query.makeStreamable(), url: buildURL(path: .chats)), onResult: onResult, completion: completion)
    }
    
    public func edits(query: EditsQuery, completion: @escaping (Result<EditsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<EditsResult>(body: query, url: buildURL(path: .edits)), completion: completion)
    }
    
    public func model(query: ModelQuery, completion: @escaping (Result<ModelResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ModelResult>(url: buildURL(path: .models.withPath(query.model)), method: "GET"), completion: completion)
    }
    
    public func models(completion: @escaping (Result<ModelsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ModelsResult>(url: buildURL(path: .models), method: "GET"), completion: completion)
    }
    
    public func moderations(query: ModerationsQuery, completion: @escaping (Result<ModerationsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ModerationsResult>(body: query, url: buildURL(path: .moderations)), completion: completion)
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping (Result<AudioTranscriptionResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<AudioTranscriptionResult>(body: query, url: buildURL(path: .audioTranscriptions)), completion: completion)
    }
    
    public func audioTranslations(query: AudioTranslationQuery, completion: @escaping (Result<AudioTranslationResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<AudioTranslationResult>(body: query, url: buildURL(path: .audioTranslations)), completion: completion)
    }
}

extension OpenAI {

    func performRequest<ResultType: Codable>(request: any URLRequestBuildable, completion: @escaping (Result<ResultType, Error>) -> Void) {
        do {
            let request = try request.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(OpenAIError.emptyData))
                    return
                }

                var apiError: Error? = nil
                do {
                    let decoded = try JSONDecoder().decode(ResultType.self, from: data)
                    completion(.success(decoded))
                } catch {
                    apiError = error
                }

                if let apiError = apiError {
                    do {
                        let decoded = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                        completion(.failure(decoded))
                    } catch {
                        completion(.failure(apiError))
                    }
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func performSteamingRequest<ResultType: Codable>(request: any URLRequestBuildable, onResult: @escaping (Result<ResultType, Error>) -> Void, completion: ((Error?) -> Void)?) {
        do {
            let request = try request.build(token: configuration.token, organizationIdentifier: configuration.organizationIdentifier, timeoutInterval: configuration.timeoutInterval)
            let session = StreamingSession<ResultType>(urlRequest: request)
            session.onReceiveContent = {_, object in
                onResult(.success(object))
            }
            session.onProcessingError = {_, error in
                onResult(.failure(error))
            }
            session.onComplete = { [weak self] object, error in
                self?.streamingSessions.removeAll(where: { $0 == object })
                completion?(error)
            }
            session.perform()
            streamingSessions.append(session)
        } catch {
            completion?(error)
        }
    }
}

extension OpenAI {
    
    func buildURL(path: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = configuration.host
        let path = self.routeVersion + path
        components.path = path
        return components.url!
    }
}

typealias APIPath = String
extension APIPath {
    
    static let completions = "/completions"
    static let images = "/images/generations"
    static let embeddings = "/embeddings"
    static let chats = "/chat/completions"
    static let edits = "/edits"
    static let models = "/models"
    static let moderations = "/moderations"
    
    static let audioTranscriptions = "/audio/transcriptions"
    static let audioTranslations = "/audio/translations"
    
    func withPath(_ path: String) -> String {
        self + "/" + path
    }
}
