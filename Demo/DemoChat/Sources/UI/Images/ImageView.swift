//
//  ImageView.swift
//  DemoChat
//
//  Created by Aled Samuel on 24/04/2023.
//

import SwiftUI

public struct ImageView: View {
    @ObservedObject var store: ImageStore
    
    public init(store: ImageStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            List {
                NavigationLink("Create Image", destination: ImageCreationView(store: store))
                NavigationLink("Create Image Edit", destination: ImageEditView(store: store))
                    .disabled(true)
                NavigationLink("Create Image Variation", destination: ImageVariationView(store: store))
                    .disabled(true)
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Image")
        }
    }
}

public struct ImageEditView: View {
    @ObservedObject var store: ImageStore
    
    public init(store: ImageStore) {
        self.store = store
    }
    
    public var body: some View {
        List {
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Create Image Edit")
    }
}

public struct ImageVariationView: View {
    @ObservedObject var store: ImageStore
    
    public init(store: ImageStore) {
        self.store = store
    }
    
    public var body: some View {
        List {
            
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Create Image Variation")
    }
}
