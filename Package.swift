// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenAI",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .watchOS(.v6),
        .tvOS(.v11),
            .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "OpenAI",
            targets: ["OpenAI"]),
    ],
    targets: [
        .target(
            name: "OpenAI",
            dependencies: []),
        .testTarget(
            name: "OpenAITests",
            dependencies: ["OpenAI"]),
    ]
)
