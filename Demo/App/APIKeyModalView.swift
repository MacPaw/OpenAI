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

    @Binding private var configuration: DemoAPIConfiguration
    @State private var draft: DemoAPIConfiguration

    public init(
        configuration: Binding<DemoAPIConfiguration>,
        isMandatory: Bool = true
    ) {
        self._configuration = configuration
        self._draft = State(initialValue: configuration.wrappedValue)
        self.isMandatory = isMandatory
    }

    private var isConfigurationValid: Bool {
        draft.sdkConfiguration != nil
    }

    private var selectedProvider: Binding<APIProvider> {
        Binding(get: { draft.provider }, set: { draft.selectProvider($0) })
    }

    private var baseURL: Binding<String> {
        Binding(get: { draft.baseURL }, set: { draft.customBaseURL = $0 })
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Provider")
                            .font(.caption)

                        Picker("Provider", selection: selectedProvider) {
                            ForEach(APIProvider.allCases) { provider in
                                Text(provider.displayName).tag(provider)
                            }
                        }
                        .pickerStyle(.menu)
                        Text(
                            "Changing provider clears the API key. Enter credentials for the selected provider."
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Base URL")
                            .font(.caption)

                        TextField("https://api.example.com/v1", text: baseURL)
                            .textFieldStyle(.roundedBorder)
                            .disabled(draft.provider != .custom)
                            .autocorrectionDisabled(true)
                            #if os(iOS)
                                .textInputAutocapitalization(.never)
                            #endif

                        if let endpoint = APIEndpoint(baseURL: draft.baseURL) {
                            Text("Effective base URL: \(endpoint.baseURL)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("Use a valid HTTPS base URL, or HTTP with localhost, 127.x.x.x, or [::1].")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("API Key")
                            .font(.caption)

                        if draft.provider == .openAI {
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

                    SecureField("API Key", text: $draft.apiKey)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)
                        #if os(iOS)
                            .textInputAutocapitalization(.never)
                        #endif

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
            }
            .navigationTitle("API Configuration")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if isMandatory {
                        EmptyView()
                    } else {
                        Button("Save", action: commitAndDismiss)
                            .disabled(!isConfigurationValid)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    if !isMandatory {
                        Button("Cancel", role: .cancel) { dismiss() }
                    }
                }
            }
        }
        .interactiveDismissDisabled(isMandatory)
    }

    private func commitAndDismiss() {
        guard isConfigurationValid else {
            return
        }
        configuration = draft.normalized
        dismiss()
    }
}

struct APIKeyModalView_Previews: PreviewProvider {
    struct APIKeyModalView_PreviewsContainerView: View {
        @State var configuration = DemoAPIConfiguration()
        let isMandatory: Bool

        var body: some View {
            APIKeyModalView(
                configuration: $configuration,
                isMandatory: isMandatory
            )
        }
    }

    static var previews: some View {
        APIKeyModalView_PreviewsContainerView(isMandatory: true)
        APIKeyModalView_PreviewsContainerView(isMandatory: false)
    }
}
