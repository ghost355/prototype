// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "prototype",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "prototype",
            targets: ["prototype"]
        ),
        .executable(
            name: "PrototypeCLI",
            targets: ["PrototypeCLI"]
        ),
    ],
    targets: [
        .target(
            name: "prototype",
            dependencies: [],
            resources: [.process("Resources")]
        ),
        .executableTarget(
            name: "PrototypeCLI",
            dependencies: ["prototype"],
            path: "Sources/PrototypeCLI"
        ),
        .testTarget(
            name: "prototypeTests",
            dependencies: ["prototype"]
        ),
    ]
)
