//
//  TranscribeView.swift
//  DemoChat
//

import SwiftUI
import OpenAI
import UniformTypeIdentifiers
import UIKit

struct TranscribeView: View {
    @ObservedObject var miscStore: MiscStore
    @StateObject private var store = TranscriptionStore()
    @Environment(\.apiProvider) private var apiProvider
    @State private var showsFileImporter = false
    @State private var hasConfiguredModel = false

    var body: some View {
        List {
            Section {
                Button("Choose Audio File") { showsFileImporter = true }
                    .disabled(store.isLoading || store.isTranscribing)
                if let audio = store.selectedAudio {
                    LabeledContent("File", value: audio.name)
                    LabeledContent("Size", value: ByteCountFormatter.string(fromByteCount: Int64(audio.data.count), countStyle: .file))
                }
                if store.isLoading {
                    ProgressView("Reading audio…")
                }
            } header: {
                Text("Audio File")
            } footer: {
                Text("Choose a recording up to 25 MB. Nothing is uploaded until you tap Transcribe. Supported formats depend on your provider.")
            }

            Section("Options") {
                if apiProvider == .openAI {
                    Picker("Model", selection: $store.model) {
                        Text("whisper-1").tag("whisper-1")
                        Text("gpt-4o-transcribe").tag("gpt-4o-transcribe")
                        Text("gpt-4o-mini-transcribe").tag("gpt-4o-mini-transcribe")
                    }
                } else {
                    TextField("Transcription model ID", text: $store.model)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    Text("Your \(apiProvider.displayName) endpoint must support audio/transcriptions. Enter a model supported by that provider.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                TextField("Language code (optional, e.g. en)", text: $store.language)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Prompt (optional)", text: $store.prompt, axis: .vertical)
            }
            .disabled(store.isLoading || store.isTranscribing)

            Section {
                if store.isTranscribing {
                    ProgressView("Transcribing…")
                    Button("Cancel", role: .cancel) { store.cancel() }
                } else {
                    Button("Transcribe") {
                        Task { await store.transcribe(using: miscStore.openAIClient) }
                    }
                    .disabled(store.selectedAudio == nil || store.isLoading || store.model.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                if let error = store.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
            } footer: {
                Text("The selected file is sent to your configured \(apiProvider.displayName) provider. API usage may incur charges.")
            }

            if !store.transcript.isEmpty {
                Section("Transcript") {
                    Text(store.transcript).textSelection(.enabled)
                    Button("Copy Transcript") { UIPasteboard.general.string = store.transcript }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Transcribe")
        .fileImporter(isPresented: $showsFileImporter, allowedContentTypes: Self.audioTypes) { result in
            switch result {
            case .success(let url):
                Task { await store.importAudio(from: url) }
            case .failure(let error):
                let cocoaError = error as NSError
                guard cocoaError.domain != NSCocoaErrorDomain || cocoaError.code != NSUserCancelledError else { return }
                store.clearAudio()
                store.errorMessage = error.localizedDescription
            }
        }
        .onAppear {
            if !hasConfiguredModel {
                resetModelForProvider()
                hasConfiguredModel = true
            }
        }
        .onChange(of: apiProvider) { _, _ in
            store.cancel()
            resetModelForProvider()
        }
        .onDisappear { store.cancel() }
    }

    private func resetModelForProvider() {
        store.model = apiProvider == .openAI ? "whisper-1" : ""
    }

    private static var audioTypes: [UTType] {
        AudioTranscriptionQuery.FileType.allCases.compactMap { UTType(filenameExtension: $0.rawValue) }
    }
}
