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
    @Binding private var proxy: String
    @State private var internalAPIKey: String
    @State private var internalProxy: String

    public init(
        apiKey: Binding<String>,
        proxy: Binding<String>,
        isMandatory: Bool = true
    ) {
        self._apiKey = apiKey
        self._proxy = proxy
        self._internalAPIKey = State(initialValue: apiKey.wrappedValue)
        self._internalProxy = State(initialValue: proxy.wrappedValue)
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

                VStack(alignment: .leading, spacing: 8) {
                    Text(
                    "You can find and configure your OpenAI API key at"
                    )
                    .font(.caption)

                    Link(
                        "https://platform.openai.com/account/api-keys",
                        destination: URL(string: "https://platform.openai.com/account/api-keys")!
                    )
                    .font(.caption)
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


                VStack(alignment: .leading, spacing: 8) {
                    Text(
                        "Set your proxy."
                    )
                    .font(.caption)
                }

                TextEditor(
                    text: $internalProxy
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
                            apiKey = internalAPIKey
                            proxy = internalProxy
                            dismiss()
                        } label: {
                          Text(
                            "Continue"
                          )
                          .padding(8)
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(internalAPIKey.isEmpty && internalProxy.isEmpty || !internalAPIKey.isEmpty && !internalProxy.isEmpty)

                        Spacer()
                    }
                }
            }
            .padding()
            .navigationTitle("OpenAI API Key")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if isMandatory {
                        EmptyView()
                    } else {
                        Button("Close") {
                            apiKey = internalAPIKey
                            dismiss()
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("OpenAI Reverse Proxy")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    if isMandatory {
                        EmptyView()
                    } else {
                        Button("Close") {
                            proxy = internalProxy
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct APIKeyModalView_Previews: PreviewProvider {
    struct APIKeyModalView_PreviewsContainerView: View {
        @State var apiKey = ""
        @State var proxy = ""
        let isMandatory: Bool

        var body: some View {
            APIKeyModalView(
                apiKey: $apiKey,
                proxy: $proxy,
                isMandatory: isMandatory
            )
        }
    }

    static var previews: some View {
        APIKeyModalView_PreviewsContainerView(isMandatory: true)
        APIKeyModalView_PreviewsContainerView(isMandatory: false)
    }
}
