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

final public class OpenAI {

    public struct Configuration {
        
        /// OpenAI API token. See https://platform.openai.com/docs/api-reference/authentication
        public let token: String
        
        /// Optional OpenAI organization identifier. See https://platform.openai.com/docs/api-reference/authentication
        public let organizationIdentifier: String?
        
        /// API host. Set this property if you use some kind of proxy or your own server. Default is api.openai.com
        public let host: String

        /// Optional base path if you set up OpenAI API proxy on a custom path on your own host. Default is ""
        public let basePath: String

        public let port: Int
        public let scheme: String
        
        /// Default request timeout
        public let timeoutInterval: TimeInterval
        
        public init(token: String, organizationIdentifier: String? = nil, host: String = "api.openai.com", port: Int = 443, scheme: String = "https", basePath: String = "", timeoutInterval: TimeInterval = 60.0) {
            self.token = token
            self.organizationIdentifier = organizationIdentifier
            self.host = host
            self.port = port
            self.scheme = scheme
            self.basePath = basePath
            self.timeoutInterval = timeoutInterval
        }
    }
    
    let session: URLSessionProtocol
    var streamingSessions = ArrayWithThreadSafety<NSObject>()
    private let cancellablesFactory: CancellablesFactory
    
    public let configuration: Configuration

    public convenience init(apiToken: String) {
        self.init(configuration: Configuration(token: apiToken), session: URLSession.shared)
    }
    
    public convenience init(configuration: Configuration) {
        self.init(configuration: configuration, session: URLSession.shared)
    }

    init(configuration: Configuration, session: URLSessionProtocol, cancellablesFactory: CancellablesFactory = DefaultCancellablesFactory()) {
        self.configuration = configuration
        self.session = session
        self.cancellablesFactory = cancellablesFactory
    }

    public convenience init(configuration: Configuration, session: URLSession = URLSession.shared) {
        self.init(
            configuration: configuration,
            session: session as URLSessionProtocol
        )
    }
    
    public func threadsAddMessage(threadId: String, query: MessageQuery, completion: @escaping (Result<ThreadAddMessageResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeThreadsAddMessageRequest(threadId, query),
            completion: completion
        )
    }
    
    public func threadsMessages(threadId: String, before: String? = nil, completion: @escaping (Result<ThreadsMessagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeThreadsMessagesRequest(threadId, before: before),
            completion: completion
        )
    }
    
    public func runRetrieve(threadId: String, runId: String, completion: @escaping (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeRunRetrieveRequest(threadId, runId),
            completion: completion
        )
    }
    
    public func runRetrieveSteps(threadId: String, runId: String, before: String? = nil, completion: @escaping (Result<RunRetrieveStepsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeRunRetrieveStepsRequest(threadId, runId, before),
            completion: completion
        )
    }
    
    public func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery, completion: @escaping (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeRunSubmitToolOutputsRequest(threadId, runId, query),
            completion: completion
        )
    }
    
    public func runs(threadId: String, query: RunsQuery, completion: @escaping (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeRunsRequest(threadId, query),
            completion: completion
        )
    }

    public func threads(query: ThreadsQuery, completion: @escaping (Result<ThreadsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeThreadsRequest(query),
            completion: completion
        )
    }
    
    public func threadRun(query: ThreadRunQuery, completion: @escaping (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeThreadRunRequest(query),
            completion: completion
        )
    }
    
    public func assistants(after: String? = nil, completion: @escaping (Result<AssistantsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeAssistantsRequest(after),
            completion: completion
        )
    }
    
    public func assistantCreate(query: AssistantsQuery, completion: @escaping (Result<AssistantResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeAssistantCreateRequest(query),
            completion: completion
        )
    }
    
    public func assistantModify(query: AssistantsQuery, assistantId: String, completion: @escaping (Result<AssistantResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeAssistantModifyRequest(assistantId, query),
            completion: completion
        )
    }
    
    public func files(query: FilesQuery, completion: @escaping (Result<FilesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeFilesRequest(query: query),
            completion: completion
        )
    }

    public func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeImagesRequest(query: query), completion: completion)
    }
    
    public func imageEdits(query: ImageEditsQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeImageEditsRequest(query: query), completion: completion)
    }
    
    public func imageVariations(query: ImageVariationsQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeImageVariationsRequest(query: query), completion: completion)
    }
    
    public func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeEmbeddingsRequest(query: query), completion: completion)
    }
    
    public func chats(query: ChatQuery, completion: @escaping (Result<ChatResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeChatsRequest(query: query.makeNonStreamable()), completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?) -> CancellableRequest {
        performStreamingRequest(
            request: JSONRequest<ChatStreamResult>(body: query.makeStreamable(), url: buildURL(path: .chats)),
            onResult: onResult,
            completion: completion
        )
    }
    
    public func model(query: ModelQuery, completion: @escaping (Result<ModelResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeModelRequest(query: query), completion: completion)
    }
    
    public func models(completion: @escaping (Result<ModelsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeModelsRequest(), completion: completion)
    }
    
    @available(iOS 13.0, *)
    public func moderations(query: ModerationsQuery, completion: @escaping (Result<ModerationsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeModerationsRequest(query: query), completion: completion)
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping (Result<AudioTranscriptionResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeAudioTranscriptionsRequest(query: query), completion: completion)
    }
    
    public func audioTranslations(query: AudioTranslationQuery, completion: @escaping (Result<AudioTranslationResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeAudioTranslationsRequest(query: query), completion: completion)
    }
    
    public func audioCreateSpeech(query: AudioSpeechQuery, completion: @escaping (Result<AudioSpeechResult, Error>) -> Void) -> CancellableRequest {
        performSpeechRequest(request: makeAudioCreateSpeechRequest(query: query), completion: completion)
    }
}

extension OpenAI {
    func performRequest<ResultType: Codable>(request: any URLRequestBuildable, completion: @escaping (Result<ResultType, Error>) -> Void) -> CancellableRequest {
        var cancellable = cancellablesFactory.makeTaskCanceller()
        do {
            let request = try request.build(token: configuration.token, 
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
            let task = makeDataTask(forRequest: request, completion: completion)
            cancellable.task = task
            task.resume()
        } catch {
            completion(.failure(error))
        }
        return cancellable
    }
    
    func performStreamingRequest<ResultType: Codable>(request: any URLRequestBuildable, onResult: @escaping (Result<ResultType, Error>) -> Void, completion: ((Error?) -> Void)?) -> CancellableRequest {
        var cancellable = cancellablesFactory.makeSessionCanceller()
        do {
            let request = try request.build(token: configuration.token, 
                                            organizationIdentifier: configuration.organizationIdentifier,
                                            timeoutInterval: configuration.timeoutInterval)
            let session = StreamingSession<ResultType>(urlRequest: request)
            cancellable.session = session
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
        return cancellable
    }
    
    func performSpeechRequest(request: any URLRequestBuildable, completion: @escaping (Result<AudioSpeechResult, Error>) -> Void) -> CancellableRequest {
        var cancellable = cancellablesFactory.makeTaskCanceller()
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
            cancellable.task = task
            task.resume()
        } catch {
            completion(.failure(error))
        }
        return cancellable
    }
    
    func makeDataTask<ResultType: Codable>(forRequest request: URLRequest, completion: @escaping (Result<ResultType, Error>) -> Void) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, _, error in
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
    }
}

extension OpenAI {
    func buildURL(path: String, after: String? = nil) -> URL {
        DefaultURLBuilder(configuration: configuration, path: path, after: after)
            .buildURL()
    }

    func buildRunsURL(path: String, threadId: String, before: String? = nil) -> URL {
        RunsURLBuilder(configuration: configuration, path: .init(stringValue: path), threadId: threadId)
            .buildURL()
    }

    func buildRunRetrieveURL(path: String, threadId: String, runId: String, before: String? = nil) -> URL {
        RunRetrieveURLBuilder(configuration: configuration, path: .init(stringValue: path), threadId: threadId, runId: runId, before: before)
            .buildURL()
    }

    func buildAssistantURL(path: APIPath.Assistants, assistantId: String) -> URL {
        AssistantsURLBuilder(configuration: configuration, path: path, assistantId: assistantId)
            .buildURL()
    }
}

typealias APIPath = String
extension APIPath {
    struct Assistants {
        static let assistants = Assistants(stringValue: "/v1/assistants")
        static let assistantsModify = Assistants(stringValue: "/v1/assistants/ASST_ID")
        static let threads = Assistants(stringValue: "/v1/threads")
        static let threadRun = Assistants(stringValue: "/v1/threads/runs")
        static let runs = Assistants(stringValue: "/v1/threads/THREAD_ID/runs")
        static let runRetrieve = Assistants(stringValue: "/v1/threads/THREAD_ID/runs/RUN_ID")
        static let runRetrieveSteps = Assistants(stringValue: "/v1/threads/THREAD_ID/runs/RUN_ID/steps")
        static func runSubmitToolOutputs(threadId: String, runId: String) -> Assistants {
            Assistants(stringValue: "/v1/threads/\(threadId)/runs/\(runId)/submit_tool_outputs")
        }
        static let threadsMessages = Assistants(stringValue: "/v1/threads/THREAD_ID/messages")
        static let files = Assistants(stringValue: "/v1/files")
        
        let stringValue: String
    }

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
