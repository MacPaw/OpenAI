//
//  FilesStore.swift
//  DemoChat
//

import Foundation
import OpenAI
import UniformTypeIdentifiers

/// Backs the Files screens: lists, uploads, retrieves, downloads and deletes files through `openAI.files`.
///
/// A failed request throws its error, so the screen that made the request shows it. A cancelled request, or one
/// for a client that has since been replaced, returns without throwing: neither is a failure to report.
@MainActor
public final class FilesStore: ObservableObject {
    /// Upload purposes accepted by the API.
    static let uploadPurposes = ["assistants", "batch", "fine-tune", "vision", "user_data", "evals"]

    /// Purposes a listed file can have, for filtering the list.
    static let listPurposes: [OpenAIFile.Purpose] = [
        .assistants, .assistantsOutput, .batch, .batchOutput, .fineTune, .fineTuneResults, .vision, .userData, .evals
    ]

    static let pageSize = 20

    /// Set when the API configuration changes. The new client may use another API key, and so another account, so
    /// this drops everything the previous client loaded and lets requests start right away.
    public var client: FilesEndpointProtocol {
        didSet {
            generation += 1
            files = []
            hasMore = false
            isBusy = false
        }
    }

    /// Changes with `client`. A request publishes its result only if this hasn't changed since it started, so a
    /// response for the previous client can't show up after the switch.
    private var generation = 0

    @Published private(set) var files: [OpenAIFile] = []
    @Published private(set) var hasMore = false
    /// Whether a request that changes `files` (list, upload or deletion) is in flight. Only one runs at a time, so
    /// a list response can't overwrite a newer one or undo an upload or deletion; the others are skipped meanwhile.
    /// The UI disables the controls that start them while busy.
    @Published private(set) var isBusy = false
    @Published var purposeFilter: OpenAIFile.Purpose? = nil

    /// Reads the file to upload. Tests replace it to hold a read in flight.
    private let readFile: @Sendable (URL) async throws -> Data

    public convenience init(client: FilesEndpointProtocol) {
        self.init(client: client, readFile: Self.readOffMainActor)
    }

    init(client: FilesEndpointProtocol, readFile: @escaping @Sendable (URL) async throws -> Data) {
        self.client = client
        self.readFile = readFile
    }

    /// Loads the first page of files for the current purpose filter. Does nothing while busy.
    func reload() async throws {
        try await load(after: nil)
    }

    /// Appends the next page, if there is one. Does nothing while busy.
    func loadMore() async throws {
        guard hasMore else { return }
        // The cursor is the last loaded file that still exists: the API rejects a deleted file as `after` (404).
        // With every loaded file deleted, the remaining ones are the first page.
        try await load(after: files.last?.id)
    }

    private func load(after: String?) async throws {
        guard !isBusy else { return }
        isBusy = true
        let generation = generation
        defer { finishRequest(generation) }
        do {
            let page = try await client.list(query: .init(
                purpose: purposeFilter?.rawValue,
                limit: Self.pageSize,
                after: after
            ))
            guard isCurrent(generation) else { return }
            files = after == nil ? page.data : files + page.data
            hasMore = page.hasMore
        } catch {
            // Leaving the Files screen cancels its reload, which isn't a failure to report.
            guard isCurrent(generation), !Self.isCancellation(error) else { return }
            if after == nil {
                // Don't keep showing files that may not match the current filter.
                files = []
                hasMore = false
            }
            throw error
        }
    }

    /// Uploads the file at `url`, which may be security-scoped (as returned by a file importer).
    ///
    /// Cancelling the calling task stops the upload: before anything is sent if the file is still being read,
    /// otherwise by cancelling the request. A cancelled upload returns `nil` instead of throwing. If the request was
    /// already sent in full, the file may still be created.
    @discardableResult
    func upload(url: URL, purpose: String, expiresAfterSeconds: Int64?) async throws -> OpenAIFile? {
        guard !isBusy else { return nil }
        isBusy = true
        let generation = generation
        defer { finishRequest(generation) }
        do {
            let data = try await readFile(url)
            // The read doesn't see this task's cancellation, so check for it before sending.
            try Task.checkCancellation()
            // The client may have been replaced during the read; don't send the file to the new one.
            guard isCurrent(generation) else { return nil }
            let contentType = UTType(filenameExtension: url.pathExtension)?.preferredMIMEType
                ?? "application/octet-stream"
            let file = try await client.create(query: CreateFileQuery(
                purpose: purpose,
                file: data,
                fileName: url.lastPathComponent,
                contentType: contentType,
                expiresAfter: expiresAfterSeconds.map { .init(anchor: .createdAt, seconds: $0) }
            ))
            guard isCurrent(generation) else { return nil }
            if purposeFilter == nil || purposeFilter == file.purpose {
                files.insert(file, at: 0)
            }
            return file
        } catch {
            guard isCurrent(generation), !Self.isCancellation(error) else { return nil }
            throw error
        }
    }

    /// Fetches the file again and updates it in the list.
    func retrieve(id: String) async throws -> OpenAIFile? {
        let generation = generation
        do {
            let file = try await client.retrieve(id: id)
            guard isCurrent(generation) else { return nil }
            if let index = files.firstIndex(where: { $0.id == id }) {
                files[index] = file
            }
            return file
        } catch {
            guard isCurrent(generation) else { return nil }
            throw error
        }
    }

    func content(id: String) async throws -> Data? {
        let generation = generation
        do {
            let data = try await client.content(id: id)
            return isCurrent(generation) ? data : nil
        } catch {
            guard isCurrent(generation) else { return nil }
            throw error
        }
    }

    /// Deletes the file and removes it from the list. Returns whether the API reported it as deleted.
    @discardableResult
    func delete(id: String) async throws -> Bool {
        guard !isBusy else { return false }
        isBusy = true
        let generation = generation
        defer { finishRequest(generation) }
        do {
            let result = try await client.delete(id: id)
            guard isCurrent(generation) else { return false }
            if result.deleted {
                files.removeAll { $0.id == id }
            }
            return result.deleted
        } catch {
            guard isCurrent(generation) else { return false }
            throw error
        }
    }

    private func isCurrent(_ generation: Int) -> Bool {
        generation == self.generation
    }

    /// Ends a list, upload or deletion. A request for the previous client leaves `isBusy` alone: the client switch
    /// already reset it, and a request for the new client may be running.
    private func finishRequest(_ generation: Int) {
        if isCurrent(generation) {
            isBusy = false
        }
    }

    /// Whether `error` comes from cancelling the task: `CancellationError` from a cancellation check, or
    /// `URLError.cancelled` from URLSession cancelling the request.
    private static func isCancellation(_ error: Error) -> Bool {
        error is CancellationError || (error as? URLError)?.code == .cancelled
    }

    /// Reads the file off the main actor: it can be up to 512 MB, and reading it there would freeze the UI.
    private nonisolated static func readOffMainActor(_ url: URL) async throws -> Data {
        try await Task.detached { try readSecurityScopedFile(at: url) }.value
    }

    private nonisolated static func readSecurityScopedFile(at url: URL) throws -> Data {
        let isAccessing = url.startAccessingSecurityScopedResource()
        defer {
            if isAccessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        return try Data(contentsOf: url)
    }
}
