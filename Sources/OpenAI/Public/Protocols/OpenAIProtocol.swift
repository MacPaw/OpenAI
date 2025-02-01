//
//  OpenAIProtocol.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 01.02.2025.
//

import Foundation

#if canImport(Combine)
@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public protocol OpenAIProtocol: OpenAIClosureBased, OpenAIAsync, OpenAICombine {}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
extension OpenAI: OpenAIProtocol {}
#else
@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public protocol OpenAIProtocol: OpenAIClosureBased, OpenAIAsync {}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
extension OpenAI: OpenAIProtocol {}
// else, if os version is older than above:
// use OpenAIClosureBased or OpenAI
#endif
