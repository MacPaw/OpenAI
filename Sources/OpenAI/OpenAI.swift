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

        public init(token: String, organizationIdentifier: String? = nil, host: String = "api.openai.com", timeoutInterval: TimeInterval = 60.0) {
            self.token = token
            self.organizationIdentifier = organizationIdentifier
            self.host = host
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

    public func images_generate(query: ImageGenerateParams, completion: @escaping (Result<ImagesResponse, Error>) -> Void) {
        performRequest(request: JSONRequest<ImagesResponse>(body: query, url: buildURL(path: .images)), completion: completion)
    }

    public func images_edit(query: ImageEditParams, completion: @escaping (Result<ImagesResponse, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<ImagesResponse>(body: query, url: buildURL(path: .imageEdits)), completion: completion)
    }

    public func images_create_variation(query: ImageCreateVariationParams, completion: @escaping (Result<ImagesResponse, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<ImagesResponse>(body: query, url: buildURL(path: .imageVariations)), completion: completion)
    }

    public func embeddings_create(query: EmbeddingCreateParams, completion: @escaping (Result<EmbeddingResponse, Error>) -> Void) {
        performRequest(request: JSONRequest<EmbeddingResponse>(body: query, url: buildURL(path: .embeddings)), completion: completion)
    }

    public func chat_completions(query: ChatCompletionCreateParams, completion: @escaping (Result<ChatCompletion, Error>) -> Void) {
        performRequest(request: JSONRequest<ChatCompletion>(body: query.makeNonStreamable(), url: buildURL(path: .chats)), completion: completion)
    }

    public func chat_with_streaming_response_completions(query: ChatCompletionCreateParams, onResult: @escaping (Result<ChatCompletionChunk, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performStreamingRequest(request: JSONRequest<ChatCompletion>(body: query.makeStreamable(), url: buildURL(path: .chats)), onResult: onResult, completion: completion)
    }

    public func models_retreive(query: ModelCreateParams, completion: @escaping (Result<Model, Error>) -> Void) {
        performRequest(request: JSONRequest<Model>(url: buildURL(path: .models.withPath(query.model)), method: "GET"), completion: completion)
    }

    public func models_delete(query: ModelCreateParams, completion: @escaping (Result<ModelDeleted, Error>) -> Void) {
        performRequest(request: JSONRequest<Model>(url: buildURL(path: .models.withPath(query.model)), method: "DELETE"), completion: completion)
    } // TODO: test deleteModel

    public func models_list(completion: @escaping (Result<ModelsResponse, Error>) -> Void) {
        performRequest(request: JSONRequest<ModelsResponse>(url: buildURL(path: .models), method: "GET"), completion: completion)
    }

    public func moderations_create(query: ModerationCreateParams, completion: @escaping (Result<ModerationCreateResponse, Error>) -> Void) {
        performRequest(request: JSONRequest<ModerationCreateResponse>(body: query, url: buildURL(path: .moderations)), completion: completion)
    }

    public func audio_transcriptions_create(query: TranscriptionCreateParams, completion: @escaping (Result<Transcription, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<Transcription>(body: query, url: buildURL(path: .audioTranscriptions)), completion: completion)
    }

    public func audio_translations_create(query: TranslationCreateParams, completion: @escaping (Result<Translation, Error>) -> Void) {
        performRequest(request: MultipartFormDataRequest<Translation>(body: query, url: buildURL(path: .audioTranslations)), completion: completion)
    }

    public func audio_speech_create(query: SpeechCreateParams, completion: @escaping (Result<Speech, Error>) -> Void) {
        performSpeechRequest(request: JSONRequest<Speech>(body: query, url: buildURL(path: .audioSpeech)), completion: completion)
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

    func performStreamingRequest<ResultType: Codable>(request: any URLRequestBuildable, onResult: @escaping (Result<ResultType, Error>) -> Void, completion: ((Error?) -> Void)?) {
        do {
            let request = try request.build(token: configuration.token,
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
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

    func performSpeechRequest(request: any URLRequestBuildable, completion: @escaping (Result<Speech, Error>) -> Void) {
        do {
            let request = try request.build(token: configuration.token,
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)

            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(OpenAIError.emptyData))
                    return
                }

                completion(.success(Speech(audio: data)))
                let apiError: Error? = nil

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

    static let embeddings = "/v1/embeddings"
    static let chats = "/v1/chat/completions"
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
