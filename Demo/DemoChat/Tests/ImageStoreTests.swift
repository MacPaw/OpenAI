import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Testing
import os
@testable import DemoChat
@testable import OpenAI

@MainActor
@Suite(.timeLimit(.minutes(1)))
struct ImageStoreTests {
    @Test(arguments: [ImagesQuery.Size._1024, ._1536x1024, ._1024x1536, .auto], [1, 10])
    func creationSendsExplicitModel(size: ImagesQuery.Size, n: Int) async throws {
        let host = UUID().uuidString.lowercased() + ".test"
        let capturedBody = OSAllocatedUnfairLock(initialState: Data?.none)
        ImageURLProtocol.handlers.withLock { handlers in
            handlers[host] = { request in
                let stream = try #require(request.httpBody.map { InputStream(data: $0) } ?? request.httpBodyStream)
                stream.open()
                defer { stream.close() }
                let json = try JSONSerialization.jsonObject(with: stream)
                let body = try JSONSerialization.data(withJSONObject: json)
                capturedBody.withLock { $0 = body }
                return Data(#"{"created":1,"data":[{"url":"https://example.com/puppy.png"}]}"#.utf8)
            }
        }
        defer { ImageURLProtocol.handlers.withLock { $0.removeValue(forKey: host) } }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ImageURLProtocol.self]
        let session = URLSession(configuration: configuration)
        defer { session.invalidateAndCancel() }
        let client = OpenAI(configuration: .init(token: "test", host: host), session: session)
        let store = ImageStore(openAIClient: client)

        store.images(prompt: "A puppy", n: n, size: size)
        try await sleepUntil { !store.imagesQueryInProgress }

        let body = try #require(capturedBody.withLock { $0 })
        let json = try #require(JSONSerialization.jsonObject(with: body) as? [String: Any])
        #expect(json["model"] as? String == "gpt-image-1.5")
        #expect(json["prompt"] as? String == "A puppy")
        #expect(json["n"] as? Int == n)
        #expect(json["size"] as? String == size.rawValue)
        #expect(json["response_format"] == nil)
        #expect(store.images.first?.url == "https://example.com/puppy.png")
        #expect(store.imagesQueryError == nil)
    }

    @Test
    func failureIsVisibleAndRetryPublishesBase64ImagesThenCancellationEndsProgress() async throws {
        let host = UUID().uuidString.lowercased() + ".test"
        let requests = OSAllocatedUnfairLock(initialState: 0)
        let png = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+ip1sAAAAASUVORK5CYII="
        ImageURLProtocol.handlers.withLock { handlers in
            handlers[host] = { _ in
                let number = requests.withLock { count in
                    count += 1
                    return count
                }
                switch number {
                case 1:
                    return Data(#"{"error":{"message":"Image generation rejected","type":"invalid_request_error"}}"#.utf8)
                case 2:
                    return try JSONSerialization.data(withJSONObject: [
                        "created": 1, "data": [["b64_json": png], ["b64_json": png]]
                    ])
                default:
                    return nil
                }
            }
        }
        defer { ImageURLProtocol.handlers.withLock { $0.removeValue(forKey: host) } }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ImageURLProtocol.self]
        let session = URLSession(configuration: configuration)
        defer { session.invalidateAndCancel() }
        let client = OpenAI(configuration: .init(token: "test", host: host), session: session)
        let store = ImageStore(openAIClient: client)

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        try await sleepUntil { !store.imagesQueryInProgress }
        #expect(store.imagesQueryError?.localizedDescription == "Image generation rejected")
        #expect(store.images.isEmpty)

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        #expect(store.imagesQueryError == nil)
        try await sleepUntil { !store.imagesQueryInProgress }
        #expect(store.imagesQueryError == nil)
        #expect(store.images.count == 2)
        #expect(store.images.allSatisfy { $0.b64Json == png && $0.url == nil })
        #if canImport(UIKit)
        #expect(store.decodedImages.count == 2)
        #expect(store.decodedImages.allSatisfy { $0?.size == CGSize(width: 1, height: 1) })
        #endif

        store.images(prompt: "A puppy", n: 2, size: ._1024)
        try await sleepUntil { requests.withLock { $0 == 3 } }
        #expect(store.imagesQueryInProgress)
        store.cancelImagesQuery()
        #expect(!store.imagesQueryInProgress)
        #expect(store.imagesQueryError == nil)
        #expect(store.images.isEmpty)
    }
}

private final class ImageURLProtocol: URLProtocol {
    static let handlers = OSAllocatedUnfairLock(initialState: [String: @Sendable (URLRequest) throws -> Data?]())

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        do {
            let host = request.url!.host!
            let handler = try #require(Self.handlers.withLock { $0[host] })
            guard let data = try handler(request) else { return }
            let status = data.starts(with: Data(#"{"error"#.utf8)) ? 400 : 200
            let response = HTTPURLResponse(url: request.url!, statusCode: status, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
