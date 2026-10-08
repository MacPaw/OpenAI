import Foundation
import OpenAI
import SwiftUI

struct SelectedAudio: Equatable, Sendable {
    static let maximumBytes = 25_000_000

    let name: String
    let data: Data
    let fileType: AudioTranscriptionQuery.FileType

    init(name: String, data: Data) throws {
        let fileType = try Self.fileType(for: name)
        guard !data.isEmpty else { throw AudioImportError.emptyFile }
        guard data.count <= Self.maximumBytes else { throw AudioImportError.tooLarge }
        self.name = name
        self.data = data
        self.fileType = fileType
    }

    static func fileType(for name: String) throws -> AudioTranscriptionQuery.FileType {
        let fileExtension = URL(fileURLWithPath: name).pathExtension.lowercased()
        guard let fileType = AudioTranscriptionQuery.FileType(rawValue: fileExtension) else {
            throw AudioImportError.unsupportedFormat
        }
        return fileType
    }
}

enum AudioImportError: LocalizedError, Equatable {
    case unsupportedFormat
    case emptyFile
    case tooLarge
    case notRegularFile

    var errorDescription: String? {
        switch self {
        case .unsupportedFormat:
            return "Choose a FLAC, MP3, MPGA, MP4, M4A, MPEG, OGG, WAV, or WebM file."
        case .emptyFile:
            return "The selected audio file is empty."
        case .tooLarge:
            return "Choose an audio file no larger than 25 MB."
        case .notRegularFile:
            return "Choose an audio file, not a folder."
        }
    }
}

@MainActor
final class TranscriptionStore: ObservableObject {
    typealias AudioLoader = @Sendable (URL) async throws -> SelectedAudio
    typealias Transcription = @Sendable (AudioTranscriptionQuery) async throws -> String

    @Published private(set) var selectedAudio: SelectedAudio?
    @Published private(set) var isLoading = false
    @Published private(set) var isTranscribing = false
    @Published private(set) var transcript = ""
    @Published var errorMessage: String?
    @Published var model = Model.whisper_1
    @Published var language = ""
    @Published var prompt = ""

    private let audioLoader: AudioLoader
    private var importTask: Task<SelectedAudio, Error>?
    private var transcriptionTask: Task<String, Error>?
    private var operationID = UUID()

    init(audioLoader: @escaping AudioLoader = TranscriptionStore.loadAudio) {
        self.audioLoader = audioLoader
    }

    func importAudio(from url: URL) async {
        guard !Task.isCancelled else { return }
        clearAudio()
        isLoading = true

        let currentOperation = operationID
        let loader = audioLoader
        let task = Task { try await loader(url) }
        importTask = task
        defer {
            if operationID == currentOperation {
                isLoading = false
                importTask = nil
            }
        }

        do {
            let audio = try await withTaskCancellationHandler {
                try await task.value
            } onCancel: {
                task.cancel()
            }
            guard operationID == currentOperation, !Task.isCancelled, !task.isCancelled else { return }
            selectedAudio = audio
        } catch {
            guard operationID == currentOperation, !Task.isCancelled, !task.isCancelled else { return }
            if !(error is CancellationError) {
                errorMessage = error.localizedDescription
            }
        }
    }

    func transcribe(using client: any OpenAIProtocol) async {
        await transcribe { query in
            try await client.audioTranscriptions(query: query).text
        }
    }

    func transcribe(using transcription: @escaping Transcription) async {
        guard !Task.isCancelled, !isLoading, !isTranscribing else { return }
        guard let audio = selectedAudio else {
            errorMessage = "Choose an audio file first."
            return
        }
        guard let model = nonempty(model) else {
            errorMessage = "Enter a transcription model."
            return
        }

        let query = AudioTranscriptionQuery(
            file: audio.data,
            fileType: audio.fileType,
            model: model,
            prompt: nonempty(prompt),
            language: nonempty(language),
            responseFormat: .json
        )
        cancel()
        transcript = ""
        errorMessage = nil
        isTranscribing = true

        let currentOperation = operationID
        let task = Task { try await transcription(query) }
        transcriptionTask = task
        defer {
            if operationID == currentOperation {
                isTranscribing = false
                transcriptionTask = nil
            }
        }

        do {
            let text = try await withTaskCancellationHandler {
                try await task.value
            } onCancel: {
                task.cancel()
            }
            guard operationID == currentOperation, !Task.isCancelled, !task.isCancelled else { return }
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                errorMessage = "No speech was detected in this recording."
            } else {
                transcript = text
            }
        } catch {
            guard operationID == currentOperation, !Task.isCancelled, !task.isCancelled else { return }
            if !(error is CancellationError) {
                errorMessage = error.localizedDescription
            }
        }
    }

    func clearAudio() {
        cancel()
        selectedAudio = nil
        transcript = ""
        errorMessage = nil
    }

    func cancel() {
        // Cancellation alone cannot prevent a non-cooperative loader or provider from finishing.
        operationID = UUID()
        importTask?.cancel()
        transcriptionTask?.cancel()
        importTask = nil
        transcriptionTask = nil
        isLoading = false
        isTranscribing = false
    }

    private func nonempty(_ value: String) -> String? {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }

    nonisolated static func loadAudio(from url: URL) async throws -> SelectedAudio {
        let task = Task.detached(priority: .userInitiated) {
            let hasAccess = url.startAccessingSecurityScopedResource()
            defer {
                if hasAccess { url.stopAccessingSecurityScopedResource() }
            }

            try Task.checkCancellation()
            _ = try SelectedAudio.fileType(for: url.lastPathComponent)
            let values = try url.resourceValues(forKeys: [.isRegularFileKey, .fileSizeKey])
            guard values.isRegularFile == true else { throw AudioImportError.notRegularFile }
            if let size = values.fileSize, size > SelectedAudio.maximumBytes {
                throw AudioImportError.tooLarge
            }

            let file = try FileHandle(forReadingFrom: url)
            defer { try? file.close() }
            var data = Data()
            // Bound reads too: a file may grow after the metadata check.
            while data.count <= SelectedAudio.maximumBytes {
                try Task.checkCancellation()
                let count = min(64 * 1024, SelectedAudio.maximumBytes + 1 - data.count)
                guard let chunk = try file.read(upToCount: count), !chunk.isEmpty else { break }
                data.append(chunk)
            }
            try Task.checkCancellation()
            return try SelectedAudio(name: url.lastPathComponent, data: data)
        }
        return try await withTaskCancellationHandler {
            try await task.value
        } onCancel: {
            task.cancel()
        }
    }
}
