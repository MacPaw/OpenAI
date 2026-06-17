//
//  OpenAI+OpenAIAsync.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 31.01.2025.
//

import Foundation

extension OpenAI: OpenAIAsync {
    public func images(query: ImagesQuery) async throws -> ImagesResult {
        try await performRequestAsync(
            request: makeImagesRequest(query: query)
        )
    }
    
    public func imageEdits(query: ImageEditsQuery) async throws -> ImagesResult {
        try await performRequestAsync(
            request: makeImageEditsRequest(query: query)
        )
    }
    
    public func imageVariations(query: ImageVariationsQuery) async throws -> ImagesResult {
        try await performRequestAsync(
            request: makeImageVariationsRequest(query: query)
        )
    }
    
    public func embeddings(query: EmbeddingsQuery) async throws -> EmbeddingsResult {
        try await performRequestAsync(
            request: makeEmbeddingsRequest(query: query)
        )
    }
    
    public func chats(query: ChatQuery) async throws -> ChatResult {
        try await performRequestAsync(
            request: makeChatsRequest(query: query)
        )
    }
    
    public func chatsStream(query: ChatQuery) -> AsyncThrowingStream<ChatStreamResult, Error> {
        makeAsyncStream { onResult, completion in
            chatsStream(query: query, onResult: onResult, completion: completion)
        }
    }
    
    public func model(query: ModelQuery) async throws -> ModelResult {
        try await performRequestAsync(
            request: makeModelRequest(query: query)
        )
    }
    
    public func models() async throws -> ModelsResult {
        try await performRequestAsync(
            request: makeModelsRequest()
        )
    }
    
    public func moderations(query: ModerationsQuery) async throws -> ModerationsResult {
        try await performRequestAsync(
            request: makeModerationsRequest(query: query)
        )
    }
    
    public func audioCreateSpeech(query: AudioSpeechQuery) async throws -> AudioSpeechResult {
        try await performSpeechRequestAsync(
            request: makeAudioCreateSpeechRequest(query: query)
        )
    }
    
    public func audioCreateSpeechStream(
        query: AudioSpeechQuery
    ) -> AsyncThrowingStream<AudioSpeechResult, Error> {
        makeAsyncStream { onResult, completion in
            audioCreateSpeechStream(query: query, onResult: onResult, completion: completion)
        }
    }
    
    public func audioTranscriptions(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionResult {
        try await performRequestAsync(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    public func audioTranscriptionsVerbose(query: AudioTranscriptionQuery) async throws -> AudioTranscriptionVerboseResult {
        guard query.responseFormat == .verboseJson else {
            throw AudioTranscriptionError.invalidQuery(expectedResponseFormat: .verboseJson)
        }
        
        return try await performRequestAsync(
            request: makeAudioTranscriptionsRequest(query: query)
        )
    }
    
    public func audioTranscriptionStream(
        query: AudioTranscriptionQuery
    ) -> AsyncThrowingStream<AudioTranscriptionStreamResult, Error> {
        makeAsyncStream { onResult, completion in
            audioTranscriptionStream(query: query, onResult: onResult, completion: completion)
        }
    }
    
    public func audioTranslations(query: AudioTranslationQuery) async throws -> AudioTranslationResult {
        try await performRequestAsync(
            request: makeAudioTranslationsRequest(query: query)
        )
    }
    
    public func assistants() async throws -> AssistantsResult {
        try await assistants(after: nil)
    }
    
    public func assistants(after: String?) async throws -> AssistantsResult {
        try await performRequestAsync(
            request: makeAssistantsRequest(after)
        )
    }
    
    public func assistantCreate(query: AssistantsQuery) async throws -> AssistantResult {
        try await performRequestAsync(
            request: makeAssistantCreateRequest(query)
        )
    }
    
    public func assistantModify(query: AssistantsQuery, assistantId: String) async throws -> AssistantResult {
        try await performRequestAsync(
            request: makeAssistantModifyRequest(assistantId, query)
        )
    }
    
    public func threads(query: ThreadsQuery) async throws -> ThreadsResult {
        try await performRequestAsync(
            request: makeThreadsRequest(query)
        )
    }
    
    public func threadRun(query: ThreadRunQuery) async throws -> RunResult {
        try await performRequestAsync(
            request: makeThreadRunRequest(query)
        )
    }
    
    public func runs(threadId: String,query: RunsQuery) async throws -> RunResult {
        try await performRequestAsync(
            request: makeRunsRequest(threadId, query)
        )
    }
    
    public func runRetrieve(threadId: String, runId: String) async throws -> RunResult {
        try await performRequestAsync(
            request: makeRunRetrieveRequest(threadId, runId)
        )
    }
    
    public func runRetrieveSteps(threadId: String, runId: String) async throws -> RunRetrieveStepsResult {
        try await runRetrieveSteps(threadId: threadId, runId: runId, before: nil)
    }
    
    public func runRetrieveSteps(threadId: String, runId: String, before: String?) async throws -> RunRetrieveStepsResult {
        try await performRequestAsync(
            request: makeRunRetrieveStepsRequest(threadId, runId, before)
        )
    }
    
    public func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery) async throws -> RunResult {
        try await performRequestAsync(
            request: makeRunSubmitToolOutputsRequest(threadId, runId, query)
        )
    }
    
    public func threadsMessages(threadId: String) async throws -> ThreadsMessagesResult {
        try await performRequestAsync(
            request: makeThreadsMessagesRequest(threadId, before: nil)
        )
    }
    
    public func threadsMessages(threadId: String, before: String?) async throws -> ThreadsMessagesResult {
        try await performRequestAsync(
            request: makeThreadsMessagesRequest(threadId, before: before)
        )
    }
    
    public func threadsAddMessage(threadId: String, query: MessageQuery) async throws -> ThreadAddMessageResult {
        try await performRequestAsync(
            request: makeThreadsAddMessageRequest(threadId, query)
        )
    }
    
    public func files(query: FilesQuery) async throws -> FilesResult {
        try await performRequestAsync(
            request: makeFilesRequest(query: query)
        )
    }

    public func retrieveFileContent(id: String) async throws -> Data {
        try await performRawDataRequestAsync(
            request: makeFileContentRequest(id: id)
        )
    }

    public func deleteFile(id: String) async throws -> FileDeleteResult {
        try await performRequestAsync(
            request: makeFileDeleteRequest(id: id)
        )
    }

    // MARK: - Batch API

    public func createBatch(query: BatchQuery) async throws -> BatchResult {
        try await performRequestAsync(
            request: makeBatchCreateRequest(query: query)
        )
    }

    public func retrieveBatch(id: String) async throws -> BatchResult {
        try await performRequestAsync(
            request: makeBatchRetrieveRequest(id: id)
        )
    }

    public func listBatches(after: String? = nil, limit: Int = 20) async throws -> BatchListResult {
        try await performRequestAsync(
            request: makeBatchListRequest(after: after, limit: limit)
        )
    }

    public func cancelBatch(id: String) async throws -> BatchResult {
        try await performRequestAsync(
            request: makeBatchCancelRequest(id: id)
        )
    }

    // MARK: - Batch API Convenience Methods

    /// Submits a batch of chat requests for async processing.
    /// Handles JSONL encoding, file upload, and batch creation.
    ///
    /// - Parameters:
    ///   - requests: Array of batch request lines to process
    ///   - fileName: Name for the uploaded JSONL file
    ///   - endpoint: The API endpoint for batch requests (default: chat completions)
    ///   - metadata: Optional metadata to attach to the batch
    /// - Returns: The created batch result with ID for tracking
    public func submitBatch(
        requests: [BatchRequestLine],
        fileName: String,
        endpoint: BatchEndpoint = .chatCompletions,
        metadata: [String: String]? = nil
    ) async throws -> BatchResult {
        // Step 1: Encode requests to JSONL
        let encoder = JSONEncoder()
        let jsonlData = try requests.map { request -> String in
            let data = try encoder.encode(request)
            return String(data: data, encoding: .utf8)!
        }.joined(separator: "\n")

        // Step 2: Upload file
        let fileData = jsonlData.data(using: .utf8)!
        let fileQuery = FilesQuery(
            purpose: "batch",
            file: fileData,
            fileName: fileName,
            contentType: "application/jsonl"
        )
        let fileResult = try await files(query: fileQuery)

        // Step 3: Create batch
        let batchQuery = BatchQuery(
            inputFileId: fileResult.id,
            endpoint: endpoint,
            metadata: metadata
        )
        return try await createBatch(query: batchQuery)
    }

    /// Waits for a batch to complete and returns the parsed responses.
    /// Polls the batch status until completion, then downloads and parses results.
    ///
    /// - Parameters:
    ///   - batchId: The batch ID to wait for
    ///   - pollingInterval: Time between status checks (default 5 seconds)
    ///   - timeout: Maximum time to wait (default 24 hours)
    /// - Returns: Array of parsed batch response lines
    /// - Throws: Error if batch fails, expires, or is cancelled
    public func waitForBatch(
        id batchId: String,
        pollingInterval: TimeInterval = 5.0,
        timeout: TimeInterval = 86400
    ) async throws -> [BatchResponseLine] {
        let startTime = Date()

        // Step 4: Poll for completion
        var batch = try await retrieveBatch(id: batchId)
        while batch.status != .completed &&
              batch.status != .failed &&
              batch.status != .expired &&
              batch.status != .cancelled &&
              batch.status != .cancelling {

            if Date().timeIntervalSince(startTime) > timeout {
                throw BatchError.timeout(batchId: batchId, lastStatus: batch.status)
            }

            try await Task.sleep(nanoseconds: UInt64(pollingInterval * 1_000_000_000))
            batch = try await retrieveBatch(id: batchId)
        }

        // Check for failure states
        guard batch.status == .completed else {
            throw BatchError.batchFailed(batchId: batchId, status: batch.status)
        }

        // Step 5: Download output file
        guard let outputFileId = batch.outputFileId else {
            throw BatchError.noOutputFile(batchId: batchId)
        }

        let outputData = try await retrieveFileContent(id: outputFileId)
        guard let outputString = String(data: outputData, encoding: .utf8) else {
            throw BatchError.invalidOutputData(batchId: batchId)
        }

        // Step 6: Parse JSONL responses
        let decoder = JSONDecoder()
        let lines = outputString.split(separator: "\n")
        return try lines.map { line in
            let lineData = line.data(using: .utf8)!
            return try decoder.decode(BatchResponseLine.self, from: lineData)
        }
    }

    func performRequestAsync<ResultType: Codable & Sendable>(request: any URLRequestBuildable) async throws -> ResultType {
        try await asyncClient.performRequest(request: request)
    }
    
    func performSpeechRequestAsync(request: any URLRequestBuildable) async throws -> AudioSpeechResult {
        try await asyncClient.performSpeechRequest(request: request)
    }

    func performRawDataRequestAsync(request: any URLRequestBuildable) async throws -> Data {
        try await asyncClient.performRawDataRequest(request: request)
    }
    
    func makeAsyncStream<ResultType: Codable & Sendable>(
        byWrapping call: (_ onResult: @escaping @Sendable (Result<ResultType, Error>) -> Void, _ completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest
    ) -> AsyncThrowingStream<ResultType, Error> {
        return AsyncThrowingStream { continuation in

            let resultClosure: @Sendable (Result<ResultType, Error>) -> Void = {
                continuation.yield(with: $0)
            }
            
            let completionClosure: @Sendable (Error?) -> Void = {
                continuation.finish(throwing: $0)
            }
            
            let cancellableRequest = call(resultClosure, completionClosure)
            
            continuation.onTermination = { termination in
                switch termination {
                case .cancelled:
                    cancellableRequest.cancelRequest()
                case .finished:
                    break
                @unknown default:
                    break
                }
            }
        }
    }
}
