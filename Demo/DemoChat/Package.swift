// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DemoChat",
    platforms: [.macOS(.v13), .iOS(.v17)],
    products: [
        .library(
            name: "DemoChat",
            targets: ["DemoChat"]
        ),
    ],
    dependencies: [
        .package(name: "OpenAI", path: "../.."),
        .package(url: "https://github.com/exyte/Chat.git", from: "3.3.3"),
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", from: "0.9.0"),
        // Pinned explicitly: MediaPicker 3.4.x calls PopupParameters.displayMode(_:), which
        // AnchoredPopup only added in 1.2.0. MediaPicker's own manifest still declares
        // `from: "1.1.3"`, so without this override SwiftPM's version resolution can pick
        // 1.1.3 and fail to build.
        .package(url: "https://github.com/exyte/AnchoredPopup.git", from: "1.2.2")
    ],
    targets: [
        .target(
            name: "DemoChat",
            dependencies: [
                "OpenAI",
                .product(name: "ExyteChat", package: "Chat"),
                .product(name: "MCP", package: "swift-sdk")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "DemoChatTests",
            dependencies: ["DemoChat"],
            path: "Tests"
        ),
    ]
)
