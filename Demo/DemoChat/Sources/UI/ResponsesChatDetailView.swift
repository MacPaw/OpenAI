//
//  ResponsesChatDetailView.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 29.03.2025.
//

import SwiftUI
import ExyteChat
import OpenAI
import Combine

public struct ResponsesChatDetailView: View {
    @State private var errorTitle = ""
    @State private var errorAlertPresented = false
    @StateObject private var settingsStore = ResponsesSettingsStore()
    @ObservedObject var store: ResponsesStore
    
    @State private var isFunctionCallViewPresented = false
    @State private var functionCallResult: String?
    
    private var settingsDescription: String {
        var elements: [String] = ["Model: \(settingsStore.selectedModel)"]
        
        elements.append("stream: \(settingsStore.stream ? "true" : "false")")
        
        var tools: [String] = []
        if settingsStore.webSearchEnabled {
            tools.append("Web Search")
        }
        
        if settingsStore.functionCallingEnabled {
            tools.append("Functions")
        }
        
        if !tools.isEmpty {
            elements.append("tools: \(tools.joined(separator: ", "))")
        }
        
        return elements.joined(separator: ", ")
    }
    
    public init(store: ResponsesStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            chatView()
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    VStack {
                        HStack {
                            if store.webSearchInProgress {
                                Image(systemName: "globe")
                                Text("Searching Web…")
                                    
                            } else if store.inProgress {
                                Text("Streaming…")
                            } else {
                                Text("Responses API")
                            }
                        }.fontWeight(.semibold)
                        
                        Text(settingsDescription)
                            .font(.caption)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ResponsesChatSettingsView(store: settingsStore)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(errorTitle, isPresented: $errorAlertPresented, actions: {})
        .sheet(
            isPresented: $isFunctionCallViewPresented,
            onDismiss: {
                store.cancelFunctionCall()
            },
            content: {
                FunctionCallStubView(call: store.functionCall!) { stubResult in
                    functionCallResult = stubResult
                    isFunctionCallViewPresented = false
                }
            }
        )
        .onAppear(perform: {
            store.onFunctionCalled = {
                isFunctionCallViewPresented = true
            }
        })
        .task(id: functionCallResult) {
            guard let result = functionCallResult else {
                return
            }
            
            do {
                try await store.replyFunctionCall(
                    result: result,
                    model: settingsStore.selectedModel,
                    stream: settingsStore.stream,
                    webSearchEnabled: settingsStore.webSearchEnabled,
                    functionCallingEnabled: settingsStore.functionCallingEnabled
                )
            } catch {
                errorTitle = error.localizedDescription
                errorAlertPresented = true
            }
            
            guard !Task.isCancelled else {
                // Maybe there was some change to functionCallResult from outside
                // In that case, we wouldn't want to continue this execution and mess with functionCallResult, let the outside code be in control
                return
            }
            
            functionCallResult = nil
        }
    }
    
    @ViewBuilder
    private func chatView() -> some View {
        ExyteChat.ChatView(
            messages: store.chatMessages,
            chatType: .conversation,
            replyMode: .answer,
            didSendMessage: { draftMessage in
                Task {
                    do {
                        try await store.send(
                            message: draftMessage,
                            model: settingsStore.selectedModel,
                            stream: settingsStore.stream,
                            webSearchEnabled: settingsStore.webSearchEnabled,
                            functionCallingEnabled: settingsStore.functionCallingEnabled
                        )
                    } catch {
                        errorTitle = error.localizedDescription
                        errorAlertPresented = true
                    }
                }
        })
        .setAvailableInputs([.text, .media])
        .messageUseMarkdown(true)
    }
}

private struct FunctionCallStubView: View {
    let call: ResponsesStore.WeatherFunctionCall
    let onSubmit: (String) -> Void
    
    @State private var stubResult: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("\(call.functionName) function has been called by the model with such arguments:")
                    .font(.headline)
                    .multilineTextAlignment(.center)

                Text("Location: \(call.location), Unit: \(call.unit)")
                    .font(.subheadline)

                Text("Stub the function execution result to supply the model back with results, so it can incorporate them into its final response.")
                    .font(.body)
                    .multilineTextAlignment(.center)

                TextField("Enter current weather (e.g., 21°C)", text: $stubResult)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Submit") {
                    onSubmit(stubResult)
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("Stub Function Result")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var store: ResponsesStore = {
        let store = ResponsesStore(client: PreviewMockResponsesEndpointProtocol())
        store.webSearchInProgress = true
        return store
    }()
    
    ResponsesChatDetailView(store: store)
}

private struct PreviewMockResponsesEndpointProtocol: ResponsesEndpointProtocol {
    func createResponse(query: CreateModelResponseQuery) -> AnyPublisher<ResponseObject, any Error> {
        fatalError()
    }
    
    func createResponseStreaming(query: CreateModelResponseQuery) -> AnyPublisher<Result<ResponseStreamEvent, any Error>, any Error> {
        fatalError()
    }
    
    func createResponse(query: CreateModelResponseQuery, completion: @escaping @Sendable (Result<ResponseObject, any Error>) -> Void) -> any CancellableRequest {
        fatalError()
    }
    
    func createResponse(query: CreateModelResponseQuery) async throws -> ResponseObject {
        fatalError()
    }
    
    func createResponseStreaming(query: CreateModelResponseQuery) -> AsyncThrowingStream<ResponseStreamEvent, any Error> {
        fatalError()
    }
    
    func createResponseStreaming(query: CreateModelResponseQuery, onResult: @escaping @Sendable (Result<ResponseStreamEvent, any Error>) -> Void, completion: (@Sendable ((any Error)?) -> Void)?) -> any CancellableRequest {
        fatalError()
    }
}
