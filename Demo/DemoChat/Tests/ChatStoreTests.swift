import Foundation
import Testing
@testable import DemoChat
@testable import OpenAI

// A reply's request is never answered, so a test ends it by cancelling it; if that doesn't end it, fail the test instead
// of waiting forever.
@MainActor
@Suite(.timeLimit(.minutes(1)))
struct ChatStoreTests {
    @Test
    func deletesAConversation() throws {
        let store = makeStore()
        store.createConversation()
        store.createConversation()
        let ids = store.conversations.map(\.id)

        try store.deleteConversation(ids[0])

        #expect(store.conversations.map(\.id) == [ids[1]])
    }

    /// A reply's requests refer to its conversation by position, which deleting an earlier conversation would shift.
    @Test(arguments: [true, false])
    func deletionIsRefusedWhileAReplyIsInProgress(isStreamEnabled: Bool) async throws {
        let store = makeStore()
        store.createConversation()
        store.createConversation()
        let ids = store.conversations.map(\.id)

        let reply = Task {
            await store.sendMessage(
                Message(id: "message", role: .user, content: "Hi", createdAt: Date(timeIntervalSince1970: 0)),
                conversationId: ids[1],
                model: .gpt4_o,
                isStreamEnabled: isStreamEnabled
            )
        }
        // The message is added before the request is sent.
        try await sleepUntil { !store.conversations[1].messages.isEmpty }

        #expect(throws: ChatStore.ReplyInProgressError.self) {
            try store.deleteConversation(ids[0])
        }
        #expect(store.conversations.map(\.id) == ids)

        reply.cancel()
        await reply.value
        try store.deleteConversation(ids[0])
        #expect(store.conversations.map(\.id) == [ids[1]])
    }

    private func makeStore() -> ChatStore {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [NeverAnsweringURLProtocol.self]
        let client = OpenAI(configuration: .init(token: "test"), session: URLSession(configuration: configuration))
        return ChatStore(openAIClient: client, idProvider: { UUID().uuidString })
    }
}

/// Receives requests and never answers them, so a reply stays in progress until its task is cancelled.
private final class NeverAnsweringURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {}
    override func stopLoading() {}
}
