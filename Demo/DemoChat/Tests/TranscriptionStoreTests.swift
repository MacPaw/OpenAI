import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import OpenAI
import Testing
@testable import DemoChat

@Test(arguments: AudioTranscriptionQuery.FileType.allCases)
func selectedAudioAcceptsSDKFormats(fileType: AudioTranscriptionQuery.FileType) throws {
    let audio = try SelectedAudio(name: "recording.\(fileType.rawValue.uppercased())", data: Data([1]))
    #expect(audio.fileType == fileType)
    #expect(audio.data == Data([1]))
}

@Test(arguments: ["recording", "recording.txt", "recording.mp3.txt"])
func selectedAudioRejectsUnsupportedFormats(name: String) {
    #expect(throws: AudioImportError.unsupportedFormat) {
        try SelectedAudio(name: name, data: Data([1]))
    }
}

@Test func selectedAudioRejectsEmptyFiles() {
    #expect(throws: AudioImportError.emptyFile) {
        try SelectedAudio(name: "recording.wav", data: Data())
    }
}

@Test func selectedAudioEnforcesExactSizeLimit() throws {
    let audio = try SelectedAudio(name: "recording.mp3", data: Data(count: SelectedAudio.maximumBytes))
    #expect(audio.data.count == 25_000_000)
    #expect(throws: AudioImportError.tooLarge) {
        try SelectedAudio(name: "recording.mp3", data: Data(count: SelectedAudio.maximumBytes + 1))
    }
}

@Test func audioLoaderReadsLocalFilesAndRejectsInvalidInputs() async throws {
    let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    defer { try? FileManager.default.removeItem(at: directory) }

    let url = directory.appendingPathComponent("recording.MPGA")
    let bytes = Data([1, 2, 3, 4])
    try bytes.write(to: url)
    let audio = try await TranscriptionStore.loadAudio(from: url)
    #expect(audio.name == "recording.MPGA")
    #expect(audio.data == bytes)
    #expect(audio.fileType == .mpga)

    let emptyURL = directory.appendingPathComponent("empty.wav")
    try Data().write(to: emptyURL)
    await #expect(throws: AudioImportError.emptyFile) {
        try await TranscriptionStore.loadAudio(from: emptyURL)
    }

    let folderURL = directory.appendingPathComponent("folder.mp3")
    try FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
    await #expect(throws: AudioImportError.notRegularFile) {
        try await TranscriptionStore.loadAudio(from: folderURL)
    }

    let largeURL = directory.appendingPathComponent("large.wav")
    try Data().write(to: largeURL)
    let file = try FileHandle(forWritingTo: largeURL)
    try file.truncate(atOffset: UInt64(SelectedAudio.maximumBytes + 1))
    try file.close()
    await #expect(throws: AudioImportError.tooLarge) {
        try await TranscriptionStore.loadAudio(from: largeURL)
    }

    await #expect(throws: (any Error).self) {
        try await TranscriptionStore.loadAudio(from: directory.appendingPathComponent("missing.wav"))
    }
}

@MainActor
@Test func transcriptionBuildsExpectedQueryAndPublishesResult() async throws {
    let store = try await loadedTranscriptionStore(name: "recording.mpga")
    let recorder = TranscriptionQueryRecorder()
    store.model = " custom-transcription-model \n"
    store.language = " en \n"
    store.prompt = " Technical vocabulary. \n"

    await store.transcribe { query in
        await recorder.record(query)
        return "The transcript."
    }

    let queries = await recorder.queries
    let query = try #require(queries.first)
    #expect(queries.count == 1)
    #expect(query.file == Data([1, 2, 3]))
    #expect(query.fileType == .mpga)
    #expect(query.model == "custom-transcription-model")
    #expect(query.language == "en")
    #expect(query.prompt == "Technical vocabulary.")
    #expect(query.responseFormat == .json)
    #expect(query.stream == false)
    #expect(query.temperature == nil)
    #expect(store.transcript == "The transcript.")
    #expect(store.errorMessage == nil)
    #expect(!store.isTranscribing)
}

@MainActor
@Test func transcriptionOmitsBlankOptionsAndUsesDefaultModel() async throws {
    let store = try await loadedTranscriptionStore()
    store.language = " \n"
    store.prompt = "\t"
    let recorder = TranscriptionQueryRecorder()
    await store.transcribe { query in
        await recorder.record(query)
        return "Text"
    }
    let query = try #require(await recorder.queries.first)
    #expect(query.model == Model.whisper_1)
    #expect(query.language == nil)
    #expect(query.prompt == nil)
}

@MainActor
@Test func transcriptionRequiresFileAndModelBeforeCallingProvider() async throws {
    let store = TranscriptionStore()
    let recorder = TranscriptionQueryRecorder()
    await store.transcribe { query in
        await recorder.record(query)
        return "Unexpected"
    }
    #expect(store.errorMessage == "Choose an audio file first.")

    let loadedStore = try await loadedTranscriptionStore()
    loadedStore.model = " \n"
    await loadedStore.transcribe { query in
        await recorder.record(query)
        return "Unexpected"
    }
    #expect(loadedStore.errorMessage == "Enter a transcription model.")
    #expect(await recorder.queries.isEmpty)
}

@MainActor
@Test func transcriptionFailureCanBeRetried() async throws {
    let store = try await loadedTranscriptionStore()
    await store.transcribe { _ in "Previous transcript" }
    await store.transcribe { _ in throw TranscriptionTestError.failed }
    #expect(store.errorMessage == "Test request failed.")
    #expect(store.transcript.isEmpty)
    #expect(!store.isTranscribing)
    #expect(store.selectedAudio != nil)

    await store.transcribe { _ in "Retried transcript" }
    #expect(store.transcript == "Retried transcript")
    #expect(store.errorMessage == nil)
}

@MainActor
@Test(arguments: ["", " \n\t"])
func transcriptionReportsEmptyResponses(text: String) async throws {
    let store = try await loadedTranscriptionStore()
    await store.transcribe { _ in text }
    #expect(store.transcript.isEmpty)
    #expect(store.errorMessage == "No speech was detected in this recording.")
    #expect(!store.isTranscribing)
}

@MainActor
@Test func transcriptionIgnoresDuplicateSubmissions() async throws {
    let store = try await loadedTranscriptionStore()
    let gate = SuspendedTranscriptionOperation<String>()
    let recorder = TranscriptionQueryRecorder()
    let first = Task {
        await store.transcribe { query in
            await recorder.record(query)
            return try await gate.run()
        }
    }
    await gate.waitUntilStarted()
    #expect(store.isTranscribing)
    await store.transcribe { query in
        await recorder.record(query)
        return "Duplicate"
    }
    #expect(await recorder.queries.count == 1)
    await gate.finish(.success("First"))
    await first.value
    #expect(store.transcript == "First")
}

@MainActor
@Test func cancelCancelsWorkerAndIgnoresLateResult() async throws {
    let store = try await loadedTranscriptionStore()
    let gate = SuspendedTranscriptionOperation<String>()
    let operation = Task {
        await store.transcribe { _ in try await gate.run() }
    }
    await gate.waitUntilStarted()
    store.cancel()
    #expect(!store.isTranscribing)
    #expect(store.selectedAudio != nil)
    await gate.finish(.success("Too late"))
    await operation.value
    #expect(await gate.wasCancelled)
    #expect(store.transcript.isEmpty)
    #expect(store.errorMessage == nil)
}

@MainActor
@Test func callerCancellationReachesWorker() async throws {
    let store = try await loadedTranscriptionStore()
    let gate = SuspendedTranscriptionOperation<String>()
    let operation = Task {
        await store.transcribe { _ in try await gate.run() }
    }
    await gate.waitUntilStarted()
    operation.cancel()
    await gate.finish(.success("Too late"))
    await operation.value
    #expect(await gate.wasCancelled)
    #expect(!store.isTranscribing)
    #expect(store.transcript.isEmpty)
    #expect(store.errorMessage == nil)
}

@MainActor
@Test func lateFailureCannotOverwriteNewRequestState() async throws {
    let store = try await loadedTranscriptionStore()
    let oldGate = SuspendedTranscriptionOperation<String>()
    let newGate = SuspendedTranscriptionOperation<String>()
    let old = Task { await store.transcribe { _ in try await oldGate.run() } }
    await oldGate.waitUntilStarted()
    store.cancel()
    let current = Task { await store.transcribe { _ in try await newGate.run() } }
    await newGate.waitUntilStarted()
    await oldGate.finish(.failure(TranscriptionTestError.failed))
    await old.value
    #expect(store.isTranscribing)
    #expect(store.errorMessage == nil)
    await newGate.finish(.success("Current"))
    await current.value
    #expect(store.transcript == "Current")
}

@MainActor
@Test func importingReplacementCancelsRequestAndClearsTranscript() async throws {
    let store = try await loadedTranscriptionStore()
    await store.transcribe { _ in "Previous" }
    let gate = SuspendedTranscriptionOperation<String>()
    let request = Task { await store.transcribe { _ in try await gate.run() } }
    await gate.waitUntilStarted()
    await store.importAudio(from: URL(fileURLWithPath: "/replacement.mp3"))
    await gate.finish(.success("Stale"))
    await request.value
    #expect(await gate.wasCancelled)
    #expect(store.transcript.isEmpty)
    #expect(!store.isTranscribing)
    #expect(!store.isLoading)
}

@MainActor
@Test func failedImportClearsPreviousAudioAndPreventsStaleUpload() async throws {
    let audio = try SelectedAudio(name: "first.mp3", data: Data([1]))
    let store = TranscriptionStore { url in
        if url.lastPathComponent == "first.mp3" { return audio }
        throw TranscriptionTestError.failed
    }
    await store.importAudio(from: URL(fileURLWithPath: "/first.mp3"))
    await store.transcribe { _ in "Previous" }
    await store.importAudio(from: URL(fileURLWithPath: "/missing.mp3"))
    #expect(store.selectedAudio == nil)
    #expect(store.transcript.isEmpty)
    #expect(store.errorMessage == "Test request failed.")
    let recorder = TranscriptionQueryRecorder()
    await store.transcribe { query in
        await recorder.record(query)
        return "Unexpected"
    }
    #expect(await recorder.queries.isEmpty)
}

@MainActor
@Test func clearingAudioRemovesPreviousResultAndSelection() async throws {
    let store = try await loadedTranscriptionStore()
    await store.transcribe { _ in "Previous transcript" }
    store.errorMessage = "Picker error"
    store.clearAudio()
    #expect(store.selectedAudio == nil)
    #expect(store.transcript.isEmpty)
    #expect(store.errorMessage == nil)
    #expect(!store.isLoading)
    #expect(!store.isTranscribing)
}

@MainActor
@Test func staleImportCannotReplaceNewSelection() async throws {
    let oldAudio = try SelectedAudio(name: "old.mp3", data: Data([1]))
    let newAudio = try SelectedAudio(name: "new.wav", data: Data([2]))
    let gate = SuspendedTranscriptionOperation<SelectedAudio>()
    let store = TranscriptionStore { url in
        if url.lastPathComponent == "old.mp3" { return try await gate.run() }
        return newAudio
    }
    let old = Task { await store.importAudio(from: URL(fileURLWithPath: "/old.mp3")) }
    await gate.waitUntilStarted()
    #expect(store.isLoading)
    #expect(store.selectedAudio == nil)
    await store.importAudio(from: URL(fileURLWithPath: "/new.wav"))
    await gate.finish(.success(oldAudio))
    await old.value
    #expect(await gate.wasCancelled)
    #expect(store.selectedAudio == newAudio)
    #expect(!store.isLoading)
    #expect(store.errorMessage == nil)
}

@MainActor
@Test func loadingPreventsTranscriptionAndCanBeCancelled() async throws {
    let audio = try SelectedAudio(name: "recording.mp3", data: Data([1]))
    let gate = SuspendedTranscriptionOperation<SelectedAudio>()
    let store = TranscriptionStore { _ in try await gate.run() }
    let loading = Task { await store.importAudio(from: URL(fileURLWithPath: "/recording.mp3")) }
    await gate.waitUntilStarted()
    let recorder = TranscriptionQueryRecorder()
    await store.transcribe { query in
        await recorder.record(query)
        return "Unexpected"
    }
    #expect(await recorder.queries.isEmpty)
    store.cancel()
    await gate.finish(.success(audio))
    await loading.value
    #expect(await gate.wasCancelled)
    #expect(store.selectedAudio == nil)
    #expect(!store.isLoading)
    #expect(store.errorMessage == nil)
}

@MainActor
@Test func transcriptionUsesClientProvidedAtEachSubmission() async throws {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [TranscriptionURLProtocol.self]
    let session = URLSession(configuration: configuration)
    defer { session.invalidateAndCancel() }
    let first = OpenAI(
        configuration: .init(token: "first-test-token", host: "first.example", basePath: "/v1"),
        session: session
    )
    let second = OpenAI(
        configuration: .init(token: "second-test-token", host: "second.example", basePath: "/custom"),
        session: session
    )
    let store = try await loadedTranscriptionStore()
    await store.transcribe(using: first)
    #expect(store.transcript == "first.example/v1/audio/transcriptions|Bearer first-test-token")
    await store.transcribe(using: second)
    #expect(store.transcript == "second.example/custom/audio/transcriptions|Bearer second-test-token")
    #expect(store.errorMessage == nil)
}

@MainActor
private func loadedTranscriptionStore(name: String = "recording.mp3") async throws -> TranscriptionStore {
    let audio = try SelectedAudio(name: name, data: Data([1, 2, 3]))
    let store = TranscriptionStore { _ in audio }
    await store.importAudio(from: URL(fileURLWithPath: "/\(name)"))
    return store
}

private enum TranscriptionTestError: LocalizedError {
    case failed
    var errorDescription: String? { "Test request failed." }
}

private actor TranscriptionQueryRecorder {
    private(set) var queries: [AudioTranscriptionQuery] = []
    func record(_ query: AudioTranscriptionQuery) { queries.append(query) }
}

private actor SuspendedTranscriptionOperation<Value: Sendable> {
    private var continuation: CheckedContinuation<Value, Error>?
    private var started = false
    private var startWaiters: [CheckedContinuation<Void, Never>] = []
    private(set) var wasCancelled = false

    func run() async throws -> Value {
        started = true
        startWaiters.forEach { $0.resume() }
        startWaiters.removeAll()
        defer { wasCancelled = Task.isCancelled }
        return try await withCheckedThrowingContinuation { continuation = $0 }
    }

    func waitUntilStarted() async {
        if started { return }
        await withCheckedContinuation { startWaiters.append($0) }
    }

    func finish(_ result: Result<Value, Error>) {
        continuation?.resume(with: result)
        continuation = nil
    }
}

private final class TranscriptionURLProtocol: URLProtocol, @unchecked Sendable {
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let url = request.url,
              let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        let text = "\(url.host ?? "")\(url.path)|\(request.value(forHTTPHeaderField: "Authorization") ?? "")"
        do {
            let data = try JSONSerialization.data(withJSONObject: ["text": text])
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
