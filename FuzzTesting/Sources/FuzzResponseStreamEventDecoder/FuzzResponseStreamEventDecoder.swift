//
//  FuzzResponseStreamEventDecoder.swift
//  OpenAI / FuzzTesting
//
//  libFuzzer harness for `ResponseStreamEvent` JSON decoding.
//
//  `ResponseStreamEvent.init(from:)` has a non-trivial decoding pipeline
//  with multiple `try?`/fallback paths (see Public/Schemas/Facade/
//  ResponseStreamEvent.swift). It consumes untrusted bytes off the wire,
//  which makes it a high-value target for fuzz testing.
//
//  See FuzzTesting/README.md for how to build & run.

import Foundation
import OpenAI

private let decoder = JSONDecoder()

/// The body of one fuzzer iteration. Catching all errors — we are looking
/// for crashes, hangs, and sanitizer findings, not decode failures.
@inline(__always)
private func decodeOnce(_ data: Data) {
    _ = try? decoder.decode(ResponseStreamEvent.self, from: data)
}

@_cdecl("LLVMFuzzerTestOneInput")
public func LLVMFuzzerTestOneInput(_ start: UnsafePointer<UInt8>, _ count: Int) -> Int32 {
    decodeOnce(Data(bytes: start, count: count))
    return 0
}

#if !FUZZING_ENABLED
// Replay mode for local use without libFuzzer: takes a path to a single
// input file (e.g. a libFuzzer crash artifact) and runs one decode pass.
// libFuzzer's own driver is linked in when built with `-sanitize=fuzzer`,
// in which case this `@main` entry is excluded via the `FUZZING_ENABLED`
// flag (set in `build-fuzzer.sh`).
@main
enum Replay {
    static func main() throws {
        let args = CommandLine.arguments
        guard args.count == 2 else {
            FileHandle.standardError.write(Data("usage: \(args.first ?? "FuzzResponseStreamEventDecoder") <input-file>\n".utf8))
            exit(2)
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: args[1]))
        decodeOnce(data)
        print("decoded \(data.count) bytes without crashing")
    }
}
#endif
