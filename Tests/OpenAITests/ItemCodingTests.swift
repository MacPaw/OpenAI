import Foundation
import Testing
@testable import OpenAI

struct ItemCodingTests {
    @Test func messageWithUserRoleDecodesAsInputMessage() throws {
        let item = try decode(
            """
            {
              "type": "message",
              "role": "user",
              "content": []
            }
            """
        )

        #expect(item.isInputMessage)
    }

    @Test func messageWithAssistantRoleAndOutputFieldsDecodesAsOutputMessage() throws {
        let item = try decode(
            """
            {
              "id": "msg_123",
              "type": "message",
              "role": "assistant",
              "content": [],
              "status": "completed"
            }
            """
        )

        #expect(item.isOutputMessage)
    }

    @Test func webSearchActionWithQueriesDecodesWhenDeprecatedQueryIsMissing() throws {
        let item = try decode(
            """
            {
              "id": "ws_123",
              "type": "web_search_call",
              "status": "completed",
              "action": {
                "type": "search",
                "queries": ["baseball in Ukraine"]
              }
            }
            """
        )

        #expect(item.webSearchQueries == ["baseball in Ukraine"])
    }

    private func decode(_ json: String) throws -> Components.Schemas.Item {
        try JSONDecoder().decode(Components.Schemas.Item.self, from: Data(json.utf8))
    }
}

private extension Components.Schemas.Item {
    var isInputMessage: Bool {
        if case .inputMessage = self { return true }
        return false
    }

    var isOutputMessage: Bool {
        if case .outputMessage = self { return true }
        return false
    }

    var webSearchQueries: [String]? {
        guard case let .webSearchToolCall(call) = self,
              case let .webSearchActionSearch(action) = call.action else {
            return nil
        }
        return action.queries
    }
}
