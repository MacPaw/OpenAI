//
//  File.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 08.02.2025.
//

#if canImport(Combine)
import Foundation
import Combine

class MockDataTaskPublisher: Publisher {
    // Declaring that our publisher doesn't emit any values,
    // and that it can never fail:
    typealias Output = (data: Data, response: URLResponse)
    typealias Failure = URLError
    
    var subscription: CancellableMock?
    
    // Combine will call this method on our publisher whenever
    // a new object started observing it. Within this method,
    // we'll need to create a subscription instance and
    // attach it to the new subscriber:
    func receive<S: Subscriber>(
        subscriber: S
    ) where S.Input == Output, S.Failure == Failure {
        // Creating our custom subscription instance:
        let subscription = MockDataTaskSubscription<S>()
        subscription.target = subscriber
        self.subscription = subscription
        
        // Attaching our subscription to the subscriber:
        subscriber.receive(subscription: subscription)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            MainActor.assumeIsolated {
                subscription.trigger()
            }
        })
    }
}

protocol CancellableMock: Sendable {
    var cancelCallCount: Int { get }
}
                                      
class MockDataTaskSubscription<Target: Subscriber>: Subscription, CancellableMock, @unchecked Sendable
where Target.Input == (data: Data, response: URLResponse) {
    
    var target: Target?
    
    // This subscription doesn't respond to demand, since it'll
    // simply emit events according to its underlying UIControl
    // instance, but we still have to implement this method
    // in order to conform to the Subscription protocol:
    func request(_ demand: Subscribers.Demand) {}
    
    var cancelCallCount = 0
    func cancel() {
        cancelCallCount += 1
        // When our subscription was cancelled, we'll release
        // the reference to our target to prevent any
        // additional events from being sent to it:
        target = nil
    }
    
    @objc func trigger() {
        // Whenever an event was triggered by the underlying
        // UIControl instance, we'll simply pass Void to our
        // target to emit that event:
        _ = target?.receive((Data(), URLResponse()))
    }
}
#endif
