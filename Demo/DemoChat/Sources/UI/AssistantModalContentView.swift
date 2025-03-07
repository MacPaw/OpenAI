//
//  AssistantModalContentView.swift
//
//
//  Created by Chris Dillard on 11/9/23.
//

import SwiftUI
import OpenAI

struct AssistantModalContentView: View {
    enum Mode {
        case modify
        case create
    }

    @Binding var name: String
    @Binding var description: String
    @Binding var customInstructions: String

    @Binding var codeInterpreter: Bool
    @Binding var fileSearch: Bool
    @Binding var functions: [FunctionDeclaration]
    @Binding var fileIds: [String]
    @Binding var isUploading: Bool
    @State var isFunctionModalPresented = false
    @State var newFunction: FunctionDeclaration?

    var modify: Bool

    @Environment(\.dismiss) var dismiss

    @Binding var isPickerPresented: Bool
    // If a file has been selected for uploading and is currently in progress, this is set.
    @Binding var selectedFileURL: URL?

    var onCommit: () -> Void
    var onFileUpload: () -> Void

    var body: some View {
        if modify {
            form
        } else {
            NavigationStack {
                form
            }
        }
    }
    
    @ViewBuilder
    private var form: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }
            Section("Description") {
                TextEditor(text: $description)
                    .frame(minHeight: 50)
            }
            Section("Custom Instructions") {
                TextEditor(text: $customInstructions)
                    .frame(minHeight: 100)
            }
            
            Section("Tools") {
                Toggle(isOn: $codeInterpreter, label: {
                    Text("Code interpreter")
                })
                
                Toggle(isOn: $fileSearch, label: {
                    Text("File Search")
                })
            }
            
            Section("Functions") {
                if !functions.isEmpty {
                    ForEach(functions, id: \.name) { function in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(function.name).fontWeight(.semibold)
                                if let description = function.description {
                                    Text(description)
                                        .font(.caption)
                                }
                                if let parameters = function.parameterJSON {
                                    Text(parameters)
                                        .font(.caption2)
                                }
                            }
                            Spacer()
                            Button {
                                if let index = functions.firstIndex(of: function) {
                                    functions.remove(at: index)
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill") // X button
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                Button("Create Function") {
                    isFunctionModalPresented = true
                }
            }

            Section("Files") {
                if !fileIds.isEmpty {
                    ForEach(fileIds, id: \.self) { fileId in
                        HStack {
                            // File Id of each file added to the assistant.
                            Text("File: \(fileId)")
                            Spacer()
                            // Button to remove fileId from the list of fileIds to be used when create or modify assistant.
                            Button {
                                // Add action to remove the file from the list
                                if let index = fileIds.firstIndex(of: fileId) {
                                    fileIds.remove(at: index)
                                }
                            } label: {
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
                    .fullScreenCover(isPresented: $isPickerPresented) {
                        DocumentPicker { url in
                            selectedFileURL = url
                            onFileUpload()
                        }
                    }
                }
            }
        }
        .navigationTitle("\(modify ? "Edit" : "Enter") Assistant Details")
        .toolbar {
            if !modify {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            ToolbarItemGroup(placement: .primaryAction) {
                Button("Save") {
                    onCommit()
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $isFunctionModalPresented) {
            if let newFunction {
                functions.append(newFunction)
                self.newFunction = nil
            }
        } content: {
            FunctionView(name: "", description: "", parameters: "", function: $newFunction)
        }
    }
}

extension FunctionDeclaration {
    var parameterJSON: String? {
        guard let parameters else {
            return nil
        }
        
        do {
            let parameterData = try JSONEncoder().encode(parameters)
            return String(data: parameterData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
