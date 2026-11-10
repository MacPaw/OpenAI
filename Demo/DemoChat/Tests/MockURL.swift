import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Testing
import os
@testable import OpenAI

/// Answers the requests of the client from `makeClient()` without a network. Each mock has its own host, so tests can
/// run in parallel. Call `remove()` when the test ends.
final class MockURL: Sendable {
    /// Answers a request. A response that starts with `{"error"` is sent with status 400, any other with status 200.
    /// Returning `nil` never answers, so the request stays in flight until it's cancelled.
    typealias Respond = @Sendable (URLRequest) throws -> Data?

    private struct State {
        var respond: Respond
        var lastBody: Data?
        var requestCount = 0
    }

    let host = UUID().uuidString.lowercased() + ".test"
    private let state: OSAllocatedUnfairLock<State>
    private let session: URLSession

    init(respond: @escaping Respond) {
        state = OSAllocatedUnfairLock(initialState: State(respond: respond))
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
        MockURLProtocol.mocks.withLock { $0[host] = self }
    }

    /// How requests are answered from now on
    var respond: Respond {
        get { state.withLock { $0.respond } }
        set { state.withLock { $0.respond = newValue } }
    }

    /// The body of the last request, `nil` before the first request or when it had none
    var lastBody: Data? { state.withLock { $0.lastBody } }

    /// The number of requests made so far
    var requestCount: Int { state.withLock { $0.requestCount } }

    func makeClient() -> OpenAI {
        OpenAI(configuration: .init(token: "test", host: host), session: session)
    }

    func remove() {
        session.invalidateAndCancel()
        MockURLProtocol.mocks.withLock { $0.removeValue(forKey: host) }
    }

    fileprivate func receive(_ request: URLRequest) throws -> Data? {
        let body = try Self.body(of: request)
        let respond = state.withLock { state in
            state.lastBody = body
            state.requestCount += 1
            return state.respond
        }
        return try respond(request)
    }

    private static func body(of request: URLRequest) throws -> Data? {
        if let body = request.httpBody {
            return body
        }
        guard let stream = request.httpBodyStream else {
            return nil
        }
        stream.open()
        defer { stream.close() }
        var body = Data()
        var buffer = [UInt8](repeating: 0, count: 4096)
        while stream.hasBytesAvailable {
            let count = stream.read(&buffer, maxLength: buffer.count)
            if count < 0 {
                throw try #require(stream.streamError)
            }
            if count == 0 {
                break
            }
            body.append(buffer, count: count)
        }
        return body
    }
}

private final class MockURLProtocol: URLProtocol {
    static let mocks = OSAllocatedUnfairLock(initialState: [String: MockURL]())

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        do {
            let url = try #require(request.url)
            let host = try #require(url.host)
            let mock = try #require(Self.mocks.withLock { $0[host] })
            guard let data = try mock.receive(request) else { return }
            let status = data.starts(with: Data(#"{"error"#.utf8)) ? 400 : 200
            let response = try #require(HTTPURLResponse(
                url: url,
                statusCode: status,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            ))
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
