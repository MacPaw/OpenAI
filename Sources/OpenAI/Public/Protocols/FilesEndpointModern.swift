//
//  FilesEndpointModern.swift
//  OpenAI
//

#if canImport(Combine)
public protocol FilesEndpointModern: FilesEndpointAsync, FilesEndpointCombine {}
#else
public protocol FilesEndpointModern: FilesEndpointAsync {}
#endif
