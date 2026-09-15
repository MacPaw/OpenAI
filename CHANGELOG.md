# Changelog

All notable changes to this package are documented in this file. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and versions follow [Semantic Versioning](https://semver.org/).

Compatibility promise: the public API is additive-only. Anything `public` is deprecated before it is removed, and every pull request is compared with the latest release by `swift package diagnose-api-breaking-changes` in CI. See the *API stability* section of [CONTRIBUTING.md](CONTRIBUTING.md).

## [Unreleased]

### Added
- `ResponseStreamEvent.shellCall`, covering the new shell-call streaming events (`response.shell_call_command.added/delta/done`, `response.shell_call_output_content.delta/done`) added by the latest OpenAPI spec.
- `Tool.programmaticToolCallingTool`, the tool case paired with the `OutputItem.program`/`.programOutput` response items; without it, decoding a response whose `tools` array contains a `programmatic_tool_calling` tool would throw.
- `ResponseStreamEvent.customToolCallInput`, covering the previously unhandled `response.custom_tool_call_input.delta/done` streaming events; without it, a custom-tool streaming response would fail the whole stream with an `unknownEventType` error.
- CI: an *API Breakage* workflow fails a pull request that changes the public API compared with the latest release tag. Consciously accepted breaks are listed in `.github/api-breakage-allowlist.txt` with a matching changelog entry.
- CI: the *Swift Build* workflow now builds and tests on Linux with Swift 5.10, 6.0 and 6.3 containers, tests on macOS and the iOS Simulator, and builds for tvOS, watchOS and visionOS with Xcode. Tests written with Swift Testing only exist on toolchains that ship it (Swift 6); the XCTest suite runs everywhere.
- CONTRIBUTING.md: API stability policy, including how new endpoint groups are added as namespaces and how generated `Components.Schemas` types are treated.
- This changelog.

### Changed
- **Breaking:** Regenerated `Components.Schemas` from the latest OpenAPI spec. Most of the reported breaks are mechanical (new cases added to generated enums, and generated memberwise initializers gaining parameters for new optional fields) and are allowlisted in `.github/api-breakage-allowlist.txt` without individual call-outs, matching how the `0.5.1` regeneration was documented. The changes worth knowing about if you read or construct these types directly:
  - `ResponseObject.instructions` changed from `String?` to `ResponseObject.Instructions?`, letting `instructions` be either a plain string or a list of input items. `Instructions` is a generated two-case enum (`.case1(String)` for the string form, `.case2([InputItem])` for the list form); code that read `instructions` as a `String` needs to switch over it instead. This mirrors how the official Python SDK models the same field (`Union[str, List[ResponseInputItem], None]`) rather than adding a second property under a new name.
  - `Components.Schemas.ServiceTier` was renamed to `ServiceTierResponses`.
  - `Components.Schemas.Conversation2` was removed; `Response.conversation` and `ResponseProperties`-derived types now use `ResponseConversation` instead.
  - `MCPToolCall.error` changed from `String?` to `MCPToolCallError?`.
  - `ResponseOutputTextAnnotationAddedEvent.annotation` changed from `OpenAPIObjectContainer` to `Annotation?`, matching the stricter `Annotation` schema.
  - `FunctionToolCallOutput.callId` and `FunctionCallOutputItemParam.callId` changed from `String` to `String?`.
  - `ResponseStreamEvent.reasoning` was renamed to `.reasoningText`, with its payload changing from `ReasoningEvent` to `ReasoningTextEvent`.

### Fixed
- `ResponseStreamEvent.reasoningText` streaming events never decoded: `ModelResponseStreamEventType` listened for `response.reasoning.delta`/`.done`, but the API sends `response.reasoning_text.delta`/`.done`, so reasoning-text deltas always failed with an `unknownEventType` error.
- `make download-spec` could leave the tracked `openapi.yaml` truncated if `curl` was interrupted mid-transfer; it now downloads to a temp file and moves it into place only on success.
- Build warning in `ModelResponseEventsStreamInterpreter` when logging a failed stream event decode in debug builds.
- The test target compiles for the package's minimum iOS deployment target again; it used `Regex`, which requires iOS 16.
- Building on Linux with Swift 5.10 works again. swift-corelibs-foundation gained the async `URLSession` APIs only in Swift 6, so the async client now bridges the completion-handler API on older Linux toolchains.

## [0.5.1] - 2026-07-21

### Added
- `refusal` field on the streaming chat completion delta ([#408](https://github.com/MacPaw/OpenAI/pull/408)).
- `reasoningContent` on assistant chat messages for providers that return reasoning ([#402](https://github.com/MacPaw/OpenAI/pull/402)).
- `annotations` on `ChatStreamResult` ([#399](https://github.com/MacPaw/OpenAI/pull/399)).

### Changed
- Regenerated `Components.Schemas` from the updated OpenAPI spec ([#433](https://github.com/MacPaw/OpenAI/pull/433)). This changed public generated types: transcription segment and word timestamps moved from `Float` to `Double`, `ImageGenTool.SizePayload` lost its fixed cases, `responseId` was removed from the response audio events, and `ChatResult.Choice.Message.Annotation` moved to a top-level `Annotation` type. Two `ChatCompletionMessageParam` initializers were removed.
- swift-openapi-runtime 1.11.0 → 1.12.0 ([#424](https://github.com/MacPaw/OpenAI/pull/424)).

## [0.5.0] - 2026-06-05

### Added
- `model` is optional in `CreateModelResponseQuery` for the stored-prompt (`prompt_id`) flow ([#419](https://github.com/MacPaw/OpenAI/pull/419)).

### Changed
- Regenerated `Components.Schemas` from the fresh OpenAPI spec ([#423](https://github.com/MacPaw/OpenAI/pull/423)); the release notes flagged possible breaking changes.
- swift-openapi-runtime 1.8.2 → 1.11.0 ([#416](https://github.com/MacPaw/OpenAI/pull/416)).

### Fixed
- Missing `name` field on `ResponseFunctionCallArgumentsDoneEvent` ([#420](https://github.com/MacPaw/OpenAI/pull/420)).

## [0.4.9] - 2026-04-30

### Added
- `completion_tokens_details` on `CompletionUsage` ([#411](https://github.com/MacPaw/OpenAI/pull/411)).
- `prompt_cache_key` on `CreateModelResponseQuery` ([#412](https://github.com/MacPaw/OpenAI/pull/412)).
- Dependabot configuration for GitHub Actions and Swift dependencies ([#414](https://github.com/MacPaw/OpenAI/pull/414)).

### Changed
- `ChoiceDeltaToolCall.index` is required again ([#388](https://github.com/MacPaw/OpenAI/pull/388)).
- `ChatQuery` description output is easier to read ([#394](https://github.com/MacPaw/OpenAI/pull/394)).
- Documentation: `response_format` versus `text` for structured outputs ([#413](https://github.com/MacPaw/OpenAI/pull/413)); security policy points to the private reporting channel ([#410](https://github.com/MacPaw/OpenAI/pull/410)).

Older releases are documented on the [GitHub Releases](https://github.com/MacPaw/OpenAI/releases) page.

[Unreleased]: https://github.com/MacPaw/OpenAI/compare/0.5.1...HEAD
[0.5.1]: https://github.com/MacPaw/OpenAI/compare/0.5.0...0.5.1
[0.5.0]: https://github.com/MacPaw/OpenAI/compare/0.4.9...0.5.0
[0.4.9]: https://github.com/MacPaw/OpenAI/compare/0.4.8...0.4.9
