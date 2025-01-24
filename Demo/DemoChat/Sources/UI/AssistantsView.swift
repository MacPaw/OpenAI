//
//  ChatView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Combine
import SwiftUI
import OpenAI

public struct AssistantsView: View {
    @ObservedObject var store: ChatStore
    @ObservedObject var assistantStore: AssistantStore

    @Environment(\.dateProviderValue) var dateProvider
    @Environment(\.idProviderValue) var idProvider

    // state to select file
    @State private var isPickerPresented: Bool = false
    @State private var fileURL: URL?

    // state to modify assistant
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var customInstructions: String = ""
    @State private var fileIds: [String] = []

    @State private var codeInterpreter: Bool = false
    @State private var fileSearch: Bool = false
    @State private var functions: [FunctionDeclaration] = []
    @State var isLoadingMore = false
    @State private var isModalPresented = false
    @State private var isUploading = false

    //If a file is selected via the document picker, this is set.
    @State var selectedFileURL: URL?
    @State var uploadedFileId: String?

    @State var mode: AssistantModalContentView.Mode = .create

    public init(store: ChatStore, assistantStore: AssistantStore) {
        self.store = store
        self.assistantStore = assistantStore
    }

    public var body: some View {
        ZStack {
            NavigationSplitView {
                AssistantsListView(
                    assistants: $assistantStore.availableAssistants, selectedAssistantId: Binding<String?>(
                        get: {
                            assistantStore.selectedAssistantId

                        }, set: { newId in
                            guard newId != nil else { return }

                            selectAssistant(newId: newId)
                        }), onLoadMoreAssistants: {
                            loadMoreAssistants()
                        }, isLoadingMore: $isLoadingMore
                )
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button {
                            mode = .create
                            isModalPresented = true
                        } label: {
                            Label("Create Assistant", systemImage: "plus")
                        }
                        Button {
                            guard let asstId = assistantStore.selectedAssistantId else {
                                return
                            }
                            
                            // Create new local conversation to represent new thread.
                            store.createConversation(type: .assistant, assistantId: asstId)
                        } label: {
                            Label("Start Chat", systemImage: "plus.message")
                        }
                        .disabled(assistantStore.selectedAssistantId == nil)
                        Button {
                            Task {
                                let _ = await assistantStore.getAssistants()
                            }
                        } label: {
                            Label("Get Assistants", systemImage: "arrow.triangle.2.circlepath")
                        }
                    }
                }
            } detail: {
                if assistantStore.selectedAssistantId != nil {
                    assistantContentView()
                } else {
                    Text("Select an assistant")
                }
            }
            .sheet(isPresented: $isModalPresented) {
                resetAssistantCreator()
            } content: {
                assistantContentView()
            }
        }
    }

    @ViewBuilder
    private func assistantContentView() -> some View {
        AssistantModalContentView(name: $name, description: $description, customInstructions: $customInstructions,
                                  codeInterpreter: $codeInterpreter, fileSearch: $fileSearch, functions: $functions, fileIds: $fileIds,
                                  isUploading: $isUploading, modify: mode == .modify, isPickerPresented: $isPickerPresented, selectedFileURL: $selectedFileURL) {
            Task {
                await handleOKTap()
            }
        } onFileUpload: {
            Task {
                guard let selectedFileURL  else { return }
                
                isUploading = true
                let file = await assistantStore.uploadFile(url: selectedFileURL)
                uploadedFileId =  file?.id
                isUploading = false
                
                if uploadedFileId == nil {
                    print("Failed to upload")
                    self.selectedFileURL = nil
                }
                else {
                    // if successful upload , we can show it.
                    if let uploadedFileId = uploadedFileId {
                        self.selectedFileURL = nil
                        
                        fileIds += [uploadedFileId]
                        
                        print("Successful upload!")
                    }
                }
            }
        }
    }
    
    private func handleOKTap() async {

        var mergedFileIds = [String]()

        mergedFileIds += fileIds

        let asstId: String?

        switch mode {
        // Create new Assistant and select it
        case .create:
            asstId = await assistantStore.createAssistant(name: name, description: description, instructions: customInstructions, codeInterpreter: codeInterpreter, fileSearch: fileSearch, functions: functions, fileIds: mergedFileIds.isEmpty ? nil : mergedFileIds)
            assistantStore.selectedAssistantId = asstId
        // Modify existing Assistant
        case .modify:
            guard let selectedAssistantId = assistantStore.selectedAssistantId else {
                print("Cannot modify assistant, not selected.")
                return
            }

            asstId = await assistantStore.modifyAssistant(asstId: selectedAssistantId, name: name, description: description, instructions: customInstructions, codeInterpreter: codeInterpreter, fileSearch: fileSearch, functions: functions, fileIds: mergedFileIds.isEmpty ? nil : mergedFileIds)
        }

        // Reset Assistant Creator after attempted creation or modification.
        resetAssistantCreator()

        if asstId == nil {
            print("Failed to modify or create Assistant.")
        }
    }

    private func loadMoreAssistants() {
        guard !isLoadingMore else { return }

        isLoadingMore = true
        let lastAssistantId = assistantStore.availableAssistants.last?.id ?? ""

        Task {
            // Fetch more assistants and append to the list
            let _ = await assistantStore.getAssistants(after: lastAssistantId)
            isLoadingMore = false
        }
    }

    private func resetAssistantCreator() {
        // Reset state for Assistant creator.
        name = ""
        description = ""
        customInstructions = ""

        codeInterpreter = false
        fileSearch = false
        functions = []
        selectedFileURL = nil
        uploadedFileId = nil
        fileIds = []
    }

    private func selectAssistant(newId: String?) {
        assistantStore.selectAssistant(newId)

        let selectedAssistant = assistantStore.availableAssistants.filter { $0.id == assistantStore.selectedAssistantId }.first

        name = selectedAssistant?.name ?? ""
        description = selectedAssistant?.description ?? ""
        customInstructions = selectedAssistant?.instructions ?? ""
        codeInterpreter = selectedAssistant?.codeInterpreter ?? false
        fileSearch = selectedAssistant?.fileSearch ?? false
        functions = selectedAssistant?.functions ?? []
        fileIds = selectedAssistant?.fileIds ?? []

        mode = .modify

    }
}
