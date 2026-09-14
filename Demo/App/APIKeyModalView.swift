//
//  APIKeyModalView.swift
//  Demo
//
//  Created by Sihao Lu on 4/7/23.
//

import DemoChat
import SwiftUI

struct APIKeyModalView: View {
    @Environment(\.dismiss) var dismiss

    let isMandatory: Bool

    @Binding private var apiKey: String
    @Binding private var providerRawValue: String
    @Binding private var baseURL: String

    @State private var internalAPIKey: String
    @State private var internalProvider: APIProvider
    @State private var internalBaseURL: String

    public init(
        apiKey: Binding<String>,
        providerRawValue: Binding<String>,
        baseURL: Binding<String>,
        isMandatory: Bool = true
    ) {
        self._apiKey = apiKey
        self._providerRawValue = providerRawValue
        self._baseURL = baseURL
        self._internalAPIKey = State(initialValue: apiKey.wrappedValue)
        let provider = APIProvider(rawValue: providerRawValue.wrappedValue) ?? .custom
        self._internalProvider = State(initialValue: provider)
        self._internalBaseURL = State(
            initialValue: baseURL.wrappedValue.isEmpty
                ? provider.defaultBaseURL ?? ""
                : baseURL.wrappedValue
        )
        self.isMandatory = isMandatory
    }

    private var isConfigurationValid: Bool {
        !internalAPIKey.isEmpty && APIEndpoint(baseURL: internalBaseURL) != nil
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
                VStack(alignment: .leading, spacing: 8) {
                    Text("Provider")
                        .font(.caption)

                    Picker("Provider", selection: $internalProvider) {
                        ForEach(APIProvider.allCases) { provider in
                            Text(provider.displayName).tag(provider)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: internalProvider) { _, provider in
                        if let defaultBaseURL = provider.defaultBaseURL {
                            internalBaseURL = defaultBaseURL
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Base URL")
                        .font(.caption)

                    TextField("https://api.example.com/v1", text: $internalBaseURL)
                        .textFieldStyle(.roundedBorder)
                        .disabled(internalProvider != .custom)
                        .autocorrectionDisabled(true)
                        #if os(iOS)
                        .textInputAutocapitalization(.never)
                        #endif

                    if APIEndpoint(baseURL: internalBaseURL) == nil {
                        Text("Enter a valid HTTP or HTTPS base URL.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("API Key")
                        .font(.caption)

                    if internalProvider == .openAI {
                        let apiKeysURL = URL(
                            string: "https://platform.openai.com/account/api-keys"
                        )!
                        Link(
                            "Get an API key at platform.openai.com",
                            destination: apiKeysURL
                        )
                        .font(.caption)
                    }
                }

                TextEditor(
                    text: $internalAPIKey
                )
                .frame(height: 120)
                .font(.caption)
                .padding(8)
                .background(
                    RoundedRectangle(
                        cornerRadius: 8
                    )
                    .stroke(
                        strokeColor,
                        lineWidth: 1
                    )
                )
                .padding(4)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))

                if isMandatory {
                    HStack {
                        Spacer()

                        Button {
                            commitAndDismiss()
                        } label: {
                          Text(
                            "Continue"
                          )
                          .padding(8)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(!isConfigurationValid)

                        Spacer()
                    }
                }
            }
            .padding()
            .navigationTitle("API Configuration")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if isMandatory {
                        EmptyView()
                    } else {
                        Button("Close") {
                            commitAndDismiss()
                        }
                        .disabled(!isConfigurationValid)
                    }
                }
            }
        }
    }

    private func commitAndDismiss() {
        guard isConfigurationValid else {
            return
        }
        apiKey = internalAPIKey
        providerRawValue = internalProvider.rawValue
        baseURL = internalBaseURL.trimmingCharacters(in: .whitespacesAndNewlines)
        dismiss()
    }
}

struct APIKeyModalView_Previews: PreviewProvider {
    struct APIKeyModalView_PreviewsContainerView: View {
        @State var apiKey = ""
        @State var providerRawValue = APIProvider.openAI.rawValue
        @State var baseURL = APIProvider.openAI.defaultBaseURL ?? ""
        let isMandatory: Bool

        var body: some View {
            APIKeyModalView(
                apiKey: $apiKey,
                providerRawValue: $providerRawValue,
                baseURL: $baseURL,
                isMandatory: isMandatory
            )
        }
    }

    static var previews: some View {
        APIKeyModalView_PreviewsContainerView(isMandatory: true)
        APIKeyModalView_PreviewsContainerView(isMandatory: false)
    }
}
