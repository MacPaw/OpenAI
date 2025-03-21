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

final public class OpenAI: @unchecked Sendable {

    public struct Configuration {
        
        /// OpenAI API token. See https://platform.openai.com/docs/api-reference/authentication
        ///
        /// Set the token when the app works directly with OpenAI API. This approach is generally unsafe and should not be used in production.
        /// Default value is nil. It would work when you have a proxy server that manages authentication.
        /// See https://github.com/MacPaw/OpenAI/discussions/116 for more info
        public let token: String?
        
        /// Optional OpenAI organization identifier. See https://platform.openai.com/docs/api-reference/authentication
        public let organizationIdentifier: String?
        
        /// API host. Set this property if you use some kind of proxy or your own server. Default is api.openai.com
        public let host: String

        /// Optional base path if you set up OpenAI API proxy on a custom path on your own host. Default is "/v1"
        public let basePath: String

        public let port: Int
        public let scheme: String
        
        /// Default request timeout
        public let timeoutInterval: TimeInterval
        
        /// Headers to set on a request.
        ///
        /// Value from this dict would set on any request sent by SDK.
        ///
        /// These values are applied after all the default headers are set, so if names collide, values from this dict would override default values.
        ///
        /// Currently SDK sets such fields: Authorization, Content-Type, OpenAI-Organization.
        public let customHeaders: [String: String]
        
        public init(token: String?, organizationIdentifier: String? = nil, host: String = "api.openai.com", port: Int = 443, scheme: String = "https", basePath: String = "/v1", timeoutInterval: TimeInterval = 60.0, customHeaders: [String: String] = [:]) {
            self.token = token
            self.organizationIdentifier = organizationIdentifier
            self.host = host
            self.port = port
            self.scheme = scheme
            self.basePath = basePath
            self.timeoutInterval = timeoutInterval
            self.customHeaders = customHeaders
        }
    }
    
    let session: URLSessionProtocol
    
    private let streamingSessionFactory: StreamingSessionFactory
    private let cancellablesFactory: CancellablesFactory
    private let executionSerializer: ExecutionSerializer
    private var streamingSessions: [NSObject: InvalidatableSession] = [:]
    
    public let configuration: Configuration

    public convenience init(apiToken: String) {
        self.init(configuration: Configuration(token: apiToken), session: URLSession.shared, sslStreamingDelegate: nil)
    }
    
    public convenience init(configuration: Configuration) {
        self.init(configuration: configuration, session: URLSession.shared, sslStreamingDelegate: nil)
    }
    
    public convenience init(configuration: Configuration, session: URLSession = URLSession.shared, sslStreamingDelegate: SSLDelegateProtocol? = nil) {
        let streamingSessionFactory = ImplicitURLSessionStreamingSessionFactory(sslDelegate: sslStreamingDelegate)
        
        self.init(
            configuration: configuration,
            session: session,
            streamingSessionFactory: streamingSessionFactory
        )
    }

    init(
        configuration: Configuration,
        session: URLSessionProtocol,
        streamingSessionFactory: StreamingSessionFactory,
        cancellablesFactory: CancellablesFactory = DefaultCancellablesFactory(),
        executionSerializer: ExecutionSerializer = GCDQueueAsyncExecutionSerializer(queue: .userInitiated)
    ) {
        self.configuration = configuration
        self.session = session
        self.streamingSessionFactory = streamingSessionFactory
        self.cancellablesFactory = cancellablesFactory
        self.executionSerializer = executionSerializer
    }
    
    public func threadsAddMessage(
        threadId: String,
        query: MessageQuery,
        completion: @escaping @Sendable (Result<ThreadAddMessageResult, Error>) -> Void
    ) -> CancellableRequest {
        performRequest(
            request: makeThreadsAddMessageRequest(threadId, query),
            completion: completion
        )
    }
    
    public func threadsMessages(
        threadId: String,
        before: String? = nil,
        completion: @escaping @Sendable (Result<ThreadsMessagesResult, Error>) -> Void
    ) -> CancellableRequest {
        performRequest(
            request: makeThreadsMessagesRequest(threadId, before: before),
            completion: completion
        )
    }
    
    public func runRetrieve(threadId: String, runId: String, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeRunRetrieveRequest(threadId, runId),
            completion: completion
        )
    }
    
    public func runRetrieveSteps(
        threadId: String,
        runId: String,
        before: String? = nil,
        completion: @escaping @Sendable (Result<RunRetrieveStepsResult, Error>) -> Void
    ) -> CancellableRequest {
        performRequest(
            request: makeRunRetrieveStepsRequest(threadId, runId, before),
            completion: completion
        )
    }
    
    public func runSubmitToolOutputs(
        threadId: String,
        runId: String,
        query: RunToolOutputsQuery,
        completion: @escaping @Sendable (Result<RunResult, Error>) -> Void
    ) -> CancellableRequest {
        performRequest(
            request: makeRunSubmitToolOutputsRequest(threadId, runId, query),
            completion: completion
        )
    }
    
    public func runs(threadId: String, query: RunsQuery, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeRunsRequest(threadId, query),
            completion: completion
        )
    }

    public func threads(query: ThreadsQuery, completion: @escaping @Sendable (Result<ThreadsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeThreadsRequest(query),
            completion: completion
        )
    }
    
    public func threadRun(query: ThreadRunQuery, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeThreadRunRequest(query),
            completion: completion
        )
    }
    
    public func assistants(after: String? = nil, completion: @escaping @Sendable (Result<AssistantsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeAssistantsRequest(after),
            completion: completion
        )
    }
    
    public func assistantCreate(query: AssistantsQuery, completion: @escaping @Sendable (Result<AssistantResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeAssistantCreateRequest(query),
            completion: completion
        )
    }
    
    public func assistantModify(query: AssistantsQuery, assistantId: String, completion: @escaping @Sendable (Result<AssistantResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeAssistantModifyRequest(assistantId, query),
            completion: completion
        )
    }
    
    public func files(query: FilesQuery, completion: @escaping @Sendable (Result<FilesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(
            request: makeFilesRequest(query: query),
            completion: completion
        )
    }

    public func images(query: ImagesQuery, completion: @escaping @Sendable (Result<ImagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeImagesRequest(query: query), completion: completion)
    }
    
    public func imageEdits(query: ImageEditsQuery, completion: @escaping @Sendable (Result<ImagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeImageEditsRequest(query: query), completion: completion)
    }
    
    public func imageVariations(query: ImageVariationsQuery, completion: @escaping @Sendable (Result<ImagesResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeImageVariationsRequest(query: query), completion: completion)
    }
    
    public func embeddings(query: EmbeddingsQuery, completion: @escaping @Sendable (Result<EmbeddingsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeEmbeddingsRequest(query: query), completion: completion)
    }
    
    public func chats(query: ChatQuery, completion: @escaping @Sendable (Result<ChatResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeChatsRequest(query: query.makeNonStreamable()), completion: completion)
    }
    
    public func chatsStream(query: ChatQuery, onResult: @escaping @Sendable (Result<ChatStreamResult, Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest {
        performStreamingRequest(
            request: JSONRequest<ChatStreamResult>(body: query.makeStreamable(), url: buildURL(path: .chats)),
            onResult: onResult,
            completion: completion
        )
    }
    
    public func model(query: ModelQuery, completion: @escaping @Sendable (Result<ModelResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeModelRequest(query: query), completion: completion)
    }
    
    public func models(completion: @escaping @Sendable (Result<ModelsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeModelsRequest(), completion: completion)
    }
    
    @available(iOS 13.0, *)
    public func moderations(query: ModerationsQuery, completion: @escaping @Sendable (Result<ModerationsResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeModerationsRequest(query: query), completion: completion)
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping @Sendable (Result<AudioTranscriptionResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeAudioTranscriptionsRequest(query: query), completion: completion)
    }
    
    public func audioTranslations(query: AudioTranslationQuery, completion: @escaping @Sendable (Result<AudioTranslationResult, Error>) -> Void) -> CancellableRequest {
        performRequest(request: makeAudioTranslationsRequest(query: query), completion: completion)
    }
    
    public func audioCreateSpeech(query: AudioSpeechQuery, completion: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void) -> CancellableRequest {
        performSpeechRequest(request: makeAudioCreateSpeechRequest(query: query), completion: completion)
    }
    
    public func audioCreateSpeechStream(query: AudioSpeechQuery, onResult: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest {
        performSpeechStreamingRequest(
            request: JSONRequest<AudioSpeechResult>(body: query, url: buildURL(path: .audioSpeech)),
            onResult: onResult,
            completion: completion
        )
    }
}

extension OpenAI {
    func performRequest<ResultType: Codable>(request: any URLRequestBuildable, completion: @escaping @Sendable (Result<ResultType, Error>) -> Void) -> CancellableRequest {
        do {
            let request = try request.build(configuration: configuration)
            let task = makeDataTask(forRequest: request, completion: completion)
            task.resume()
            return cancellablesFactory.makeTaskCanceller(task: task)
        } catch {
            completion(.failure(error))
            return NoOpCancellableRequest()
        }
    }
    
    func performStreamingRequest<ResultType: Codable & Sendable>(
        request: any URLRequestBuildable,
        onResult: @escaping @Sendable (Result<ResultType, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            
            let session = streamingSessionFactory.makeServerSentEventsStreamingSession(urlRequest: urlRequest) { _, object in
                onResult(.success(object))
            } onProcessingError: { _, error in
                onResult(.failure(error))
            } onComplete: { [weak self] session, error in
                completion?(error)
                self?.invalidateSession(session)
            }
            
            return runSession(session)
        } catch {
            completion?(error)
            return NoOpCancellableRequest()
        }
    }
    
    func performSpeechRequest(request: any URLRequestBuildable, completion: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void) -> CancellableRequest {
        do {
            let request = try request.build(configuration: configuration)
            
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
            return cancellablesFactory.makeTaskCanceller(task: task)
        } catch {
            completion(.failure(error))
            return NoOpCancellableRequest()
        }
    }
    
    func performSpeechStreamingRequest(
        request: any URLRequestBuildable,
        onResult: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void,
        completion: (@Sendable (Error?) -> Void)?
    ) -> CancellableRequest {
        do {
            let urlRequest = try request.build(configuration: configuration)
            
            let session = streamingSessionFactory.makeAudioSpeechStreamingSession(urlRequest: urlRequest) { _, object in
                onResult(.success(object))
            } onProcessingError: { _, error in
                onResult(.failure(error))
            } onComplete: { [weak self] session, error in
                completion?(error)
                self?.invalidateSession(session)
            }
            
            return runSession(session)
        } catch {
            completion?(error)
            return NoOpCancellableRequest()
        }
    }
    
    func makeDataTask<ResultType: Codable>(forRequest request: URLRequest, completion: @escaping @Sendable (Result<ResultType, Error>) -> Void) -> URLSessionDataTaskProtocol {
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
    
    func makeRawResponseDataTask(forRequest request: URLRequest, completion: @escaping @Sendable (Result<Data, Error>) -> Void) -> URLSessionDataTaskProtocol {
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(OpenAIError.emptyData))
            }
            
            completion(.success(data))
        }
    }
    
    private func runSession<I>(_ session: StreamingSession<I>) -> CancellableRequest {
        let performableSession = session.makeSession()
        
        executionSerializer.dispatch {
            self.streamingSessions[session] = performableSession
        }
        
        performableSession.performSession()
        
        return cancellablesFactory.makeSessionCanceller(
            session: performableSession
        )
    }
    
    private func invalidateSession(_ object: NSObject) {
        self.executionSerializer.dispatch {
            let invalidatableSession = self.streamingSessions.removeValue(forKey: object)
            invalidatableSession?.invalidateAndCancel()
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
        static let assistants = Assistants(stringValue: "/assistants")
        static let assistantsModify = Assistants(stringValue: "/assistants/ASST_ID")
        static let threads = Assistants(stringValue: "/threads")
        static let threadRun = Assistants(stringValue: "/threads/runs")
        static let runs = Assistants(stringValue: "/threads/THREAD_ID/runs")
        static let runRetrieve = Assistants(stringValue: "/threads/THREAD_ID/runs/RUN_ID")
        static let runRetrieveSteps = Assistants(stringValue: "/threads/THREAD_ID/runs/RUN_ID/steps")
        static func runSubmitToolOutputs(threadId: String, runId: String) -> Assistants {
            Assistants(stringValue: "/threads/\(threadId)/runs/\(runId)/submit_tool_outputs")
        }
        static let threadsMessages = Assistants(stringValue: "/threads/THREAD_ID/messages")
        static let files = Assistants(stringValue: "/files")
        
        let stringValue: String
    }

    static let embeddings = "/embeddings"
    static let chats = "/chat/completions"
    static let models = "/models"
    static let moderations = "/moderations"
    
    static let audioSpeech = "/audio/speech"
    static let audioTranscriptions = "/audio/transcriptions"
    static let audioTranslations = "/audio/translations"
    
    static let images = "/images/generations"
    static let imageEdits = "/images/edits"
    static let imageVariations = "/images/variations"
    
    func withPath(_ path: String) -> String {
        self + "/" + path
    }
}
