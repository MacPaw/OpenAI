//
//  FileDetailView.swift
//  DemoChat
//

import OpenAI
import SwiftUI

/// Shows a file's details, refreshes them, downloads its content and deletes it.
struct FileDetailView: View {
    @ObservedObject var store: FilesStore
    @State var file: OpenAIFile
    @Environment(\.dismiss) private var dismiss

    @State private var content: Data?
    @State private var contentPreview: FileContentPreview?
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
                if let content, let contentPreview {
                    previewView(contentPreview)
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
    private func previewView(_ preview: FileContentPreview) -> some View {
        switch preview {
        case .text(let text, let isTruncated):
            Text(isTruncated ? text + "…" : text)
                .font(.system(.footnote, design: .monospaced))
                .textSelection(.enabled)
        case .binary(let byteCount):
            Text("Binary content, \(Int64(byteCount).formatted(.byteCount(style: .file)))")
                .foregroundStyle(.secondary)
        }
    }

    private func downloadContent() {
        isLoadingContent = true
        Task {
            if let data = await store.content(id: file.id) {
                contentPreview = FileContentPreview(data)
                content = data
            }
            isLoadingContent = false
        }
    }

    private func date(_ unixTimestamp: Int) -> Date {
        Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    }
}
