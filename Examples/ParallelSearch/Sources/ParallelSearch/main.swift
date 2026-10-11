import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import MCP
import OpenAI

enum ExampleError: Swift.Error, CustomStringConvertible {
    case message(String)
    var description: String {
        switch self { case .message(let text): return text }
    }
}

enum Command {
    case search(objective: String, queries: [String])
    case fetch(urls: [String])
    case query(model: String, prompt: String, tools: [String])

    static let usage = """
    Usage:
      parallel-search search "objective" "keyword query" ["another query" ...]
      parallel-search fetch https://example.com [https://example.org ...]
      parallel-search query MODEL "prompt" [web_search web_fetch]

    Search and fetch call anonymous Parallel Search MCP directly.
    Query prints a Responses API request; it does not submit it.
    """

    init(arguments: [String]) throws {
        guard let mode = arguments.first,
              arguments.dropFirst().allSatisfy({ !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty })
        else { throw ExampleError.message(Self.usage) }
        switch mode {
        case "search" where arguments.count >= 3:
            self = .search(objective: arguments[1], queries: Array(arguments.dropFirst(2)))
        case "fetch" where (2...21).contains(arguments.count):
            let urls = Array(arguments.dropFirst())
            guard urls.allSatisfy({
                guard let url = URL(string: $0), let host = url.host, !host.isEmpty else { return false }
                return ["http", "https"].contains(url.scheme?.lowercased() ?? "")
            }) else { throw ExampleError.message("Fetch requires HTTP or HTTPS URLs.") }
            self = .fetch(urls: urls)
        case "query" where arguments.count >= 3:
            let tools = arguments.count == 3 ? ["web_search", "web_fetch"] : Array(arguments.dropFirst(3))
            guard tools.allSatisfy({ ["web_search", "web_fetch"].contains($0) }) else {
                throw ExampleError.message("Select web_search, web_fetch, or both.")
            }
            self = .query(model: arguments[1], prompt: arguments[2], tools: Array(Set(tools)).sorted())
        default:
            throw ExampleError.message(Self.usage)
        }
    }

    var selectedTools: [String] {
        switch self {
        case .search: return ["web_search"]
        case .fetch: return ["web_fetch"]
        case .query(_, _, let tools): return tools
        }
    }
}

struct ParallelExample {
    static let endpoint = URL(string: "https://search.parallel.ai/mcp")!
    static let userAgent = "MacPaw-OpenAI-ParallelSearchExample/1.0"

    static func configuration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = ["User-Agent": userAgent]
        configuration.urlCredentialStorage = nil
        configuration.httpCookieStorage = nil
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        return configuration
    }

    static func run(_ command: Command, configuration: URLSessionConfiguration = configuration(), endpoint: URL = endpoint) async throws -> String {
        let client = MCP.Client(name: "MacPaw-OpenAI-ParallelSearchExample", version: "1.0")
        // JSON request/response mode also works on Linux, where SDK 0.9.0 does not support SSE.
        let transport = HTTPClientTransport(endpoint: endpoint, configuration: configuration, streaming: false)
        do {
            _ = try await client.connect(transport: transport)
            var names = Set<String>()
            var cursor: String?
            repeat {
                let page = try await client.listTools(cursor: cursor)
                names.formUnion(page.tools.map(\.name))
                cursor = page.nextCursor
            } while cursor != nil
            guard Set(command.selectedTools).isSubset(of: names) else {
                throw ExampleError.message("The server did not advertise the selected tools: \(command.selectedTools.joined(separator: ", ")).")
            }

            let output: String
            switch command {
            case .query(let model, let prompt, let tools):
                let query = CreateModelResponseQuery(input: .textInput(prompt), model: model, tools: [.mcpTool(.init(
                    _type: .mcp,
                    serverLabel: "parallel_search",
                    serverUrl: endpoint.absoluteString,
                    headers: .init(additionalProperties: ["User-Agent": userAgent]),
                    allowedTools: .case1(tools),
                    requireApproval: .case2(.always)
                ))])
                let encoder = JSONEncoder()
                encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
                output = String(decoding: try encoder.encode(query), as: UTF8.self)
            case .search(let objective, let queries):
                output = try await call(client, name: "web_search", arguments: [
                    "objective": .string(objective),
                    "search_queries": .array(queries.map { .string($0) }),
                    "session_id": .string(UUID().uuidString)
                ])
            case .fetch(let urls):
                output = try await call(client, name: "web_fetch", arguments: [
                    "urls": .array(urls.map { .string($0) }),
                    "session_id": .string(UUID().uuidString)
                ])
            }
            await client.disconnect()
            return output
        } catch {
            await client.disconnect()
            throw error
        }
    }

    private static func call(_ client: MCP.Client, name: String, arguments: [String: MCP.Value]) async throws -> String {
        let result = try await client.callTool(name: name, arguments: arguments)
        let text = result.content.compactMap { content -> String? in
            if case .text(let text) = content { return text }
            return nil
        }.joined(separator: "\n")
        guard result.isError != true else { throw ExampleError.message("\(name) failed: \(text)") }
        guard !text.isEmpty else { throw ExampleError.message("\(name) returned no text.") }
        return text
    }
}

@main
struct ParallelSearch {
    static func main() async {
        do {
            let command = try Command(arguments: Array(CommandLine.arguments.dropFirst()))
            print(try await ParallelExample.run(command))
        } catch {
            FileHandle.standardError.write(Data("\(error)\n".utf8))
            exit(1)
        }
    }
}
