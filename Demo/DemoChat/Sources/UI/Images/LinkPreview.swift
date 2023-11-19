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
        LPMetadataProvider().startFetchingMetadata(for: previewURL) { metadata, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let metadata = metadata else {
                print("Metadata missing for \(previewURL.absoluteString)")
                return
            }
            uiView.metadata = metadata
        }
    }
}
