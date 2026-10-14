import Testing
@testable import DemoChat

struct DownloadedFileContentTests {
    @Test(arguments: [
        ("report.jsonl", "report.jsonl"),
        ("../outside.txt", "outside.txt"),
        ("a/b/c.txt", "c.txt"),
        ("/absolute/path.txt", "path.txt"),
        ("trailing/slash/", "slash"),
        ("  padded.txt  ", "padded.txt"),
    ])
    func keepsOnlyTheLastPathComponent(filename: String, expected: String) {
        #expect(DownloadedFileContent.fileName(for: filename, fallback: "file-abc") == expected)
    }

    @Test(arguments: ["", "/", ".", "..", "a/..", "   "])
    func fallsBackWhenNothingUsableIsLeft(filename: String) {
        #expect(DownloadedFileContent.fileName(for: filename, fallback: "file-abc") == "file-abc")
    }
}
