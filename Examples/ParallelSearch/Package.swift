// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ParallelSearchExample",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "parallel-search", targets: ["ParallelSearch"])],
    dependencies: [
        .package(name: "OpenAI", path: "../.."),
        .package(url: "https://github.com/modelcontextprotocol/swift-sdk.git", exact: "0.9.0")
    ],
    targets: [
        .executableTarget(name: "ParallelSearch", dependencies: [
            "OpenAI", .product(name: "MCP", package: "swift-sdk")
        ]),
        .testTarget(name: "ParallelSearchTests", dependencies: ["ParallelSearch"], resources: [.copy("server.py")])
    ]
)
