// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DungeonMap",
    platforms: [.iOS(.v18), .macOS(.v13)],
    products: [
        .library(
            name: "DungeonMap",
            targets: ["DungeonMap", "DungeonMapTracker"]
        ),
    ],
    targets: [
        .target(
            name: "DungeonMap"
        ),
        .testTarget(
            name: "DungeonMapTests",
            dependencies: ["DungeonMap"]
        ),
        .target(
            name: "DungeonMapTracker",
            dependencies: [
                "PrintHierarchyDecoder",
            ]
        ),
        .target(
            name: "PrintHierarchyDecoder"
        ),
        .testTarget(
            name: "PrintHierarchyDecoderTests",
            dependencies: [
                "PrintHierarchyDecoder"
            ]
        )
    ]
)
