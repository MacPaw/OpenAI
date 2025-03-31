//
//  ListView.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import SwiftUI

struct AssistantsListView: View {
    @Binding var assistants: [Assistant]
    @Binding var selectedAssistantId: String?
    var onLoadMoreAssistants: () -> Void
    @Binding var isLoadingMore: Bool

    var body: some View {
        VStack {
            List(
                $assistants,
                editActions: [.delete],
                selection: $selectedAssistantId
            ) { $assistant in
                HStack {
                    Text(assistant.name)
                        .lineLimit(2)
                    Spacer()
                    if assistant.id == selectedAssistantId {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                .onAppear {
                    if assistant.id == assistants.last?.id {
                        onLoadMoreAssistants()
                    }
                }
            }


            if isLoadingMore {
                ProgressView()
                    .padding()
            }
        }
        .navigationTitle("Assistants")
    }
}
