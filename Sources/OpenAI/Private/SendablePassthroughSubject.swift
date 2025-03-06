//
//  SendablePassthroughSubject.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 04.03.2025.
//

#if canImport(Combine)
import Foundation
import Combine

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
final class SendablePassthroughSubject<Output: Sendable, Failure: Error>: @unchecked Sendable {
    private let passthroughSubject: PassthroughSubject<Output, Failure>
    
    init(passthroughSubject: PassthroughSubject<Output, Failure>) {
        self.passthroughSubject = passthroughSubject
    }
    
    func send(_ input: Output) {
        DispatchQueue.userInitiated.async {
            self.passthroughSubject.send(input)
        }
    }
    
    func send(completion: Subscribers.Completion<Failure>) {
        DispatchQueue.userInitiated.async {
            self.passthroughSubject.send(completion: completion)
        }
    }
    
    func publisher() -> AnyPublisher<Output, Failure> {
        passthroughSubject.eraseToAnyPublisher()
    }
}
#endif
