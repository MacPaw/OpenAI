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

    // UPDATES FROM 11-06-23
    public func threadsAddMessage(threadId: String, query: MessageQuery, completion: @escaping (Result<ThreadAddMessageResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<ThreadsMessagesResult>.jsonRequest(
                urlBuilder: RunsURLBuilder(
                    configuration: configuration,
                    path: .threadsMessages,
                    threadId: threadId
                ),
                body: query
            ),
            completion: completion
        )
    }

    public func threadsMessages(threadId: String, before: String? = nil, completion: @escaping (Result<ThreadsMessagesResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<ThreadsMessagesResult>.jsonRequest(
                urlBuilder: RunsURLBuilder(configuration: configuration, path: .threadsMessages, threadId: threadId),
                body: nil,
                method: "GET"
            ),
            completion: completion
        )
    }

    public func runRetrieve(threadId: String, runId: String, completion: @escaping (Result<RunResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<RunResult>.jsonRequest(
                urlBuilder: RunRetrieveURLBuilder(configuration: configuration, path: .runRetrieve, threadId: threadId, runId: runId),
                body: nil,
                method: "GET"
            ),
            completion: completion
        )
    }

    public func runRetrieveSteps(threadId: String, runId: String, before: String? = nil, completion: @escaping (Result<RunRetrieveStepsResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<RunRetrieveStepsResult>.jsonRequest(
                urlBuilder: RunRetrieveURLBuilder(
                    configuration: configuration,
                    path: .runRetrieveSteps,
                    threadId: threadId,
                    runId: runId,
                    before: before
                ),
                body: nil,
                method: "GET"
            ),
            completion: completion
        )
    }
    
    public func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery, completion: @escaping (Result<RunResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<RunResult>.jsonRequest(
                urlBuilder: DefaultURLBuilder(
                    configuration: configuration,
                    path: .Assistants.runSubmitToolOutputs(threadId: threadId, runId: runId).stringValue
                ),
                body: query
            ),
            completion: completion
        )
    }

    public func runs(threadId: String, query: RunsQuery, completion: @escaping (Result<RunResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<RunResult>.jsonRequest(
                urlBuilder: RunsURLBuilder(configuration: configuration, path: .runs, threadId: threadId),
                body: query
            ),
            completion: completion
        )
    }

    public func threads(query: ThreadsQuery, completion: @escaping (Result<ThreadsResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<ThreadsResult>.jsonRequest(
                urlBuilder: DefaultURLBuilder(configuration: configuration, path: .Assistants.threads.stringValue),
                body: query
            ),
            completion: completion
        )
    }
    
    public func threadRun(query: ThreadRunQuery, completion: @escaping (Result<RunResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<RunResult>.jsonRequest(
                urlBuilder: DefaultURLBuilder(configuration: configuration, path: .Assistants.threadRun.stringValue),
                body: query
            ),
            completion: completion
        )
    }

    public func assistants(after: String? = nil, completion: @escaping (Result<AssistantsResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<AssistantsResult>.jsonRequest(
                urlBuilder: DefaultURLBuilder(configuration: configuration, path: .Assistants.assistants.stringValue, after: after),
                body: nil,
                method: "GET"
            ),
            completion: completion
        )
    }

    public func assistantCreate(query: AssistantsQuery, completion: @escaping (Result<AssistantResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<AssistantResult>.jsonRequest(
                urlBuilder: DefaultURLBuilder(configuration: configuration, path: .Assistants.assistants.stringValue),
                body: query
            ),
            completion: completion
        )
    }

    public func assistantModify(query: AssistantsQuery, assistantId: String, completion: @escaping (Result<AssistantResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<AssistantsResult>.jsonRequest(
                urlBuilder: AssistantsURLBuilder(configuration: configuration, path: .assistantsModify, assistantId: assistantId),
                body: query
            ),
            completion: completion
        )
    }

    public func files(query: FilesQuery, completion: @escaping (Result<FilesResult, Error>) -> Void) {
        performRequest(
            request: AssistantsRequest<FilesResult>.multipartFormDataRequest(
                urlBuilder: DefaultURLBuilder(configuration: configuration, path: .Assistants.files.stringValue),
                body: query
            ),
            completion: completion
        )
    }
    // END UPDATES FROM 11-06-23

    public func completions(query: CompletionsQuery, completion: @escaping (Result<CompletionsResult, Error>) -> Void) {
        performRequest(request: JSONRequest<CompletionsResult>(body: query, url: buildURL(path: .completions)), completion: completion)
    }
    
    public func completionsStream(query: CompletionsQuery, onResult: @escaping (Result<CompletionsResult, Error>) -> Void, completion: ((Error?) -> Void)?) {
        performStreamingRequest(request: JSONRequest<CompletionsResult>(body: query.makeStreamable(), url: buildURL(path: .completions)), onResult: onResult, completion: completion)
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
        performStreamingRequest(request: JSONRequest<ChatStreamResult>(body: query.makeStreamable(), url: buildURL(path: .chats)), onResult: onResult, completion: completion)
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
    // 1106
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
    // 1106 end

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
