//
//  ListModelsView.swift
//  DemoChat
//
//  Created by Aled Samuel on 22/04/2023.
//

import SwiftUI

public struct ListModelsView: View {
    @ObservedObject var store: MiscStore
    
    public var body: some View {
        NavigationStack {
            List($store.availableModels) { row in
                Text(row.id)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Models")
        }
        .onAppear {
            Task {
                await store.getModels()
            }
        }
    }
}
