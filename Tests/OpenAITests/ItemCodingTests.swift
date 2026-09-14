// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
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

    // The generated decoders match wire values (`message`, `item_reference`) rather than schema names. These two
    // cases were undecodable with the previous generator patches, which did not resolve the values of
    // allOf-based resources or of nullable `type` properties.

    @Test func itemResourceMessageWithUserRoleDecodesAsInputMessageResource() throws {
        let item = try JSONDecoder().decode(
            Components.Schemas.ItemResource.self,
            from: Data(
                """
                {
                  "id": "msg_123",
                  "type": "message",
                  "role": "user",
                  "content": []
                }
                """.utf8
            )
        )

        guard case .inputMessageResource = item else {
            Issue.record("Expected inputMessageResource, got \(item)")
            return
        }
    }

    @Test func inputItemDecodesItemReferenceByWireValue() throws {
        let item = try JSONDecoder().decode(
            Components.Schemas.InputItem.self,
            from: Data(
                """
                {
                  "type": "item_reference",
                  "id": "msg_123"
                }
                """.utf8
            )
        )

        guard case .itemReferenceParam = item else {
            Issue.record("Expected itemReferenceParam, got \(item)")
            return
        }
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
#endif
