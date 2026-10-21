//
//  FileContentPreview.swift
//  DemoChat
//

import Foundation

/// What the detail screen shows for downloaded file content: the start of it as text, or its size when it isn't
/// UTF-8 text. Built once per download from a bounded prefix, so a large file is never decoded or counted in full.
enum FileContentPreview: Equatable {
    /// How many bytes of the content to decode for the preview.
    static let maxBytes = 20_000

    case text(String, isTruncated: Bool)
    case binary(byteCount: Int)

    init(_ data: Data, maxBytes: Int = Self.maxBytes) {
        guard data.count > maxBytes else {
            self = String(data: data, encoding: .utf8).map { .text($0, isTruncated: false) }
                ?? .binary(byteCount: data.count)
            return
        }
        // Cutting at `maxBytes` can split a multi-byte UTF-8 character (up to 4 bytes), which makes the prefix
        // invalid UTF-8 although the content is text. Drop up to 3 trailing bytes before deciding it's binary.
        let prefix = data.prefix(maxBytes)
        for droppedBytes in 0...3 {
            if let text = String(data: prefix.dropLast(droppedBytes), encoding: .utf8) {
                self = .text(text, isTruncated: true)
                return
            }
        }
        self = .binary(byteCount: data.count)
    }
}
