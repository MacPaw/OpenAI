//
//  FilesEndpoint+Combine.swift
//  OpenAI
//

#if canImport(Combine)
import Combine
import Foundation

extension FilesEndpoint: FilesEndpointCombine {
    public func content(id: String) -> AnyPublisher<Data, Error> {
        combineClient.performRawDataRequest(request: makeContentRequest(id: id))
    }

    public func delete(id: String) -> AnyPublisher<Components.Schemas.DeleteFileResponse, Error> {
        combineClient.performRequest(request: makeDeleteRequest(id: id))
    }
}
#endif
