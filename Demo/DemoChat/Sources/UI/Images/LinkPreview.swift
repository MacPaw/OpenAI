//
//  LinkPreview.swift
//  DemoChat
//
//  Created by Aled Samuel on 25/04/2023.
//

import SwiftUI
import LinkPresentation

struct LinkPreview: UIViewRepresentable {
    typealias UIViewType = LPLinkView
    
    var previewURL: URL
    
    func makeUIView(context: Context) -> LPLinkView {
        LPLinkView(url: previewURL)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        Task { @MainActor in
            uiView.metadata = try await fetchMetadata()
        }
    }
    
    private func fetchMetadata() async throws -> LPLinkMetadata{
        let metadata = try await LPMetadataProvider().startFetchingMetadata(for: previewURL)
        return metadata
    }
}

