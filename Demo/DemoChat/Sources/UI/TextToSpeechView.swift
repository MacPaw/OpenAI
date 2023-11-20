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
    
    @ObservedObject var store: MiscStore
    
    @State private var prompt: String = ""
    @State private var voice: AudioSpeechQuery.AudioSpeechVoice = .alloy
    @State private var speed: Double = 1
    @State private var responseFormat: AudioSpeechQuery.AudioSpeechResponseFormat = .mp3
    
    public init(store: MiscStore) {
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
                        let allVoices = AudioSpeechQuery.AudioSpeechVoice.allCases
                        ForEach(allVoices, id: \.self) { voice in
                            Text("\(voice.rawValue.capitalized)")
                        }
                    }
                }
                HStack {
                    Text("Speed: ")
                    Spacer()
                    Stepper(value: $speed, in: 0.25...4, step: 0.25) {
                        HStack {
                            Spacer()
                            Text("**\(String(format: "%.2f", speed))**")
                        }
                    }
                }
                HStack {
                    Picker("Format", selection: $responseFormat) {
                        let allFormats = AudioSpeechQuery.AudioSpeechResponseFormat.allCases
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
                        let query = AudioSpeechQuery(model: .tts_1,
                                                     input: prompt,
                                                     voice: voice,
                                                     responseFormat: responseFormat,
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
            }
            if !$store.audioObjects.wrappedValue.isEmpty {
                Section("Click to play, swipe to save:") {
                    ForEach(store.audioObjects) { object in
                        HStack {
                            Text(object.prompt.capitalized)
                            Spacer()
                            Button(action: {
                                guard let player = object.audioPlayer,
                                        object.format != AudioSpeechQuery.AudioSpeechResponseFormat.opus.rawValue else { return }
                                
                                if player.isPlaying {
                                    player.stop()
                                } else {
                                    player.prepareToPlay()
                                    player.volume = 1
                                    player.play()
                                }
                            }, label: {
                                Image(systemName: "play.fill").foregroundStyle(object.format == AudioSpeechQuery.AudioSpeechResponseFormat.opus.rawValue ? Color.secondary : Color.accentColor)
                            })
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                saveAudioDataToFile(audioData: object.originResponse.audioData!, fileName: "GeneratedAudio.\(object.format)")
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
        .navigationTitle("Create Speech")
    }
    
}

extension TextToSpeechView {
    
    func saveAudioDataToFile(audioData: Data, fileName: String) {
        if let fileURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            let saveURL = fileURL.appendingPathComponent(fileName)
            
            do {
                try audioData.write(to: saveURL)
                
                let filePicker = UIDocumentPickerViewController(forExporting: [saveURL], asCopy: false)
                filePicker.shouldShowFileExtensions = true
                
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let rootViewController = windowScene.windows.first?.rootViewController else { return }
                rootViewController.present(filePicker, animated: true, completion: nil)
                
            } catch {
                NSLog("Failed to save audio data: \(error)")
            }
        }
    }
    
}
