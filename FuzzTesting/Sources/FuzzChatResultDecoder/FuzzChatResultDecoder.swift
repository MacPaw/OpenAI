//
//  FuzzChatResultDecoder.swift
//  OpenAI / FuzzTesting
//
//  libFuzzer harness for `ChatResult` JSON decoding. `ChatResult` is the
//  non-streaming response body for `/v1/chat/completions` — bytes come
//  straight off the wire and pass through a Codable initializer that
//  recursively decodes message content, tool calls, annotations, and
//  usage details, any of which can have unexpected shapes.
//
//  See FuzzTesting/README.md.

import Foundation
import OpenAI

private let decoder = JSONDecoder()

@inline(__always)
private func decodeOnce(_ data: Data) {
    _ = try? decoder.decode(ChatResult.self, from: data)
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
            FileHandle.standardError.write(Data("usage: \(args.first ?? "FuzzChatResultDecoder") <input-file>\n".utf8))
            exit(2)
        }
        let data = try Data(contentsOf: URL(fileURLWithPath: args[1]))
        decodeOnce(data)
        print("decoded \(data.count) bytes without crashing")
    }
}
#endif
