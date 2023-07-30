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
        public let token: String
        
        /// Optional OpenAI organization identifier. See https://platform.openai.com/docs/api-reference/authentication
        public let organizationIdentifier: String?
        
        /// API host. Set this property if you use some kind of proxy or your own server. Default is api.openai.com
        public let host: String
        
        /// Default request timeout
        public let timeoutInterval: TimeInterval
        
        /// A dictionary of HTTP headers to include in requests to OpenAI (or any proxy server the request may be sent to)
        public var additionalHeaders: [String: String]
        
        public init(token: String, organizationIdentifier: String? = nil, host: String = "api.openai.com", timeoutInterval: TimeInterval = 60.0, additionalHeaders: [String: String]? = nil) {
            self.token = token
            self.organizationIdentifier = organizationIdentifier
            self.host = host
            self.timeoutInterval = timeoutInterval            
            self.additionalHeaders = additionalHeaders ?? [:]
        }
    }
    
    private let session: URLSessionProtocol
    private var streamingSessions: [NSObject] = []
    
    public let configuration: Configuration

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
        performRequest(request: JSONRequest<CompletionsQuery, CompletionsResult>(body: query, url: buildURL(path: .completions), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func completionsStream(query: CompletionsQuery, onResult: @escaping (Result<CompletionsResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performSteamingRequest(request: JSONRequest<CompletionsQuery, CompletionsResult>(body: query.makeStreamable(), url: buildURL(path: .completions), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), onResult: onResult, completion: completion)
    }
    
    public func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ImagesQuery, ImagesResult>(body: query, url: buildURL(path: .images), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<EmbeddingsQuery, EmbeddingsResult>(body: query, url: buildURL(path: .embeddings), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func chats(query: ChatQuery, completion: @escaping (Result<ChatResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ChatQuery, ChatResult>(body: query, url: buildURL(path: .chats), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performSteamingRequest(request: JSONRequest<ChatQuery, ChatResult>(body: query.makeStreamable(), url: buildURL(path: .chats), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), onResult: onResult, completion: completion)
    }
    
    public func edits(query: EditsQuery, completion: @escaping (Result<EditsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<EditsQuery, EditsResult>(body: query, url: buildURL(path: .edits), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func model(query: ModelQuery, completion: @escaping (Result<ModelResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ModelQuery, ModelResult>(url: buildURL(path: .models.withPath(query.model)), method: "GET", headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func models(completion: @escaping (Result<ModelsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<Empty, ModelsResult>(url: buildURL(path: .models), method: "GET", headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func moderations(query: ModerationsQuery, completion: @escaping (Result<ModerationsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ModerationsQuery, ModerationsResult>(body: query, url: buildURL(path: .moderations), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping (Result<AudioTranscriptionResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<AudioTranscriptionQuery, AudioTranscriptionResult>(body: query, url: buildURL(path: .audioTranscriptions), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
    
    public func audioTranslations(query: AudioTranslationQuery, completion: @escaping (Result<AudioTranslationResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<AudioTranslationQuery, AudioTranslationResult>(body: query, url: buildURL(path: .audioTranslations), headers: generateHeaders(), timeoutInterval: configuration.timeoutInterval), completion: completion)
    }
}

extension OpenAI {
    func generateHeaders() -> [String: String] {
        var headers = configuration.additionalHeaders
        headers["Authorization"] = "Bearer \(configuration.token)"
        if let organizationIdentifier = configuration.organizationIdentifier {
            headers["OpenAI-Organization"] = organizationIdentifier
        }
        return headers
    }
}

extension OpenAI {

    func performRequest<ResultType: Codable>(request: any URLRequestBuildable, completion: @escaping (Result<ResultType, Error>) -> Void) {
        do {
            let request = try request.build()
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
            let request = try request.build()
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
        components.path = path
        return components.url!
    }
}

typealias APIPath = String
extension APIPath {
    
    static let completions = "/v1/completions"
    static let images = "/v1/images/generations"
    static let embeddings = "/v1/embeddings"
    static let chats = "/v1/chat/completions"
    static let edits = "/v1/edits"
    static let models = "/v1/models"
    static let moderations = "/v1/moderations"
    
    static let audioTranscriptions = "/v1/audio/transcriptions"
    static let audioTranslations = "/v1/audio/translations"
    
    func withPath(_ path: String) -> String {
        self + "/" + path
    }
}
