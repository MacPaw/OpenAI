//
//  StreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 03.02.2025.
//

import Foundation

protocol StreamInterpreter: AnyObject, Sendable {
    associatedtype ResultType: Codable
    
    func setCallbackClosures(onEventDispatched: @escaping @Sendable (ResultType) -> Void, onError: @escaping @Sendable (Error) -> Void)
    func processData(_ data: Data)
}
