//
//  APIKeyModalView.swift
//  Demo
//
//  Created by Sihao Lu on 4/7/23.
//

import SwiftUI

struct APIKeyModalView: View {
    @Environment(\.dismiss) var dismiss

    let isMandatory: Bool

    @Binding private var apiKey: String
    @Binding private var providerRaw: String
    @Binding private var host: String
    @Binding private var basePath: String

    @State private var internalAPIKey: String
    @State private var internalProvider: APIProvider
    @State private var internalHost: String
    @State private var internalBasePath: String

    public init(
        apiKey: Binding<String>,
        providerRaw: Binding<String>,
        host: Binding<String>,
        basePath: Binding<String>,
        isMandatory: Bool = true
    ) {
        self._apiKey = apiKey
        self._providerRaw = providerRaw
        self._host = host
        self._basePath = basePath
        self._internalAPIKey = State(initialValue: apiKey.wrappedValue)
        let resolvedProvider = APIProvider(rawValue: providerRaw.wrappedValue) ?? .openAI
        self._internalProvider = State(initialValue: resolvedProvider)
        self._internalHost = State(initialValue: host.wrappedValue.isEmpty
            ? (resolvedProvider.defaultHost ?? "")
            : host.wrappedValue)
        self._internalBasePath = State(initialValue: basePath.wrappedValue.isEmpty
            ? (resolvedProvider.defaultBasePath ?? "")
            : basePath.wrappedValue)
        self.isMandatory = isMandatory
    }

    private var strokeColor: Color {
        #if os(iOS)
        return Color(uiColor: UIColor.systemGray5)
        #elseif os(macOS)
        return Color(nsColor: NSColor.lightGray)
        #endif
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                providerPicker
                hostFields
                apiKeyField

                if isMandatory {
                    HStack {
                        Spacer()
                        Button {
                            commitAndDismiss()
                        } label: {
                            Text("Continue").padding(8)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(internalAPIKey.isEmpty || internalHost.isEmpty)
                        Spacer()
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Provider & API Key")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if isMandatory {
                        EmptyView()
                    } else {
                        Button("Close") {
                            commitAndDismiss()
                        }
                    }
                }
            }
        }
    }

    private var providerPicker: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Provider").font(.caption).foregroundColor(.secondary)
            Picker("Provider", selection: $internalProvider) {
                ForEach(APIProvider.allCases) { provider in
                    Text(provider.displayName).tag(provider)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: internalProvider) { _, newValue in
                if let host = newValue.defaultHost { internalHost = host }
                if let basePath = newValue.defaultBasePath { internalBasePath = basePath }
            }
        }
    }

    private var hostFields: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Host").font(.caption).foregroundColor(.secondary)
            TextField("api.openai.com", text: $internalHost)
                .textFieldStyle(.roundedBorder)
                .disabled(internalProvider != .custom)
                .autocorrectionDisabled(true)
                #if os(iOS)
                .textInputAutocapitalization(.never)
                #endif

            Text("Base path").font(.caption).foregroundColor(.secondary)
            TextField("/v1", text: $internalBasePath)
                .textFieldStyle(.roundedBorder)
                .disabled(internalProvider != .custom)
                .autocorrectionDisabled(true)
                #if os(iOS)
                .textInputAutocapitalization(.never)
                #endif
        }
    }

    private var apiKeyField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("API Key").font(.caption).foregroundColor(.secondary)
            if internalProvider == .openAI {
                Link(
                    "Get a key at platform.openai.com/account/api-keys",
                    destination: URL(string: "https://platform.openai.com/account/api-keys")!
                )
                .font(.caption)
            }
            TextEditor(text: $internalAPIKey)
                .frame(height: 100)
                .font(.caption)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(strokeColor, lineWidth: 1)
                )
                .padding(4)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    private func commitAndDismiss() {
        apiKey = internalAPIKey
        providerRaw = internalProvider.rawValue
        host = internalHost
        basePath = internalBasePath
        dismiss()
    }
}

struct APIKeyModalView_Previews: PreviewProvider {
    struct APIKeyModalView_PreviewsContainerView: View {
        @State var apiKey = ""
        @State var providerRaw = APIProvider.openAI.rawValue
        @State var host = APIProvider.openAI.defaultHost ?? ""
        @State var basePath = APIProvider.openAI.defaultBasePath ?? ""
        let isMandatory: Bool

        var body: some View {
            APIKeyModalView(
                apiKey: $apiKey,
                providerRaw: $providerRaw,
                host: $host,
                basePath: $basePath,
                isMandatory: isMandatory
            )
        }
    }

    static var previews: some View {
        APIKeyModalView_PreviewsContainerView(isMandatory: true)
        APIKeyModalView_PreviewsContainerView(isMandatory: false)
    }
}
