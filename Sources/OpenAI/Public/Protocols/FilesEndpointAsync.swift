//
//  FilesEndpointAsync.swift
//  OpenAI
//

import Foundation

public protocol FilesEndpointAsync: Sendable {
    /// Downloads the contents of a file, for example the JSONL output of a batch.
    func content(id: String) async throws -> Data

    /// Deletes a file.
    func delete(id: String) async throws -> Components.Schemas.DeleteFileResponse
}
