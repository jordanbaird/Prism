// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "Prism",
    products: [
        .library(
            name: "Prism",
            targets: ["Prism"]),
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
