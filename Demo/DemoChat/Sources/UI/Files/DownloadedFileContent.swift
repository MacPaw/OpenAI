//
//  DownloadedFileContent.swift
//  DemoChat
//

import CoreTransferable
import Foundation
import UniformTypeIdentifiers

/// A downloaded file's contents, shared straight from memory, so nothing is written to disk.
struct DownloadedFileContent: Transferable {
    let data: Data
    /// A name safe to suggest to the receiving app; see ``fileName(for:fallback:)``.
    let fileName: String

    init(data: Data, filename: String, fallbackName: String) {
        self.data = data
        self.fileName = Self.fileName(for: filename, fallback: fallbackName)
    }

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .data) { $0.data }
            .suggestedFileName { $0.fileName }
    }

    /// The last path component of `filename`, which comes from the API and may contain `/` or `..`.
    /// Returns `fallback` when nothing usable is left.
    static func fileName(for filename: String, fallback: String) -> String {
        let lastComponent = filename
            .split(separator: "/", omittingEmptySubsequences: true)
            .last
            .map(String.init)?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        switch lastComponent {
        case "", ".", "..":
            return fallback
        default:
            return lastComponent
        }
    }
}
