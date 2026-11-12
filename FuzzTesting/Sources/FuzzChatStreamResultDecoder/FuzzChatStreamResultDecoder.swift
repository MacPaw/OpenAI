//
//  FuzzChatStreamResultDecoder.swift
//  OpenAI / FuzzTesting
//
//  libFuzzer harness for `ChatStreamResult` JSON decoding — the
//  per-chunk type emitted by `/v1/chat/completions` when streaming.
//  Each SSE `data:` line is decoded into this type, so any malformed
//  byte sequence the parser tolerates ends up here.
//
//  See FuzzTesting/README.md.

import Foundation
import OpenAI

private let decoder = JSONDecoder()

@inline(__always)
private func decodeOnce(_ data: Data) {
    _ = try? decoder.decode(ChatStreamResult.self, from: data)
}

@_cdecl("LLVMFuzzerTestOneInput")
public func LLVMFuzzerTestOneInput(_ start: UnsafePointer<UInt8>, _ count: Int) -> Int32 {
    decodeOnce(Data(bytes: start, count: count))
    return 0
}

#if !FUZZING_ENABLED
@main
enum Replay {
    static func main() throws {
        let args = CommandLine.arguments
        guard args.count == 2 else {
            FileHandle.standardError.write(Data("usage: \(args.first ?? "FuzzChatStreamResultDecoder") <input-file>\n".utf8))
            exit(2)
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: args[1]))
        decodeOnce(data)
        print("decoded \(data.count) bytes without crashing")
    }
}
#endif
