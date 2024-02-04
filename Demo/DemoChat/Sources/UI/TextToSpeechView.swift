//
//  File.swift
//
//
//  Created by Ihor Makhnyk on 16.11.2023.
//

import SwiftUI
import OpenAI
import UIKit

public struct TextToSpeechView: View {

    @ObservedObject var store: SpeechStore

    @State private var prompt: String = ""
    @State private var voice: SpeechCreateParams.Voice = .alloy
    @State private var speed: Double = 1
    @State private var responseFormat: SpeechCreateParams.ResponseFormat = .mp3
    @State private var showsModelSelectionSheet = false
    @State private var selectedSpeechModel: String = SpeechModel.tts_1.rawValue

    private static let availableSpeechModels: [String] = SpeechModel.allCases.map { $0.rawValue }

    public init(store: SpeechStore) {
        self.store = store
    }

    public var body: some View {
        List {
            Section {
                HStack {
                    VStack {
                        Text("Prompt")
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    Spacer()
                    ZStack(alignment: .topTrailing) {
                        TextEditor(text: $prompt)
                            .scrollContentBackground(.hidden)
                            .multilineTextAlignment(.trailing)
                        if prompt.isEmpty {
                            Text("...input")
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.trailing)
                                .allowsHitTesting(false)
                                .padding(8)
                        }
                    }
                }
                HStack {
                    Picker("Voice", selection: $voice) {
                        let allVoices = SpeechCreateParams.Voice.allCases
                        ForEach(allVoices, id: \.self) { voice in
                            Text("\(voice.rawValue.capitalized)")
                        }
                    }
                }
                HStack {
                    Text("Speed: ")
                    Spacer()
                    Stepper(value: $speed, in: SpeechCreateParams.Speed.min.rawValue...SpeechCreateParams.Speed.max.rawValue, step: 0.25) {
                        HStack {
                            Spacer()
                            Text("**\(String(format: "%.2f", speed))**")
                        }
                    }
                }
                HStack {
                    Picker("Format", selection: $responseFormat) {
                        let allFormats = SpeechCreateParams.ResponseFormat.allCases
                        ForEach(allFormats, id: \.self) { format in
                            Text(".\(format.rawValue)")
                        }
                    }
                }
            } footer: {
                if responseFormat == .opus {
                    Text("'.opus' is unsupported by AVFAudio player.").foregroundStyle(.secondary).font(.caption)
                }
            }
            Section {
                HStack {
                    Button("Create Speech") {
                        let query = SpeechCreateParams(input: prompt,
                                                       model: SpeechCreateParams.Model(rawValue: selectedSpeechModel)!,
                                                     voice: voice,
                                                     response_format: responseFormat,
                                                     speed: speed)
                        Task {
                            await store.createSpeech(query)
                        }
                        prompt = ""
                    }
                    .foregroundColor(.accentColor)
                    .disabled(prompt.replacingOccurrences(of: " ", with: "").isEmpty)
                    Spacer()
                }
                .modelSelect(selectedModel: $selectedSpeechModel, models: Self.availableSpeechModels, showsModelSelectionSheet: $showsModelSelectionSheet, help: "https://platform.openai.com/docs/models/tts")
            }
            if !$store.audioObjects.wrappedValue.isEmpty {
                Section("Click to play, swipe to save:") {
                    ForEach(store.audioObjects, id: \.self) { object in
                        HStack {
                            Text(object.prompt.capitalized)
                            Spacer()
                            Button(action: {
                                guard let player = object.audioPlayer,
                                        object.format != SpeechCreateParams.ResponseFormat.opus.rawValue else { return }

                                if player.isPlaying {
                                    player.stop()
                                } else {
                                    player.prepareToPlay()
                                    player.volume = 1
                                    player.play()
                                }
                            }, label: {
                                Image(systemName: "play.fill").foregroundStyle(object.format == SpeechCreateParams.ResponseFormat.opus.rawValue ? Color.secondary : Color.accentColor)
                            })
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                presentUserDirectoryDocumentPicker(for: object.originResponse.audio, filename: "GeneratedAudio.\(object.format)")
                            } label: {
                                Image(systemName: "square.and.arrow.down")
                            }
                            .tint(.accentColor)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollDismissesKeyboard(.interactively)
        .navigationTitle("Create Speech", selectedModel: $selectedSpeechModel)
    }
}

extension TextToSpeechView {

    private func presentUserDirectoryDocumentPicker(for audioData: Data?, filename: String) {
        guard let audioData else { return }
        store.getFileInDocumentsDirectory(audioData, fileName: filename) { fileUrl in
            let filePickerVC = UIDocumentPickerViewController(forExporting: [fileUrl], asCopy: false)
            filePickerVC.shouldShowFileExtensions = true

            guard let vc = getCurrentViewController() else { return }
            vc.present(filePickerVC, animated: true, completion: nil)
        }
    }
}
