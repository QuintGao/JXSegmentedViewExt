// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JXSegmentedViewExt",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "JXSegmentedViewExt",
            targets: ["JXSegmentedViewExt"]
        )
    ],
    targets: [
        .target(
            name: "JXSegmentedViewExt",
            dependencies: [],
            path: "",
            sources: ["Sources"]
        )
    ]
)
