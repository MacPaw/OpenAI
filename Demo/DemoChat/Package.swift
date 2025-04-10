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
        .package(url: "https://github.com/exyte/Chat.git", from: "2.5.7")
    ],
    targets: [
        .target(
            name: "DemoChat",
            dependencies: [
                "OpenAI",
                .product(name: "ExyteChat", package: "Chat"),
            ],
            path: "Sources"
        ),
    ]
)
