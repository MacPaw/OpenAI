import Foundation
import Testing
@testable import DemoChat
@testable import OpenAI

@MainActor
@Suite(.timeLimit(.minutes(1)))
struct MiscStoreTests {
    @Test(arguments: [200, 400])
    func moderationUsesOmniAndPreservesConversationHandling(status: Int) async throws {
        let mock = MockURL { _ in
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
        defer { mock.remove() }
        let store = MiscStore(openAIClient: mock.makeClient())

        await store.sendModerationMessage(Message(id: "user", role: .user, content: "I love puppies", createdAt: Date()))

        let body = try #require(mock.lastBody)
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

