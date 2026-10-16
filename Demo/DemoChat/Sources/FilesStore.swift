//
//  FilesStore.swift
//  DemoChat
//

import Foundation
import OpenAI
import UniformTypeIdentifiers

/// Backs the Files screens: lists, uploads, retrieves, downloads and deletes files through `openAI.files`.
@MainActor
public final class FilesStore: ObservableObject {
    /// Upload purposes accepted by the API.
    static let uploadPurposes = ["assistants", "batch", "fine-tune", "vision", "user_data", "evals"]

    /// Purposes a listed file can have, for filtering the list.
    static let listPurposes: [OpenAIFile.Purpose] = [
        .assistants, .assistantsOutput, .batch, .batchOutput, .fineTune, .fineTuneResults, .vision, .userData, .evals
    ]

    static let pageSize = 20

    var client: FilesEndpointProtocol

    @Published private(set) var files: [OpenAIFile] = []
    @Published private(set) var hasMore = false
    /// A list request is in flight. Uploads and deletions are refused meanwhile, so the response can't undo them.
    @Published private(set) var isLoading = false
    /// An upload or deletion is in flight. List requests are skipped meanwhile, for the same reason.
    @Published private(set) var isChanging = false
    @Published var purposeFilter: OpenAIFile.Purpose? = nil
    @Published var error: Error?

    public init(client: FilesEndpointProtocol) {
        self.client = client
    }

    /// Whether any request that changes `files` is in flight. Only one runs at a time, so a list response can't
    /// overwrite a newer one or undo an upload or deletion. The UI disables the controls that start them meanwhile.
    var isBusy: Bool {
        isLoading || isChanging
    }

    /// Loads the first page of files for the current purpose filter. Does nothing while busy.
    func reload() async {
        await load(after: nil)
    }

    /// Appends the next page, if there is one. Does nothing while busy.
    func loadMore() async {
        guard hasMore else { return }
        // The cursor is the last loaded file that still exists: the API rejects a deleted file as `after` (404).
        // With every loaded file deleted, the remaining ones are the first page.
        await load(after: files.last?.id)
    }

    private func load(after: String?) async {
        guard !isBusy else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let page = try await client.list(query: .init(
                purpose: purposeFilter?.rawValue,
                limit: Self.pageSize,
                after: after
            ))
            files = after == nil ? page.data : files + page.data
            hasMore = page.hasMore
        } catch {
            self.error = error
            if after == nil {
                // Don't keep showing files that may not match the current filter.
                files = []
                hasMore = false
            }
        }
    }

    /// Uploads the file at `url`, which may be security-scoped (as returned by a file importer).
    @discardableResult
    func upload(url: URL, purpose: String, expiresAfterSeconds: Int64?) async -> OpenAIFile? {
        guard !isBusy else { return nil }
        isChanging = true
        defer { isChanging = false }
        do {
            // Off the main actor: the file can be up to 512 MB, and reading it here would freeze the UI.
            let data = try await Task.detached { try Self.readSecurityScopedFile(at: url) }.value
            let contentType = UTType(filenameExtension: url.pathExtension)?.preferredMIMEType
                ?? "application/octet-stream"
            let file = try await client.create(query: CreateFileQuery(
                purpose: purpose,
                file: data,
                fileName: url.lastPathComponent,
                contentType: contentType,
                expiresAfter: expiresAfterSeconds.map { .init(anchor: .createdAt, seconds: $0) }
            ))
            if purposeFilter == nil || purposeFilter == file.purpose {
                files.insert(file, at: 0)
            }
            return file
        } catch {
            self.error = error
            return nil
        }
    }

    /// Fetches the file again and updates it in the list.
    func retrieve(id: String) async -> OpenAIFile? {
        do {
            let file = try await client.retrieve(id: id)
            if let index = files.firstIndex(where: { $0.id == id }) {
                files[index] = file
            }
            return file
        } catch {
            self.error = error
            return nil
        }
    }

    func content(id: String) async -> Data? {
        do {
            return try await client.content(id: id)
        } catch {
            self.error = error
            return nil
        }
    }

    /// Deletes the file and removes it from the list. Returns whether the API reported it as deleted.
    @discardableResult
    func delete(id: String) async -> Bool {
        guard !isBusy else { return false }
        isChanging = true
        defer { isChanging = false }
        do {
            let result = try await client.delete(id: id)
            if result.deleted {
                files.removeAll { $0.id == id }
            }
            return result.deleted
        } catch {
            self.error = error
            return false
        }
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
