//
//  FilesView.swift
//  DemoChat
//

import OpenAI
import SwiftUI

/// Lists the files in the organization, filtered by purpose, with paging, upload and delete.
public struct FilesView: View {
    @StateObject private var store: FilesStore
    @Environment(\.apiProvider) private var apiProvider
    @State private var isUploadPresented = false

    public init(client: FilesEndpointProtocol) {
        _store = StateObject(wrappedValue: FilesStore(client: client))
    }

    public var body: some View {
        if apiProvider == .openAI {
            list
        } else {
            OpenAIOnlyView(feature: "Files", provider: apiProvider)
        }
    }

    private var list: some View {
        List {
            Section {
                Picker("Purpose", selection: $store.purposeFilter) {
                    Text("All").tag(OpenAIFile.Purpose?.none)
                    ForEach(FilesStore.listPurposes, id: \.self) { purpose in
                        Text(purpose.rawValue).tag(Optional(purpose))
                    }
                }
            }

            Section {
                ForEach(store.files, id: \.id) { file in
                    NavigationLink {
                        FileDetailView(store: store, file: file)
                    } label: {
                        FileRow(file: file)
                    }
                }
                .onDelete { offsets in
                    let ids = offsets.map { store.files[$0].id }
                    Task {
                        for id in ids {
                            await store.delete(id: id)
                        }
                    }
                }

                if store.hasMore {
                    Button("Load More") {
                        Task { await store.loadMore() }
                    }
                    .disabled(store.isLoading)
                }
            }
        }
        .listStyle(.insetGrouped)
        .overlay {
            if store.isLoading && store.files.isEmpty {
                ProgressView()
            } else if store.files.isEmpty {
                ContentUnavailableView(
                    "No Files",
                    systemImage: "doc",
                    description: Text("Upload a file with the + button.")
                )
            }
        }
        .navigationTitle("Files")
        .toolbar {
            Button {
                isUploadPresented = true
            } label: {
                Label("Upload File", systemImage: "plus")
            }
        }
        .sheet(isPresented: $isUploadPresented) {
            UploadFileView(store: store)
        }
        .refreshable {
            await store.reload()
        }
        .task {
            // Runs again when returning from a file's details; keep the loaded pages then.
            if store.files.isEmpty {
                await store.reload()
            }
        }
        .onChange(of: store.purposeFilter) {
            Task { await store.reload() }
        }
        .filesErrorAlert(store: store)
    }
}

private struct FileRow: View {
    let file: OpenAIFile

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(file.filename)
                .font(.headline)
                .lineLimit(1)
            HStack {
                Text(file.purpose.rawValue)
                Text(Int64(file.bytes).formatted(.byteCount(style: .file)))
                Spacer()
                Text(Date(timeIntervalSince1970: TimeInterval(file.createdAt)), style: .date)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

extension View {
    /// Shows the store's last error, and clears it when dismissed.
    func filesErrorAlert(store: FilesStore) -> some View {
        alert(
            "Request Failed",
            isPresented: Binding(
                get: { store.error != nil },
                set: { if !$0 { store.error = nil } }
            ),
            presenting: store.error
        ) { _ in
            Button("OK", role: .cancel) {}
        } message: { error in
            Text(error.localizedDescription)
        }
    }
}
