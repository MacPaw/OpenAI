//
//  BatchesEndpointModern.swift
//  OpenAI
//

#if canImport(Combine)
public protocol BatchesEndpointModern: BatchesEndpointAsync, BatchesEndpointCombine {}
#else
public protocol BatchesEndpointModern: BatchesEndpointAsync {}
#endif
