//
//  FilesView.swift
//  DemoChat
//

import OpenAI
import SwiftUI

/// Lists the files in the organization, filtered by purpose, with paging, upload and delete.
public struct FilesView: View {
    @ObservedObject var store: FilesStore
    @Environment(\.apiProvider) private var apiProvider
    @State private var isUploadPresented = false

    public init(store: FilesStore) {
        self.store = store
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
                // `FilesStore` runs one request at a time and skips a reload while busy, so the filter is
                // disabled meanwhile instead. The same goes for the other controls that start a request below.
                .disabled(store.isBusy)
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
                .deleteDisabled(store.isBusy)

                if store.hasMore {
                    Button("Load More") {
                        Task { await store.loadMore() }
                    }
                    .disabled(store.isBusy)
                }
            }
        }
        .listStyle(.insetGrouped)
        .overlay {
            if store.isBusy && store.files.isEmpty {
                ProgressView()
            } else if store.files.isEmpty && !store.hasMore {
                ContentUnavailableView(
                    "No Files",
                    systemImage: "doc",
                    description: Text("Upload a file with the + button.")
                )
                // Decorative; keep the purpose picker under it usable.
                .allowsHitTesting(false)
            }
        }
        .navigationTitle("Files")
        .toolbar {
            Button {
                isUploadPresented = true
            } label: {
                Label("Upload File", systemImage: "plus")
            }
            .disabled(store.isBusy)
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
        // The upload sheet shows its own errors. Presenting this alert too would dismiss the sheet, and with
        // it the sheet's alert, which clears the error before it can be read.
        .filesErrorAlert(store: store, isEnabled: !isUploadPresented)
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
    /// Shows the store's last error, and clears it when dismissed. While `isEnabled` is `false`, the error
    /// is left for another view to show.
    func filesErrorAlert(store: FilesStore, isEnabled: Bool = true) -> some View {
        alert(
            "Request Failed",
            isPresented: Binding(
                get: { isEnabled && store.error != nil },
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
