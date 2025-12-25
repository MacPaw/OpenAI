//
//  FileDeleteResult.swift
//  OpenAI
//
//  Result from deleting a file.
//

import Foundation

/// Result from deleting a file via the Files API.
public struct FileDeleteResult: Codable, Equatable, Sendable {
    /// The file ID that was deleted.
    public let id: String
    /// The object type (always "file").
    public let object: String
    /// Whether the file was successfully deleted.
    public let deleted: Bool
}
