import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Testing
@testable import ParallelSearch

private final class ServerFixture {
    let process = Process()
    let directory: URL
    let endpoint: URL

    init(missingFetch: Bool = false, toolError: Bool = false) throws {
        directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let output = Pipe()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["python3", Bundle.module.url(forResource: "server", withExtension: "py")!.path,
                             directory.appendingPathComponent("requests.json").path,
                             missingFetch ? "missing" : "all", toolError ? "error" : "success"]
        process.standardOutput = output
        try process.run()
        var address = Data()
        while let byte = try output.fileHandleForReading.read(upToCount: 1), !byte.isEmpty {
            if byte == Data([10]) { break }
            address.append(byte)
        }
        guard let url = URL(string: String(decoding: address, as: UTF8.self)), url.host == "127.0.0.1" else {
            process.terminate()
            throw ExampleError.message("Cannot start Python 3 HTTP fixture server")
        }
        endpoint = url
    }

    func recorded() throws -> [[String: Any]] {
        try JSONSerialization.jsonObject(with: Data(contentsOf: directory.appendingPathComponent("requests.json"))) as! [[String: Any]]
    }

    deinit {
        process.terminate()
        process.waitUntilExit()
        try? FileManager.default.removeItem(at: directory)
    }
}

@Suite(.serialized)
struct ParallelSearchTests {
    private func checkRequests(_ server: ServerFixture) throws {
        let requests = try server.recorded()
        #expect(!requests.isEmpty)
        for request in requests {
            #expect(request["path"] as? String == "/mcp")
            #expect(request["method"] as? String == "POST")
            let headers = try #require(request["headers"] as? [String: String])
            #expect(headers["user-agent"] == ParallelExample.userAgent)
            #expect(headers["authorization"] == nil)
            #expect(headers["cookie"] == nil)
        }
        let methods = requests.compactMap { ($0["body"] as? [String: Any])?["method"] as? String }
        #expect(methods.contains("initialize"))
        #expect(methods.contains("tools/list"))
        #expect(ParallelExample.endpoint.absoluteString == "https://search.parallel.ai/mcp")
    }

    @Test func discoveryDispatchAndAnonymousHeaders() async throws {
        for arguments in [["search", "Find Swift docs", "Swift concurrency docs"], ["fetch", "https://www.swift.org/documentation/"]] {
            let server = try ServerFixture()
            let command = try Command(arguments: arguments)
            let output = try await ParallelExample.run(command, endpoint: server.endpoint)
            #expect(output.contains("https://www.swift.org/documentation/"))
            try checkRequests(server)
            let calls = try server.recorded().compactMap { $0["body"] as? [String: Any] }.filter { $0["method"] as? String == "tools/call" }
            #expect(calls.count == 1)
            let params = try #require(calls.first?["params"] as? [String: Any])
            #expect(params["name"] as? String == command.selectedTools.first)
            let toolArguments = try #require(params["arguments"] as? [String: Any])
            #expect(UUID(uuidString: try #require(toolArguments["session_id"] as? String)) != nil)
            if arguments[0] == "search" {
                #expect(toolArguments["objective"] as? String == "Find Swift docs")
                #expect(toolArguments["search_queries"] as? [String] == ["Swift concurrency docs"])
            } else {
                #expect(toolArguments["urls"] as? [String] == ["https://www.swift.org/documentation/"])
            }
        }
    }

    @Test func nativeQueryUsesSelectedDiscoveredToolWithoutSubmitting() async throws {
        let server = try ServerFixture()
        let output = try await ParallelExample.run(try Command(arguments: ["query", "gpt-4.1", "Find Swift docs", "web_search"]), endpoint: server.endpoint)
        let query = try #require(try JSONSerialization.jsonObject(with: Data(output.utf8)) as? [String: Any])
        #expect(query["model"] as? String == "gpt-4.1")
        #expect(query["input"] as? String == "Find Swift docs")
        let tools = try #require(query["tools"] as? [[String: Any]])
        #expect(tools.count == 1)
        #expect(tools[0]["server_url"] as? String == server.endpoint.absoluteString)
        #expect(tools[0]["allowed_tools"] as? [String] == ["web_search"])
        #expect(tools[0]["require_approval"] as? String == "always")
        #expect(tools[0]["headers"] as? [String: String] == ["User-Agent": ParallelExample.userAgent])
        #expect(try !server.recorded().contains { ($0["body"] as? [String: Any])?["method"] as? String == "tools/call" })
        try checkRequests(server)
    }

    @Test func missingToolsAndToolFailuresAreErrors() async throws {
        let server = try ServerFixture(missingFetch: true)
        await #expect(throws: ExampleError.self) {
            try await ParallelExample.run(.fetch(urls: ["https://www.swift.org"]), endpoint: server.endpoint)
        }
        #expect(try !server.recorded().contains { ($0["body"] as? [String: Any])?["method"] as? String == "tools/call" })
        let failingServer = try ServerFixture(toolError: true)
        await #expect(throws: ExampleError.self) {
            try await ParallelExample.run(.search(objective: "Swift", queries: ["Swift docs"]), endpoint: failingServer.endpoint)
        }
    }

    @Test func invalidArgumentsAndUnrelatedToolsAreRejected() {
        for arguments in [[], ["fetch", "file:///etc/passwd"], ["fetch", "https:///"], ["search", "Swift", ""], ["query", "gpt-4.1", "Swift", "unrelated_tool"]] {
            #expect(throws: ExampleError.self) { try Command(arguments: arguments) }
        }
    }
}
