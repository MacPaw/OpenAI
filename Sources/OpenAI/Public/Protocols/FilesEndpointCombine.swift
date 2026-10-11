//
//  FilesEndpointCombine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine
import Foundation

public protocol FilesEndpointCombine: Sendable {
    /// Downloads the contents of a file, for example the JSONL output of a batch.
    func content(id: String) -> AnyPublisher<Data, Error>

    /// Deletes a file.
    func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error>
}
#endif
