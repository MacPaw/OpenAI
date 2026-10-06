//
//  DetailView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif
import OpenAI
import SwiftUI

import ExyteChat

struct DetailView: View {
    @State var inputText: String = ""
    @FocusState private var isFocused: Bool
    @State private var showsModelSelectionSheet = false
    @State private var selectedModel: Model?
    @State private var showsCustomModelAlert = false
    @State private var customModelDraft = ""
    @State private var streamEnabled = true
    @Environment(\.apiProvider) private var apiProvider
    @Environment(\.ignoresSavedData) private var ignoresSavedData
    var availableAssistants: [Assistant]
    /// Whether a message can only be sent once a chat model is chosen. Moderation sends with its own fixed model, so it opts out.
    var requiresChatModel = true
    /// Model IDs entered during this session, by provider. Chats are separate views, so the owner keeps this to carry an entered ID to the next chat even when saved IDs are ignored.
    var sessionModelIDs: Binding<[String: String]> = .constant([:])

    private static let availableChatModels: [Model] = Array(Model.allModels(satisfying: .init(supportedEndpoints: [.chatCompletions]))).sorted(by: >)

    /// OpenAI chats start on a default model. Other providers have no known models, so the user enters one.
    private var selectedChatModel: Model? {
        selectedModel ?? (apiProvider == .openAI ? Model.gpt6_luna : nil)
    }

    private var storedModelKey: String { "chatModelID.\(apiProvider.rawValue)" }

    /// Non-OpenAI model IDs are remembered per provider so they aren't re-entered for every chat: the one entered in this session, else (unless saved data is ignored) the one saved earlier.
    private func loadStoredModel() {
        guard apiProvider != .openAI else {
            selectedModel = nil
            return
        }
        selectedModel = sessionModelIDs.wrappedValue[apiProvider.rawValue]
            ?? (ignoresSavedData ? nil : UserDefaults.standard.string(forKey: storedModelKey))
    }

    private func useCustomModel(_ id: String) {
        let id = id.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !id.isEmpty else { return }
        selectedModel = id
        sessionModelIDs.wrappedValue[apiProvider.rawValue] = id
        UserDefaults.standard.set(id, forKey: storedModelKey)
    }

    let conversation: Conversation
    let error: Error?
    let sendMessage: (String, Message.Image?, Model, Bool) -> Void
    
    @Binding var isSendingMessage: Bool
    
    private var fillColor: Color {
#if os(iOS)
        return Color(uiColor: UIColor.systemBackground)
#elseif os(macOS)
        return Color(nsColor: NSColor.textBackgroundColor)
#endif
    }
    
    private var strokeColor: Color {
#if os(iOS)
        return Color(uiColor: UIColor.systemGray5)
#elseif os(macOS)
        return Color(nsColor: NSColor.lightGray)
#endif
    }
    
    var body: some View {
        NavigationStack {
            chatView()
                .navigationTitle(conversation.type == .assistant ? "Assistant: \(currentAssistantName())" : "Chat")
                .safeAreaInset(edge: .top) {
                    HStack {
                        Text(
                            "Model: \(conversation.type == .assistant ? Model.gpt4_o_mini : selectedChatModel ?? "not set"), stream: \(streamEnabled)"
                        )
                        .font(.caption)
                        .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .toolbar {
                    if conversation.type == .assistant {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            Menu {
                                ForEach(availableAssistants, id: \.self) { item in
                                    Button(item.name) {
                                        print("Select assistant")
                                        //selectedItem = item
                                    }
                                }
                            } label: {
                                Image(systemName: "eyeglasses")
                            }
                        }
                    }
                    if conversation.type == .normal {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showsModelSelectionSheet.toggle()
                            }) {
                                Image(systemName: "cpu")
                            }
                        }
                    }
                }
                .confirmationDialog(
                    "Select model",
                    isPresented: $showsModelSelectionSheet,
                    titleVisibility: .visible,
                    actions: {
                        Button {
                            streamEnabled.toggle()
                        } label: {
                            Text(streamEnabled ? "Disable streaming" : "Enable streaming")
                        }
                        
                        if apiProvider == .openAI {
                            ForEach(DetailView.availableChatModels, id: \.self) { model in
                                Button {
                                    selectedModel = model
                                } label: {
                                    Text(model)
                                }
                            }
                        } else {
                            Button("Custom model ID…") {
                                customModelDraft = selectedModel ?? ""
                                showsCustomModelAlert = true
                            }
                        }

                        Button("Cancel", role: .cancel) {
                            showsModelSelectionSheet = false
                        }
                    },
                    message: {
                        Text(apiProvider == .openAI
                            ? "View https://platform.openai.com/docs/models/overview for details"
                            : "Enter a model ID supported by this provider.")
                        .font(.caption)
                    }
                )
                .alert("Model ID", isPresented: $showsCustomModelAlert) {
                    TextField("Model ID", text: $customModelDraft)
                        #if os(iOS)
                        .textInputAutocapitalization(.never)
                        #endif
                        .autocorrectionDisabled()
                    Button("Use") { useCustomModel(customModelDraft) }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Enter a model ID supported by this provider.")
                }
        }
        .onAppear(perform: loadStoredModel)
        .onChange(of: apiProvider) { _ in loadStoredModel() }
    }
    
    @ViewBuilder
    private func chatView() -> some View {
        ExyteChat.ChatView(
            messages: conversation.exyteChatMessages,
            chatType: .conversation,
            replyMode: .answer,
            didSendMessage: { draftMessage in
                Task {
                    let image: Message.Image?
                    
                    if let media = draftMessage.medias.first,
                       media.type == .image,
                       let url = await media.getThumbnailURL(),
                       let data = await media.getThumbnailData() {
                        image = .init(
                            attachmentId: media.id.uuidString,
                            thumbnailURL: url,
                            data: data
                        )
                    } else {
                        image = nil
                    }
                    
                    guard let model = selectedChatModel ?? (requiresChatModel ? nil : "") else {
                        // The draft is already cleared by the chat view, so ask for the model rather than dropping silently
                        showsCustomModelAlert = true
                        return
                    }
                    sendMessage(
                        draftMessage.text,
                        image,
                        model,
                        streamEnabled
                    )
                }
        })
        .setAvailableInputs([.text, .media])
        .betweenListAndInputViewBuilder(infoMessage)
    }
    
    @ViewBuilder func infoMessage() -> some View {
        if isSendingMessage {
            infoMessage("Sending...", isError: false)
        } else if let error {
            infoMessage(error.localizedDescription, isError: false)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func infoMessage(_ string: String, isError: Bool) -> some View {
        Text(
            string
        )
        .font(.caption)
        .foregroundColor({
            #if os(iOS)
            return Color(uiColor: isError ? .systemRed : .secondaryLabel)
            #elseif os(macOS)
            return Color(isError ? .systemRed : .secondaryLabel)
            #endif
        }())
        .padding(.horizontal)
    }
    
    func currentAssistantName() -> String {
        availableAssistants.filter { conversation.assistantId == $0.id }.first?.name ?? ""
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            availableAssistants: [],
            conversation: Conversation(
                id: "1",
                messages: [
                    Message(id: "1", role: .assistant, content: "Hello, how can I help you today?", createdAt: Date(timeIntervalSinceReferenceDate: 0)),
                    Message(id: "2", role: .user, content: "I need help with my subscription.", createdAt: Date(timeIntervalSinceReferenceDate: 100)),
                    Message(id: "3", role: .assistant, content: "Sure, what seems to be the problem with your subscription?", createdAt: Date(timeIntervalSinceReferenceDate: 200)),
                    Message(id: "4", role: .tool, content:
                              """
                              get_current_weather({
                                "location": "Glasgow, Scotland",
                                "format": "celsius"
                              })
                              """, createdAt: Date(timeIntervalSinceReferenceDate: 200))
                ]
            ),
            error: nil,
            sendMessage: { _, _, _, _  in }, isSendingMessage: Binding.constant(false)
        )
    }
}
