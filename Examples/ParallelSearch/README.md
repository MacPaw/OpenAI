# Parallel Search MCP example

Run free web search and page fetching with [Parallel Search MCP](https://docs.parallel.ai/integrations/mcp/search-mcp),
or prepare an MCP tool configuration for this library's Responses API. No Parallel account,
API key, or OpenAI key is needed to run these commands. Anonymous search uses Fast mode
and has lower rate limits than authenticated access.

## Run

Install Swift 6.0 or later on macOS or Linux, clone this repository, and run from its root:

```sh
swift run --package-path Examples/ParallelSearch parallel-search search \
  "Find Swift structured concurrency documentation" "Swift structured concurrency documentation"

swift run --package-path Examples/ParallelSearch parallel-search fetch \
  https://www.swift.org/documentation/

swift run --package-path Examples/ParallelSearch parallel-search query gpt-4.1 \
  "Find Swift structured concurrency documentation" web_search
```

The first two commands print the server's search results or extracted page content.
Each command connects using the MCP Swift SDK's HTTP JSON request/response transport,
discovers tools, and checks that the selected tool is available before using it.
Fetch accepts up to 20 HTTP or HTTPS URLs. Search accepts one or more keyword queries
after the objective.

The `query` command prints JSON encoded from a native `CreateModelResponseQuery` with
an opt-in `Tool.mcpTool`. It checks the selected tool names against live discovery.
Choose `web_search`, `web_fetch`, or both; omitting the names selects both.
The tool keeps approval set to `always`. Use the same construction in your existing
Responses caller, where you handle MCP approval requests. This command **does not submit
the request or generate a model answer**. Submitting a Responses request requires your
OpenAI API key and a model that supports MCP tools.

The example uses an ephemeral HTTP session without saved credentials or cookies and
does not read API keys from the environment. It does not change the library or Demo's
defaults or saved settings.

## Check

The transport tests also require Python 3 for a local HTTP fixture server.

```sh
swift test --package-path Examples/ParallelSearch
```

Tests exercise MCP discovery and tool execution through the HTTP transport, including
request headers, tool selection, errors, and Responses query serialization.
