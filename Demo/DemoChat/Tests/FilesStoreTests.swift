import Combine
import Foundation
import Testing
import os
@testable import DemoChat
@testable import OpenAI

// Several tests hold requests in flight; a mistake there deadlocks the test, so fail it instead of waiting forever.
@MainActor
@Suite(.timeLimit(.minutes(1)))
struct FilesStoreTests {
    @Test
    func reloadListsFirstPageWithPurposeFilter() async throws {
        let endpoint = FakeFilesEndpoint(pages: [.page(["file-1", "file-2"], hasMore: true)])
        let store = FilesStore(client: endpoint)
        store.purposeFilter = .batch

        await store.reload()

        let query = try #require(endpoint.listQueries.first)
        #expect(query.purpose == "batch")
        #expect(query.limit == FilesStore.pageSize)
        #expect(query.after == nil)
        #expect(store.files.map(\.id) == ["file-1", "file-2"])
        #expect(store.hasMore)
    }

    @Test
    func loadMoreAppendsThePageAfterTheLastFile() async throws {
        let endpoint = FakeFilesEndpoint(pages: [
            .page(["file-1", "file-2"], hasMore: true),
            .page(["file-3"], hasMore: false),
        ])
        let store = FilesStore(client: endpoint)

        await store.reload()
        await store.loadMore()

        #expect(endpoint.listQueries.last?.after == "file-2")
        #expect(store.files.map(\.id) == ["file-1", "file-2", "file-3"])
        #expect(!store.hasMore)
    }

    @Test
    func uploadSendsTheFileAndExpiration() async throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("requests.json")
        try Data("{}".utf8).write(to: url)
        let endpoint = FakeFilesEndpoint(pages: [])
        let store = FilesStore(client: endpoint)

        let file = await store.upload(url: url, purpose: "batch", expiresAfterSeconds: 3600)

        let query = try #require(endpoint.createQueries.first)
        #expect(query.purpose == "batch")
        #expect(query.fileName == "requests.json")
        #expect(query.contentType == "application/json")
        #expect(query.file == Data("{}".utf8))
        #expect(query.expiresAfter?.seconds == 3600)
        #expect(store.files.map(\.id) == [try #require(file).id])
    }

    @Test
    func uploadCancelledBeforeSendingSendsNothing() async throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("cancelled.json")
        try Data("{}".utf8).write(to: url)
        let endpoint = FakeFilesEndpoint(pages: [])
        let store = FilesStore(client: endpoint)

        // Cancelled before it starts, so the cancellation is already there when the file has been read.
        let upload = Task { await store.upload(url: url, purpose: "batch", expiresAfterSeconds: nil) }
        upload.cancel()

        #expect(await upload.value == nil)
        #expect(endpoint.createQueries.isEmpty)
        #expect(store.error == nil)
        #expect(!store.isBusy)
    }

    @Test
    func uploadIsNotSentWhenTheClientChangesDuringTheRead() async throws {
        let oldEndpoint = FakeFilesEndpoint(pages: [])
        let newEndpoint = FakeFilesEndpoint(pages: [])
        let reader = HeldFileReader()
        let store = FilesStore(client: oldEndpoint, readFile: { _ in await reader.read() })

        let upload = Task {
            await store.upload(url: URL(filePath: "/switched.json"), purpose: "batch", expiresAfterSeconds: nil)
        }
        await waitUntil { reader.startedReads == 1 }
        store.client = newEndpoint
        reader.releaseReads()

        #expect(await upload.value == nil)
        #expect(oldEndpoint.createQueries.isEmpty)
        #expect(newEndpoint.createQueries.isEmpty)
        #expect(store.error == nil)
    }

    /// Goes through a real client and URLSession, so it checks that cancelling the task actually cancels the request.
    @Test
    func uploadCancelledWhileSendingCancelsTheRequest() async throws {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("sending.json")
        try Data("{}".utf8).write(to: url)
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [UnansweredURLProtocol.self]
        let client = OpenAI(configuration: .init(token: "test"), session: URLSession(configuration: configuration))
        let store = FilesStore(client: client.files)

        let upload = Task { await store.upload(url: url, purpose: "batch", expiresAfterSeconds: nil) }
        try await sleepUntil { UnansweredURLProtocol.state.withLock { $0.started } }
        upload.cancel()

        #expect(await upload.value == nil)
        try await sleepUntil { UnansweredURLProtocol.state.withLock { $0.stopped } }
        #expect(store.error == nil)
        #expect(!store.isBusy)
    }

    @Test
    func deleteRemovesTheFile() async throws {
        let endpoint = FakeFilesEndpoint(pages: [.page(["file-1", "file-2"], hasMore: false)])
        let store = FilesStore(client: endpoint)
        await store.reload()

        let deleted = await store.delete(id: "file-1")

        #expect(deleted)
        #expect(store.files.map(\.id) == ["file-2"])
    }

    @Test
    func reloadIsSkippedWhileALoadIsRunning() async throws {
        let endpoint = FakeFilesEndpoint(pages: [.page(["file-1"], hasMore: false)])
        endpoint.holdsRequests = true
        let store = FilesStore(client: endpoint)

        let firstReload = Task { await store.reload() }
        await waitUntil { endpoint.listQueries.count == 1 }
        #expect(store.isBusy)

        // In its own task, so that if it does call `list`, the test fails instead of waiting forever.
        let secondReload = Task { await store.reload() }
        await yieldRepeatedly()
        #expect(endpoint.listQueries.count == 1)

        endpoint.releaseRequests()
        await firstReload.value
        await secondReload.value
        #expect(store.files.map(\.id) == ["file-1"])
        #expect(!store.isBusy)
    }

    @Test
    func loadMoreIsSkippedWhileAReloadIsRunning() async throws {
        let endpoint = FakeFilesEndpoint(pages: [
            .page(["file-1"], hasMore: true),
            .page(["file-2"], hasMore: false),
        ])
        let store = FilesStore(client: endpoint)
        await store.reload()
        endpoint.holdsRequests = true

        let reload = Task { await store.reload() }
        await waitUntil { endpoint.listQueries.count == 2 }

        let loadMore = Task { await store.loadMore() }
        await yieldRepeatedly()
        #expect(endpoint.listQueries.count == 2)

        endpoint.releaseRequests()
        await reload.value
        await loadMore.value
        #expect(store.files.map(\.id) == ["file-2"])
    }

    @Test
    func deleteIsRefusedWhileAReloadIsRunning() async throws {
        let endpoint = FakeFilesEndpoint(pages: [
            .page(["file-1", "file-2"], hasMore: false),
            .page(["file-1", "file-2"], hasMore: false),
        ])
        let store = FilesStore(client: endpoint)
        await store.reload()
        endpoint.holdsRequests = true

        let reload = Task { await store.reload() }
        await waitUntil { endpoint.listQueries.count == 2 }

        // In its own task, so that if it does call the API, the test fails instead of waiting forever.
        let delete = Task { await store.delete(id: "file-1") }
        await yieldRepeatedly()
        #expect(endpoint.deletedIDs.isEmpty)

        endpoint.releaseRequests()
        await reload.value
        #expect(await delete.value == false)
        #expect(store.files.map(\.id) == ["file-1", "file-2"])
    }

    /// A reload started during a deletion could return the file before the server removes it, and bring it back.
    @Test
    func reloadIsSkippedWhileADeletionIsRunning() async throws {
        let endpoint = FakeFilesEndpoint(pages: [.page(["file-1", "file-2"], hasMore: false)])
        let store = FilesStore(client: endpoint)
        await store.reload()
        endpoint.holdsRequests = true

        let delete = Task { await store.delete(id: "file-1") }
        await waitUntil { endpoint.deletedIDs.count == 1 }

        let reload = Task { await store.reload() }
        await yieldRepeatedly()
        #expect(endpoint.listQueries.count == 1)

        endpoint.releaseRequests()
        _ = await delete.value
        await reload.value
        #expect(store.files.map(\.id) == ["file-2"])
    }

    @Test
    func loadMoreUsesTheLastRemainingFileAsTheCursor() async throws {
        let endpoint = FakeFilesEndpoint(pages: [
            .page(["file-1", "file-2"], hasMore: true),
            .page(["file-3"], hasMore: false),
        ])
        let store = FilesStore(client: endpoint)
        await store.reload()

        await store.delete(id: "file-2")
        await store.loadMore()

        #expect(endpoint.listQueries.last?.after == "file-1")
        #expect(store.files.map(\.id) == ["file-1", "file-3"])
    }

    @Test
    func loadMoreLoadsTheFirstPageWhenEveryLoadedFileWasDeleted() async throws {
        let endpoint = FakeFilesEndpoint(pages: [
            .page(["file-1", "file-2"], hasMore: true),
            .page(["file-3"], hasMore: false),
        ])
        let store = FilesStore(client: endpoint)
        await store.reload()

        await store.delete(id: "file-1")
        await store.delete(id: "file-2")
        await store.loadMore()

        #expect(endpoint.listQueries.count == 2)
        #expect(endpoint.listQueries.last?.after == nil)
        #expect(store.files.map(\.id) == ["file-3"])
    }

    /// The API configuration changed, possibly to another account, while a request to the old one was in flight.
    @Test
    func switchingTheClientClearsTheListAndIgnoresTheOldClientsResponses() async throws {
        let oldEndpoint = FakeFilesEndpoint(pages: [
            .page(["file-1"], hasMore: true),
            .page(["file-2"], hasMore: false),
        ])
        let store = FilesStore(client: oldEndpoint)
        await store.reload()
        oldEndpoint.holdsRequests = true
        let staleLoad = Task { await store.loadMore() }
        await waitUntil { oldEndpoint.listQueries.count == 2 }

        store.client = FakeFilesEndpoint(pages: [.page(["file-new"], hasMore: false)])
        #expect(store.files.isEmpty)
        #expect(!store.hasMore)
        #expect(!store.isBusy)

        await store.reload()
        #expect(store.files.map(\.id) == ["file-new"])

        oldEndpoint.releaseRequests()
        await staleLoad.value
        #expect(store.files.map(\.id) == ["file-new"])
        #expect(!store.isBusy)
    }

    @Test
    func failedReloadClearsTheList() async throws {
        let endpoint = FakeFilesEndpoint(pages: [.page(["file-1"], hasMore: true)])
        let store = FilesStore(client: endpoint)
        await store.reload()
        store.purposeFilter = .batchOutput

        await store.reload()

        #expect(store.error != nil)
        #expect(store.files.isEmpty)
        #expect(!store.hasMore)
    }

    @Test
    func failedRequestIsPublished() async throws {
        let endpoint = FakeFilesEndpoint(pages: [])
        let store = FilesStore(client: endpoint)

        await store.reload()

        #expect(store.error != nil)
        #expect(store.files.isEmpty)
    }
}

private struct NoMorePagesError: Error {}

/// Yields to other tasks until `condition` holds.
@MainActor
private func waitUntil(_ condition: () -> Bool) async {
    while !condition() {
        await Task.yield()
    }
}

/// Sleeps until `condition` holds, for state changed on another thread, such as URL loading.
@MainActor
private func sleepUntil(_ condition: () -> Bool) async throws {
    while !condition() {
        try await Task.sleep(for: .milliseconds(10))
    }
}

/// Stands in for reading the file to upload, and holds each read until `releaseReads()`, so a test can act while
/// one is in flight.
@MainActor
private final class HeldFileReader {
    private(set) var startedReads = 0
    private var heldReads: [CheckedContinuation<Void, Never>] = []

    func read() async -> Data {
        startedReads += 1
        await withCheckedContinuation { heldReads.append($0) }
        return Data("{}".utf8)
    }

    func releaseReads() {
        heldReads.forEach { $0.resume() }
        heldReads = []
    }
}

/// Receives requests and never answers them, like an upload that's still being sent. Records whether a request
/// started and whether URLSession stopped it.
private final class UnansweredURLProtocol: URLProtocol {
    static let state = OSAllocatedUnfairLock(initialState: (started: false, stopped: false))

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        Self.state.withLock { $0.started = true }
    }

    override func stopLoading() {
        Self.state.withLock { $0.stopped = true }
    }
}

/// Gives other tasks a chance to run, for checking that something does *not* happen.
@MainActor
private func yieldRepeatedly() async {
    for _ in 0..<20 {
        await Task.yield()
    }
}

private extension ListFilesResponse {
    static func page(_ ids: [String], hasMore: Bool) -> Self {
        .init(
            object: "list",
            data: ids.map(OpenAIFile.mock(id:)),
            firstId: ids.first ?? "",
            lastId: ids.last ?? "",
            hasMore: hasMore
        )
    }
}

private extension OpenAIFile {
    static func mock(id: String) -> Self {
        .init(
            id: id,
            bytes: 2,
            createdAt: 0,
            filename: "\(id).json",
            object: .file,
            purpose: .batch,
            status: .processed
        )
    }
}

/// Returns the given list pages in order, echoes uploads back as files, and records the requests it receives.
/// Main-actor isolated like the tests, so recording a request and holding it can't interleave with a test's checks.
@MainActor
private final class FakeFilesEndpoint: FilesEndpointProtocol {
    private var pages: [ListFilesResponse]
    private(set) var listQueries: [ListFilesQuery] = []
    private(set) var createQueries: [CreateFileQuery] = []
    private(set) var deletedIDs: [String] = []
    /// When set, `list` and `delete` wait until `releaseRequests()`, so a test can act while one is in flight.
    var holdsRequests = false
    private var heldRequests: [CheckedContinuation<Void, Never>] = []

    init(pages: [ListFilesResponse]) {
        self.pages = pages
    }

    /// Lets every held request continue.
    func releaseRequests() {
        heldRequests.forEach { $0.resume() }
        heldRequests = []
    }

    private func holdIfNeeded() async {
        if holdsRequests {
            await withCheckedContinuation { heldRequests.append($0) }
        }
    }

    func create(query: CreateFileQuery) async throws -> OpenAIFile {
        createQueries.append(query)
        return .mock(id: "file-uploaded")
    }

    func list(query: ListFilesQuery) async throws -> ListFilesResponse {
        listQueries.append(query)
        await holdIfNeeded()
        guard !pages.isEmpty else { throw NoMorePagesError() }
        return pages.removeFirst()
    }

    func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse {
        deletedIDs.append(id)
        await holdIfNeeded()
        return .init(id: id, object: .file, deleted: true)
    }

    func retrieve(id: String) async throws -> OpenAIFile { fatalError() }
    func content(id: String) async throws -> Data { fatalError() }

    nonisolated func create(query: CreateFileQuery) -> AnyPublisher<OpenAIFile, Error> { fatalError() }
    nonisolated func retrieve(id: String) -> AnyPublisher<OpenAIFile, Error> { fatalError() }
    nonisolated func list(query: ListFilesQuery) -> AnyPublisher<ListFilesResponse, Error> { fatalError() }
    nonisolated func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error> { fatalError() }
    nonisolated func content(id: String) -> AnyPublisher<Data, Error> { fatalError() }

    nonisolated func create(query: CreateFileQuery, completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void) -> CancellableRequest { fatalError() }
    nonisolated func retrieve(id: String, completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void) -> CancellableRequest { fatalError() }
    nonisolated func list(query: ListFilesQuery, completion: @escaping @Sendable (Result<ListFilesResponse, Error>) -> Void) -> CancellableRequest { fatalError() }
    nonisolated func delete(id: String, completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void) -> CancellableRequest { fatalError() }
    nonisolated func content(id: String, completion: @escaping @Sendable (Result<Data, Error>) -> Void) -> CancellableRequest { fatalError() }
}
