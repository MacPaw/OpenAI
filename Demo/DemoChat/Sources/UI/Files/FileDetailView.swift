//
//  FileDetailView.swift
//  DemoChat
//

import OpenAI
import SwiftUI

/// Shows a file's details, refreshes them, downloads its content and deletes it.
struct FileDetailView: View {
    /// How much of a text file's content to show.
    private static let previewLength = 5_000

    @ObservedObject var store: FilesStore
    @State var file: OpenAIFile
    @Environment(\.dismiss) private var dismiss

    @State private var content: Data?
    @State private var isLoadingContent = false
    @State private var isDeleteConfirmationPresented = false

    var body: some View {
        List {
            Section("Details") {
                LabeledContent("ID") {
                    Text(file.id).textSelection(.enabled)
                }
                LabeledContent("Filename", value: file.filename)
                LabeledContent("Purpose", value: file.purpose.rawValue)
                LabeledContent("Size", value: Int64(file.bytes).formatted(.byteCount(style: .file)))
                LabeledContent("Created") {
                    Text(date(file.createdAt).formatted(date: .abbreviated, time: .shortened))
                }
                LabeledContent("Expires") {
                    Text(file.expiresAt.map { date($0).formatted(date: .abbreviated, time: .shortened) } ?? "Never")
                }
            }

            Section("Content") {
                if let content {
                    contentPreview(content)
                    let shared = DownloadedFileContent(data: content, filename: file.filename, fallbackName: file.id)
                    ShareLink("Share", item: shared, preview: SharePreview(shared.fileName))
                } else if isLoadingContent {
                    ProgressView()
                } else {
                    Button("Download Content", action: downloadContent)
                }
            }

            Section {
                Button("Delete File", role: .destructive) {
                    isDeleteConfirmationPresented = true
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(file.filename)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                Task {
                    if let refreshed = await store.retrieve(id: file.id) {
                        file = refreshed
                    }
                }
            } label: {
                Label("Refresh", systemImage: "arrow.clockwise")
            }
        }
        .confirmationDialog(
            "Delete \(file.filename)?",
            isPresented: $isDeleteConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                Task {
                    if await store.delete(id: file.id) {
                        dismiss()
                    }
                }
            }
        }
        .filesErrorAlert(store: store)
    }

    @ViewBuilder
    private func contentPreview(_ content: Data) -> some View {
        if let text = String(data: content, encoding: .utf8) {
            Text(text.count > Self.previewLength ? String(text.prefix(Self.previewLength)) + "…" : text)
                .font(.system(.footnote, design: .monospaced))
                .textSelection(.enabled)
        } else {
            Text("Binary content, \(Int64(content.count).formatted(.byteCount(style: .file)))")
                .foregroundStyle(.secondary)
        }
    }

    private func downloadContent() {
        isLoadingContent = true
        Task {
            if let data = await store.content(id: file.id) {
                content = data
            }
            isLoadingContent = false
        }
    }

    private func date(_ unixTimestamp: Int) -> Date {
        Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    }
}
