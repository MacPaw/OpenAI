// Swift Testing ships with Swift 6 toolchains. The package still supports Swift 5.10, where these tests do not exist.
#if canImport(Testing)
import Foundation
import Testing
@testable import OpenAI

struct InputItemCodingTests {
    @Test func messageDecodesAsInputMessage() throws {
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

    @Test func itemReferenceRuntimeValueDecodesAsItemReference() throws {
        let item = try decode(
            """
            {
              "type": "item_reference",
              "id": "item_123"
            }
            """
        )

        #expect(item.itemReferenceId == "item_123")
    }

    @Test func compactionTriggerDecodes() throws {
        let item = try decode(
            """
            {
              "type": "compaction_trigger"
            }
            """
        )

        #expect(item.isCompactionTrigger)
    }

    @Test func programItemDecodes() throws {
        let item = try decode(
            """
            {
              "type": "program",
              "id": "cm_123",
              "call_id": "call_123",
              "code": "console.log(1)",
              "fingerprint": "fp_123"
            }
            """
        )

        #expect(item.programCallId == "call_123")
    }

    @Test func programOutputItemDecodes() throws {
        let item = try decode(
            """
            {
              "type": "program_output",
              "id": "cmo_123",
              "call_id": "call_123",
              "result": "42",
              "status": "completed"
            }
            """
        )

        #expect(item.programOutputResult == "42")
    }

    private func decode(_ json: String) throws -> InputItem {
        try JSONDecoder().decode(InputItem.self, from: Data(json.utf8))
    }
}

private extension InputItem {
    var isInputMessage: Bool {
        if case .inputMessage = self { return true }
        return false
    }

    var isCompactionTrigger: Bool {
        if case .compactionTriggerItemParam = self { return true }
        return false
    }

    var itemReferenceId: String? {
        guard case let .itemReference(param) = self else { return nil }
        return param.id
    }

    var programCallId: String? {
        guard case let .programItemParam(param) = self else { return nil }
        return param.callId
    }

    var programOutputResult: String? {
        guard case let .programOutputItemParam(param) = self else { return nil }
        return param.result
    }
}
#endif
