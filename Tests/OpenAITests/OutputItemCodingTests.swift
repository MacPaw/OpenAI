// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
import Foundation
import Testing
@testable import OpenAI

struct OutputItemCodingTests {
    @Test func webSearchToolCallWithoutActionDecodesWithNilAction() throws {
        // The live API can emit this shape in a `response.output_item.added` event before it has
        // decided on an action, even though the spec marks `action` required.
        let item = try decode(
            """
            {
              "id": "ws_123",
              "type": "web_search_call",
              "status": "in_progress"
            }
            """
        )

        guard case let .webSearchToolCall(call) = item else {
            Issue.record("Expected .webSearchToolCall, got \(item)")
            return
        }
        #expect(call.id == "ws_123")
        #expect(call.action == nil)
    }

    @Test func webSearchToolCallWithActionDecodesAction() throws {
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

        guard case let .webSearchToolCall(call) = item,
              case let .webSearchActionSearch(action) = call.action else {
            Issue.record("Expected .webSearchToolCall with a search action, got \(item)")
            return
        }
        #expect(action.queries == ["baseball in Ukraine"])
    }

    @Test func reasoningItemDecodes() throws {
        let item = try decode(
            """
            {
              "id": "rs_123",
              "type": "reasoning",
              "summary": []
            }
            """
        )

        if case .reasoning = item {
            // expected
        } else {
            Issue.record("Expected .reasoning, got \(item)")
        }
    }

    private func decode(_ json: String) throws -> OutputItem {
        try JSONDecoder().decode(OutputItem.self, from: Data(json.utf8))
    }
}
#endif
