import Combine
import Foundation
import Testing
@testable import DemoChat
@testable import OpenAI

@MainActor
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
    func deleteRemovesTheFile() async throws {
        let endpoint = FakeFilesEndpoint(pages: [.page(["file-1", "file-2"], hasMore: false)])
        let store = FilesStore(client: endpoint)
        await store.reload()

        let deleted = await store.delete(id: "file-1")

        #expect(deleted)
        #expect(store.files.map(\.id) == ["file-2"])
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

/// Returns the given list pages in order, echoes uploads back as files, and records the queries it receives.
private final class FakeFilesEndpoint: FilesEndpointProtocol, @unchecked Sendable {
    private var pages: [ListFilesResponse]
    private(set) var listQueries: [ListFilesQuery] = []
    private(set) var createQueries: [CreateFileQuery] = []

    init(pages: [ListFilesResponse]) {
        self.pages = pages
    }

    func create(query: CreateFileQuery) async throws -> OpenAIFile {
        createQueries.append(query)
        return .mock(id: "file-uploaded")
    }

    func list(query: ListFilesQuery) async throws -> ListFilesResponse {
        listQueries.append(query)
        guard !pages.isEmpty else { throw NoMorePagesError() }
        return pages.removeFirst()
    }

    func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse {
        .init(id: id, object: .file, deleted: true)
    }

    func retrieve(id: String) async throws -> OpenAIFile { fatalError() }
    func content(id: String) async throws -> Data { fatalError() }

    func create(query: CreateFileQuery) -> AnyPublisher<OpenAIFile, Error> { fatalError() }
    func retrieve(id: String) -> AnyPublisher<OpenAIFile, Error> { fatalError() }
    func list(query: ListFilesQuery) -> AnyPublisher<ListFilesResponse, Error> { fatalError() }
    func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error> { fatalError() }
    func content(id: String) -> AnyPublisher<Data, Error> { fatalError() }

    func create(query: CreateFileQuery, completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void) -> CancellableRequest { fatalError() }
    func retrieve(id: String, completion: @escaping @Sendable (Result<OpenAIFile, Error>) -> Void) -> CancellableRequest { fatalError() }
    func list(query: ListFilesQuery, completion: @escaping @Sendable (Result<ListFilesResponse, Error>) -> Void) -> CancellableRequest { fatalError() }
    func delete(id: String, completion: @escaping @Sendable (Result<Components.Schemas.DeleteFileResponse, Error>) -> Void) -> CancellableRequest { fatalError() }
    func content(id: String, completion: @escaping @Sendable (Result<Data, Error>) -> Void) -> CancellableRequest { fatalError() }
}
