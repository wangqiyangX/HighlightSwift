// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "HighlightSwift",
    platforms: [
        .iOS(.v17),
        .tvOS(.v15),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "HighlightSwift",
            targets: ["HighlightSwift"]),
    ],
    targets: [
        .target(
            name: "HighlightSwift",
            resources: [.process("HighlightJS")],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]),
        .testTarget(
            name: "HighlightSwiftTests",
            dependencies: ["HighlightSwift"]),
    ]
)
