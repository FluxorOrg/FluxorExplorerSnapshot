// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "FluxorExplorerSnapshot",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "FluxorExplorerSnapshot",
            targets: ["FluxorExplorerSnapshot"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/FluxorOrg/Fluxor",
            from: "1.0.0"),
        .package(
            url: "https://github.com/Flight-School/AnyCodable",
            from: "0.2.3"),
    ],
    targets: [
        .target(
            name: "FluxorExplorerSnapshot",
            dependencies: ["Fluxor", "AnyCodable"]),
        .testTarget(
            name: "FluxorExplorerSnapshotTests",
            dependencies: ["FluxorExplorerSnapshot"]),
    ]
)
