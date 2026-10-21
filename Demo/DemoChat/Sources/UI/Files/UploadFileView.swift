//
//  UploadFileView.swift
//  DemoChat
//

import SwiftUI
import UniformTypeIdentifiers

/// Picks a file, a purpose and an optional expiration, and uploads the file.
struct UploadFileView: View {
    @ObservedObject var store: FilesStore
    @Environment(\.dismiss) private var dismiss

    @State private var fileURL: URL?
    @State private var isImporterPresented = false
    @State private var purpose = "user_data"
    @State private var expires = false
    @State private var expirationHours = 1
    @State private var isUploading = false
    @State private var uploadTask: Task<Void, Never>?

    var body: some View {
        NavigationStack {
            Form {
                Section("File") {
                    Button(fileURL?.lastPathComponent ?? "Choose File") {
                        isImporterPresented = true
                    }
                }

                Section("Purpose") {
                    Picker("Purpose", selection: $purpose) {
                        ForEach(FilesStore.uploadPurposes, id: \.self) { purpose in
                            Text(purpose).tag(purpose)
                        }
                    }
                }

                Section {
                    Toggle("Expire", isOn: $expires)
                    if expires {
                        Stepper(
                            "After \(expirationHours) hour\(expirationHours == 1 ? "" : "s")",
                            value: $expirationHours,
                            in: 1...720
                        )
                    }
                } header: {
                    Text("Expiration")
                } footer: {
                    Text("By default, files with `purpose=batch` expire after 30 days and all other files are persisted until they are manually deleted.")
                }
            }
            .navigationTitle("Upload File")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    if isUploading {
                        ProgressView()
                    } else {
                        Button("Upload", action: upload)
                            .disabled(fileURL == nil)
                    }
                }
            }
            .fileImporter(isPresented: $isImporterPresented, allowedContentTypes: [.item]) { result in
                if case .success(let url) = result {
                    fileURL = url
                }
            }
            .filesErrorAlert(store: store)
        }
        .onDisappear {
            // Both Cancel and swiping the sheet down end up here. Stop the upload rather than let it finish unseen.
            uploadTask?.cancel()
        }
    }

    private func upload() {
        guard let fileURL else { return }
        isUploading = true
        uploadTask = Task {
            let file = await store.upload(
                url: fileURL,
                purpose: purpose,
                expiresAfterSeconds: expires ? Int64(expirationHours) * 3600 : nil
            )
            isUploading = false
            if file != nil {
                dismiss()
            }
        }
    }
}
