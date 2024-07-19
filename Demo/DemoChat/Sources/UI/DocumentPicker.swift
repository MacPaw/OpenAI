//
//  DocumentPicker.swift
//
//
//  Created by Chris Dillard on 11/10/23.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
    var callback: (URL) -> Void

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedUITypes(), asCopy: true)
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.shouldShowFileExtensions = true

        pickerViewController.delegate = context.coordinator
        return pickerViewController
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            parent.callback(url)
        }
    }
}
