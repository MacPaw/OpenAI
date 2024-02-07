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

struct DetailView: View {
    @State var inputText: String = ""
    @FocusState private var isFocused: Bool
    @State private var showsModelSelectionSheet = false
    @State private var selectedChatModel: Model = .gpt4_0613

    private let availableChatModels: [Model] = [.gpt3_5Turbo, .gpt4_0613]

    let conversation: Conversation
    let error: Error?
    let sendMessage: (String, Model) -> Void

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
            ScrollViewReader { scrollViewProxy in
                VStack {
                    List {
                        ForEach(conversation.messages) { message in
                            ChatBubble(message: message)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .animation(.default, value: conversation.messages)
//                    .onChange(of: conversation) { newValue in
//                        if let lastMessage = newValue.messages.last {
//                            scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
//                        }
//                    }

                    if let error = error {
                        errorMessage(error: error)
                    }

                    inputBar(scrollViewProxy: scrollViewProxy)
                }
                .navigationTitle("Chat")
                .safeAreaInset(edge: .top) {
                    HStack {
                        Text(
                            "Model: \(selectedChatModel)"
                        )
                        .font(.caption)
                        .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showsModelSelectionSheet.toggle()
                        }) {
                            Image(systemName: "cpu")
                        }
                    }
                }
                .confirmationDialog(
                    "Select model",
                    isPresented: $showsModelSelectionSheet,
                    titleVisibility: .visible,
                    actions: {
                        ForEach(availableChatModels, id: \.self) { model in
                            Button {
                                selectedChatModel = model
                            } label: {
                                Text(model)
                            }
                        }

                        Button("Cancel", role: .cancel) {
                            showsModelSelectionSheet = false
                        }
                    },
                    message: {
                        Text(
                            "View https://platform.openai.com/docs/models/overview for details"
                        )
                        .font(.caption)
                    }
                )
            }
        }
    }

    @ViewBuilder private func errorMessage(error: Error) -> some View {
        Text(
            error.localizedDescription
        )
        .font(.caption)
        .foregroundColor({
            #if os(iOS)
            return Color(uiColor: .systemRed)
            #elseif os(macOS)
            return Color(.systemRed)
            #endif
        }())
        .padding(.horizontal)
    }

    @ViewBuilder private func inputBar(scrollViewProxy: ScrollViewProxy) -> some View {
        HStack {
            TextEditor(
                text: $inputText
            )
            .padding(.vertical, -8)
            .padding(.horizontal, -4)
            .frame(minHeight: 22, maxHeight: 300)
            .foregroundColor(.primary)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .background(
                RoundedRectangle(
                    cornerRadius: 16,
                    style: .continuous
                )
                .fill(fillColor)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 16,
                        style: .continuous
                    )
                    .stroke(
                        strokeColor,
                        lineWidth: 1
                    )
                )
            )
            .fixedSize(horizontal: false, vertical: true)
            .onSubmit {
                withAnimation {
                    tapSendMessage(scrollViewProxy: scrollViewProxy)
                }
            }
            .padding(.leading)

            Button(action: {
                withAnimation {
                    tapSendMessage(scrollViewProxy: scrollViewProxy)
                }
            }) {
                Image(systemName: "paperplane")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .padding(.trailing)
            }
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(.bottom)
    }
    
    private func tapSendMessage(
        scrollViewProxy: ScrollViewProxy
    ) {
        let message = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        if message.isEmpty {
            return
        }
        
        sendMessage(message, selectedChatModel)
        inputText = ""
        
//        if let lastMessage = conversation.messages.last {
//            scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
//        }
    }
}

struct ChatBubble: View {
    let message: Message

    private var assistantBackgroundColor: Color {
        #if os(iOS)
        return Color(uiColor: UIColor.systemGray5)
        #elseif os(macOS)
        return Color(nsColor: NSColor.lightGray)
        #endif
    }

    private var userForegroundColor: Color {
        #if os(iOS)
        return Color(uiColor: .white)
        #elseif os(macOS)
        return Color(nsColor: NSColor.white)
        #endif
    }

    private var userBackgroundColor: Color {
        #if os(iOS)
        return Color(uiColor: .systemBlue)
        #elseif os(macOS)
        return Color(nsColor: NSColor.systemBlue)
        #endif
    }

    var body: some View {
        HStack {
            switch message.role {
            case .assistant:
                Text(message.content)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(assistantBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                Spacer(minLength: 24)
            case .user:
                Spacer(minLength: 24)
                Text(message.content)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .foregroundColor(userForegroundColor)
                    .background(userBackgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            case .function:
              Text(message.content)
                  .font(.footnote.monospaced())
                  .padding(.horizontal, 16)
                  .padding(.vertical, 12)
                  .background(assistantBackgroundColor)
                  .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
              Spacer(minLength: 24)
            case .system:
                EmptyView()
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            conversation: Conversation(
                id: "1",
                messages: [
                    Message(id: "1", role: .assistant, content: "Hello, how can I help you today?", createdAt: Date(timeIntervalSinceReferenceDate: 0)),
                    Message(id: "2", role: .user, content: "I need help with my subscription.", createdAt: Date(timeIntervalSinceReferenceDate: 100)),
                    Message(id: "3", role: .assistant, content: "Sure, what seems to be the problem with your subscription?", createdAt: Date(timeIntervalSinceReferenceDate: 200)),
                    Message(id: "4", role: .function, content:
                              """
                              get_current_weather({
                                "location": "Glasgow, Scotland",
                                "format": "celsius"
                              })
                              """, createdAt: Date(timeIntervalSinceReferenceDate: 200))
                ]
            ),
            error: nil,
            sendMessage: { _, _ in }
        )
    }
}

