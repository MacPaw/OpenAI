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
        public let port: Int
        public let scheme: String
        /// Default request timeout
        public let timeoutInterval: TimeInterval
        
        public init(token: String, organizationIdentifier: String? = nil, host: String = "api.openai.com", port: Int = 443, scheme: String = "https", timeoutInterval: TimeInterval = 60.0) {
            self.token = token
            self.organizationIdentifier = organizationIdentifier
            self.host = host
            self.port = port
            self.scheme = scheme
            self.timeoutInterval = timeoutInterval
        }
    }
    
    private let session: URLSessionProtocol
    private var streamingSessions = ArrayWithThreadSafety<NSObject>()
    
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
        performRequest(request: JSONRequest<CompletionsResult>(body: query, url: buildURL(path: .completions)), completion: completion)
    }
    
    public func completionsStream(query: CompletionsQuery, control: StreamControl = StreamControl(), onResult: @escaping (Result<CompletionsResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performStreamingRequest(request: JSONRequest<CompletionsResult>(body: query.makeStreamable(), url: buildURL(path: .completions)), control: control, onResult: onResult, completion: completion)
    }
    
    public func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ImagesResult>(body: query, url: buildURL(path: .images)), completion: completion)
    }
    
    public func imageEdits(query: ImageEditsQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<ImagesResult>(body: query, url: buildURL(path: .imageEdits)), completion: completion)
    }
    
    public func imageVariations(query: ImageVariationsQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<ImagesResult>(body: query, url: buildURL(path: .imageVariations)), completion: completion)
    }
    
    public func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<EmbeddingsResult>(body: query, url: buildURL(path: .embeddings)), completion: completion)
    }
    
    public func chats(query: ChatQuery, completion: @escaping (Result<ChatResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ChatResult>(body: query, url: buildURL(path: .chats)), completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performStreamingRequest(request: JSONRequest<ChatResult>(body: query.makeStreamable(), url: buildURL(path: .chats)), onResult: onResult, completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, control: StreamControl = StreamControl(), onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performStreamingRequest(request: JSONRequest<ChatResult>(body: query.makeStreamable(), url: buildURL(path: .chats)), control: control, onResult: onResult, completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, url: URL, control: StreamControl = StreamControl(), onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performStreamingRequest(request: JSONRequest<ChatStreamResult>(body: query.makeStreamable(), url: url), control: control, onResult: onResult, completion: completion)
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
    
    @available(iOS 13.0, *)
    public func moderations(query: ModerationsQuery, completion: @escaping (Result<ModerationsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<ModerationsResult>(body: query, url: buildURL(path: .moderations)), completion: completion)
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping (Result<AudioTranscriptionResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<AudioTranscriptionResult>(body: query, url: buildURL(path: .audioTranscriptions)), completion: completion)
    }
    
    public func audioTranslations(query: AudioTranslationQuery, completion: @escaping (Result<AudioTranslationResult, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<AudioTranslationResult>(body: query, url: buildURL(path: .audioTranslations)), completion: completion)
    }
    
    public func audioCreateSpeech(query: AudioSpeechQuery, completion: @escaping (Result<AudioSpeechResult, Error>) -> Void) {
        performSpeechRequest(request: JSONRequest<AudioSpeechResult>(body: query, url: buildURL(path: .audioSpeech)), completion: completion)
    }
    
}

extension OpenAI {

    func performRequest<ResultType: Codable>(request: any URLRequestBuildable, completion: @escaping (Result<ResultType, Error>) -> Void) {
        do {
            let request = try request.build(token: configuration.token, 
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let data = data else {
                    return completion(.failure(OpenAIError.emptyData))
                }
                let decoder = JSONDecoder()
                do {
                    completion(.success(try decoder.decode(ResultType.self, from: data)))
                } catch {
                    completion(.failure((try? decoder.decode(APIErrorResponse.self, from: data)) ?? error))
                }
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func performStreamingRequest<ResultType: Codable>(request: any URLRequestBuildable, control: StreamControl = StreamControl(), onResult: @escaping (Result<ResultType, Error>) -> Void, completion: ((Error?) -> Void)?) {
        do {
            let request = try request.build(token: configuration.token, 
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
            let session = StreamingSession<ResultType>(urlRequest: request)
            control.setSession(session as! StreamingSession<ChatStreamResult>)
            session.onReceiveContent = { _, object in
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
    
    func performSpeechRequest(request: any URLRequestBuildable, completion: @escaping (Result<AudioSpeechResult, Error>) -> Void) {
        do {
            let request = try request.build(token: configuration.token, 
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
            
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    return completion(.failure(error))
                }
                guard let data = data else {
                    return completion(.failure(OpenAIError.emptyData))
                }
                
                completion(.success(AudioSpeechResult(audio: data)))
            }
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
}

extension OpenAI {
    
    func buildURL(path: String) -> URL {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.port = configuration.port
        components.path = path
        return components.url!
    }
}

typealias APIPath = String
extension APIPath {
    
    static let completions = "/v1/completions"
    static let embeddings = "/v1/embeddings"
    static let chats = "/v1/chat/completions"
    static let edits = "/v1/edits"
    static let models = "/v1/models"
    static let moderations = "/v1/moderations"
    
    static let audioSpeech = "/v1/audio/speech"
    static let audioTranscriptions = "/v1/audio/transcriptions"
    static let audioTranslations = "/v1/audio/translations"
    
    static let images = "/v1/images/generations"
    static let imageEdits = "/v1/images/edits"
    static let imageVariations = "/v1/images/variations"
    
    func withPath(_ path: String) -> String {
        self + "/" + path
    }
}
