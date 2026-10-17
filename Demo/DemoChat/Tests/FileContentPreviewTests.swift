import Foundation
import Testing
@testable import DemoChat

struct FileContentPreviewTests {
    @Test
    func showsShortTextInFull() {
        let preview = FileContentPreview(Data("{\"a\": 1}\n".utf8), maxBytes: 100)
        #expect(preview == .text("{\"a\": 1}\n", isTruncated: false))
    }

    @Test
    func truncatesLongTextToTheByteLimit() {
        let preview = FileContentPreview(Data(String(repeating: "a", count: 150).utf8), maxBytes: 100)
        #expect(preview == .text(String(repeating: "a", count: 100), isTruncated: true))
    }

    /// "€" is 3 bytes in UTF-8, so a 100-byte cut after 99 "a"s lands inside it.
    @Test
    func treatsTextCutMidCharacterAsText() {
        let text = String(repeating: "a", count: 99) + String(repeating: "€", count: 10)
        let preview = FileContentPreview(Data(text.utf8), maxBytes: 100)
        #expect(preview == .text(String(repeating: "a", count: 99), isTruncated: true))
    }

    @Test(arguments: [10, 1_000])
    func fallsBackToTheByteCountForBinaryData(byteCount: Int) {
        let data = Data((0..<byteCount).map { _ in UInt8(0xFF) })
        #expect(FileContentPreview(data, maxBytes: 100) == .binary(byteCount: byteCount))
    }
}
