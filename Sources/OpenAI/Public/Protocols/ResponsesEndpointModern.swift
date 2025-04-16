//
//  ResponsesEndpointModern.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 14.04.2025.
//

#if canImport(Combine)
public protocol ResponsesEndpointModern: ResponsesEndpointAsync, ResponsesEndpointCombine {}
#else
public protocol ResponsesEndpointModern: ResponsesEndpointAsync {}
#endif
