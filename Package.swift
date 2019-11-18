// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "FluxorExplorerSnapshot",
    platforms: [
        .macOS(.v10_15),
        .iOS("13.0"),
        .tvOS("13.0"),
    ],
    products: [
        .library(
            name: "FluxorExplorerSnapshot",
            targets: ["FluxorExplorerSnapshot"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/mortengregersen/fluxor",
            from: "0.1.0-beta"),
    ],
    targets: [
        .target(
            name: "FluxorExplorerSnapshot",
            dependencies: ["Fluxor"]),
        .testTarget(
            name: "FluxorExplorerSnapshotTests",
            dependencies: ["FluxorExplorerSnapshot"]),
    ]
)
