// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Prism",
    products: [
        .library(
            name: "Prism",
            targets: ["Prism"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-docc-plugin",
            from: "1.0.0"
        ),
    ],
    targets: [
        .target(
            name: "Prism",
            dependencies: []),
        .testTarget(
            name: "PrismTests",
            dependencies: ["Prism"]),
    ]
)
