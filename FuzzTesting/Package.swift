// swift-tools-version: 5.10
//
// FuzzTesting/Package.swift
//
// A separate SwiftPM package for libFuzzer harnesses. Lives under
// `FuzzTesting/` so that the main `OpenAI` package manifest stays
// unchanged for library consumers.
//
// Pattern adapted from grpc-swift's FuzzTesting setup. See
// `FuzzTesting/README.md` for how to build and run.

import PackageDescription

let package = Package(
    name: "FuzzTesting",
    platforms: [.macOS(.v10_15)],
    dependencies: [
        .package(name: "OpenAI", path: ".."),
    ],
    targets: [
        .executableTarget(
            name: "FuzzResponseStreamEventDecoder",
            dependencies: [
                .product(name: "OpenAI", package: "OpenAI"),
            ],
            path: "Sources/FuzzResponseStreamEventDecoder"
        ),
    ]
)
