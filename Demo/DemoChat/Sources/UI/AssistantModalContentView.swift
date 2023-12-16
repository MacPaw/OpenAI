//
//  AssistantModalContentView.swift
//
//
//  Created by Chris Dillard on 11/9/23.
//

import SwiftUI

struct AssistantModalContentView: View {
    enum Mode {
        case modify
        case create
    }

    @Binding var name: String
    @Binding var description: String
    @Binding var customInstructions: String

    @Binding var codeInterpreter: Bool
    @Binding var retrieval: Bool
    @Binding var fileIds: [String]
    @Binding var isUploading: Bool

    var modify: Bool

    @Environment(\.dismiss) var dismiss

    @Binding var isPickerPresented: Bool
    // If a file has been selected for uploading and is currently in progress, this is set.
    @Binding var selectedFileURL: URL?

    var onCommit: () -> Void
    var onFileUpload: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(minHeight: 50)
                }
                Section(header: Text("Custom Instructions")) {
                    TextEditor(text: $customInstructions)
                        .frame(minHeight: 100)
                }

                Toggle(isOn: $codeInterpreter, label: {
                    Text("Code interpreter")
                })

                Toggle(isOn: $retrieval, label: {
                    Text("Retrieval")
                })

                if !fileIds.isEmpty {
                    ForEach(fileIds, id: \.self) { fileId in
                        HStack {
                            // File Id of each file added to the assistant.
                            Text("File: \(fileId)")
                            Spacer()
                            // Button to remove fileId from the list of fileIds to be used when create or modify assistant.
                            Button(action: {
                                // Add action to remove the file from the list
                                if let index = fileIds.firstIndex(of: fileId) {
                                    fileIds.remove(at: index)
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill") // X button
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }

                if let selectedFileURL {
                    HStack {
                        Text("File: \(selectedFileURL.lastPathComponent)")

                        Button("Remove") {
                            self.selectedFileURL = nil
                        }
                    }
                }
                else {
                    Button("Upload File") {
                        isPickerPresented = true
                    }
                    .sheet(isPresented: $isPickerPresented) {
                        DocumentPicker { url in
                            selectedFileURL = url
                            onFileUpload()
                        }
                    }
                }
            }
            .navigationTitle("\(modify ? "Edit" : "Enter") Assistant Details")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("OK") {
                    onCommit()
                    dismiss()
                }
            )
        }
    }
}
