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
            targets: ["prototype"])
    ],
    targets: [
        .target(
            name: "prototype"),
        .testTarget(
            name: "prototypeTests",
            dependencies: ["prototype"]
        ),
    ]
)
