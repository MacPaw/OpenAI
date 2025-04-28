//
//  FunctionView.swift
//
//
//  Created by Brent Whitman on 2024-01-31.
//

import SwiftUI
import OpenAI

struct FunctionView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String
    @State var description: String
    @State var parameters: String
    @Binding var function: FunctionDeclaration?
    @State var isShowingAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
                TextField("Parameters", text: $parameters)
            }
            .navigationTitle("Create Function")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let parameters = validateParameters() else {
                            return
                        }
                        guard !isShowingAlert else {
                            return
                        }
                        
                        function = FunctionDeclaration(name: name, description: description, parameters: .init(schema: parameters))
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Parameters Error"), message: Text(alertMessage))
            }
        }
    }
    
    private func validateParameters() -> (any JSONSchema)? {
        guard !parameters.isEmpty, let parametersData = parameters.data(using: .utf8) else {
            return nil
        }

        do {
            let parametersJSON = try JSONDecoder().decode([String: AnyJSONDocument].self, from: parametersData)
            return parametersJSON
        } catch {
            alertMessage = error.localizedDescription
            isShowingAlert = true
            return nil
        }
    }
}

#Preview {
    FunctionView(name: "print", description: "Prints text to the console", parameters: "{\"type\": \"string\"}", function: .constant(nil))
}
