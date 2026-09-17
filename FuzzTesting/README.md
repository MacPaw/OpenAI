# FuzzTesting

libFuzzer harnesses for the `OpenAI` Swift package. Lives in its own
SwiftPM package so the main library's `Package.swift` stays clean for
library consumers.

This is the in-repo half of the work tracked in [#241 — Integrate
OSS-Fuzz](https://github.com/MacPaw/OpenAI/issues/241). The upstream
`google/oss-fuzz` project submission is a separate piece.

## Targets

| Target                                          | What it fuzzes                                                  |
| ----------------------------------------------- | --------------------------------------------------------------- |
| `FuzzResponseStreamEventDecoder`                | `JSONDecoder().decode(ResponseStreamEvent.self, …)`             |
| `FuzzChatResultDecoder`                         | `JSONDecoder().decode(ChatResult.self, …)`                      |
| `FuzzChatStreamResultDecoder`                   | `JSONDecoder().decode(ChatStreamResult.self, …)`                |
| `FuzzResponseObjectDecoder`                     | `JSONDecoder().decode(ResponseObject.self, …)`                  |
| `FuzzAudioTranscriptionStreamResultDecoder`     | `JSONDecoder().decode(AudioTranscriptionStreamResult.self, …)`  |

All five targets fuzz Codable decoders that consume bytes off the wire:

- `ResponseStreamEvent.init(from:)` runs several fallible decode passes
  before falling back to a generated raw event with ~50 oneOf cases.
- `ChatResult` / `ChatStreamResult` cover the non-streaming and
  streaming `/v1/chat/completions` response shapes, including tool
  calls, annotations, refusals, and usage breakdowns.
- `ResponseObject` covers the non-streaming `/v1/responses` envelope
  with reasoning, tool outputs, and rich output items.
- `AudioTranscriptionStreamResult` has a hand-written `init(from:)`
  that branches on `type` and optionally reads `logprobs`.

## Replay mode (no libFuzzer toolchain required)

```sh
cd FuzzTesting
swift build
swift run FuzzResponseStreamEventDecoder FuzzCorpus/FuzzResponseStreamEventDecoder/seed-function-call-args-done.json
```

Replay mode runs the harness against a single input file and exits. Use
it to reproduce libFuzzer crash artifacts locally, or to smoke-test the
harness against seed inputs.

## Fuzzing mode (libFuzzer)

Requires a Swift toolchain built with libFuzzer support
([reference](https://github.com/apple/swift/blob/main/docs/libFuzzerIntegration.md)).
On Linux, this typically means a Swift toolchain installed with the
fuzzer runtime; on macOS, support is more limited.

```sh
cd FuzzTesting
swift build -c debug \
  -Xswiftc -sanitize=fuzzer,address \
  -Xswiftc -parse-as-library \
  -Xswiftc -DFUZZING_ENABLED
./.build/debug/FuzzResponseStreamEventDecoder \
  FuzzCorpus/FuzzResponseStreamEventDecoder \
  -max_total_time=60
```

`-DFUZZING_ENABLED` removes each harness's `@main` replay entry point
so libFuzzer's own `main` (provided by `-sanitize=fuzzer`) drives
`LLVMFuzzerTestOneInput`.

## Adding a corpus input

Drop any byte sequence into `FuzzCorpus/<TargetName>/`. Real-world
response chunks captured during integration testing make the best seeds.
The fuzzer will mutate from these.

## Adding a new harness

1. Add an `.executableTarget` to `Package.swift`.
2. Create `Sources/<TargetName>/<TargetName>.swift` with the same shape
   as the existing harnesses:
   - One `@_cdecl("LLVMFuzzerTestOneInput")` function with the body
     under test.
   - A `#if !FUZZING_ENABLED` replay `@main` for local use.
3. Add a `FuzzCorpus/<TargetName>/` directory with at least one seed.

Pick targets that consume untrusted bytes: parsers, decoders, anything
on the network-input path.
