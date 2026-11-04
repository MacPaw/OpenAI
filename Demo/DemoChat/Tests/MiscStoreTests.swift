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
struct MiscStoreTests {
    @Test(arguments: [200, 400])
    func moderationUsesOmniAndPreservesConversationHandling(status: Int) async throws {
        let host = UUID().uuidString.lowercased() + ".test"
        let capturedBody = OSAllocatedUnfairLock(initialState: Data?.none)
        ModerationURLProtocol.handlers.withLock { handlers in
            handlers[host] = { request in
                let stream = try #require(request.httpBody.map { InputStream(data: $0) } ?? request.httpBodyStream)
                stream.open()
                defer { stream.close() }
                let json = try JSONSerialization.jsonObject(with: stream)
                let body = try JSONSerialization.data(withJSONObject: json)
                capturedBody.withLock { $0 = body }
                if status == 400 {
                    return Data(#"{"error":{"message":"Moderation rejected","type":"invalid_request_error"}}"#.utf8)
                }
                let keys = ["harassment", "harassment/threatening", "hate", "hate/threatening",
                            "self-harm", "self-harm/intent", "self-harm/instructions", "sexual",
                            "sexual/minors", "violence", "violence/graphic", "illicit", "illicit/violent"]
                return try JSONSerialization.data(withJSONObject: [
                    "id": "modr-test", "model": "omni-moderation-latest",
                    "results": [[
                        "flagged": false,
                        "categories": Dictionary(uniqueKeysWithValues: keys.map { ($0, false) }),
                        "category_scores": Dictionary(uniqueKeysWithValues: keys.map { ($0, 0.0) }),
                        "category_applied_input_types": ["illicit": ["text"]]
                    ]]
                ])
            }
        }
        defer { ModerationURLProtocol.handlers.withLock { $0.removeValue(forKey: host) } }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ModerationURLProtocol.self]
        let session = URLSession(configuration: configuration)
        defer { session.invalidateAndCancel() }
        let client = OpenAI(configuration: .init(token: "test", host: host), session: session)
        let store = MiscStore(openAIClient: client)

        await store.sendModerationMessage(Message(id: "user", role: .user, content: "I love puppies", createdAt: Date()))

        let body = try #require(capturedBody.withLock { $0 })
        let query = try JSONDecoder().decode(ModerationsQuery.self, from: body)
        #expect(query.model == "omni-moderation-latest")
        #expect(query.input == "I love puppies")
        #expect(store.moderationConversation.messages.first?.content == "I love puppies")
        if status == 200 {
            #expect(store.moderationConversationError == nil)
            #expect(store.moderationConversation.messages.last?.role == .assistant)
            #expect(store.moderationConversation.messages.last?.content.contains("🟢 harassment") == true)
        } else {
            #expect(store.moderationConversationError?.localizedDescription == "Moderation rejected")
            #expect(store.moderationConversation.messages.count == 1)
        }
    }
}

private final class ModerationURLProtocol: URLProtocol {
    static let handlers = OSAllocatedUnfairLock(initialState: [String: @Sendable (URLRequest) throws -> Data]())

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        do {
            let host = request.url!.host!
            let handler = try #require(Self.handlers.withLock { $0[host] })
            let data = try handler(request)
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
