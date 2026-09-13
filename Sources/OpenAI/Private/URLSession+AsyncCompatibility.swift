//
//  URLSession+AsyncCompatibility.swift
//  OpenAI
//
//  swift-corelibs-foundation, the Foundation used on Linux, gained the async URLSession APIs such as
//  `data(for:delegate:)` in Swift 6.0. `URLSessionProtocol` requires that method, so on earlier Linux
//  toolchains it is bridged from the completion-handler API here. Apple platforms and Swift 6 Linux use
//  Foundation's own implementation.
//

#if canImport(FoundationNetworking) && compiler(<6.0)
import Foundation
import FoundationNetworking

extension URLSession {
    /// Bridges `dataTask(with:completionHandler:)` to async/await on Linux toolchains before Swift 6.
    ///
    /// - Parameter delegate: Ignored. Per-task delegates are not supported by this Foundation version,
    ///   and the library only ever passes `nil` here.
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        let taskHolder = CancellableDataTaskHolder()
        return try await withTaskCancellationHandler {
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(Data, URLResponse), Error>) in
                // `as URLSessionDataTask` selects Foundation's method over the URLSessionProtocol overload
                // that returns URLSessionDataTaskProtocol, the same way URLSessionProtocol.swift does.
                let task = self.dataTask(with: request, completionHandler: { data, response, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else if let data, let response {
                        continuation.resume(returning: (data, response))
                    } else {
                        continuation.resume(throwing: URLError(.unknown))
                    }
                }) as URLSessionDataTask
                taskHolder.start(task)
            }
        } onCancel: {
            taskHolder.cancel()
        }
    }
}

/// Keeps the data task reachable from the cancellation handler, and cancels it even when cancellation
/// arrives before the task has been created.
private final class CancellableDataTaskHolder: @unchecked Sendable {
    private let lock = NSLock()
    private var task: URLSessionDataTask?
    private var isCancelled = false

    func start(_ task: URLSessionDataTask) {
        lock.lock()
        self.task = task
        let cancelImmediately = isCancelled
        lock.unlock()
        if cancelImmediately {
            task.cancel()
        } else {
            task.resume()
        }
    }

    func cancel() {
        lock.lock()
        isCancelled = true
        let task = self.task
        lock.unlock()
        task?.cancel()
    }
}
#endif
